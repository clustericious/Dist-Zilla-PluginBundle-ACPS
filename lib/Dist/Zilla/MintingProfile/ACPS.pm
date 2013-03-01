package Dist::Zilla::MintingProfile::ACPS;

use Moose;
use v5.10;
use File::HomeDir;
use File::Spec;
use Dist::Zilla::PluginBundle::ACPS;

# ABSTRACT: ACPS Dist::Zilla minting profile
# VERSION

with qw( Dist::Zilla::Role::MintingProfile );

my $prep = sub {
  use autodie;

  my $dzil_dir = File::Spec->catdir(File::HomeDir->my_home, '.dzil');
  my $dzil_ini = File::Spec->catfile(File::HomeDir->my_home, '.dzil', 'config.ini');

  mkdir $dzil_dir unless -d $dzil_dir;
  unless(-e $dzil_ini)
  {

    my($user, $name) = eval { (getpwnam($ENV{USER} // $ENV{USERNAME}))[0,6] };

    warn "unable to determine user name: $@" if $@;

    $user //= "user";
    $name //= "User Name";

    my $email = "$user\@sesda2.com";

    print "creating $dzil_ini with default settings (you may want to edit this to change defaults)";
    open my $fp, '>', $dzil_ini;
    say $fp "[%User]";
    say $fp "name = $name";
    say $fp "email = $email";
    say $fp "";
    say $fp "[%Rights]";
    say $fp "license_class    = None";
    say $fp "copyright_holder = NASA GSFC";
    close $fp;
  }
};

sub profile_dir
{
  my($self, $name) = @_;
  $prep->();
  Dist::Zilla::PluginBundle::ACPS
    ->share_dir
    ->subdir('profiles')
    ->subdir($name);
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 SYNOPSIS

 % dzil new -P ACPS Hello::World

=head1 DESCRIPTION

Minting profile for ACPS.

=cut
