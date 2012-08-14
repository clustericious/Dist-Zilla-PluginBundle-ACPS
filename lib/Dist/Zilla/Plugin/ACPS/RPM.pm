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

use namespace::autoclean;

has '+spec_file' => (
  is => 'ro',
  default => sub { Dist::Zilla::MintingProfile::ACPS->profile_dir . '/default/dist.spec' },
);

sub mk_spec {
    my($self,$archive, $specfile) = @_;

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
    
    $self->log("creating spec: " . $specfile)
        if defined $specfile;
    
    return $ret;
}

sub mk_rpm {
    my $self = shift;

    unless(-d dir(File::HomeDir->my_home, 'rpmbuild'))
    {
        $self->log_fatal("first create a ~/rpmbuild directory (and make sure rpmbuild is installed)");
    }

    mkdir dir(File::HomeDir->my_home, 'rpmbuild', $_) for qw( BUILD RPMS SOURCES SPECS SRPMS );

    my $tar = sprintf('%s-%s.tar.gz',$self->zilla->name,$self->zilla->version);
    
    unless(-f $tar)
    {
        $self->log_fatal("could not find tar file (expected $tar to work)");
    }

    # copy tar to SOURCES directory
    do {
        my $from = $tar;
        my $to   = file(File::HomeDir->my_home, 'rpmbuild', 'SOURCES', $tar);
        $self->log("copy tar: $to");
        copy($from, $to) || $self->log_fatal("Copy failed: $!");
    };
    
    # generate spec file
    my $spec = do {
        my $outfile = Path::Class::File->new(File::HomeDir->my_home, qw( rpmbuild SPECS ), $self->zilla->name . '.spec');
        my $out = $outfile->openw;
        $self->log("creating spec: " . $outfile);
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
