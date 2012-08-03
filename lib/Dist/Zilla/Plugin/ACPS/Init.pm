package Dist::Zilla::Plugin::ACPS::Init;

use Moose;
use v5.10;
use Git::Wrapper;

# ABSTRACT: init plugin for ACPS
# VERSION

with 'Dist::Zilla::Role::AfterMint';

use namespace::autoclean;

sub after_mint
{
  my($self, $opts) = @_;

  my $git = Git::Wrapper->new($opts->{mint_root});

  foreach my $remote ($git->remote('-v'))
  {
    # TODO maybe also create the cm repo remote
    if($remote =~ /^public\s+(.*):(public_git\/.*\.git) \(push\)$/)
    {
      my($hostname,$dir) = ($1,$2);
      use autodie qw( :system );
      system('ssh', $hostname, 'git', "--git-dir=$dir", 'init', '--bare');
      $git->push(qw( public master ));
    }
  }

}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 DESCRIPTION

Standard init plugin for ACPS distros.  May change in the future,
but for now it creates a public git repo on acpsdev2.

=cut
