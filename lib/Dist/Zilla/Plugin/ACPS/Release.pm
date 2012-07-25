package Dist::Zilla::Plugin::ACPS::Release;

# VERSION

use Moose;
use v5.10;
use Git::Wrapper;

with qw( Dist::Zilla::Role::BeforeRelease Dist::Zilla::Role::Releaser );

use namespace::autoclean;

sub before_release
{
  my $self = shift;

  my $git = Git::Wrapper->new($self->zilla->root);
  foreach my $tag ($git->tag)
  {
    if($tag eq $self->zilla->version)
    {
      $self->log_fatal(['there is already a tag for this version: %s', $self->zilla->version]);
    }
  }
}

sub release
{
  my($self, $archive) = @_;

  # do nothign for now.
}


__PACKAGE__->meta->make_immutable;
1;

__END__

=head1 NAME

Dist::Zilla::Plugin::ACPS::Release - release plugin for ACPS

=head1 AUTHOR

Graham Ollis <gollis@sesda2.com>

=cut
