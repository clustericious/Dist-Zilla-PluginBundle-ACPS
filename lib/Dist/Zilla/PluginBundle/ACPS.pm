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
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Dist::Zilla::PluginBundle::ACPS - the basic plugins to maintain and release ACPS dists

=head1 DESCRIPTION

This plugin is meant to bea basic "first step" bundle for ACPS.  It includes
the following plugins with their default configuration:

=over 4

=item *

L<Dist::Zilla::Plugin::GatherDir>

=item *

L<Dist::Zilla::Plugin::PruneCruft>

=item *

L<Dist::Zilla::Plugin::ManifestSkip>

=item *

L<Dist::Zilla::Plugin::MetaYAML>

=item *

L<Dist::Zilla::Plugin::MetaJSON>

=item *

L<Dist::Zilla::Plugin::License>

=item *

L<Dist::Zilla::Plugin::Readme>

=item *

L<Dist::Zilla::Plugin::ExtraTests>

=item *

L<Dist::Zilla::Plugin::ExecDir>

=item *

L<Dist::Zilla::Plugin::ShareDir>

=item *

L<Dist::Zilla::Plugin::ModuleBuild>

=item *

L<Dist::Zilla::Plugin::MakeMaker>

=item *

L<Dist::Zilla::Plugin::Manifest>

=item *

L<Dist::Zilla::Plugin::TestRelease>

=item *

L<Dist::Zilla::Plugin::ConfirmRelease>

=item *

L<Dist::Zilla::Plugin::NextRelease>

=item *

L<Dist::Zilla::Plugin::AutoPrereqs>

=item *

L<Dist::Zilla::Plugin::OurPkgVersion>

=item *

L<Dist::Zilla::Plugin::Git::Check>

=item *

L<Dist::Zilla::Plugin::Git::Commit>

=item *

L<Dist::Zilla::Plugin::Git::Tag>

=item *

L<Dist::Zilla::Plugin::Git::Push>

=back

=head1 AUTHOR

Graham Ollis <gollis@sesda2.com>

=cut
