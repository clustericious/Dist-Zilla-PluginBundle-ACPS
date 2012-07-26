use strict;
use warnings;
use Test::More tests => 5;

use_ok 'Dist::Zilla::PluginBundle::ACPS';
use_ok 'Dist::Zilla::Plugin::ACPS::Release';
use_ok 'Dist::Zilla::Plugin::ACPS::Init';
use_ok 'Dist::Zilla::Plugin::ACPS::RPM';
use_ok 'Dist::Zilla::MintingProfile::ACPS';
