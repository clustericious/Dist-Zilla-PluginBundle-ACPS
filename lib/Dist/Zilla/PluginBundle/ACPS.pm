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

    PodWeaver
    NextRelease
    AutoPrereqs
    OurPkgVersion
  )
}

sub allow_dirty { [ 'Changes', 'dist.ini' ] };

sub mvp_multivalue_args { qw( allow_dirty ) }

sub is_legacy { 0 }

sub configure {
  my($self) = @_;

  $self->add_plugins($self->plugin_list);

  my $allow_dirty = $self->allow_dirty;
  if(defined $self->payload->{allow_dirty})
  {
    push @{ $allow_dirty }, @{ $self->payload->{allow_dirty} };
  }

  print "allow_dirty = ", join(" ", @$allow_dirty), "\n";
  $self->add_plugins(
    ['Git::Check', { allow_dirty => $allow_dirty } ], 
    'ACPS::Git::Commit',
    ($self->is_legacy ? () : ('ACPS::Git::CommitBuild')),
    'ACPS::Release',
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
 
 [PodWeaver]
 [NextRelease]
 [AutoPrereqs]
 [OurPkgVersion]
 
 [Git::Check]
 [ACPS::Git::Commit]
 [ACPS::Release]

=cut
