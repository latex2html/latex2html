#! /usr/local/bin/perl -w

###############################################################################
# $Id: build.pl,v 1.6 2002/04/10 00:29:48 RRM Exp $
#
# build.pl
#
# Preprocesses perl scripts. Reads l2hcfg.pm and one operating system
# specific module (containing OS specific subroutines) and uses this
# information to modify the script given on the command line. Reads
# <script>.pin (perl-in) and writes <script>. See below for the
# preprocessor syntax.
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
# $Log: build.pl,v $
# Revision 1.6  2002/04/10 00:29:48  RRM
#  --  fixed spelling error in a comment  :-)
#
# Revision 1.5  1999/10/25 21:18:22  MRO
#
# -- added more configure options (Jens' suggestions)
# -- fixed bug in regexp range reported by Achim Haertel
# -- fixed old references in documentation (related to mail list/archive)
#
# Revision 1.4  1999/09/07 22:00:25  MRO
#
# -- added option -devel to build.pl and BUILDOPT macro to Makefile
#
# Revision 1.3  1999/08/30 22:45:09  MRO
#
# -- perl now reports line numbers respective to .pin file - eases
#    code development!
# -- l2hcfg.pm is installed, too for further reference
# -- some minor bugs (hopefully) fixed.
#
# Revision 1.2  1999/05/31 07:49:12  MRO
#
#
# - a lot of cleanups wrt. OS/2
# - make test now available (TEST.BAT on Win32, TEST.CMD on OS/2)
# - re-inserted L2HCONFIG environment
# - added some new subs to L2hos (path2os, path2URL, Cwd)
#
# Revision 1.1  1999/05/11 06:10:02  MRO
#
#
# - merged config stuff, did first tries on Linux. Simple document
#   passes! More test required, have to ger rid of Warnings in texexpand
#
# Revision 1.15  1999/05/05 19:47:10  MRO
#
#
# - many cosmetic changes
# - final backup before merge
#
# Revision 1.14  1999/04/10 12:03:33  MRO
#
#
# - enabled use of different suffixes
#
# Revision 1.13  1999/02/23 23:32:32  MRO
#
#
# -- few changes for Win32
#
# Revision 1.12  1998/12/12 16:39:15  MRO
#
#
# -- cosmetic changes, reworked catching of STDERR in config.pl (Win32)
# -- new configure opt --disable-paths
# -- major cleanups
#
# Revision 1.11  1998/10/31 14:13:07  MRO
# -- changed OS-dependent module loading strategy: Modules are now located in
#    different (OS-specific) directories nut have the same name: Easier to
#    maintain and cleaner code
# -- Cleaned up config procedure
# -- Extended makefile functionality
#
# Revision 1.10  1998/08/09 17:58:18  MRO
# -- save update
#
# Revision 1.9  1998/07/07 21:55:08  MRO
# -- enabled warpper and texlive build
#
# Revision 1.8  1998/07/01 19:34:59  MRO
# -- added more wrapper templates, updated config.pl and pertially build.pl
#
# Revision 1.7  1998/06/14 14:10:40  latex2html
# -- Started to implement TeXlive configuration and better OS specific
#    handling (Batch files)                              (Marek)
#
# Revision 1.6  1998/06/01 12:57:58  latex2html
# -- Cleanup and cosmetics.
#
# Revision 1.5  1998/05/06 22:31:13  latex2html
# -- Enhancements to the config procedure: Added a "generic" target
#    in the Makefile for the TeXlive CD (not perfect yet)
# -- included test for kpsewhich / Web2C
# -- included latest stuff from Override.pm into os_*.pm
#
# Revision 1.4  1998/04/28 22:21:27  latex2html
# - The platform specific stuff is now kept in a separate perl module. This
#   does not introduce significant overhead and enhances maintainability.
#
# Revision 1.3  1998/03/19 23:38:09  latex2html
# -- made pstoimg plug-in compatible with old one (touchwood!)
# -- cleaned up, added some comments
# -- inserted version information output
# -- incorporated patches to make OS/2 run better (thanks Uli)
# -- updated Makefile: make, make test, make install should work now
#
# Revision 1.2  1998/03/02 23:38:42  latex2html
# Reworked configuration procedure substantially. Fixed some killing bugs.
# Should now run on Win32, too.
# The file prefs.pm contains user-configurable stuff for DOS platforms.
# UNIX users can override the settings with the configure utility (preferred).
#
# Revision 1.1  1998/02/14 19:31:56  latex2html
# Preliminary checkin of configuration procedure
#
###############################################################################

require 5.003;
use strict;
# use diagnostics;
use vars qw(%os_cfg %cfg);

use Getopt::Long;

my ($VERSION) = q$Revision: 1.6 $ =~ /:\s*(\S*)/;

# --------------------------------------------------------------------------
# Initialize
# --------------------------------------------------------------------------

# Read in the system's configuration
use cfgcache;

my $dd = $cfg{'dd'};
my $plat = $cfg{'plat'};
my $BINDIR = 'bin';

# for TeXlive we need them all
my %plat_ext = (
  'dos' => '.bat',
  'win32' => '.bat',
  'os2' => '.cmd',
  'macos' => '.bat',
  'unix' => '');

print "build.pl (Revision $VERSION)\n";

# --------------------------------------------------------------------------
# Parse command line
# --------------------------------------------------------------------------

my %opt = ();

unless(GetOptions(\%opt, qw(executable|x suffix=s devel))) {
  die "$0: Error: Illegal option(s) specified.\n";
}

my $script = shift(@ARGV);

my $is_executable = $opt{executable};

unless($script) {
  die "$0: Error: No script specified\n";
}

if($script =~ /pstoimg/ && !$cfg{'have_pstoimg'}) {
  print "$0: Warning: Skipping build of $script because of missing external programs.\n";
  exit 0;
}

# --------------------------------------------------------------------------
# Go!
# --------------------------------------------------------------------------

# Treat executables specially

my $add_header_footer = 0;
my $output = $script;
if($is_executable) {
  if($cfg{'texlive'}) {
    my @platlist = keys %plat_ext;
    $output .= '.pl';
    &build($script,$output,0,1);
    my $plat;
    foreach $plat (@platlist) {
      &make_bin_dir($plat);
      &build("wrapper$dd$plat","$BINDIR$dd$plat$dd$script$plat_ext{$plat}",0,1);
    }
  }
  elsif($cfg{'wrapper'}) { # create one wrapper
    $output .= '.pl';
    &build($script,$output,0,1);
    &make_bin_dir();
    &build("wrapper$dd$plat","$BINDIR$dd$script$plat_ext{$plat}",0,1);
  }
  else { # normal executable
    if($cfg{'PERLHEADER'}) {
      $add_header_footer = 1;
    }
    $output .= ($cfg{'exec_extension'} || '');
    &build($script,$output,$add_header_footer,1);
  }
}
elsif($opt{suffix}) {
  $script =~ s:\.pin$::;
  &build($script,"$script$opt{suffix})",0);
}
else {
  $script =~ s:\..*$::;
  &build($script,$output,0);
}

exit 0;

sub build {
  my ($script,$output,$add_header_footer,$executable) = @_;

  print qq{Building "$output" from "$script.pin"\n};

  my @stack = ();
  my $do_include = 1;

  unless(open(IN,"<$script.pin")) {
    print "$0: Error: Cannot read $script.pin: $!\n";
    exit 1;
  }

  if(-e $output) {
    if(-e "$script.bak") {
      unless(unlink("$script.bak")) {
        print qq{$0: Error: Cannot unlink "$script.bak": $!\n};
        exit 1;
      }
    }
    unless(rename($output,"$script.bak")) {
      print qq{$0: Error: Cannot rename existing "$output" to  "$script.bak": $!\n};
      exit 1;
    }
  }
  unless(open(OUT,">$output")) {
    print "$0: Error: Cannot write $script: $!\n";
    exit 1;
  }

  # Treat executables specially: Add perl starter

  if($add_header_footer) {
    # BAD HACK AHEAD! Warnings should always be turned on!!
    my $head = $cfg{'PERLHEADER'} || '';
    if($script =~ /^latex2html/) {
       $head =~ s/ -w//;
    }
    print OUT $head;
  }
  my $sourcefilename = "$script.pin";
  $sourcefilename =~ s:^.*[\\/$dd$dd]::; # strip path
  print OUT qq{# line 1 "$sourcefilename"\n} if($opt{devel});

  # Do the preprocessing: Look for:
  #      #if <perlexpression>
  #      #unless <perlexpresion>
  #      #else
  #      #fi
  #   The <perlexpression> may contain configuration variables as @var@,
  #   e.g. #if @GSDEVICE@ eq 'ppmraw'
  #      #- comment to be deleted
  #
  #      @var@
  #   All such occurences will be replaced with the configuration
  #   variable var

  my $have_line = 0;

  while(defined($_ = <IN>)) {
    if( /^\s*#(if|unless)\s+([^#\n]+)/ ) {
      $have_line = $.;
      my $true = ($1 eq 'if');
      my $cond = $2;
      $cond =~ s/@(\w+)@/\$cfg{'$1'}/g;
      push @stack,$do_include;
      # print "debug: evalling +$cond+ ... ";
      my $result = eval $cond;
      if($@) {
        print qq{$0: Error: Conditional expression "$cond" failed in "$script.pin" line $.: $@\n};
        exit 1;
      }
      # print "-$result-\n";
      if($do_include && $do_include ne 'void') {
        $do_include = $result ? $true : !$true;
      }
      else {
        $do_include = 'void';
      }
    }
    elsif( /^\s*#else\b/ && $do_include ne 'void' ) {
      $have_line = $.;
      unless(@stack) {
        print "$0: Error: Hierarchy error at #else in $script.pin line $.\n";
        exit 1;
      }
      $do_include = !$do_include;
    }
    elsif( /^\s*#fi\b/ ) {
      $have_line = $.;
      unless(@stack) {
        print "$0: Error: Hierarchy error at #fi in $script.pin line $.\n";
        exit 1;
      }
      $do_include = pop @stack;
    }
    elsif( /^\s*#-/ ) {
      $have_line = $.;
      next;
    }
    elsif( $do_include && $do_include ne 'void' ) {
      if($have_line) {
        print OUT "# line " . ($have_line + 1) . qq{ "$sourcefilename"\n}
          if($opt{devel});
        $have_line = 0;
      }
      s#@(\w+)@#my $a = defined $cfg{$1} ? $cfg{$1} : ''; $a  =~ s/\\/\\\\/g unless($1 eq 'PERL'); $a#ge;
      print OUT;
    }
  }

  if($add_header_footer) {
    print OUT $cfg{'PERLFOOTER'};
  }

  close(IN);
  close(OUT);

  if(@stack) {
    # print "Stack: ",join(',',@stack),"\n";
    print "$0: Error: Hierarchy error in $script.pin at EOF\n";
    exit 1;
  }

  # set execute permissions on unix
  if($executable) {
    eval { chmod 0755, $output };
    if($@) {
      print "Warning: $@\n";
    }
  }
}

sub make_bin_dir {
  my @plats = @_;

  unless(-d $BINDIR) {
    unless(mkdir($BINDIR,0755)) {
      print qq{Error: Could not create directory "$BINDIR": $!\n};
      return 0;
    }
  }
  if(@plats) {
    my $p;
    foreach $p (@plats) {
      my $platbindir = "$BINDIR$dd$p";
      unless(-d $platbindir) {
        unless(mkdir($platbindir,0755)) {
          print qq{Error: Could not create directory "$platbindir": $!\n};
          return 0;
        }
      }
    }
  }
  1;
}
