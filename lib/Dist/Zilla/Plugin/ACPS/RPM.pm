package Dist::Zilla::Plugin::ACPS::RPM;

use Moose;
use v5.10;
use Dist::Zilla::MintingProfile::ACPS;

# ABSTRACT: RPM Dist::Zilla plugin for ACPS
# VERSION

extends 'Dist::Zilla::Plugin::RPM';

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
    return $t->fill_in(
        HASH => {
            zilla   => \($self->zilla),
            archive => \$archive,
        },
    ) || $self->log_fatal($Text::Template::ERROR);
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 DESCRIPTION

This in herits from L<Dist::Zilla::Plugin::RPM>, and changes the
default spec template.

=cut
