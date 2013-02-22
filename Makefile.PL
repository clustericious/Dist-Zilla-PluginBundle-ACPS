
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker 6.30;

use File::ShareDir::Install;
install_share module => "Dist::Zilla::MintingProfile::ACPS", "profiles";


my %WriteMakefileArgs = (
  "ABSTRACT" => "the basic plugins to maintain and release ACPS dists",
  "AUTHOR" => "Graham Ollis <gollis\@sesda3.com>",
  "BUILD_REQUIRES" => {
    "Module::Build" => "0.3601",
    "Test::More" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "File::ShareDir::Install" => "0.03",
    "Module::Build" => "0.3601"
  },
  "DISTNAME" => "Dist-Zilla-PluginBundle-ACPS",
  "EXE_FILES" => [],
  "LICENSE" => "restrictive",
  "NAME" => "Dist::Zilla::PluginBundle::ACPS",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Cwd" => 0,
    "DateTime" => 0,
    "Dist::Zilla" => 0,
    "Dist::Zilla::App" => 0,
    "Dist::Zilla::Plugin::OurPkgVersion" => 0,
    "Dist::Zilla::Plugin::PodWeaver" => 0,
    "Dist::Zilla::PluginBundle::Git" => 0,
    "Dist::Zilla::Role::AfterMint" => 0,
    "Dist::Zilla::Role::AfterRelease" => 0,
    "Dist::Zilla::Role::BeforeRelease" => 0,
    "Dist::Zilla::Role::BuildPL" => 0,
    "Dist::Zilla::Role::Git::DirtyFiles" => 0,
    "Dist::Zilla::Role::Git::Repo" => 0,
    "Dist::Zilla::Role::MintingProfile::ShareDir" => 0,
    "Dist::Zilla::Role::Plugin" => 0,
    "Dist::Zilla::Role::PluginBundle::Easy" => 0,
    "Dist::Zilla::Role::PrereqSource" => 0,
    "Dist::Zilla::Role::Releaser" => 0,
    "Dist::Zilla::Role::VersionProvider" => 0,
    "File::Copy" => 0,
    "File::HomeDir" => 0,
    "File::Spec" => 0,
    "File::Spec::Functions" => 0,
    "File::Temp" => 0,
    "File::chdir" => 0,
    "Git::Wrapper" => "0.021",
    "IPC::Open3" => 0,
    "IPC::System::Simple" => 0,
    "JSON" => 0,
    "List::MoreUtils" => 0,
    "Moose" => 0,
    "MooseX::AttributeShortcuts" => 0,
    "MooseX::Has::Sugar" => 0,
    "MooseX::Types::Moose" => 0,
    "MooseX::Types::Path::Class" => 0,
    "Path::Class" => 0,
    "Path::Class::Dir" => 0,
    "String::Formatter" => 0,
    "Template" => 0,
    "Try::Tiny" => 0,
    "autodie" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.10",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

{
package
MY;
use File::ShareDir::Install qw(postamble);
}


