package Dist::Zilla::MintingProfile::ACPS;

use Moose;
use v5.10;

# VERSION

with qw( Dist::Zilla::Role::MintingProfile::ShareDir );

no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Dist::Zilla::MintingProfile::ACPS - ACPS Dist::Zilla minting profile

=head1 AUTHOR

Graham Ollis <gollis@sesda2.com>

=cut
