package Dist::Zilla::App::Command::apinstall;

use strict;
use warnings;
use Carp;
use File::HomeDir;

# ABSTRACT: install RPM file for your dist
# VERSION

use Dist::Zilla::App -command;

sub abstract { 'install RPM file for your dist' }

sub execute {
  my($self,$opt,$args) = @_;
  
  my $plugin = $self->zilla->plugin_named('ACPS::RPM');
  
  unless(defined $plugin)
  {
    $self->log("[apbuild] add this to your dist.ini:");
    $self->log("[apbuild] [ACPS::RPM]");
    $self->log("[apbuild] ;ignore_build_deps = 1 ; uncomment to ignore deps");
    die "could not find ACPS::RPM plugin";
  }
    
  $self->zilla->build_archive;

  $plugin->install_rpm($plugin->mk_rpm);
}

1;

=head1 SYNOPSIS

  dzil apinstall

=cut
