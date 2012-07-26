package Dist::Zilla::Plugin::ACPS::Legacy;

use Moose;
use v5.10;
use autodie;

# VERSION

with qw( Dist::Zilla::Role::VersionProvider );

use namespace::autoclean;

sub provide_version
{
  my($self) = @_;
  
  my $version;

  foreach my $line (split /\n/, $self->zilla->main_module->content)
  {
    $version = $1 if $line =~ /\$VERSION\s+=\s+["']?(.*?)["']?;/;
  }

  return $version;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Dist::Zilla::Plugin::ACPS::Legacy - Dist::Zilla plugin for ACPS CIs that are pre-Dist::Zilla

=head1 DESCRIPTION

Don't use this direectly, instead use L<@ACPS::Legacy|Dist::Zilla::PluginBundle::ACPS::Legacy>.
This plugin does this:

=over 4

=item *

Determines the version from MainModule::VERSION instead of getting it from the dist.ini.

=back

=head1 AUTHOR

Graham Ollis <gollis@sesda2.com>

=cut
