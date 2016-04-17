#! /usr/bin/perl -w

###############################################################################
# $Id: install.pl,v 1.12 2002/04/27 11:31:23 RRM Exp $
#
# install.pl
#
# This script is used to install LaTeX2HTML on the user's system
#
# Author: Marek Rouchal <marek@saftsack.fs.uni-bayreuth.de>
#
# This software is part of LaTeX2HTML, originally by Nikos Drakos
# It is published under the GNU Public License and comes without any
# warranty.
#
###############################################################################
# Changes History
#
# $Log: install.pl,v $
# Revision 1.12  2002/04/27 11:31:23  RRM
#      new release version:  2002-1
#
#  --  implements $LATEX2HTMLDIR (shared) and $LATEX2HTMLPLATDIR (unshared)
#      puts unshared l2hconf.pm into $LATEX2HTMLPLATDIR (platform-specific)
#      other modules into $LATEX2HTMLDIR (shareable across platforms)
#
#  --  checks for more graphics conversion utilities, for use with revised
#       graphics.perl  and  graphicx.perl
#
# Revision 1.11  2002/03/07 01:56:19  RRM
#  --  allow the environment variable DESTDIR to be recognise, as a means
#      of giving the installation location; e.g.
#
#         make install DESTDIR=/usr/local/mypackages/
#
#      This is mainly for package-manager software, such as Debian and fink.
#      Thanks to David R Morrison <drm@cgtp.duke.edu>
#      and Daniel Steffen <steffen@maths.mq.edu.au>  for this feature.
#
# Revision 1.10  1999/11/16 00:07:21  MRO
#
# -- minimal change to make $TMP commentable, i.e. unavailable
#
# Revision 1.9  1999/11/09 00:43:42  MRO
#
#
# -- added some changes suggested on the mail list recently: mainly cleanup
#    of -dir option
# -- added installation support for latex2html styles
#
# Revision 1.8  1999/10/26 22:32:57  MRO
#
# -- added a credit
# -- reworked parts of the INSTALL documentation
# -- installation now tries to install styles
#
# Revision 1.7  1999/10/25 21:18:22  MRO
#
# -- added more configure options (Jens' suggestions)
# -- fixed bug in regexp range reported by Achim Haertel
# -- fixed old references in documentation (related to mail list/archive)
#
# Revision 1.6  1999/10/03 18:40:42  MRO
#
# -- some cleanups for beta2
# -- "make check" now checks all Perl code
#
# Revision 1.5  1999/08/30 22:45:09  MRO
#
# -- perl now reports line numbers respective to .pin file - eases
#    code development!
# -- l2hcfg.pm is installed, too for furtjer reference
# -- some minor bugs (hopefully) fixed.
#
# Revision 1.4  1999/06/06 14:24:58  MRO
#
#
# -- many cleanups wrt. to TeXlive
# -- changed $* to /m as far as possible. $* is deprecated in perl5, all
#    occurrences should be removed.
#
# Revision 1.3  1999/06/04 15:30:20  MRO
#
#
# -- fixed errors introduced by cleaning up TMP*
# -- made pstoimg -quiet really quiet
# -- pstoimg -debug now saves intermediate result files
# -- several fixes for OS/2
#
# Revision 1.2  1999/05/19 23:54:07  MRO
#
#
# -- uniquified icons - some of them look a little bit strange, might
#    need to be fixed.
# -- got rid of unlink errors, cleaned up some cosmetics
#
# Revision 1.1  1999/05/11 06:10:03  MRO
#
#
# - merged config stuff, did first tries on Linux. Simple document
#   passes! More test required, have to ger rid of Warnings in texexpand
#
# Revision 1.12  1999/02/23 23:32:35  MRO
#
#
# -- few changes for Win32
#
# Revision 1.11  1999/02/10 01:37:15  MRO
#
#
# -- changed os-dependency structure again - now neat OO modules are
#    used: portable, extensible, neat!
# -- some minor cleanups and bugfixes
#
# Revision 1.10  1999/02/07 23:47:52  MRO
#
#
# -- made install procedure work
#
# Revision 1.9  1998/12/14 22:55:07  MRO
#
#
# -- commit test for MRO
#
# Revision 1.8  1998/12/12 16:39:17  MRO
#
#
# -- cosmetic changes, reworked catching of STDERR in config.pl (Win32)
# -- new configure opt --disable-paths
# -- major cleanups
#
# Revision 1.7  1998/12/07 23:20:00  MRO
#
#
# -- added POD documentation to pstoimg and did a general cleanup
# -- some finetuning of config procedure and modules
#
# Revision 1.6  1998/10/31 14:13:09  MRO
# -- changed OS-dependent module loading strategy: Modules are now located in
#    different (OS-specific) directories nut have the same name: Easier to
#    maintain and cleaner code
# -- Cleaned up config procedure
# -- Extended makefile functionality
#
# Revision 1.5  1998/05/06 22:31:24  latex2html
# -- Enhancements to the config procedure: Added a "generic" target
#    in the Makefile for the TeXlive CD (not perfect yet)
# -- included test for kpsewhich / Web2C
# -- included latest stuff from Override.pm into os_*.pm
#
# Revision 1.4  1998/04/28 22:22:40  latex2html
# - The platform specific stuff is now kept in a separate perl module. This
#   does not introduce significant overhead and enhances maintainability.
#
# Revision 1.3  1998/03/19 23:38:12  latex2html
# -- made pstoimg plug-in compatible with old one (touchwood!)
# -- cleaned up, added some comments
# -- inserted version information output
# -- incorporated patches to make OS/2 run better (thanks Uli)
# -- updated Makefile: make, make test, make install should work now
#
# Revision 1.2  1998/03/17 23:26:47  latex2html
# -- fixed some bugs in config.pl
# -- first version of install.pl finished
#
# Revision 1.1  1998/03/16 23:32:01  latex2html
# -- lots of cosmetic changes and bugfixes, thanks to Uli Wortmann
#    for OS/2 testing
# -- start of install procedure; checks for installation paths implemented
#
###############################################################################

require 5.003;
use strict;
# use diagnostics;
use vars qw(%cfg);

my ($VERSION) = q$Revision: 1.12 $ =~ /:\s*(\S*)/;

# --------------------------------------------------------------------------
# Initialize
# --------------------------------------------------------------------------

use cfgcache;
use L2hos;

my $dd = $cfg{'dd'};

print "install.pl (Revision $VERSION)\n\n";

my $FILECHMOD = 0644; # numbers staring with 0 are octal!
my $DIRCHMOD  = 0755;
my $BINCHMOD  = 0755;

# --------------------------------------------------------------------------
# The distribution's contents
# --------------------------------------------------------------------------

# legal values: bin|lib|plat  store in binary or library directory
#               recurse       recurse for contents (directory only)
#               from=<dir>    use other source directory
#               to=<dir>      use other destination directory
#      separate these flags with ','

my %Install_items = (
  #'Changes'           => 'lib',
  #'FAQ'               => 'lib',
  #'INSTALL'           => 'lib',
  'IndicTeX-HTML'     => 'lib,recurse',
  'L2hos'             => 'lib,recurse',
  'L2hos.pm'          => 'lib',
  #'MANIFEST'          => 'lib',
  #'README'            => 'lib',
  #'README.dvips'      => 'lib',
  #'TODO'            => 'lib',
  'XyMTeX-HTML'       => 'lib,recurse',
  #'config'            => 'lib,recurse',
  #'config.bat'        => 'lib',
  #'configure'         => 'lib',
  #'configure.in'      => 'lib',
  'cweb2html'         => 'lib,recurse',
  'docs'              => 'lib,recurse',
  'dot.latex2html-init' => 'lib',
  'example'           => 'lib,recurse',
  'foilhtml'          => 'lib,recurse',
  # icons are teated specially below
  # the local config is also installed
  'cfgcache.pm'       => 'plat',
  #'latex2html.config' is now l2hconf.pm
  'l2hconf.pm'        => 'plat',
  'makemap'           => 'lib',
  'makeseg'           => 'lib,recurse',
  #'prefs.pm'          => 'lib',
  'readme.hthtml'     => 'lib',
  'styles'            => 'lib,recurse',
  # MRO: Tests are for pre-installation testing
  #'tests'             => 'lib,recurse',
  'texinputs'         => 'lib,recurse',
  #'texlive.pm'        => 'lib',
  'versions'          => 'lib,recurse',
  #'wrapper'           => 'lib,recurse',
);

# --------------------------------------------------------------------------
# Special case: OS dependencies
# --------------------------------------------------------------------------

my @scripts = qw(latex2html pstoimg texexpand);

if($cfg{'texlive'}) {
  #$Install_items{'bin'} = 'lib,recurse';
  # where to install what be built
  my %plat_map = (
        win32 => 'win32:.bat',
        unix => 'i386-linux,rs6000-aix3.2.5,alpha-osf3.2,rs6000-aix4.1,alpha-osf4.0,mips-irix5.3,sparc-solaris2.5.1,hppa1.1-hpux10.10,mips-irix6.2,sparc-sunos4.1.4,powerpc-apple-darwin-current:'
        );
  my $script;
  foreach $script (@scripts) {
    my $plat;
    foreach $plat (qw(unix win32)) {
      my ($d,$ext) = split(/:/, $plat_map{$plat});
      my $ip;
      foreach $ip (split(',',$d)) {
        &install_file("./bin/$plat/$script$ext",
          "$cfg{'PREFIX'}/bin/$ip",$BINCHMOD);
        $Install_items{"bin/$plat/$script$ext"} =
          "to=$cfg{'PREFIX'}/bin/$ip";
      }
    }
    $Install_items{"$script.pl"} = 'lib';
  }
} elsif($cfg{'wrapper'}) {
  foreach(@scripts) {
    $Install_items{"$_$cfg{'exec_extension'}"} = 'bin,from=bin';
    $Install_items{"$_.pl"} = 'lib';
  }
} else {
  foreach(@scripts) {
    $Install_items{"$_$cfg{'exec_extension'}"} = 'bin';
  }
}

# --------------------------------------------------------------------------
# Special case: icons
# --------------------------------------------------------------------------

# icons come in two flavors: GIF and PNG. They go into a icons directory
# in SHLIBDIR (for the -local_icons option) and - if set - to ICONSTORAGE.
# The icons are installed corresponding to the supported image formats.
# If there is no image format supported, GIF icons are copied.

my @icon_types = $cfg{'IMAGE_TYPES'} ? 
  split(/\s+/,$cfg{'IMAGE_TYPES'}) : qw(gif);
my $iconrx = join('|', @icon_types);

my $dest1 = "$cfg{'SHLIBDIR'}${dd}icons";
if((-d $dest1 && !-w _) || (-d $cfg{'SHLIBDIR'} && !-w _)) {
  print STDERR "Error: Cannot install icons in '$dest1': No write permission.\n";
  $dest1 = '';
}
my $dest2 = $cfg{'ICONSTORAGE'} || '';
if(-d $dest2 && !-w $dest2) {
  print STDERR "Error: Cannot install icons in '$dest2': No write permission.\n";
  $dest2 = '';
}
my $dir = "icons";
unless(opendir(DIR,$dir)) {
  print STDERR qq{Error: Could not read directory "$dir": $!\n};
} else {
  my $icon;
  while(defined($icon = readdir(DIR))) {
    next unless($icon =~ /\.($iconrx|html)$/oi);
    my $full = "$dir/$icon";
    next if($icon =~ /^\.{1,2}$/ || !-f $full || !-s _);
    &install_file($full,$dest1,$FILECHMOD,0) if($dest1);
    &install_file($full,$dest2,$FILECHMOD,0) if($dest2);
  }
  closedir(DIR);
}

# --------------------------------------------------------------------------
# Go!
# --------------------------------------------------------------------------

my $item;
foreach $item (sort keys %Install_items) {

  # Special case: pstoimg
  if($item =~ /pstoimg/ && !$cfg{'have_pstoimg'}) {
    print qq{Warning: pstoimg not installed, because build failed.\n};
    next;
  }

  my $from = '.';
  if($Install_items{$item} =~ /(?:^|,)from=([^,]+)(?:,|$)/) {
    $from = $1;
  }

  my $dest = '';
  my $chmod = $FILECHMOD;
  if($Install_items{$item} =~ /(^|,)bin(,|$)/) {
    $dest = $cfg{'BINDIR'};
    $chmod = $BINCHMOD;
  }
  elsif($Install_items{$item} =~ /(^|,)lib(,|$)/) {
    $dest = $cfg{'SHLIBDIR'};
  }
  elsif($Install_items{$item} =~ /(^|,)plat(,|$)/) {
    $dest = $cfg{'LIBDIR'};
  }
  if($Install_items{$item} =~ /(?:^|,)to=([^,]*)(?:,|$)/) {
    $dest = $1;
  }
  
  unless($dest) {
    die qq{Error: No destination for item "$item"\n};
  }
  if($Install_items{$item} =~ /(?:^|,)chmod=(\d+)(,|$)/) {
    $chmod = $1;
  }
  if($Install_items{$item} =~ /recurse/) {
    &install_recurse($item,$dest,$chmod);
  }
  else {
    &install_file("$from/$item",$dest,$chmod);
  }
}

#-----------------------------------------------------------------------------
# try to install LaTeX2HTML style files
#-----------------------------------------------------------------------------

if($cfg{TEXPATH}) {
  print "\nNote: trying to install LaTeX2HTML style files in TeX directory tree\n     ($cfg{TEXPATH})\n";
  unless(mkpath($cfg{TEXPATH})) {
  #my $testpath = $cfg{TEXPATH}; # to strip (latex2)html
  #$testpath =~ s/[$dd$dd][^$dd$dd]*$//;
  #if((-d $cfg{TEXPATH} && !-w _) || (-d $testpath && !-w _)) {
    print STDERR "\nError: Cannot install LaTeX2HTML style files in $cfg{TEXPATH}\n";
  } else {
    my $dir = 'texinputs';
    my $dest = $cfg{TEXPATH};
    unless(opendir(DIR,$dir)) {
      print STDERR qq{Error: Could not read directory "$dir": $!\n};
    } else {
      my $file;
      my $ok = 1;
      while(defined($file = readdir(DIR))) {
        my $full = "$dir/$file";
        next if($file =~ /^\.\.?$/ || !-f $full || !-s _);
        unless(&install_file($full,$cfg{TEXPATH},$FILECHMOD,0)) {
          $ok = 0;
          last;
        }
      }
      closedir(DIR);
      if($ok && $cfg{MKTEXLSR}) {
        print "Info: Running $cfg{MKTEXLSR} to rebuild ls-R database...\n";
        system($cfg{MKTEXLSR});
      }
    }
  }
}
print "Done. Have a lot of fun with LaTeX2HTML!\n";
exit 0;

sub install_file {
  my ($src,$dest,$chmod) = @_;

  # prepend the value of DESTDIR, for package-managers
  $dest = $ENV{'DESTDIR'}.$dest if($ENV{'DESTDIR'});
  my $mkdir = $dest;

  my $file = $src;
  $file =~ s:^.*/::;
  my $full = "$dest$dd$file";

  $src  =~ s:/:$dd:g; # insert correct dir delimiter

  &mkpath($mkdir) || return 0;
  L2hos->Unlink($full); # avoid overwriting the target of symlinks
  unless(L2hos->Copy($src,$full)) {
    return 0;
  } elsif($chmod) {
    unless(chmod($chmod,$full)) {
      print STDERR qq{Warning: chmod of "$full" failed: $!\n};
      return 0;
    }
  }
  print "Info: Installed $full\n";
  1;
}

sub install_recurse {
  my ($dir,$dest,$chmod) = @_;

  my $reldir = $dir;
  $reldir =~ s:^.*/::;

  unless(opendir(DIR,$dir)) {
    print STDERR qq{Error: Could not read directory "$dir": $!\n};
    return 0;
  }
  my @subdirs = ();
  my $item;
  while(defined($item = readdir(DIR))) {
    next if($item =~ /^(\.{1,2}|CVS)$/);
    my $full = "$dir/$item";
    if(-d $full) {
      push(@subdirs,$full);
    } elsif(-s _) {
      &install_file($full,"$dest$dd$reldir",$chmod);
    } else {
      print "Warning: Skipping $full\n";
    }
  }
  closedir(DIR);
  foreach(@subdirs) {
    &install_recurse($_,"$dest$dd$reldir",$chmod);
  }
  1;
}

sub mkpath {
  my ($dir) = @_;

  unless(-d $dir) {
    if($dir =~ m#^(.*)[$dd$dd]([^$dd$dd]+)$#o) {
      my $parent = $1;
      $parent .= $dd unless($parent =~ /[$dd$dd]/o);
      &mkpath($parent) || return 0; # error
      unless(mkdir($dir,$DIRCHMOD)) {
        print STDERR qq{Error: Could not create directory "$dir": $!\n};
        return 0;
      }
    } else {
      print STDERR qq{Error: Cannot split directory "$dir"\n};
      return 0;
    }
  }
  1;
}

