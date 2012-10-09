package Dist::Zilla::App::Command::apupload;

use strict;
use warnings;
use Carp;
use File::HomeDir;

# ABSTRACT: generate RPM file for your dist
our $VERSION = '0.08'; # VERSION

use Dist::Zilla::App -command;

sub abstract { 'upload RPM file for your dist to a RestYum server' }

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

    $plugin->upload_rpm($plugin->mk_rpm);
}

1;


__END__
=pod

=head1 NAME

Dist::Zilla::App::Command::apupload - generate RPM file for your dist

=head1 VERSION

version 0.08

=head1 SYNOPSIS

  dzil apupload

=head1 AUTHOR

Graham Ollis <gollis@sesda2.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by NASA GSFC.  No
license is granted to other entities.

=cut

