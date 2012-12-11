package Dist::Zilla::Plugin::ACPS::JavaScriptMinifier;

# ABSTRACT: minify JavaScript files into a single ball of fun
# VERSION

use Moose;
use v5.10;
use JavaScript::Minifier::XS qw( minify );
use Text::Glob qw( match_glob );

with (
  'Dist::Zilla::Role::FileInjector',
  'Dist::Zilla::Role::FileMunger',
);

use namespace::autoclean;

has input => ( is => 'ro', isa => 'Str' );
has output => ( is => 'ro', isa => 'Str' );

sub munge_files
{
  my $self = shift;
  # tried using FileFinderUser with :SharedFiles but got this error:
  # Can't locate object method "zilla" via package "Dist::Zilla::Dist::Builder" 
  my $js = '';
  foreach my $file (grep { match_glob $self->input, $_->name } @{ $self->zilla->files })
  {
    $self->log("minifying " . $file->name);
    $js .= $file->content . "\n";
  }

  my $file = Dist::Zilla::File::FromCode->new({
    name => $self->output,
    code => sub {
      $self->log('writing ' . $self->output);
      minify($js);
    },
  });
  
  $self->add_file($file);
  return;
}

__PACKAGE__->meta->make_immutable;

1;

=head1 SYNOPSIS

in your dist.ini:

 [ACPS::JavaScriptMinifier]
 input = public/js/foo-*.js
 output = public/js/foo.min.js

=head1 AUTHOR

Graham Ollis <gollis@sesda2.com>

=cut
