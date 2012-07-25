package Dist::Zilla::PluginBundle::ACPS;

use strict;
use warnings;
use v5.10;

# ABSTRACT: the basic plugins to maintain and release ACPS dists
# VERSION

use Moose;
with 'Dist::Zilla::Role::PluginBundle::Easy';

use namespace::autoclean;

sub configure {
  my($self) = @_;

  $self->add_plugins(qw(
    GatherDir
    PruneCruft
    ManifestSkip
    MetaYAML
    MetaJSON
    License
    Readme
    ExtraTests
    ExecDir
    ShareDir
    ModuleBuild
    MakeMaker
    Manifest
    TestRelease
    ConfirmRelease
    ACPS::Release

    NextRelease
    AutoPrereqs
    OurPkgVersion
  ));

  $self->add_bundle(
    '@Git' => {
      push_to     => 'public',
      tag_format  => '%v',
      tag_message => 'version %v',
    },
  );
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Dist::Zilla::PluginBundle::ACPS - the basic plugins to maintain and release ACPS dists

=head1 DESCRIPTION

Plugin bundle for creating and maintaining Perl distributions for ACPS.
It is equivalent to this:

 [GatherDir]
 [PruneCruft]
 [ManifestSkip]
 [MetaYAML]
 [MetaJSON]
 [License]
 [Readme]
 [ExtraTests]
 [ExecDir]
 [ShareDir]
 [ModuleBuild]
 [MakeMaker]
 [Manifest]
 [TestRelease]
 [ConfirmRelease]
 [ACPS::Release]
 [NextRelease]
 [AutoPrereqs]
 [OurPkgVersion]
 [@Git]
 push_to = public
 tag_format = %v
 tag_message = version %v

=head1 AUTHOR

Graham Ollis <gollis@sesda2.com>

=cut
