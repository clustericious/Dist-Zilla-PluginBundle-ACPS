package Dist::Zilla::PluginBundle::ACPS::Legacy;

use Moose;
use v5.10;

# ABSTRACT: Dist::Zilla ACPS bundle for dists not originally written with Dist::Zilla in mind
# VERSION

extends 'Dist::Zilla::PluginBundle::ACPS';

use namespace::autoclean;

sub plugin_list {
  qw(
    GatherDir
    PruneCruft
    ManifestSkip
    License
    ExecDir

    TestRelease
    ConfirmRelease
    ACPS::Legacy

    PodVersion
    OurPkgVersion
  )
}

sub is_legacy { 1 }

sub allow_dirty { [ qw( dist.ini META.yml META.json ) ] };

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 DESCRIPTION

This plugin bundle is identical to L<@ACPS|Dist::Zilla::PluginBundle::ACPS> except it does not include
L<Manifest|Dist::Zilla::Plugin::Manifest>,
L<MetaYAML|Dist::Zilla::Plugin::MetaYAML>,
L<MetaJSON|Dist::Zilla::Plugin::MetaJSON>,
L<Readme|Dist::Zilla::Plugin::Readme>,
L<NextRelease|Dist::Zilla::Plugin::NextRelease>,
L<AutoPrereqs|Dist::Zilla::Plugin::AutoPrereqs>,
L<ModuleBuild|Dist::Zilla::Plugin::ModuleBuild> or
L<MakeMaker|Dist::Zilla::Plugin::MakeMaker>, as these are usually maintained by hand or via the Build.PL
in older ACPS distributions.

This plugin bundle also includes L<ACPS::Legacy|Dist::Zilla::Plugin::ACPS::Legacy>.

=cut
