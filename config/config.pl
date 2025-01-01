#! /usr/bin/perl -w

###############################################################################
# $Id: config.pl,v 1.49 2002/09/27 09:26:56 RRM Exp $
#
# config.pl
#
# Accompanies LaTeX2HTML
#
# Finds local configuration. Does a lot of checks to find external
# programs. See the manual and the INSTALL file for further
# documentation.
#
# Author: Marek Rouchal <marek@saftsack.fs.uni-bayreuth.de>
#
# This software is part of Latex2HTML, originally by Nikos Drakos
# It is published under the GNU Public License and comes without any
# warranty.
#
# You aren't supposed to edit this script. You can specify command line
# options to customize it to your local setup.

###############################################################################
# Changes History
#
# $Log: config.pl,v $
# Revision 1.49  2002/09/27 09:26:56  RRM
#  --  increased version number to  2002-2-1  (from 2002-2)
#      else automatic package software complains about checksum mismatch
#      whenever there is a change to *any* file in the distribution
#
# Revision 1.48  2002/08/20 11:33:54  RRM
#  --  increase version to  2002-2, due to changes in  latex2html.pin
#
# Revision 1.47  2002/08/17 00:15:42  RRM
#  --  fixed the order of the pnmcrop test:  ($vers >= 10 || $sub_vers > 10)
#      Thanks to Shigeharu TAKENO  for this fix.  <shige@iee.niit.ac.jp>
#
# Revision 1.46  2002/07/10 12:18:00  RRM
#  --  support netpbm version 10.x
#      thanks to  Shigeharu TAKENO  for the patch
#
# Revision 1.45  2002/04/28 12:32:02  RRM
#  --  handle $DVPSOPT and $ICONSERVER as variables configurable via prefs.pm
#
# Revision 1.44  2002/04/27 23:14:56  RRM
#  --  forgot to uncomment the test for  ppmtojpeg  after testing
#      now it will be found, for converting exotic formats to jpeg
#
# Revision 1.43  2002/04/27 11:31:23  RRM
#      new release version:  2002-1
#
#  --  implements $LATEX2HTMLDIR (shared) and $LATEX2HTMLPLATDIR (unshared)
#      puts unshared l2hconf.pm into $LATEX2HTMLPLATDIR (platform-specific)
#      other modules into $LATEX2HTMLDIR (shareable across platforms)
#
#  --  checks for more graphics conversion utilities, for use with revised
#       graphics.perl  and  graphicx.perl
#
# Revision 1.42  2002/04/10 00:32:40  RRM
#  --  added directories starting /usr/share to the search path for GS
#  --  default for library installation is now /usr/share/lib/latex2html
#      (thanks to Nelson Beebe, Utah) for this improvement.
#
# Revision 1.41  2002/03/20 04:32:02  RRM
#  --  change version number to  '2002'
#
# Revision 1.40  2002/02/28 19:25:21  RRM
#  -- fixed bug in gs version, introduced with previous edit
#
# Revision 1.39  2002/02/23 23:56:57  RRM
#  --  recognise Ghostscript PRE-RELEASE versions;
#      thanks to David R. Morrison <drm@math.duke.edu>.
#
# Revision 1.38  2001/10/25 10:39:27  RRM
#  --  pnmcrop -verbose  option only with versions  9.11+
#
# Revision 1.37  2001/10/18 10:37:53  RRM
#  --  initialise $PNMCROPOPT, for *all* versions of pnmcrop
#
# Revision 1.36  2001/08/21 10:39:15  RRM
#  --  use $PNMCROPOPT with versions v9.12+ of  pnmcrop
#
# Revision 1.35  2001/03/25 02:54:36  RRM
#  --  fixed the pnmcrop version test: >11 instead of >12
#  --  added the -sides  switch for these latest versions.
#
# Revision 1.34  2001/03/25 02:13:00  RRM
#      This detects the new Netpbm utilities, versions 8.x --> v9.11 and later
# 	available from  sourceforge.org.
#      For versions up to 9.11, a variable $PNMBLACK is set to ' -black ',
#      to allow correct cropping of black cropping-bars.
#      With versions v9.12 and later, we use:  pnmcrop -sides -verbose
#      which make the -black redundant, and works also with colored bars.
#
# Revision 1.33  2000/12/21 08:16:46  RRM
#  --  increased the version number to  2K.1beta
#
# Revision 1.32  2000/07/13 14:22:44  MRO
#
# -- fixed bug in Ghostscript detection. Enhanced it to work with 6.x
#
# Revision 1.31  2000/07/11 17:38:59  MRO
#
#
# added support for Ghostscript tester releases
#
# Revision 1.30  1999/11/09 00:43:42  MRO
#
#
# -- added some changes suggested on the mail list recently: mainly cleanup
#    of -dir option
# -- added installation support for latex2html styles
#
# Revision 1.29  1999/11/04 08:23:52  RRM
#  --  recognise:  Aladdin Ghostscript <num>.<num>
#
# Revision 1.28  1999/11/03 12:45:30  RRM
#  --  recognise  'BETA RELEASE' versions of Ghostscript
#
# Revision 1.27  1999/10/26 22:32:56  MRO
#
# -- added a credit
# -- reworked parts of the INSTALL documentation
# -- installation now tries to install styles
#
# Revision 1.26  1999/10/25 21:18:22  MRO
#
# -- added more configure options (Jens' suggestions)
# -- fixed bug in regexp range reported by Achim Haertel
# -- fixed old references in documentation (related to mail list/archive)
#
# Revision 1.25  1999/10/17 09:18:00  MRO
#
# -- Makefile now supports building of a *.zip container, too
# -- enhanced config.pl to add drive letter on DOSish platforms
#
# Revision 1.24  1999/10/06 22:04:13  MRO
#
# -- texexpand: latex2html calls texexpand with the -out option instead of
#    output redirection: this is safer on non-UNIX platforms
# -- pstoimg: now there's no default cropping (useful for standalone
#    conversions). latex2html was changes appropriately
# -- minor cleanups in latex2html script and documentation
#
# Revision 1.23  1999/10/03 18:40:42  MRO
#
# -- some cleanups for beta2
# -- "make check" now checks all Perl code
#
# Revision 1.22  1999/10/03 11:09:38  RRM
#     v99.2 beta  the alpha has been stable for a long time now
#     only minor errors have been reported recently
#
# Revision 1.21  1999/09/23 08:56:58  RRM
#  --  this version should be "thread-safe" now
#  	--- there are no more *-globs . References are used throughout.
#  --  UTF8 implemented completely, as an output encoding
#  --  use of full entity names is implemented as an output encoding
#  --  mechanism available to choose whether to allow 8-bit chars in the
#  	output, or UTF8 or entity names or images
#  --  implemented post-processing search for ,, << >> ligatures
#
# Revision 1.20  1999/09/14 22:02:02  MRO
#
# -- numerous cleanups, no new features
#
# Revision 1.19  1999/09/13 21:58:41  MRO
#
# -- replaces open_tags by reference open_tags_R, should now be transparent
# -- added some more test stuff, enhanced Makefile
# -- cleaned up README and INSTALL
#
# Revision 1.18  1999/09/09 00:30:58  MRO
#
#
# -- removed all *_ where possible
#
# Revision 1.17  1999/08/31 23:04:22  MRO
#
# -- started to get rid of *_ etc, some parts are still open
#
# Revision 1.16  1999/08/30 22:45:09  MRO
#
# -- perl now reports line numbers respective to .pin file - eases
#    code development!
# -- l2hcfg.pm is installed, too for furtjer reference
# -- some minor bugs (hopefully) fixed.
#
# Revision 1.15  1999/08/26 23:33:42  MRO
#
# -- added option to load l2hcfg.pm from previous installation
# -- fixed a bunch of bugs reported by Stefan Klupsch (thanks!)
#
# Revision 1.14  1999/07/11 08:37:08  RRM
#  --  advanced the alpha-number
#  --  much better support for non-latin1 charsets and unicode entities
#  --  added  techexpl.pl  extension for using IBM TechExplorer plug-in
#
# Revision 1.13  1999/07/10 10:14:02  RRM
#  --  Revision 1.13 has some bug-fixes and implements file-markers,
#  	so that plug-ins may get the original LaTeX source inputs
#
# Revision 1.12  1999/06/24 07:30:45  MRO
#
#
# -- remove DMBtest.db after config procedure (Linux)
#
# Revision 1.11  1999/06/24 07:28:59  MRO
#
#
# -- removed L2HMODULE
# -- fixed processing of -info switch
# -- changed option order for dvips on win32 (thanks JCL)
# -- bumped version to 99.2a8
#
# Revision 1.10  1999/06/10 23:00:01  MRO
#
#
# -- fixed an artifact in the *ball icons
# -- cleanups
# -- option documentation added
# -- fixed bug in color perl (determining path to rgb/crayola)
#
# Revision 1.9  1999/06/06 14:24:57  MRO
#
#
# -- many cleanups wrt. to TeXlive
# -- changed $* to /m as far as possible. $* is deprecated in perl5, all
#    occurrences should be removed.
#
# Revision 1.8  1999/06/04 15:30:19  MRO
#
#
# -- fixed errors introduced by cleaning up TMP*
# -- made pstoimg -quiet really quiet
# -- pstoimg -debug now saves intermediate result files
# -- several fixes for OS/2
#
# Revision 1.7  1999/06/03 13:02:44  RRM
#  --  merged fixes to latex2html collected over the past months
#  --  new features include resizable images (in MSIE only, Netscape fails)
#  --  allows customised treatment of theorem-like environments
#  --  some fixes/improvements to styles/{alltt,amsmath,amstex,makeidx}.perl
#  	and minor edits to  versions/{html3_1,math,frame}.pl and others
#
# Revision 1.6  1999/06/03 12:15:49  MRO
#
#
# - cleaned up the TMP / TMPDIR / TMP_ mechanism. Should work much the
#   same now, but the code should be easier to understand.
#
# - cleaned up L2hos, added an INSTALLation FAQ, beautified the test
#   document a little bit
#
# Revision 1.5  1999/06/01 06:55:41  MRO
#
#
# - fixed small bug in L2hos/*
# - added some test_mode related output to latex2html
# - improved documentation
# - fixed small bug in pstoimg wrt. OS2
#
# Revision 1.4  1999/05/31 07:49:13  MRO
#
#
# - a lot of cleanups wrt. OS/2
# - make test now available (TEST.BAT on Win32, TEST.CMD on OS/2)
# - re-inserted L2HCONFIG environment
# - added some new subs to L2hos (path2os, path2URL, Cwd)
#
# Revision 1.3  1999/05/21 06:49:06  MRO
#
#
# -- first attempt to make things work out of the box on Win32. There
#    are still problems with the directory/path separators
#
# Revision 1.2  1999/05/19 23:54:06  MRO
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
# Revision 1.27  1999/05/05 19:47:11  MRO
#
#
# - many cosmetic changes
# - final backup before merge
#
# Revision 1.26  1999/03/15 23:00:54  MRO
#
#
# - moved L2hos modules to top level directory, so that no dir-
#   delimiter is necessary in the @INC-statement.
# - changed strategy for "shave": Do not rely on STDERR redirection any
#   more (caused problems on at least Win32)
#
# Revision 1.25  1999/02/23 23:32:33  MRO
#
#
# -- few changes for Win32
#
# Revision 1.24  1999/02/14 23:44:36  MRO
#
#
# -- first attempt to fix Win32 problems
#
# Revision 1.23  1999/02/11 00:18:31  MRO
#
#
# -- cleaned up warppers, TeXlive stuff and Makefile
#
# Revision 1.22  1999/02/10 01:37:14  MRO
#
#
# -- changed os-dependency structure again - now neat OO modules are
#    used: portable, extensible, neat!
# -- some minor cleanups and bugfixes
#
# Revision 1.21  1998/12/12 16:39:16  MRO
#
#
# -- cosmetic changes, reworked catching of STDERR in config.pl (Win32)
# -- new configure opt --disable-paths
# -- major cleanups
#
# Revision 1.20  1998/12/08 23:50:35  MRO
#
#
# -- small change for Solaris
# -- added new target test_pstoimg in Makefile
# -- fixed bug in latex2html
#
# Revision 1.19  1998/12/07 23:19:59  MRO
#
#
# -- added POD documentation to pstoimg and did a general cleanup
# -- some finetuning of config procedure and modules
#
# Revision 1.18  1998/10/31 14:13:08  MRO
# -- changed OS-dependent module loading strategy: Modules are now located in
#    different (OS-specific) directories nut have the same name: Easier to
#    maintain and cleaner code
# -- Cleaned up config procedure
# -- Extended makefile functionality
#
# Revision 1.17  1998/08/09 17:58:19  MRO
# -- save update
#
# Revision 1.16  1998/07/01 19:35:00  MRO
# -- added more wrapper templates, updated config.pl and pertially build.pl
#
# Revision 1.15  1998/06/30 23:12:14  MRO
# -- Reworked os dependency setup, mainly for TeXlive integration.
#    Started wrapper coding.
#
# Revision 1.14  1998/06/14 14:10:41  latex2html
# -- Started to implement TeXlive configuration and better OS specific
#    handling (Batch files)                              (Marek)
#
# Revision 1.13  1998/06/07 22:35:26  latex2html
# -- included things I learned from the Win95 port to config procedure:
#    GS_LIB, Win32 module calls, directory separator stuff, ... (Marek)
#
# Revision 1.12  1998/06/01 12:58:05  latex2html
# -- Cleanup and cosmetics.
#
# Revision 1.11  1998/05/14 22:27:42  latex2html
# -- more work on config procedure (Makefile, GS_LIB)
# -- tested pstoimg in 98.1 environment successfully on Linux
#
# Revision 1.10  1998/05/06 22:31:20  latex2html
# -- Enhancements to the config procedure: Added a "generic" target
#    in the Makefile for the TeXlive CD (not perfect yet)
# -- included test for kpsewhich / Web2C
# -- included latest stuff from Override.pm into os_*.pm
#
# Revision 1.9  1998/03/23 23:42:31  latex2html
# -- fixed bug in configure.in ($PERL)
# -- fixed bug in config.pl (correct version numbering for dvips 5.58f)
# -- removed obsolete install-sh (also from configure.in)
#
# Revision 1.8  1998/03/19 23:38:10  latex2html
# -- made pstoimg plug-in compatible with old one (touchwood!)
# -- cleaned up, added some comments
# -- inserted version information output
# -- incorporated patches to make OS/2 run better (thanks Uli)
# -- updated Makefile: make, make test, make install should work now
#
# Revision 1.7  1998/03/17 23:26:44  latex2html
# -- fixed some bugs in config.pl
# -- first version of install.pl finished
#
# Revision 1.6  1998/03/16 23:33:08  latex2html
# -- small quirk fixed (removal of DBM test files)
#
# Revision 1.5  1998/03/16 23:31:58  latex2html
# -- lots of cosmetic changes and bugfixes, thanks to Uli Wortmann
#    for OS/2 testing
# -- start of install procedure; checks for installation paths implemented
#
# Revision 1.4  1998/03/12 23:04:15  latex2html
# -- small change in DBM check (no more dot in database name)
#
# Revision 1.3  1998/03/11 23:44:06  latex2html
# -- cleaned up config.pl and reworked dvips checks
# -- got pstoimg.pin up to par with the regular pstoimg
# -- cosmetic changes
# -- runs now under Win95 with Fabrice Popineau's Win32 tools (gs, TeX,...)
#
# Revision 1.2  1998/03/02 23:38:44  latex2html
# Reworked configuration procedure substantially. Fixed some killing bugs.
# Should now run on Win32, too.
# The file prefs.pm contains user-configurable stuff for DOS platforms.
# UNIX users can override the settings with the configure utility (preferred).
#
# Revision 1.1  1998/02/14 19:31:57  latex2html
# Preliminary checkin of configuration procedure
#
###############################################################################

package main;

use strict;
require 5.00305;
use Cwd;
use IO::File;

use FindBin;
use lib "$FindBin::Bin/..";
use L2hos;

#use diagnostics;
use vars qw(%prefs %cfg %newcfg);

# This is the central place to modify the release name and date!!!
my $RELEASE = '2025';
my $VERSION = 'Released January 1, 2025';

# --------------------------------------------------------------------------
# Open log
# --------------------------------------------------------------------------

# Use the same logfile as configure
my $LOGFILE = 'config.log';
my $LOG = new IO::File ">>$LOGFILE";
logit("Cannot append to $LOGFILE: $!\n") unless(defined $LOG);

# --------------------------------------------------------------------------
# Parse command line
# --------------------------------------------------------------------------

my %opt;
foreach (@ARGV) {
  # allow for two delimiting characters; DOS ignores '='!!!
  if(/^(\w+)[=+](.*)/) {
    $opt{$1} = $2 || '';
    # logit("Debug: $1 = +$2+\n");
  }
}

# --------------------------------------------------------------------------
# Initialize
# --------------------------------------------------------------------------

# The name of the configuration file to create
my $CFGFILE = 'cfgcache.pm';
logit("\nconfig.pl, Release $RELEASE ($VERSION)\n");
logit("Accompanies LaTeX2HTML, (C) 1999 GNU Public License.\n\n");

# This hash contains the final configuration
%newcfg = ('distver' => $RELEASE,
	   'release_date' => $VERSION);

# Try to read old config file; will be loaded to %cfg
my $oldconfig = $opt{'OLDCONFIG'} || $CFGFILE;
&checking("for old config file ($oldconfig)");
if(eval "require '$oldconfig';" && %cfgcache::cfg) {
  &result('loaded');
  %cfg = %cfgcache::cfg;
  undef %cfgcache::cfg;
} else {
  &result('not found (ok)');
  %cfg = ();
}

# --------------------------------------------------------------------------
# Determine platform we are running on
# --------------------------------------------------------------------------

# Platform types are currently: unix dos win32 os2 macos

&checking('for platform');

my @paths = (); # Paths where executables are located
my $dd = L2hos->dd; # The directory delimiter character (e.g. UNIX: "/")
my $pathd = L2hos->pathd; # The path delimiter character (e.g. UNIX: ":")
$newcfg{'plat'} = L2hos->plat;
$newcfg{'NULLFILE'} = L2hos->nulldev;

my $cwd = L2hos->Cwd(); # get the current directory
#$cwd =~ s:/:$dd:g; # beautify the path delimiter(s)
$cwd = cwd() unless(-d $cwd); # test if it still works :-)
$newcfg{'srcdir'} = $cwd;

# ----------------------------------------------------------------------------
# win32: Windows 95, Windows NT
# ----------------------------------------------------------------------------

if(L2hos->plat eq 'win32') {
  &result("$^O (Windows 32 bit)");
  if($ENV{'PATH'}) {
    @paths = split(/\Q$pathd/,$ENV{'PATH'});
  } else {
    @paths = qw(.);
  }
}

# ----------------------------------------------------------------------------
# dos: DOS, Windows 3.x
# ----------------------------------------------------------------------------

elsif(L2hos->plat eq 'dos') {
  &result("$^O (DOS/Windows 3.x)");
  if($ENV{'PATH'}) {
    @paths = split(/\Q$pathd/,$ENV{'PATH'});
  } else {
    @paths = qw(.);
  }
}

# ----------------------------------------------------------------------------
# os2: OS/2
# ----------------------------------------------------------------------------

elsif(L2hos->plat eq 'os2') {
  &result("$^O (OS/2)");
  if($ENV{'PATH'}) {
    @paths = split(/\Q$pathd/,$ENV{'PATH'});
  } else {
    @paths = qw(.);
  }
}

# ----------------------------------------------------------------------------
# macos: MacOS
# ----------------------------------------------------------------------------

# MRO: This is probably screwed, someone needs to test this

elsif(L2hos->plat eq 'macOS') {
  &result("$^O (MacOS)");
  if($ENV{'PATH'}) {
    @paths = split(/\Q$pathd/,$ENV{'PATH'});
  } else {
    @paths = qw(.);
  }
}

# ----------------------------------------------------------------------------
# unix: all UNIXes and clones
# ----------------------------------------------------------------------------

else { # unix
  &result("$^O (assuming $newcfg{plat})");
  if($ENV{'PATH'}) {
    @paths = split(/\Q$pathd/,$ENV{'PATH'});
  } else {
    @paths = qw(.);
  }
}

# --------------------------------------------------------------------------
# Read preferences file
#
# This step is postponed to this point in order to allow platform dependent
# configuration defaults in the preferences file.
# --------------------------------------------------------------------------

unless(require 'prefs.pm') {
  logit("Error: Preferences file not found.\n");
  cleanup(1);
  exit 1;
}
import prefs;

# --------------------------------------------------------------------------
# If we're running in TeXlive-Mode, copy the predefined cfgcache.pm and stop
# --------------------------------------------------------------------------

if(&is_true(&get_name('TEXLIVE'))) {
  &Copy('texlive.pm',$CFGFILE);
  logit("Writing predefined configuration file for TeXlive\n");
  exit 0;
}

# --------------------------------------------------------------------------
# Add extra executable search path(s)
# --------------------------------------------------------------------------

my $extrapath = $opt{EXTRAPATH} || $prefs{EXTRAPATH} || '';
@paths = grep(-d, uniquify(@paths, split(/\Q$pathd/,$extrapath)));
#logit("DEBUG: EXTRAPATH=$extrapath\n");
#logit("DEBUG: PATH=" . join(':',@paths) . "\n");

# --------------------------------------------------------------------------
# Perl Version
#
# The perl version is checked by the require command above; the following is
# added for cosmetical reasons
# --------------------------------------------------------------------------

# only perl gets an absolute pathname
my $abs_path_names = 1;
if($opt{'PERL'}) {
  $newcfg{'PERL'} = &find_prog(&get_name('PERL',1));
} else {
  $newcfg{'PERL'} = &find_prog($^X); # take the perl internal executable name
}
&checking('perl version');
&result($]);

# Read perl's own Config module
# used to get path for perldoc
use Config qw(%Config);
$newcfg{PERLSCRIPTDIR} = $Config{scriptdir};

# the other programs can live without
$abs_path_names = &get_name('ABSPATHS');

# --------------------------------------------------------------------------
# DBM check
# --------------------------------------------------------------------------

&checking('if perl supports some dbm');

my %array;
unless(dbmopen(%array,'DBMtest',0755)) {
  my $err = $@ || 'dbmopen failed';
  &result('no');
  logit("Error: Perl reported DBM error: $err\nLaTeX2HTML needs some DBM.\n");
  cleanup(1);
  exit 1;
}
else {
  #JCL: we do not need to write sth into it, if Perl lacks DBM we
  # detected it with dbmopen before...
  dbmclose(%array);
  &result('yes');
}
unlink qw(DBMtest DBMtest.dir DBMtest.pag DBMtest.db); # ignore any errors

# --------------------------------------------------------------------------
# Globbing Check
# --------------------------------------------------------------------------

&checking('if perl globbing works');

open(TMP,">TEST1.TMP"); close TMP; # create temporary test files
open(TMP,">TEST2.TMP"); close TMP;
my @list = (<TEST*.TMP>); # glob test
unlink qw(TEST1.TMP TEST2.TMP); # remove temporary test files

unless(grep(/^TEST[12]\.TMP$/i,@list) == 2) {
  &result('no');
  logit("  Cannot live without globbing\n");
  # Try to find out what is going wrong
  # Perl uses full_csh to perform globbing, this may change of course
  my $csh = eval {require 'Config.pm'; &Config::FETCH('','full_csh')};
  if($csh) {
    unless(-f $csh) {
      logit("Error: $csh does not exist\n");
    }
    elsif(!-x $csh) {
      logit("Error: $csh is not executable\n");
    }
    else {
      logit("Error: unknown globbing problem, check perl installation\n");
    }
  }
  else {
    logit("Error: perl globbing failed. Couldn't determine csh info.\n");
  }
  cleanup(1);
  exit 1;
}
else {
  &result('yes');
}

# --------------------------------------------------------------------------
# Hashbang script starts
# --------------------------------------------------------------------------

$newcfg{'texlive'} = &is_true(&get_name('TEXLIVE'));
$newcfg{'wrapper'} = &is_true(&get_name('WRAPPER'));

$newcfg{'HASHBANG'} = 0;
$newcfg{'exec_extension'} = '';
$newcfg{'perl_starter'} = '';
$newcfg{'PERLHEADER'} = '';
$newcfg{'PERLFOOTER'} = '';

# Unix: Use #! mechanism, if it works

if($newcfg{'plat'} =~ /unix/i) {
  if(&is_true(&get_name('HASHBANG'))) {
    $newcfg{'PERLHEADER'} = "#! $newcfg{'PERL'} -w\n";
    $newcfg{'HASHBANG'} = 1;
  }
  else {
    # Hashbang script starts are not allowed; use this "killer" to
    # start the script on (almost) all sorts of shells...
    $newcfg{'PERLHEADER'} = <<"EOF";
# -*- perl -*- -w
eval '(exit \$?0)' && eval 'exec $newcfg{'PERL'} -S \$0 \${1+"\$\@"}'
  & eval 'exec $newcfg{'PERL'} -S \$0 \$argv:q'
  if 0; # suppress this stuff in perl
EOF
    $newcfg{'perl_starter'} = $newcfg{'PERL'};
  }
}

# OS/2: Use the "extproc" mechanism

elsif($newcfg{'plat'} =~ /os2/i) {
  $newcfg{'PERLHEADER'} = "extproc $newcfg{'PERL'} -S -w\n";
  $newcfg{'exec_extension'} = '.cmd';
  $newcfg{'perl_starter'} = $newcfg{'PERL'};
}

# DOS/Windows: Create BATch files

elsif($newcfg{'plat'} =~ /dos|win32/i) {
  $newcfg{'PERLHEADER'} = <<"EOF";
\@rem = '--*-Perl-*--
\@echo off
set arg=
set prog=%0
:one
set arg=%*
:two
if exist %prog%.bat goto indot
$newcfg{'PERL'} -x -S %prog% %arg%
goto endofperl
:indot
$newcfg{'PERL'} -x %prog%.bat %arg%
set arg=
set prog=
goto endofperl
\@rem ';
#! perl -w
# line 21
EOF
  $newcfg{'PERLFOOTER'} = <<"EOF";
__END__
:endofperl
EOF
  $newcfg{'exec_extension'} = '.bat';
  $newcfg{'perl_starter'} = "$newcfg{'PERL'} -x";
}

# other OSes have no means for starting up scripts

else {
  $newcfg{'PERLHEADER'} = "# -*- perl -*- -w\n";
  $newcfg{'perl_starter'} = $newcfg{'PERL'};
}

# --------------------------------------------------------------------------
# Images
#
# Supported image output formats: GIF and PNG
#
# Note that the GIF format has some legal restrictions: Due to the usage
# of LZW compression in the GIF format, that is licensed by Unisys, every
# program creating GIFs has to have a license from Unisys when run for
# commercial purposes.
# --------------------------------------------------------------------------

$opt{'have_pstoimg'} = 1; # be optimistic that pstoimg can be built
$opt{'IMAGES'} = &is_true(&get_name('IMAGES'));
$opt{'GIF'} = &is_true(&get_name('GIF'));
$opt{'PNG'} = &is_true(&get_name('PNG'));
$opt{'SVG'} = &is_true(&get_name('SVG'));

unless($opt{'GIF'} || $opt{'PNG'}) {
  $opt{'IMAGES'} = 0;
  $opt{'have_pstoimg'} = 0;
  logit("Warning: Both GIF and PNG support disabled. LaTeX2HTML won't generate any images.\n");
}

# --------------------------------------------------------------------------
# TeX, LaTeX, IniTeX, Web2C
# --------------------------------------------------------------------------

$newcfg{'TEX'} = '';

if($opt{'IMAGES'}) {
  my $tex = &find_prog(&get_name('TEX',1));
  if($tex) {
    $newcfg{'TEX'} = $tex;
  }
}
  
$newcfg{'LATEX'} = '';

if($opt{'IMAGES'}) {
  my $latex = &find_prog(&get_name('LATEX',1));
  if($latex) {
    $newcfg{'LATEX'} = $latex;
  }
  else {
    $opt{'IMAGES'} = 0;
    &warn_no_images();
  }
}
  
$newcfg{'PDFLATEX'} = '';

if($opt{'IMAGES'}) {
  my $pdflatex = &find_prog(&get_name('PDFLATEX',1));
  if($pdflatex) {
    $newcfg{'PDFLATEX'} = $pdflatex;
  }
  else {
    $opt{'IMAGES'} = 0;
    &warn_no_images();
  }
}
  
$newcfg{'LUALATEX'} = '';

if($opt{'IMAGES'}) {
  my $lualatex = &find_prog(&get_name('LUALATEX',1));
  if($lualatex) {
    $newcfg{'LUALATEX'} = $lualatex;
  }
  else {
    $opt{'IMAGES'} = 0;
    &warn_no_images();
  }
}
  
$newcfg{'DVILUALATEX'} = '';

if($opt{'IMAGES'}) {
  my $dvilualatex = &find_prog(&get_name('DVILUALATEX',1));
  if($dvilualatex) {
    $newcfg{'DVILUALATEX'} = $dvilualatex;
  }
  else {
    $opt{'IMAGES'} = 0;
    &warn_no_images();
  }
}
  
$newcfg{'INITEX'} = '';

if($opt{'IMAGES'}) {
  my $initex = &find_prog(&get_name('INITEX',1));
  if($initex) {
    $newcfg{'INITEX'} = $initex;
  }
}

$newcfg{'KPSEWHICH'} = '';
$newcfg{'WEB2C'} = 0;
my $kpath = '';

my $kpsewhich = &find_prog(&get_name('KPSEWHICH',1));
if($kpsewhich) {
  $newcfg{'KPSEWHICH'} = $kpsewhich;
  &checking('for kpsewhich syntax');
  my @try_opts = ('-show-path=tex', '-p tex');
  my $try;
  my $num = 1;
  foreach $try (@try_opts) {
    my ($stat,$out,$err) = &get_out_err("$kpsewhich $try");
    if($stat == 0) { # ok
      $newcfg{'WEB2C'} = $num;
      &result("ok (style=$num)");
      $kpath = $out;
      last;
    }
    $num++;
  }
  if(--$num > $#try_opts) {
    &result("no, from which planet is your kpsewhich?");
    $newcfg{'KPSEWHICH'} = '';
  }
}

if ($kpsewhich) {
    &checking('for preview.sty');
    my ($stat,$out,$err) = &get_out_err("$kpsewhich preview.sty");
    if($stat == 0) { # ok
	&result("ok");
    } else {
	&logit("NONE\nWarning: preview.sty not found.\n         svg images will not work.\n         dvipng will not work\n");
    }
}

&checking('for TeX include path');
my $texpath = $opt{TEXPATH} || $prefs{TEXPATH} || '';
if($texpath eq 'no') {
    $texpath = '';
}
elsif(!$texpath && $kpath) {
  my @texpaths = ();
  chomp($kpath);
  foreach(split(/\Q$pathd/,$kpath)) {
    s/^!+//; # strip leading !'s
    s:[/\\]+$::; # strip trailing path delims
    $_ = L2hos->path2os($_);
    if(L2hos->is_absolute_path($_) && -d) {
      push(@texpaths,$_);
    }
  }
  if(@texpaths > 1) {
    ($texpath) = grep(-d $_.$dd.'latex', @texpaths);
    $texpath = $texpaths[0] unless($texpath);
  } else {
    $texpath = $texpaths[0] || '';
  }
  if(-d $texpath.$dd.'latex') {
    $texpath .= $dd . 'latex';
  }
  if(-d $texpath.$dd.'latex2html') {
    $texpath .= $dd . 'latex2html';
  } else {
    $texpath .= $dd . 'html';
  }
}
unless($texpath) {
  logit("NONE\nWarning: Will not automatically install LaTeX2HTML style files.\n");
} else {
  &result($texpath);
  # find the ls-R update tool
  $newcfg{'MKTEXLSR'} = &find_prog(&get_name('MKTEXLSR',1));
}
$newcfg{'TEXPATH'} = $texpath;

# --------------------------------------------------------------------------
# dvips
#
# This (and gs) is the most complicated setup feature. It is advisable to
# get the latest version of dvips for best results, i.e. currently(?)
# 5.76
# --------------------------------------------------------------------------

$newcfg{'DVIPS'} = '';
$newcfg{'DVIPSOPT'} = $prefs{'DVIPSOPT'}||'';
$newcfg{'PK_GENERATION'} = 0;
$newcfg{'have_dvipsmode'} = '';
$newcfg{'METAMODE'} = '';
$newcfg{'METADPI'} = 0;

if($opt{'IMAGES'}) {
  my $dvips = &find_prog(&get_name('DVIPS',1));
  if($dvips) {
    my @switches = '';
    &checking('dvips version');
    my $veropt;
    my $version = '';

    # Try to determine the version. Obstacles: output goes to STDOUT or
    # STDERR and can have different formats

    my @tryopts;
    if($newcfg{'plat'} eq 'os2') {
      # --version requires pressing \n on OS/2
      @tryopts = ('','--version','-?','-v');
    } elsif($newcfg{'plat'} eq 'win32') {
      # --version requires pressing \n on MikTeX
      @tryopts = ('','--version','-?','-v');
    } else {
      @tryopts = ('--version','','-?','-v');
    }
    foreach $veropt (@tryopts) {
      my ($stat,$msg,$err) = &get_out_err("$dvips $veropt");
      $msg .= $err || '';
      if(!$stat && $msg =~ /(?:^| )dvips(?:\(k\)|k|)\s*(\d+[.]?\d*[A-Z]?)/is) {
        $version = $1;
        last;
      }
    }
    unless($version) {
      $opt{'IMAGES'} = 0;
      &result('no');
      logit(qq{Error: could not determine dvips version\n});
      &warn_no_images();
    }
    else {
      &result($version);
      my $numeric = $version;
      # convert letter minor number to decimal
      if($numeric =~ /(\d+[.]?\d*)([A-Z])/i) {
        my ($primary,$secondary) = ($1,$2);
        if($secondary) {
          $secondary = unpack('C',uc($2))-unpack('C','A')+1;
          $secondary = "0$secondary" if($secondary < 10);
        }
        else {
          $secondary = '00';
        }
        $numeric = "$primary$secondary";
      }
      if($numeric < 5.516) {
        logit(<<"EOF");
Warning: This dvips version does not support all features requested by pstoimg.
         It is recommended to upgrade to a more recent version.
EOF
      }
      &checking('if dvips supports the combination of -E and -i -S 1');
      # this option is available since 5.62
      if($numeric > 5.61 && &is_true(&get_name('EPS'))) {
        push(@switches, '-E');
        &result('yes');
      }
      else {
        &result('no');
      }
      if(&is_true(&get_name('REVERSE'))) {
        push(@switches, '-r0');
      }
      $newcfg{'DVIPS'} = $dvips;
      $newcfg{'DVIPSOPT'} .= join(' ','',@switches) if (@switches);

      # Font generation
      if(&is_true(&get_name('PK'))) {
        $newcfg{'PK_GENERATION'} = 1;
        $newcfg{'METAMODE'} = lc(&get_name('METAMODE'));
        $newcfg{'METADPI'} = &get_name('METADPI') || 0;
        logit("Note: Will use PK generation (mode=$newcfg{'METAMODE'}, dpi=$newcfg{'METADPI'})\n");
        &checking('if dvips supports the -mode switch');
        # the -mode switch is available since 5.58c
        if($numeric >= 5.5803) {
          $newcfg{'have_dvipsmode'} = 1;
          &result('yes');
        }
        else {
          $newcfg{'have_dvipsmode'} = 0;
          &result('no');
        }
      }
      else {
        $newcfg{'PK_GENERATION'} = 0;
      }
    }
  }
  else {
    $opt{'IMAGES'} = 0;
    &warn_no_images();
  }
}

# --------------------------------------------------------------------------
# dvipng
# --------------------------------------------------------------------------

$newcfg{'DVIPNG'} = '';

if($opt{'IMAGES'}) {
  my $dvipng = &find_prog(&get_name('DVIPNG',1));
  if($dvipng) {
    $newcfg{'DVIPNG'} = $dvipng;
  }
}

# --------------------------------------------------------------------------
# pdftocairo
# --------------------------------------------------------------------------

$newcfg{'PDFTOCAIRO'} = '';

if($opt{'IMAGES'}) {
  my $pdftocairo = &find_prog(&get_name('PDFTOCAIRO',1));
  if($pdftocairo) {
    $newcfg{'PDFTOCAIRO'} = $pdftocairo;
  } else {
    $opt{'SVG'} = 0;
  }
}

# --------------------------------------------------------------------------
# ps2pdf
# --------------------------------------------------------------------------

$newcfg{'PS2PDF'} = '';

if($opt{'IMAGES'}) {
  my $ps2pdf = &find_prog(&get_name('PS2PDF',1));
  if($ps2pdf) {
    $newcfg{'PS2PDF'} = $ps2pdf;
  }
}

# --------------------------------------------------------------------------
# pdfcrop
# --------------------------------------------------------------------------

$newcfg{'PDFCROP'} = '';

if($opt{'IMAGES'}) {
  my $pdfcrop = &find_prog(&get_name('PDFCROP',1));
  if($pdfcrop) {
    $newcfg{'PDFCROP'} = $pdfcrop;
  }
}

# HTML validator
# checks the validity of the generated HTML
# The support is very rudimentary here.

$newcfg{'HTML_VALIDATOR'} = '';

my $validator = &find_prog(&get_name('HTML_VALIDATOR',1));
if($validator) {
  $newcfg{'HTML_VALIDATOR'} = $validator;
}

  
# --------------------------------------------------------------------------
# Ghostscript
#
# There are versions from 2.6.1 to 5.x available and running out there.
# We have to make the best out of every single one. If you asked me, I'd say:
# get 4.03 or some 5.x and everything would be perfect.
# --------------------------------------------------------------------------

$newcfg{'GS'} = '';
$newcfg{'GSDEVICE'} = '';
$newcfg{'GSALIASDEVICE'} = '';
$newcfg{'have_geometry'} = 0;
$newcfg{'GSLANDSCAPE'} = '';
$newcfg{'GS_LIB'} = '';

if($opt{'have_pstoimg'}) {
  my $gs = &find_prog(&get_name('GS',1));
  if($gs) {
    my @gs_devs;
    my @gs_lib_path;
    my $gs_version;

    my $flag = 0;
    unless(open(GS,"$gs -h 2>&1|")) {
      $opt{'have_pstoimg'} = 0;
      logit("Error: could not execute $gs\n");
      &warn_no_images();
    }
    else {
      &checking('for ghostscript version');

      # Parse output of "gs -h". This should give us all the facts we
      # need for configuring Ghostscript.

      while (<GS>) {
        chomp;
        if($flag == 0 && /Ghostscript\s*(?:Version|(?:PRE-|BETA |TESTER )RELEASE|)\s*(\d+[.]?\d*)/i) {
          $gs_version = $1;
          $flag = 1;
        }
        elsif($flag && /^\s*Available devices/i) {
          $flag = 2; # Now look for the devices
        }
        elsif($flag && /^\s*Search path/i) {
          $flag = 3; # Now look for the gs lib path
        }
        elsif ($flag == 2) {
          # if line starts with whitespace, then we're in the devices list
          if(/^\s+(.*?)\s*$/) {
            push(@gs_devs,split(/\s+/,$1));
          }
          else {
            $flag = 1; # no more devices
            redo;
          }
        }
        elsif ($flag == 3) {
          # if line starts with whitespace, then we're in the search path list
          if(/^\s+(.*?)\s*$/ && length($1)) {
            foreach(split(/\s*[$pathd]+\s*/,$1)) {
              push(@gs_lib_path,L2hos->path2os($_)) if(length && -d $_);
            }
          }
          else {
            $flag = 1;
            redo;
          } # no more path entries
        }
      }
      close(GS);

      # Configure things determined by the Ghostscript version

      unless($gs_version) {
        &result('no');
        $opt{'have_pstoimg'} = 0;
        logit("Error: could not determine gs version\n");
        &warn_no_images();
      }
      else {
        &result($gs_version);
        if($gs_version < 3.3) {
          logit(<<"EOF");
Warning: Your Ghostscript interpreter is quite outdated. To make use of the
         advanced features of pstoimg, you should install Ghostscript 4.03 or
         5.x on your system.
EOF
        }
        else {
          $newcfg{'have_geometry'} = 1;
        }
        $newcfg{'GS'} = $gs;
        &checking('for ghostscript portable bitmap device');
        if(@gs_devs) {
          unless(&determine_gsdevice('GSDEVICE',q(pnmraw ppmraw pgnmraw pgmraw pbmraw ppm pgnm pgm pnm pbm),@gs_devs)) {
            $opt{'have_pstoimg'} = 0;
          }
        }
        else {
          &result('no');
          $opt{'have_pstoimg'} = 0;
          logit("Error: could not determine gs devices\n");
          &warn_no_images();
        }
        if($opt{'have_pstoimg'} && $gs_version > 4.02) {
          &checking('for full color device for anti-aliasing');
          &determine_gsdevice('GSALIASDEVICE',q(ppmraw pgmraw pnmraw pgnmraw ppm pgm pgnm pnm),@gs_devs);
        }
        else {
          $newcfg{'GSALIASDEVICE'} = '';
        }

        # Set up the Ghostscript library path

        &checking('for ghostscript library path');
        my @try_path = @gs_lib_path;

        # Filter valid paths from environment, if set

        if($ENV{'GS_LIB'}) {
          my @gspaths = grep(-d $_,split(/\s*[$pathd]\s*/,$ENV{'GS_LIB'}));
          push(@try_path,@gspaths) if(@gspaths);
        }

        # Add some sensible guesses

        if($newcfg{'plat'} =~ /dos|win32|os2/i ) {
          my $gsdir = $gs;
          $gsdir =~ s|\Q$dd\E[^$dd$dd]*$||; # strip name of executable
          # try this directory and the parent
          push(@try_path,$gsdir,"$gsdir${dd}..");
        }
        elsif($newcfg{'plat'} =~ /unix/i ) {
          push(@try_path,qw(/usr/share/ghostscript /usr/lib/ghostscript
            /usr/local/ghostscript /usr/local/share/ghostscript
            /usr/local/lib/ghostscript/usr/share/gs /usr/lib/gs /usr/local/gs
	    /usr/share/lib/gs /usr/share/gs /usr/share/ghostscript
            /usr/local/share/gs /usr/local/lib/gs));
        }

        # Now look for "gs_init.ps". Also try to add
        # - the Ghostscript version or
        # - "gs<version>"
        # to the path. This should cover a large number of configurations.

        my $path;
        my @right_paths = ();
        my $gs_lib = 0;
	# 2017-04-11 shige: 2-24)
	my $gs_stand_ps;
        Gslibpaths: foreach $path (@try_path) {
          foreach('',"$dd$gs_version","${dd}gs$gs_version") {
            my $testpath = $path . $_;
            # if(!$gs_lib && -d $testpath && -s "$testpath${dd}gs_init.ps") {
	    # 2017-04-11, 2019-12-03 shige: 2-24)
	    if ($testpath =~ /tlgs/) { $gs_stand_ps = "landscap.ps"; }
	    else { $gs_stand_ps = "gs_init.ps"; }
            if(!$gs_lib && -d $testpath && -s "$testpath${dd}$gs_stand_ps") {
              push(@right_paths,L2hos->path2os($testpath));
              $gs_lib = 1;
            }
            last Gslibpaths if($gs_lib);
          }
        }

        my @additional_paths = ();
        unless($gs_lib) {
          &result('no');
          logit(<<"EOF");
Warning: Could not determine GS_LIB path.
         Ghostscript may not work due to missing startup files.
         You need to set the value of GS_LIB manually in $CFGFILE.
Hint:    Search for the file 'gs_init.ps'. 
         This directory should be set in GS_LIB.
         Separate the entries with the "$pathd" character. The current
         directory "." should be included, too.
EOF
        }
        else {
           #push(@right_paths,'.');
	   # 2019-12-16 shige: 2-24) 
           my $item;
           foreach $item (@right_paths) {
             $item = &simplify_path($item);
             if(!grep($_ eq $item, @gs_lib_path)) {
               push(@additional_paths,$item);
             }
           }
           if(@additional_paths) {
             $newcfg{'GS_LIB'} = join($pathd,@additional_paths);
             &result("$newcfg{'GS_LIB'} (in addition to built-in paths)");
           }
           else {
             $newcfg{'GS_LIB'} = '';
             &result("built-in paths are correct");
           }
         }

        # The old Ghostscripts (<3.x) don't have the "-g" option. To enable
        # efficient image creation, try to determine "landscap.ps" so that
        # rotation can be used to minimize the area of the generated bitmap.

        push(@gs_lib_path,@additional_paths);
        if($opt{'have_pstoimg'} && !$newcfg{'have_geometry'}) {
          &checking('for landscap.ps');
          my $landscap;
          if(@gs_lib_path) {
            foreach(@gs_lib_path) {
              $landscap = "$_${dd}landscap.ps";
              if(-s $landscap){
                &result($newcfg{'GSLANDSCAPE'} = $landscap);
                last;
              }
              undef $landscap;
            }
          }
          unless($landscap) {
            &result('no');
            logit(<<"EOF");
Warning: Could not find landscap.ps
         You may want to set the value of GSLANDSCAPE
         (path to landscap.ps) manually in $CFGFILE.
EOF
          }
        }
      }
    }
  }
  else {
    $opt{'have_pstoimg'} = 0;
    &warn_no_images();
  }
}

# --------------------------------------------------------------------------
# PNMCROP
#
# The crucial point of pnmcrop is the "-l" option (crop from the left).
# It only works in the 1mar1994p1 version, but pstoimg depends heavily on it.
# --------------------------------------------------------------------------
# rrm. 2001/3/17:
# Later revisions (v9.x) require  -left etc. and need  -verbosity 
# to produce the messages that say what cropping has been performed.
# --------------------------------------------------------------------------

$newcfg{'PNMCROP'} = '';
$newcfg{'PNMBLACK'} = '';
$newcfg{'PNMCROPOPT'} = '';

if($opt{'have_pstoimg'}) {
  my $pnmcrop = &find_prog(&get_name('PNMCROP',1));
  if($pnmcrop) {
    my ($stat,$msg,$err) = ('','','');
    ($stat,$msg,$err) = &get_out_err("$pnmcrop -version");
    my $vers = '';
    my $major_vers = '';
    $msg = $msg || $err;
    if ($msg =~ /(^|\s*)Version.*\s([\d\.]+)\s*([\n\r]|$)/is) {
        $vers = $2;
        ($major_vers) = $vers =~ /^(\d+)/;
    }
    if ($vers =~ /(\d+\.\d+)(?:\.\d+)+/) {
        $vers = $1;
        ($major_vers) = $vers =~ /^(\d+)/;
    }
    &checking('if pnmcrop can crop from one direction');
    if ($major_vers =~ /^199/) {
	# try left crop
        my $timg = "config${dd}timg.pnm";
	($stat,$msg,$err) = &get_out_err("$pnmcrop -l $timg");
    } elsif ($major_vers > 8) {
	my $sub_vers = '';
	if ($vers =~ /9\.(\d+)/) {
	    $sub_vers = $1;
	    unless ($sub_vers > 11) {
		$newcfg{'PNMBLACK'} = ' -black ';
		print
	"\n Please update to Netpbm 9.12+, from sourceforge.org/projects/netpbm/\n",
	" else colored cropping-bars will not be removed.\n";
	    } else {
#		$pnmcrop .= ' -sides ';
		$newcfg{'PNMCROPOPT'} = ' -sides ';
	    }
	} else { $newcfg{'PNMCROPOPT'} = ' -sides '; }
	$msg = 'there is nothing to crop'; $stat = '';
    } else {
	print "\nThis $vers for $pnmcrop is not recognisable.";
	$stat = 1;
    }

    unless(!$stat && $msg =~ /^p\d+[\s\n]+\d+\s+\d+|nothing to crop/is) {
      $opt{'have_pstoimg'} = 0;
      &result('no');
      &warn_no_images();
      logit(<<"EOF");
Hint: Get netpbm version 1mar1994p1 (the p1 is important!) to fix this
      error, or later versions (v9.15+) from  sourceforge.net .
EOF
    }
    else {
      &result('yes');
      $newcfg{'PNMCROP'} = $pnmcrop;
    }
  }
  else {
    $opt{'have_pstoimg'} = 0;
    &warn_no_images();
  }
}

# --------------------------------------------------------------------------
# PNMFLIP
# --------------------------------------------------------------------------

$newcfg{'PNMFLIP'} = '';

if(1) {
  my $pnmflip = &find_prog(&get_name('PNMFLIP',1));
  if($pnmflip) {
    $newcfg{'PNMFLIP'} = $pnmflip;
  } else {
     &warn_no_graphics('flipping');
  }
}

# --------------------------------------------------------------------------
# PNMQUANT
# --------------------------------------------------------------------------

$newcfg{'PNMQUANT'} = '';

if(1) {
  my $pnmquant = &find_prog(&get_name('PNMQUANT',1));
  if($pnmquant) {
    $newcfg{'PNMQUANT'} = $pnmquant;
  }
}

# --------------------------------------------------------------------------
# PNMFILE
# --------------------------------------------------------------------------

$newcfg{'PNMFILE'} = '';

if(1) {
  my $pnmfile = &find_prog(&get_name('PNMFILE',1));
  if($pnmfile) {
    $newcfg{'PNMFILE'} = $pnmfile;
  }
}

# --------------------------------------------------------------------------
# PNMCAT
# --------------------------------------------------------------------------

$newcfg{'PNMCAT'} = '';

if(1) {
  my $pnmcat = &find_prog(&get_name('PNMCAT',1));
  if($pnmcat) {
    $newcfg{'PNMCAT'} = $pnmcat;
  } else {
     &warn_no_graphics('concatenation');
  }
}

# --------------------------------------------------------------------------
# PBMMAKE
# --------------------------------------------------------------------------

$newcfg{'PBMMAKE'} = '';

if(1) {
  my $pbmmake = &find_prog(&get_name('PBMMAKE',1));
  if($pbmmake) {
    $newcfg{'PBMMAKE'} = $pbmmake;
  } else {
     &warn_no_graphics('padding');
  }
}

# --------------------------------------------------------------------------
# PPMTOGIF
#
# Some versions of ppmtogif can produce transparent and interlaced GIFs.
# --------------------------------------------------------------------------

$newcfg{'PPMTOGIF'} = '';
$newcfg{'gif_trans'} = '';
$newcfg{'gif_interlace'} = '';

#if(($opt{'have_pstoimg'} && $opt{'GIF'})||(1)) {
if(1) {
  my $ppmtogif = &find_prog(&get_name('PPMTOGIF',1));
  if($ppmtogif) {
    my ($stat,$msg,$err) = ('','','');
    ($stat,$msg,$err) = &get_out_err("$ppmtogif -version");
    $msg = $msg || $err;
    my $vers = '';
    if ($msg =~ /(^|\s*)Version.*\s([\d\.]+)\s*([\n\r]|$)/is) { $vers = $2; }
    &checking('if ppmtogif can make transparent GIFs');
    if ($vers =~ /^199/) {
	# '-h' is an invalid option. Nevertheless it forces ppmtogif to output a
	# usage information to stderr. We'll have a closer look at that.
	($stat,$msg,$err) = &get_out_err("$ppmtogif -h");
	$msg .= $err || '';
    } else {
	$msg = 
  'ppmtogif [-interlace] [-sort] [-map mapfile] [-transparent color] [-comment text]';
    }
    $newcfg{'PPMTOGIF'} = $ppmtogif;

    if ($opt{'have_pstoimg'} && $opt{'GIF'}) {
    unless($msg =~ /ppm(to|2)gif/i) {
      $opt{'GIF'} = 0;
      result("error\n    Execution of $ppmtogif did not produce expected output\n");
    }
    else {
      if($msg =~ /-transparent/i) {
        &result('yes');
        $newcfg{'gif_trans'} = 'netpbm';
      }
      else {
        &result('no');
      }
      &checking('if ppmtogif can make interlaced GIFs');
      if($msg =~ /-interlace/i) {
        &result('yes');
        $newcfg{'gif_interlace'} = 'netpbm';
      }
      else {
        &result('no');
      }
    }}
  }
  else {
    $opt{'GIF'} = 0;
  }
}

# --------------------------------------------------------------------------
# PNMTOPNG
# --------------------------------------------------------------------------

$newcfg{'PNMTOPNG'} = '';

#if($opt{'have_pstoimg'} && $opt{'PNG'}) {
if(1) {
  my $pnmtopng = &find_prog(&get_name('PNMTOPNG',1));
  if($pnmtopng) {
    $newcfg{'PNMTOPNG'} = $pnmtopng;
  }
  else {
    $opt{'PNG'} = 0;
  }
}

$newcfg{'have_images'} = $opt{'IMAGES'};
if($opt{'have_pstoimg'}) {
  if($opt{'GIF'} || $opt{'PNG'}) {
    $newcfg{'have_pstoimg'} = 1;
  }
  else {
    $newcfg{'have_images'} = $newcfg{'have_pstoimg'} = 0;
    &warn_no_images();
  }
}
else {
  $newcfg{'have_images'} = $newcfg{'have_pstoimg'} = 0;
}

# --------------------------------------------------------------------------
# PPMTOJPEG
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'PPMTOJPEG'} = '';

if(1) {
  my $ppmtojpeg = &find_prog(&get_name('PPMTOJPEG',1));
  if($ppmtojpeg) {
    $newcfg{'PPMTOJPEG'} = $ppmtojpeg;
  } else {
     &warn_no_image_type('jpg');
  }
}


$newcfg{'IMAGE_TYPES'} = '';	# types for latex2html, subset of svg, png, gif
$newcfg{'PSTOIMG_TYPES'} = '';	# types for pstoimg, subset of png, gif

if($newcfg{'have_pstoimg'}) {
  my @imgtypes = ();
  my @pstoimgtypes = ();
  if($opt{'SVG'}) {
    push(@imgtypes,'svg');
  }
  if($opt{'PNG'}) {
    push(@imgtypes,'png');
    push(@pstoimgtypes,'png');
  }
  if($opt{'GIF'}) {
    push(@imgtypes,'gif');
    push(@pstoimgtypes,'gif');
  }
  $newcfg{'IMAGE_TYPES'} = join(' ',@imgtypes);
  $newcfg{'PSTOIMG_TYPES'} = join(' ',@pstoimgtypes);
}

# --------------------------------------------------------------------------
# PNMCUT
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'PNMCUT'} = '';

if(1) {
  my $pnmcut = &find_prog(&get_name('PNMCUT',1));
  if($pnmcut) {
    $newcfg{'PNMCUT'} = $pnmcut;
  } else {
     &warn_no_graphics('viewport');
  }
}

# --------------------------------------------------------------------------
# PNMPAD
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'PNMPAD'} = '';

if(1) {
  my $pnmpad = &find_prog(&get_name('PNMPAD',1));
  if($pnmpad) {
    $newcfg{'PNMPAD'} = $pnmpad;
  } else {
     &warn_no_graphics('padding');
  }
}

# --------------------------------------------------------------------------
# PNMROTATE
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'PNMROTATE'} = '';

if(1) {
  my $pnmrotate = &find_prog(&get_name('PNMROTATE',1));
  if($pnmrotate) {
    $newcfg{'PNMROTATE'} = $pnmrotate;
  } else {
     &warn_no_graphics('rotation');
  }
}

# --------------------------------------------------------------------------
# PNMSCALE
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'PNMSCALE'} = '';

if(1) {
  my $pnmscale = &find_prog(&get_name('PNMSCALE',1));
  if($pnmscale) {
    $newcfg{'PNMSCALE'} = $pnmscale;
  } else {
     &warn_no_graphics('scaling');
  }
}

# --------------------------------------------------------------------------
# GIFTOPNM
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'GIFTOPNM'} = '';

if(1) {
  my $giftopnm = &find_prog(&get_name('GIFTOPNM',1));
  if($giftopnm) {
    $newcfg{'GIFTOPNM'} = $giftopnm;
  } else {
     &warn_no_image_type('gif');
  }
}

# --------------------------------------------------------------------------
# JPEGTOPNM
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'JPEGTOPNM'} = '';

if(1) {
  my $jpegtopnm = &find_prog(&get_name('JPEGTOPNM',1));
  if($jpegtopnm) {
    $newcfg{'JPEGTOPNM'} = $jpegtopnm;
  } else {
     &warn_no_image_type('jpeg');
  }
}

# --------------------------------------------------------------------------
# PNGTOPNM
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'PNGTOPNM'} = '';

if(1) {
  my $pngtopnm = &find_prog(&get_name('PNGTOPNM',1));
  if($pngtopnm) {
    $newcfg{'PNGTOPNM'} = $pngtopnm;
  } else {
     &warn_no_image_type('png');
  }
}

# --------------------------------------------------------------------------
# TIFFTOPNM
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'TIFFTOPNM'} = '';

if(1) {
  my $tifftopnm = &find_prog(&get_name('TIFFTOPNM',1));
  if($tifftopnm) {
    $newcfg{'TIFFTOPNM'} = $tifftopnm;
  } else {
     &warn_no_image_type('tiff');
  }
}

# --------------------------------------------------------------------------
# ANYTOPNM
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'ANYTOPNM'} = '';

if(1) {
  my $anytopnm = &find_prog(&get_name('ANYTOPNM',1));
  if($anytopnm) {
    $newcfg{'ANYTOPNM'} = $anytopnm;
  } else {
     &warn_no_image_type('arbitrary');
  }
}

# --------------------------------------------------------------------------
# BMPTOPPM
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'BMPTOPPM'} = '';

if(1) {
  my $bmptoppm = &find_prog(&get_name('BMPTOPPM',1));
  if($bmptoppm) {
    $newcfg{'BMPTOPPM'} = $bmptoppm;
  } else {
     &warn_no_image_type('bmp');
  }
}

# --------------------------------------------------------------------------
# PCXTOPPM
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'PCXTOPPM'} = '';

if(1) {
  my $pcxtoppm = &find_prog(&get_name('PCXTOPPM',1));
  if($pcxtoppm) {
    $newcfg{'PCXTOPPM'} = $pcxtoppm;
  } else {
     &warn_no_image_type('pcx');
  }
}

# --------------------------------------------------------------------------
# SGITOPNM
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'SGITOPNM'} = '';

if(1) {
  my $sgitopnm = &find_prog(&get_name('SGITOPNM',1));
  if($sgitopnm) {
    $newcfg{'SGITOPNM'} = $sgitopnm;
  } else {
     &warn_no_image_type('sgi');
  }
}

# --------------------------------------------------------------------------
# XBMTOPBM
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'XBMTOPBM'} = '';

if(1) {
  my $xbmtopnm = &find_prog(&get_name('XBMTOPBM',1));
  if($xbmtopnm) {
    $newcfg{'XBMTOPBM'} = $xbmtopnm;
  } else {
     &warn_no_image_type('xbm');
  }
}

# --------------------------------------------------------------------------
# XWDTOPNM
# --------------------------------------------------------------------------
# used in  graphics-support.perl  for handling \includegraphics options

$newcfg{'XWDTOPNM'} = '';

if(1) {
  my $xwdtopnm = &find_prog(&get_name('XWDTOPNM',1));
  if($xwdtopnm) {
    $newcfg{'XWDTOPNM'} = $xwdtopnm;
  } else {
     &warn_no_image_type('xwd');
  }
}

# --------------------------------------------------------------------------
# GIFTOOL
#
# Only needed if ppmtogif lacks -transparent and/or -interlaced
# --------------------------------------------------------------------------

if($newcfg{'have_pstoimg'} && $opt{'GIF'} &&
  (!$newcfg{'gif_trans'} || !$newcfg{'gif_interlace'})) {
  my $giftool = &find_prog(&get_name('GIFTOOL',1));
  if($giftool) {
    $newcfg{'GIFTOOL'} = $giftool;
    $newcfg{'gif_trans'} = 'giftool' if(!$newcfg{'gif_trans'});
    $newcfg{'gif_interlace'} = 'giftool' if(!$newcfg{'gif_interlace'});
  }
}

# --------------------------------------------------------------------------
# GIFTRANS
#
# Only needed if ppmtogif lacks -transparent
# --------------------------------------------------------------------------

if($newcfg{'have_pstoimg'} && $opt{'GIF'} && !$newcfg{'gif_trans'}) {
  my $giftrans = &find_prog(&get_name('GIFTRANS',1));
  if($giftrans) {
    $newcfg{'GIFTRANS'} = $giftrans;
    $newcfg{'gif_trans'} = 'giftrans';
  }
}

# --------------------------------------------------------------------------
# SRCHILITE
# --------------------------------------------------------------------------
# used in listings.perl and minted.perl for colorized listings

$newcfg{'SRCHILITE'} = '';

if(1) {
  my $srchilite = &find_prog(&get_name('SRCHILITE',1));
  if($srchilite) {
    $newcfg{'SRCHILITE'} = $srchilite;
  }
}

# --------------------------------------------------------------------------
# SRCHILITE
# --------------------------------------------------------------------------
# used in listings.perl and minted.perl for colorized listings

$newcfg{'SRCHILITE'} = '';

if(1) {
  my $srchilite = &find_prog(&get_name('SRCHILITE',1));
  if($srchilite) {
    $newcfg{'SRCHILITE'} = $srchilite;
  }
}

# --------------------------------------------------------------------------
# Pipes
# --------------------------------------------------------------------------

if(&is_true(&get_name('PIPES'))) {
  &checking('if multiple pipes work');
  if($newcfg{'plat'} =~ /win32|dos/i) {
    &result('no');
    logit("Unfortunately multiple pipes are not reliable on this OS.\n");
    $newcfg{'pipes'} = 0;
  }
  else {
    my $cmd = "echo 101" .  (" | $newcfg{'PERL'} config${dd}pipetest.pl" x 8);
    my $out = `$cmd`;
    chomp $out;
    if($out == 109) {
      &result('yes');
      $newcfg{'pipes'} = 1;
    }
    else {
      &result('no');
      $newcfg{'pipes'} = 0;
    }
  }
}
else {
  $newcfg{'pipes'} = 0;
}

# --------------------------------------------------------------------------
# temporary disk space
#
# try all sorts of places and check whether they are directories and
# we have write permission
# --------------------------------------------------------------------------

&checking('for temporary disk space');
$newcfg{'TMPSPACE'} = '';
my @tmp = ();
push(@tmp,$cfg{'TMPSPACE'}) if($cfg{'TMPSPACE'});
push(@tmp,$prefs{'TMPSPACE'}) if($prefs{'TMPSPACE'});
push(@tmp,$ENV{'TMP'}) if($ENV{'TMP'});
push(@tmp,$ENV{'TEMP'}) if($ENV{'TEMP'});
if($newcfg{'plat'} =~ /dos|win32/i) {
  push(@tmp,qw(C:\\TMP C:\\TEMP C:\\WINDOWS\\TEMP C:\\WINNT\\TEMP));
}
elsif($newcfg{'plat'} =~ /unix/i) { # unix
  push(@tmp,qw(/tmp /usr/tmp /var/tmp /usr/local/tmp));
}
elsif($newcfg{'plat'} =~ /os2/i) { # OS/2
  # no specific items here yet!
}
else {
  logit("\nWarning: Check on this platform ($^O) not yet implemented... ");
}

foreach(@tmp) {
  if(-d && -w _) {
    $newcfg{'TMPSPACE'} = $_;
    last;
  }
}
if($newcfg{'TMPSPACE'}) {
  &result($newcfg{'TMPSPACE'});
}
else {
  &result('no');
  $newcfg{'TMPSPACE'} = '.'; # poor man's tmp
}

# --------------------------------------------------------------------------
# the installation paths
# --------------------------------------------------------------------------

$newcfg{'PREFIX'} = $opt{'PREFIX'} || '';
$newcfg{'PREFIX'} =~ s/^NONE$//;
my $have_prefix = 0;
unless($newcfg{'PREFIX'}) {
  $newcfg{'PREFIX'} = $cfg{'PREFIX'} || $prefs{'PREFIX'} || '';
  unless($newcfg{'PREFIX'}) {
    logit("Error: You must specify an installation PREFIX\n");
    cleanup(1);
    exit 1;
  }
} else {
  $have_prefix = 1;
}
$newcfg{'PREFIX'} =~ s|[/\\]+|$dd|g; # replace /\ with correct delimiter
$newcfg{'PREFIX'} =~ s|[$dd$dd]+$||; # strip trailing directory delimiter(s)
add_drive_letter($newcfg{'PREFIX'});

$newcfg{'BINDIR'} = $opt{'BINDIR'} || '';

# kludge for GNU autoconf
$newcfg{'BINDIR'} =~ s:\$\{exec_prefix\}.*::;

unless($newcfg{'BINDIR'}) {
  $newcfg{'BINDIR'} = $prefs{'BINDIR'} || '';
  $newcfg{'BINDIR'} ||= $cfg{'BINDIR'} unless($have_prefix);
}
if($newcfg{'BINDIR'}) {
  $newcfg{'BINDIR'} =~ s|[$dd$dd]+$||; # strip trailing directory delimiters
}
else {
  $newcfg{'BINDIR'} = "$newcfg{'PREFIX'}${dd}bin";
}
add_drive_letter($newcfg{'BINDIR'});

$newcfg{'SHLIBDIR'} = $opt{'SHLIBDIR'} || '';
$newcfg{'LIBDIR'} = $opt{'LIBDIR'} || '';

# kludge for GNU autoconf
$newcfg{'LIBDIR'} =~ s:\$\{exec_prefix\}.*::;
$newcfg{'SHLIBDIR'} =~ s:\$\{exec_prefix\}.*::;

unless($newcfg{'SHLIBDIR'}) {
  $newcfg{'SHLIBDIR'} = $prefs{'SHLIBDIR'} || '';
  $newcfg{'SHLIBDIR'} ||= $cfg{'SHLIBDIR'} unless($have_prefix);
}
unless($newcfg{'LIBDIR'}) {
  $newcfg{'LIBDIR'} = $prefs{'LIBDIR'} || '';
  $newcfg{'LIBDIR'} ||= $cfg{'LIBDIR'} unless($have_prefix);
}

if($newcfg{'SHLIBDIR'}) {
  $newcfg{'SHLIBDIR'} =~ s|[$dd$dd]+$||; # strip trailing directory delimiters
}
else {
  # similar to the perl installation procedure, append latex2html only
  # if it does not appear in the PREFIX
  if($newcfg{'PREFIX'} =~ /l2h|latex2html/i) {
    $newcfg{'SHLIBDIR'} = $newcfg{'PREFIX'};
  }
  else {
    $newcfg{'SHLIBDIR'} = "$newcfg{'PREFIX'}${dd}share${dd}lib${dd}latex2html";
  }
}
add_drive_letter($newcfg{'SHLIBDIR'});

$newcfg{'LATEX2HTMLDIR'} = $newcfg{'SHLIBDIR'};
# make sure the device is prepended!
if($newcfg{'plat'} =~ /win|dos|os2/i) {
  unless($newcfg{'LATEX2HTMLDIR'} =~ /^[A-Z]:/i) {
    my ($drive) = $cwd =~ /^([A-Z]:)/i;
    unless($drive) {
      logit("Fatal: Cannot determine current drive letter\n");
      cleanup(1);
      exit 1;
    }
    $newcfg{'LATEX2HTMLDIR'} = "$drive$newcfg{'LATEX2HTMLDIR'}";
  }
}

if($newcfg{'LIBDIR'}) {
  $newcfg{'LIBDIR'} =~ s|[$dd$dd]+$||; # strip trailing directory delimiters
}
else {
  # similar to the perl installation procedure, append latex2html only
  # if it does not appear in the PREFIX
  if($newcfg{'PREFIX'} =~ /l2h|latex2html/i) {
    $newcfg{'LIBDIR'} = $newcfg{'PREFIX'};
  }
  else {
    $newcfg{'LIBDIR'} = "$newcfg{'PREFIX'}${dd}lib${dd}latex2html";
  }
}
add_drive_letter($newcfg{'LIBDIR'});

$newcfg{'LATEX2HTMLPLATDIR'} = $newcfg{'LIBDIR'};
# make sure the device is prepended!
if($newcfg{'plat'} =~ /win|dos|os2/i) {
  unless($newcfg{'LATEX2HTMLPLATDIR'} =~ /^[A-Z]:/i) {
    my ($drive) = $cwd =~ /^([A-Z]:)/i;
    unless($drive) {
      logit("Fatal: Cannot determine current drive letter\n");
      cleanup(1);
      exit 1;
    }
    $newcfg{'LATEX2HTMLPLATDIR'} = "$drive$newcfg{'LATEX2HTMLPLATDIR'}";
  }
}

# how to call the scripts
if($newcfg{'texlive'}) {
  $newcfg{'scriptdir'} = $newcfg{'SHLIBDIR'};
  $newcfg{'scriptext'} = '.pl';
} elsif($newcfg{'wrapper'}) {
  $newcfg{'scriptdir'} = $newcfg{'SHLIBDIR'};
  $newcfg{'scriptext'} = '.pl';
} else {
  $newcfg{'scriptdir'} = $newcfg{'BINDIR'};
  $newcfg{'scriptext'} = $newcfg{'exec_extension'};
}

# --------------------------------------------------------------------------
# some other paths
# --------------------------------------------------------------------------

$newcfg{'RGBCOLORFILE'} = $opt{'RGB'} || $cfg{'RGBCOLORFILE'} ||
  $prefs{'RGB'} || "$newcfg{'SHLIBDIR'}${dd}styles${dd}rgb.txt";
$newcfg{'CRAYOLAFILE'} = $opt{'CRAYOLA'} || $cfg{'CRAYOLAFILE'} || 
  $prefs{'CRAYOLA'} || "$newcfg{'SHLIBDIR'}${dd}styles${dd}crayola.txt";

$newcfg{'ICONSTORAGE'} = $opt{'ICONSTORAGE'} || $cfg{'ICONSTORAGE'} ||
  $prefs{'ICONSTORAGE'} || '';
$newcfg{'ICONPATH'} = $opt{'ICONPATH'} || $cfg{'ICONPATH'} ||
  $prefs{'ICONPATH'} || '';
$newcfg{'ICONSERVER'} = $opt{'ICONSERVER'} || $cfg{'ICONSERVER'} ||
  $prefs{'ICONSERVER'} || '';

# use a file: URL to access icons if no server path given
unless($newcfg{'ICONPATH'}) {
  $newcfg{'ICONPATH'} = L2hos->path2URL("$newcfg{'SHLIBDIR'}${dd}icons");
}

# --------------------------------------------------------------------------
# generate configuration file
# --------------------------------------------------------------------------

logit("creating $CFGFILE\n");
unless(open(OUT,">$CFGFILE")) {
  logit("Error: Cannot write $CFGFILE: $!\n");
  cleanup(1);
  exit 1;
}

print OUT <<"EOT";
# LaTeX2HTML site specific configuration file
# generated by config.pl

# You may edit this file to get around deficiencies of the configuration
# procedure, but you have to be sure of what you are doing!
# If you think there are bugs in the configuration procedure, please report
# them. See the BUGS file on how to do it. Your help is appreciated!

package cfgcache;
require Exporter;
\@ISA = qw(Exporter);
\@EXPORT = qw(\%cfg);

EOT
$newcfg{'dd'} = $dd;
my $key;
foreach $key (sort keys %newcfg) {
  my $val = $newcfg{$key};
  if($val =~ /\n/s) { # contains newlines?
    chomp $val;
    print OUT "\$cfg{'$key'} = <<'EOQ';\n$val\nEOQ\n";
  }
  else {
    $val =~ s:\\:\\\\:g; # escape backslashes
    my $delim = '';
    my $i;
    foreach $i (qw(' ' | : ! + " " $ % / . = * ;)) {
      unless($val =~ /\Q$i/) {
        $delim = $i;
        last;
      }
    }
    unless($delim) {
      logit("Fatal: Could not find delimiter for $key=$val\n");
      cleanup(1);
      exit 1;
    }
    print OUT "\$cfg{'$key'} = q$delim$val$delim;\n";
  }
}
print OUT "\n1; # must be last line\n";
close(OUT);

# --------------------------------------------------------------------------
# Generate batch files for DOS/OS2 testing/installation
# --------------------------------------------------------------------------

if($newcfg{'plat'} =~ /dos|win|os2/) {
  my $testfile = "test$newcfg{'exec_extension'}";
  logit("creating $testfile\n");
  unless(open(OUT,">$testfile")) {
    logit("Error: Cannot write $testfile: $!\n");
    cleanup();
    exit 1;
  }
  my ($dir,$latex2html);
  if($newcfg{'wrapper'}) {
    $dir = "$cwd\\bin";
    $latex2html = "$dir\\latex2html$newcfg{'exec_extension'}";
  }
  elsif($newcfg{'texlive'}) {
    $dir = "$cwd\\bin\\$newcfg{'plat'}";
    $latex2html = "$dir\\latex2html$newcfg{'exec_extension'}";
  }
  else {
    $dir = $cwd;
    $latex2html = "$dir\\latex2html$newcfg{'exec_extension'}";
  }
  print OUT <<"EOF";
\@ECHO OFF
REM this is a batch file for testing the build of LaTeX2HTML
REM on DOS, Win or OS/2 as these platforms lack a "make" utility

set LATEX2HTMLDIR=$cwd
set OPATH=%PATH%
REM for OS/2, we need to set the PATH accordingly
PATH $dir;%PATH%

ECHO ... checking latex2html
$newcfg{'PERL'} -c $cwd\\latex2html$newcfg{'scriptext'}
IF ERRORLEVEL 1 GOTO ERROR

ECHO ... checking texexpand
$newcfg{'PERL'} -c $cwd\\texexpand$newcfg{'scriptext'}
IF ERRORLEVEL 1 GOTO ERROR

ECHO ... checking pstoimg
$newcfg{'PERL'} -c $cwd\\pstoimg$newcfg{'scriptext'}
IF ERRORLEVEL 1 GOTO ERROR

cd tests
echo *** Running $latex2html -test_mode %1 %2 %3 %4 %5 %6 %7 %8 %9 l2htest.tex
call $latex2html -test_mode %1 %2 %3 %4 %5 %6 %7 %8 %9 l2htest.tex
cd ..
:ERROR
PATH %OPATH%
set OPATH=
set LATEX2HTMLDIR=
EOF
  close(OUT);

  # now for the install

  $testfile = "install$newcfg{'exec_extension'}";
  logit("creating $testfile\n");
  unless(open(OUT,">$testfile")) {
    logit("Error: Cannot write $testfile: $!\n");
    cleanup();
    exit 1;
  }

  print OUT <<"EOT";
\@ECHO OFF
REM this is a batch file for installing LaTeX2HTML
REM on DOS, Win or OS/2 as these platforms lack a "make" utility

$newcfg{'PERL'} config\\install.pl
EOT
  close(OUT);
}

logit(<<"EOF");
Note: Will install...
      ... executables to   : $newcfg{'BINDIR'}
      ... shared library items to : $newcfg{'SHLIBDIR'}
      ... unshared library items to : $newcfg{'LIBDIR'}
EOF

# --------------------------------------------------------------------------
# The end!
# --------------------------------------------------------------------------

exit 0;

# --------------------------------------------------------------------------
# helpers, subs, ...
# --------------------------------------------------------------------------

sub checking {
  my ($str) = @_;
  logit("checking $str... ");
}

sub result {
  my ($str) = @_;
  logit("$str\n");
}

#------------------------------------------------------------------------------
# Return the value for a configuration option from the command line argument
# or from the environment or from the preferences file:
#------------------------------------------------------------------------------

sub get_name {
  my ($name,$flag) = @_;
  # accumulate the matching items if $flag is true
  my @stack;
  if(defined $opt{$name} && $opt{$name} !~ /^\s*$/) {
    return $opt{$name} unless($flag);
    push(@stack,$opt{$name});
  }
  if(defined $cfg{$name} && $cfg{$name} !~ /^\s*$/) {
    return $cfg{$name} unless($flag);
    push(@stack,$cfg{$name});
    my $base = $cfg{$name};
    $base =~ s:^.*[/$dd$dd]::;
    push(@stack,$base);
  }
  # MRO: logic for environment included in configure
  #if(defined $ENV{$name} && $ENV{$name} !~ /^\s*$/) {
  #  return $ENV{$name} unless($flag);
  #  push(@stack,$ENV{$name});
  #}
  if(defined $prefs{$name} && $prefs{$name} !~ /^\s*$/) {
    return $prefs{$name} unless($flag);
    push(@stack,$prefs{$name});
  }
  return(@stack) if (@stack);
  logit(qq{Error: Cannot find a value for config option "$name"\n});
  cleanup(1);
  exit 1;
}

#------------------------------------------------------------------------------
# parse a true/false setting
#------------------------------------------------------------------------------

sub is_true {
  my ($val) = @_;
  return ($val && ($val =~ /^\s*(y|1)/i)) ? 1 : 0;
}

#------------------------------------------------------------------------------
# search executable PATH for some program
#------------------------------------------------------------------------------

sub find_prog {
  my @names = @_;

  my $drive_rx = '';
  if($newcfg{'plat'} =~ /dos|win|os2/) {
    $drive_rx = '([A-Z]:)?';
  }
  if(@names == 1) {
    @names = split(/[\s,]/,$names[0]);
  }
  my $found = 0;
  my ($name,$path,$prog);
  Search: foreach $name (@names) {
    my $base = $name;
    $base =~ s:^.*[/$dd$dd]::; # strip path
    &checking("for $base");
    if($name =~ /\Q$dd/) { # contains dir delimiter?
      unless($name =~ /^$drive_rx\Q$dd/oi) { # absolute dir?
        $name = &simplify_path("$cwd$dd$name");
      }
      $prog = &check_prog($name);
      if($prog) {
        $found++;
        &result($prog);
        last Search;
      }
      else {
        &result('no');
      }
    }
    else {
      foreach $path (@paths) {
        $prog = &check_prog(($path) ? "$path$dd$name" : $name);
        if($prog) {
          $found++;
          &result($prog);
          last Search;
        }
      }
      &result('no');
    }
  }
  if($found) {
    unless(is_true($abs_path_names)) {
      $prog =~ s:^.*[/$dd$dd]::; # strip path
    }
    return $prog;
  }
  undef;
}

#------------------------------------------------------------------------------
# check for existence of some executable
# add extensions as required on certain platforms
#------------------------------------------------------------------------------

sub check_prog {
  my ($path) = @_;
  my @extensions = ();
  if($newcfg{'plat'} =~ /dos|win32|os2/i) {
    if($path =~ /\.\w{3}$/i) { # has valid extension
      if(-s $path && !-d _) {
        return $path;
      }
    }
    else { # look for extensions
      my @Extensions = ($newcfg{'plat'} =~ /os2/i) ?
        qw(.exe .com .bat .cmd) : qw(.exe .com .bat);
      my $ext;
      foreach $ext (@Extensions) {
        if(-s "$path$ext" && !-d _) {
          return "$path$ext";
        }
      }
    }
  }
  else { # do the regular check
    if(-x $path && !-d _) {
      return $path;
    }
  }
  ''; # failure
}

#------------------------------------------------------------------------------
# Capture output to STDOUT and STDERR. Must work on all platforms, therefore
# an external script is used that provides for the filehandle redirection.
# In theory it can of course be done by open("-|"), but forking is not
# supported on all platforms. I hope this is the least common denominator...
#------------------------------------------------------------------------------

sub get_out_err {
  my ($cmd) = @_;

  # redir.pl does the redirection for us
  unless(open(IN,"$newcfg{PERL} config${dd}redir.pl $cmd |")) {
    return(255,'',$!);
  }
  my @out = ();
  my @err = ();
  my $flag = 0;
  # parse the output
  while(defined($_ = <IN>)) {
    chomp;
    if($flag == 0 && /^---STDERR---$/) {
      $flag = 1;
    }
    elsif($flag == 1 && /^---STDOUT---$/) {
      $flag = 2;
    }
    elsif($flag == 1) {
      push(@err,$_) unless(/^\s*$/);
    }
    elsif($flag == 2) {
      push(@out,$_) unless(/^\s*$/);
    }
    else {
      logit("\ndebug: unexpected output: +$_+\n");
    }
  }

  close(IN); # close on a pipe sets $?
  my $stat = $?;
  $stat >>= 8 if($stat > 255);
  my $out = join("\n",@out) || '';
  my $err = join("\n",@err) || '';

  #logit("\nDEBUG: stat +$stat+\n");
  #logit("\nDEBUG: out  +$out+\n");
  #logit("\nDEBUG: err  +$err+\n");
  #my $a = <STDIN>;
  ($stat,$out,$err);
}

#------------------------------------------------------------------------------
# Get one of a list of desired Ghostscript devices
#------------------------------------------------------------------------------

sub determine_gsdevice {
  my ($type,$desired,@gs_devs) = @_;

  my $dev = $opt{$type} || $cfg{$type} || $prefs{$type};
  if($dev) {
    my $found;
    if(($found) = grep(/^\Q$dev\E$/i,@gs_devs)) {
      &result($newcfg{$type} = $found);
    }
    else {
      &result('no');
      logit("Error: $newcfg{'GS'} does not support device '$dev'. Valid are '",
        join(' ',@gs_devs),"'\n");
      return 0;
    }
  }
  else { # look for one of the following
    my @desired_dev = split(/\s+/,$desired);
    my $found = '';
    my $dev;
    foreach $dev (@desired_dev) {
      if(($found) = grep(/^\Q$dev\E$/i,@gs_devs)) {
        last;
      }
    }
    if($found) {
      &result($newcfg{$type} = $found);
    }
    else {
      &result('no');
      logit("Error:  $newcfg{'GS'} does not support any of '", join(' ',@desired_dev),"'\n");
      return 0;
    }
  }
  1;
}

#------------------------------------------------------------------------------
# Print a sad message...
#------------------------------------------------------------------------------

sub warn_no_images {
  logit("Warning: Will not be able to generate images due to above failure.\n");
  1;
}

sub warn_no_graphics {
  logit("Warning: You may need to rely on LaTeX to generate images with $_[0] effects.\n");
  1;
}

sub warn_no_image_type {
  logit("Warning: You cannot directly translate/modify graphics of $_[0] format.\n");
  1;
}

#------------------------------------------------------------------------------
# A very simple copy procedure
#------------------------------------------------------------------------------

sub Copy {
  my ($src,$dest) = @_;

  unless(open(IN,"<$src")) {
    logit(qq{Error: Cannot read "$src": $!\n});
    return 0;
  }
  local($/) = undef;
  binmode IN;
  my $contents = <IN>;
  close(IN);
  unless(open(OUT,">$dest")) {
    logit(qq{Error: Cannot write "$dest": $!\n});
    return 0;
  }
  binmode OUT;
  print OUT $contents;
  unless(close(OUT)) {
    logit(qq{Error: Could not write "$dest": $!\n});
    return 0;
  }
  1;
}

#------------------------------------------------------------------------------
# delete multiple entries from an array !not used!
#------------------------------------------------------------------------------

sub uniquify {
  my @ary = @_;
  my %seen = ();
  return(grep(!$seen{$_}++,@ary));
}

#------------------------------------------------------------------------------
# simplify path: remove dir/.. pairs from path
# Attention! This may not work properly if symbolic links are
# involved.
#------------------------------------------------------------------------------

sub simplify_path {
  my ($path) = @_;

  # Replace // and /./ by /
  $path =~ s:\Q$dd\E\.?\Q$dd\E:$dd:g;
  1 while($path =~ s:\Q$dd\E[^$dd$dd]+\Q$dd\E\.\.(\Q$dd\E|$):$1:);
  $path;
}

#------------------------------------------------------------------------------
# Write everything to screen and logfile
#------------------------------------------------------------------------------

sub logit {
  print @_;
  print $LOG @_ if(defined $LOG);
  
}

#------------------------------------------------------------------------------
# do some cleanups before exit
#------------------------------------------------------------------------------

sub cleanup {
  my ($err) = @_;

  if(defined $LOG) {
    $LOG->close;
  }
  if($err) {
    unlink $CFGFILE;
  }
}

#------------------------------------------------------------------------------
# on DOSish systems prepend drive letter if not present
#------------------------------------------------------------------------------

sub add_drive_letter {
  if($newcfg{'plat'} =~ /win|dos|os2/ && $_[0] !~ /^[A-Z]:/i) {
    my $cwd = L2hos->Cwd();
    my ($drive) = ($cwd =~ /^([A-Z]:)/i);
    if($drive) {
      $_[0] = "$drive$_[0]";
    } else {
      logit("\nError: Cannot parse drive letter from current directory\n");
    }
  }
  $_[0];
}

__END__

##############################################################################
# kpsewhich style 1:
#
#Usage: C:\TEX\BIN\WIN32\KPSEWH~1.EXE [OPTION]... [FILENAME]...
#  Standalone path lookup and expansion for Kpathsea.
#
#-debug=NUM             set debugging flags.
#-D, -dpi=NUM           use a base resolution of NUM; default 600.
#-expand-braces=STRING  output variable and brace expansion of STRING.
#-expand-path=STRING    output complete path expansion of STRING.
#-expand-var=STRING     output variable expansion of STRING.
#-format=NAME           use file type NAME (see list below).
#-help                  print this message and exit.
#-interactive           ask for additional filenames to look up.
#[-no]-mktex=FMT        disable/enable mktexFMT generation (FMT=pk/mf/tex/tfm).
#-mode=STRING           set device name for $MAKETEX_MODE to STRING;
#                       no default.
#-must-exist            search the disk as well as ls-R if necessary
#-path=STRING           search in the path STRING.
#-progname=STRING       set program name to STRING.
#-show-path=NAME        output search path for file type NAME (see list below).
#-version               print version number and exit.
#
#Email bug reports to tex-k@mail.tug.org.
#
#Recognized format names and their suffixes:
#gf: gf
#pk: pk
#bitmap font:
#tfm: .tfm
#afm: .afm
#base: .base
#bib: .bib
#bst: .bst
#cnf: .cnf
#ls-R: ls-R
#fmt: .fmt .efmt .efm
#map: .map
#mem: .mem
#mf: .mf
#mfpool: .pool
#mft: .mft
#mp: .mp
#mppool: .pool
#MetaPost support:
#ocp: .ocp
#ofm: .ofm .tfm
#opl: .opl
#otp: .otp
#ovf: .ovf
#ovp: .ovp
#graphic/figure: .eps .epsi
#tex: .tex
#TeX system documentation:
#texpool: .pool
#TeX system sources:
#PostScript header: .pro .enc
#Troff fonts:
#type1 fonts: .pfa .pfb
#vf: .vf
#dvips config:
#ist: .ist
#truetype fonts: .ttf .ttc
#type42 fonts:
#web2c files:
#other text files:
#other binary files:
#
##############################################################################
# kpsewhich style 2:
#
#kpsewhich: unknown option 'h' ignored.
#Usage: kpsewhich: [options] pathtype filename
#
#Valid options are the following:
#  -n progname  : pretend to be progname to kpathsea
#  -m mode      : set Metafont mode
#  -w           : act like kpsewhich
#  -p           : act like kpsepath
#  -v           : act like kpsexpand
#
#Valid pathtypes are:
#  gf            : generic font bitmap
#  pk            : packed bitmap font
#  base          : Metafont memory dump
#  bib           : BibTeX bibliography source
#  bst           : BibTeX style files
#  cnf           : Kpathsea runtime configuration files
#  fmt           : TeX memory dump
#  mem           : MetaPost memory dump
#  mf            : Metafont source
#  mfpool        : Metafont program strings
#  mp            : MetaPost source
#  mppool        : MetaPost program strings
#  mpsupport     : MetaPost support files
#  pict          : Other kinds of figures
#  tex           : TeX source
#  texpool       : TeX program strings
#  tfm           : TeX font metrics
#  vf            : virtual font
#  dvips_config  : dvips config files
#  dvips_header  : dvips header files
#  troff_font    : troff fonts
