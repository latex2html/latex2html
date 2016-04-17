# -*- perl -*-
###############################################################################
# $Id: Mac.pm,v 1.9 1999/10/25 21:18:22 MRO Exp $
#
# Mac.pm
#
# Contains MacOS specific wrappers for system commands.
#
# NOTE: These subs do proper error catching. They return 1 on success
#       and 0 on failure. In the latter case an error message is
#       printed.
#
# Author: Marek Rouchal <marek@saftsack.fs.uni-bayreuth.de>
# using stuff from the former Override.pm and from the File::Spec modules.
#
# This software is part of LaTex2HTML, originally by Nikos Drakos
# It is published under the GNU Public License and comes without any
# warranty.
#
# You aren't supposed to edit this script.
#
###############################################################################
# Changes History
#
# $Log: Mac.pm,v $
# Revision 1.9  1999/10/25 21:18:22  MRO
#
# -- added more configure options (Jens' suggestions)
# -- fixed bug in regexp range reported by Achim Haertel
# -- fixed old references in documentation (related to mail list/archive)
#
# Revision 1.8  1999/08/30 22:45:09  MRO
#
# -- perl now reports line numbers respective to .pin file - eases
#    code development!
# -- l2hcfg.pm is installed, too for furtjer reference
# -- some minor bugs (hopefully) fixed.
#
# Revision 1.7  1999/06/06 14:24:53  MRO
#
#
# -- many cleanups wrt. to TeXlive
# -- changed $* to /m as far as possible. $* is deprecated in perl5, all
#    occurrences should be removed.
#
# Revision 1.6  1999/06/04 15:30:16  MRO
#
#
# -- fixed errors introduced by cleaning up TMP*
# -- made pstoimg -quiet really quiet
# -- pstoimg -debug now saves intermediate result files
# -- several fixes for OS/2
#
# Revision 1.5  1999/06/03 12:15:44  MRO
#
#
# - cleaned up the TMP / TMPDIR / TMP_ mechansim. Should work much the
#   same now, but the code should be easier to understand.
#
# - cleaned up L2hos, added an INSTALLation FAQ, beautified the test
#   document a little bit
#
# Revision 1.4  1999/06/01 06:55:37  MRO
#
#
# - fixed small bug in L2hos/*
# - added some test_mode related output to latex2html
# - improved documentation
# - fixed small bug in pstoimg wrt. OS2
#
# Revision 1.3  1999/05/31 07:49:07  MRO
#
#
# - a lot of cleanups wrt. OS/2
# - make test now available (TEST.BAT on Win32, TEST.CMD on OS/2)
# - re-inserted L2HCONFIG environment
# - added some new subs to L2hos (path2os, path2URL, Cwd)
#
# Revision 1.2  1999/05/19 23:54:02  MRO
#
#
# -- uniquified icons - some of them look a little bit strange, might
#    need to be fixed.
# -- got rid of unlink errors, cleaned up some cosmetics
#
# Revision 1.1  1999/05/11 06:10:02  MRO
#
#
# - merged config stuff, did first tries on Linux. Simple document
#   passes! More test required, have to ger rid of Warnings in texexpand
#
# Revision 1.2  1999/05/05 19:47:06  MRO
#
#
# - many cosmetic changes
# - final backup before merge
#
# Revision 1.1  1999/03/15 23:00:54  MRO
#
#
# - moved L2hos modules to top level directory, so that no dir-
#   delimiter is necessary in the @INC-statement.
# - changed strategy for "shave": Do not rely on STDERR redirection any
#   more (caused problems on at least Win32)
#
# Revision 1.1  1999/02/10 01:37:16  MRO
#
#
# -- changed os-dependency structure again - now neat OO modules are
#    used: portable, extensible, neat!
# -- some minor cleanups and bugfixes
#
#
###############################################################################

# Warning! This package is under construction!
# No guarantee for anything, sorry...

package L2hos::Mac;

use Exporter ();

use Carp;
use Cwd;
use File::Copy;
use strict;
use L2hos qw($Verbose);

my $dd = ':';

# Platform identifier (configure internal)
sub plat {
  my ($self) = @_;
  'macOS';
}

# Directory delimiter
sub dd {
  my ($self) = @_;
  $dd;
}

# Path delimiter in PATH environment
sub pathd {
  my ($self) = @_;
  '|';
}

# current working directory in platform-specific format
sub Cwd {
  my ($self) = @_;
  path2os($self,cwd());
}

# The home directory
sub home {
  my ($self,$user) = @_;
  croak "Error (home): Cannot expand other user's home directory\n"
    if($user);
  $ENV{'HOME'} || Cwd() || '.';
}

# The shell the current user is running
sub shell {
  my ($self) = @_;
  ''; # sorry
}

# The user's login name
sub user {
  my ($self) = @_;
  $ENV{'USER'} || '';
}

# The user's full name
sub fullname {
  my ($self) = @_;
  $ENV{'USER'} || '';
}

# The hostname we're running on
sub host {
  my ($self) = @_;

  use Sys::Hostname;
  my $host = hostname() || '';
  $host;
}

# The null device to redirect garbage to
sub nulldev {
  my ($self) = @_;
  '';
}

# A copy method
sub Copy {
  my ($self,$from,$to) = @_;
  unless(copy($from,$to)) {
    carp qq{Error (Copy): Copy "$from" to "$to" failed: $!\n};
    return 0;
  }
  1;
}

# A delete/remove/unlink method
# ignore non-existing files
sub Unlink {
  my ($self,@files) = @_;
  my @items;
  if(@items = grep(-e, @files)) {
    unless(unlink(@items)) {
      carp 'Error (Unlink): Unlink "' . join(' ',@items) . "\" failed: $!\n";
      return 0;
    }
  }
  1;
}

# A rename/move method
sub Rename {
  my ($self,$from,$to) = @_;
  if(system('cp',$from,$to) || system('rm',$from)) {
    carp qq{Error (Rename): Rename (MacOS cp, rm) "$from" to "$to" failed: $!\n};
    return 0;
  }
  1;
}

# A (hard) link method
sub Link {
  my ($self,$from,$to) = @_;
  # no link available, simply Copy
  Copy($self,$from,$to);
  }

# A symbolic link method
sub Symlink {
  my ($self,$from,$to) = @_;
  # No symlinks, so copy
  &Copy($from,$to);
  }

# Given a directory name in either relative or absolute form, returns
# the absolute form.
# Note: The argument *must* be a directory name.
sub Make_directory_absolute {
  my ($self,$path) = @_;
  if($path =~ /^:/) { # relative!
    my $orig_cwd;
    unless($orig_cwd = cwd()) {
      carp qq{Error (Make_directory_absolute): Could not determine current directory: $!\n};
      return '';
    }
    unless(chdir $path) {
      carp qq{Error (Make_directory_absolute): chdir "$path" failed: $!\n};
      return '';
    }
    $path = cwd();
    chdir $orig_cwd;
  }
  path2os($self,$path);
}

# Call external tools
sub syswait {
  my ($self,$cmd,$in,$out,$err) = @_;
  carp qq{Debug (syswait): Running "$cmd"\n} if($Verbose);
  # it seems that no command is using specific redirections ...
  my $redirerr = 0;
  if($in) {
    open(SI, "<&STDIN");
    if(open(STDIN, "<$in")) {
      binmode(STDIN);
    } else {
      $in = '';
      $redirerr++;
    }
  }
  if($out) {
    open(SO, ">&STDOUT");
    if(open(STDOUT, ">$out")) {
      binmode(STDOUT);
    } else {
      $out = '';
      $redirerr++;
    }
  }
  if($err) {
    open(SE, ">&STDERR");
    if(open(STDERR, ">$err")) {
      binmode(STDERR);
    } else {
      $err = '';
      $redirerr++;
    }
  }
  my $errcode = system($cmd);
  if($in) {
    close(STDIN);
    open(STDIN, "<&SI");
  }
  if($out) {
    close(STDOUT);
    open(STDOUT, ">&SO");
  }
  if($err) {
    close(STDERR);
    open(STDERR, ">&SE");
  }
  if($redirerr) {
    carp "Warning (syswait): One or more redirections failed.\n";
  }
  $errcode;
}

# check if path is absolute
sub is_absolute_path {
  my ($self,$path) = @_;
  $path !~ /^\Q$dd\E/i; # Mac is different...
}

# Convert a path to OS-specific
sub path2os {
  my ($self,$path) = @_;
  # relative paths are just the other way round on Mac
  if($path =~ m:^(/*)(.*):) {
    $path = ($1 ? '' : ':' ) . $2;
  }
  $path =~ s:/+:$dd:g;
  $path;
}

# convert a path to an URL
sub path2URL {
  my ($self,$path) = @_;
  $path =~ s:[$dd$dd]+:/:g;
  "file:" . $path;
}

# convert a path so that LaTeX can use it
sub path2latex {
  my ($self,$path) = @_;
  $path =~ s:[$dd$dd]+:/:go;
  $path;
}

# run perldoc the right way
sub perldoc {
  my ($self,$script) = @_;
  use vars qw(%Config);
  eval 'use Config qw(%Config)'; # load perl's configuration
  my $perldoc = $Config{scriptdir}.$dd."perldoc";
  $script ||= $0;
  # no nroff here
  system("$perldoc -t $script");
}

# quote a command line argument
sub quote {
  my ($self,$str) = @_;
  $str;
}

1; # must be last line

__END__
