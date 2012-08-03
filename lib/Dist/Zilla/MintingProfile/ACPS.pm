package Dist::Zilla::MintingProfile::ACPS;

use Moose;
use v5.10;

# ABSTRACT: ACPS Dist::Zilla minting profile
# VERSION

with qw( Dist::Zilla::Role::MintingProfile::ShareDir );

no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 SYNOPSIS

 % dzil new -P ACPS Hello::World

=head1 DESCRIPTION

Minting profile for ACPS.

=cut
