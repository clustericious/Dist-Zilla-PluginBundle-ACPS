package Dist::Zilla::PluginBundle::ACPS;

use Moose;
use v5.10;
use Dist::Zilla;
use Dist::Zilla::Plugin::PodWeaver;
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

    PodWeaver
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

sub mvp_multivalue_args { qw( allow_dirty ) }

sub configure {
  my($self) = @_;

  $self->add_plugins($self->plugin_list);

  my $git_arguments = $self->git_arguments;

  if(defined $self->payload->{allow_dirty})
  {
    $git_arguments->{allow_dirty} //= [];
    push @{ $git_arguments->{allow_dirty} }, @{ $self->payload->{allow_dirty} };
  }

  $self->add_bundle(
    '@Git' => $git_arguments,
  );
}

__PACKAGE__->meta->make_immutable;

1;

__END__

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
 [PodWeaver]
 [NextRelease]
 [AutoPrereqs]
 [OurPkgVersion]
 [@Git]
 push_to = public
 tag_format = %v
 tag_message = version %v

=cut
