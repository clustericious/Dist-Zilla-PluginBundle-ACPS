package Dist::Zilla::Plugin::ACPS::JavaScriptVersion;

# VERSION

use Moose;
use v5.10;

with (
  'Dist::Zilla::Role::FileMunger',
);

use namespace::autoclean;

sub munge_files
{
  my $self = shift;
  # tried using FileFinderUser with :SharedFiles but got this error:
  # Can't locate object method "zilla" via package "Dist::Zilla::Dist::Builder" 
  foreach my $file (grep { $_->name =~ /main.*\.js$/ } @{ $self->zilla->files })
  {
    $self->munge_file($file);
  }
  return;
}

sub munge_file
{
  my($self, $file) = @_;
  
  my @content = split /\n\r?/, $file->content;
  my $modified = 0;
  my $version = $self->zilla->version;

  for(@content)
  {
    #$self->log("content = $_");
    if(s{^(\s*)(//\s*VERSION\s*)$}{${1}VERSION = '$version'; ${2}})
    {
      #$self->log("match!");
      $modified = 1;
    }
    else
    {
      #$self->log("not match");
    }
  }
  
  if($modified)
  {
    $self->log('set version in ' . $file->name);
    $file->content(join("\n", @content));
  }
}

__PACKAGE__->meta->make_immutable;

1;

=head1 NAME

Dist::Zilla::Plugin::ACPS::JavaScriptVersion

=head1 SYNOPSIS

in your dist.ini:

 version = 0.01

 [ACPS::JavaScriptVersion]

in your share directory public/js/foo.js

 // VERSION

becomes:

 VERSION = '0.01'; // VERSION

=head1 AUTHOR

Graham Ollis <gollis@sesda2.com>

=cut
