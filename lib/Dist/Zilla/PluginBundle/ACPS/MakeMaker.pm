package Dist::Zilla::PluginBundle::ACPS::MakeMaker;

use Moose;
use v5.10;

# ABSTRACT: Dist::Zilla ACPS bundle that uses MakeMaker instead of ModuleBuild
# VERSION

extends 'Dist::Zilla::PluginBundle::ACPS';

use namespace::autoclean;

around plugin_list => sub {
  my $orig = shift;
  my $self = shift;
  
  map { (ref $_ ? $_->[0] : $_) =~ s/^ModuleBuild$/MakeMaker/; $_ } $self->$orig(@_);
};

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 DESCRIPTION

This plugin bundle is identical to L<@ACPS|Dist::Zilla::PluginBundle::ACPS> except it uses
[MakeMaker] instead of [ModuleBuild].

=cut
