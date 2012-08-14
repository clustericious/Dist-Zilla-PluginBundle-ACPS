package Dist::Zilla::Plugin::ACPS::RPM;

use Moose;
use v5.10;
use Dist::Zilla::MintingProfile::ACPS;
use Path::Class qw( dir file );
use File::HomeDir;
use File::Copy qw( copy );

# ABSTRACT: RPM Dist::Zilla plugin for ACPS
# VERSION

extends 'Dist::Zilla::Plugin::RPM';

with 'Dist::Zilla::Role::AfterBuild';

use namespace::autoclean;

has '+spec_file' => (
  is => 'ro',
  default => sub { Dist::Zilla::MintingProfile::ACPS->profile_dir . '/default/dist.spec' },
);

sub mk_spec {
    my($self,$archive) = @_;

    # this is different from the superclass, we allow fully qualified filenames, because
    # we want to keep the spec template in the share directory with the other profile
    # stuff.
    my $spec_file = $self->spec_file =~ /^\// ? $self->spec_file : $self->zilla->root->file($self->spec_file);

    my $t = Text::Template->new(
        TYPE       => 'FILE',
        SOURCE     => $spec_file,
        DELIMITERS => [ '<%', '%>' ],
    ) || $self->log_fatal($Text::Template::ERROR);
    my $ret = $t->fill_in(
        HASH => {
            zilla   => \($self->zilla),
            archive => \$archive,
        },
    ) || $self->log_fatal($Text::Template::ERROR);
    
    return $ret;
}

sub after_build {
    my $self = shift;
    my $build_root = shift->{build_root};

    return unless -d dir(File::HomeDir->my_home, 'rpmbuild');
    
    mkdir dir(File::HomeDir->my_home, 'rpmbuild', $_) for qw( BUILD RPMS SOURCES SPECS SRPMS );

    my($base) = $build_root->dir_list(-1, 1);
    my $tar = $base . '.tar.gz';
    $self->log($tar);
    
    return unless -f $tar;

    # copy tar to SOURCES directory
    do {
        my $from = $tar;
        my $to   = file(File::HomeDir->my_home, 'rpmbuild', 'SOURCES', $tar);
        $self->log("copy $from => $to");
        copy($from, $to) || $self->log_fatal("Copy failed: $!");
    };
    
    # generate spec file
    my $spec = do {
        my $outfile = Path::Class::File->new(File::HomeDir->my_home, qw( rpmbuild SPECS ), $self->zilla->name . '.spec');
        my $out = $outfile->openw;
        $self->log("creating spec " . $outfile);
        print $out $self->mk_spec($tar);
        $outfile;
    };
    
    # build rpm
    $self->log("generate rpm: " . $_) for split /\n/, `ap build $spec`;
}


__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 DESCRIPTION

This in herits from L<Dist::Zilla::Plugin::RPM>, and changes the
default spec template.

=cut
