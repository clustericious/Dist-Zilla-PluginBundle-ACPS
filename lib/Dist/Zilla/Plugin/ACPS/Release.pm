package Dist::Zilla::Plugin::ACPS::Release;

# VERSION

use Moose;
use v5.10;

with qw( Dist::Zilla::Role::Releaser );

use namespace::autoclean;

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
