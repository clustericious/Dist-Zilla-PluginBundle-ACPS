package Dist::Zilla::Plugin::ACPS::Legacy;

use Moose;
use 5.010001;
use autodie;
use JSON::PP qw( decode_json );

# ABSTRACT: Dist::Zilla plugin for ACPS CIs that are pre-Dist::Zilla
# VERSION

with qw(
  Dist::Zilla::Role::VersionProvider
  Dist::Zilla::Role::BuildPL
  Dist::Zilla::Role::PrereqSource
);

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

sub setup_installer
{
  # Build.PL is gathered from a static file.
}

sub register_prereqs
{
  my $self = shift;
  
  my $meta = eval { decode_json($self->zilla->root->file('META.json')->slurp) };
  die "unable to load META.json, run ./Build distmeta to generate it: $@" if $@ or !defined $meta;

  foreach my $phase (qw( configure build runtime ))
  {
    if(exists $meta->{prereqs}->{$phase})
    {
      $self->zilla->log("using $phase prereqs from META.json");
      $self->zilla->register_prereqs({ phase => $phase }, %{ $meta->{prereqs}->{$phase}->{requires} });
    }
    else
    {
      $self->zilla->log("WARNING: can't find $phase prereqs from META.json");
    }
  }
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 DESCRIPTION

Don't use this direectly, instead use L<@ACPS::Legacy|Dist::Zilla::PluginBundle::ACPS::Legacy>.
This plugin does this:

=over 4

=item *

Determines the version from MainModule::VERSION instead of getting it from the dist.ini.

=back

=cut
