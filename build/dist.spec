Name: acps-<% $zilla->name %>
Version: <% (my $v = $zilla->version) =~ s/^\v//; $v %>
Release: 1
Summary: <% $zilla->abstract %>
License: <% $zilla->license->name %>
Group: Applications/CPAN
BuildArch: noarch
Vendor: <% $zilla->license->holder %>
Source: <% $archive %>
Requires: perl
<% 
  use List::MoreUtils qw( uniq ); 
  join "\n", 
    map { "Requires: perl($_)" } 
    uniq
    sort 
    grep !/^perl$/, 
    $zilla->prereqs->requirements_for('runtime', 'requires')->required_modules 
%>
BuildRequires: perl
<%
  use List::MoreUtils qw( uniq ); 
  join "\n", 
    map { "BuildRequires: perl($_)" } 
    uniq
    sort 
    grep !/^perl$/, 
    map { $zilla->prereqs->requirements_for($_, 'requires')->required_modules } qw( configure build test runtime ) 
%>
BuildRoot: %{_tmppath}/%{name}-%{version}-BUILD

%description
<% $zilla->abstract %>

%prep
%setup -q -n <% $zilla->name %>-%{version}

<% $prefix = '/util'; '' %>

%build
if [ -e Build.PL ]; then
  perl Build.PL --install_path lib=<% $prefix %>/lib/perl    \
                --install_path arch=<% $prefix %>/lib/perl   \
                --install_path bin=<% $prefix %>/bin         \
                --install_path script=<% $prefix %>/bin      \
                --install_path script=<% $prefix %>/bin      \
                --install_path bindoc=<% $prefix %>/man/man1 \
                --install_path libdoc=<% $prefix %>/man/man3 \
                --destdir %{buildroot}                       \
  && ./Build \
  && ./Build test
elif [ -e Makefile.PL ]; then
  perl Makefile.PL INSTALLSITELIB=<% $prefix %>/lib/perl     \
                   INSTALLSITEARCH=<% $prefix %>/lib/perl    \
                   INSTALLSITEBIN=<% $prefix %>/bin          \
                   INSTALLSCRIPT=<% $prefix %>/bin           \
                   INSTALLSITESCRIPT=<% $prefix %>/bin       \
                   INSTALLSITEMAN1DIR=<% $prefix %>/man/man1 \
                   INSTALLSITEMAN3DIR=<% $prefix %>/man/man3 \
  && ./Build \
  && ./Build test
fi

%install
if [ "%{buildroot}" != "/" ]; then
  rm -rf %{buildroot}
fi

echo `ls`
if [ -e Build.PL ]; then
  ./Build install
elif [ -e Makefile.PL ]; then
  make install DESTDIR=%{buildroot}
fi
find %{buildroot} -not -type d | sed -e 's#%{buildroot}##' > %{_tmppath}/filelist

%clean
if [ "%{buildroot}" != "/" ] ; then
  rm -rf %{buildroot}
fi

%files -f %{_tmppath}/filelist
%defattr(-,root,root)
