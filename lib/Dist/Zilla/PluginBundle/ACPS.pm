package Dist::Zilla::PluginBundle::ACPS;

use Moose;
use v5.10;
use Dist::Zilla;
use Dist::Zilla::PluginBundle::Git;
use Dist::Zilla::Plugin::OurPkgVersion;

# ABSTRACT: the basic plugins to maintain and release ACPS dists
# VERSION

with 'Dist::Zilla::Role::PluginBundle::Easy';

use namespace::autoclean;

sub plugin_list {
  qw(
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

    PodVersion
    NextRelease
    AutoPrereqs
    OurPkgVersion
  )
}

sub git_arguments {
  {
    push_to     => 'public',
    tag_format  => '%v',
    tag_message => 'version %v',
    commit_msg  => 'version %v'
  }
}

sub configure {
  my($self) = @_;

  $self->add_plugins($self->plugin_list);

  $self->add_bundle(
    '@Git' => $self->git_arguments,
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
 [PodVersion]
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
