#!/usr/local/bin/perl -w

###############################################################################
# $Id: redir.pl,v 1.1 1999/05/11 06:10:03 MRO Exp $
#
# redir.pl
#
# Accompanies LaTeX2HTML
#
# This little utility redirects all messages of an external program to
# STDOUT, so that also STDERR can be captured from the calling program 
# easily.
#
# Author: Marek Rouchal <marek@saftsack.fs.uni-bayreuth.de>
# inspired by several postings in comp.lang.perl.misc wrt. this
# neverending subject :-)
#
# This software is part of LaTeX2HTML, originally by Nikos Drakos.
# It is published under the GNU Public License and comes without any
# warranty.
#
# You aren't supposed to edit this script. You can specify command line
# options to customize it to your local setup.

##############################################################################
# Usage: perl redir.pl <command> [ <arg1> ... ]
#
# <command> is invoked with redirected STDERR, output is presented in this
# way (without the leading # of course):
#
# ---STDERR---
# <all output to STDERR here>
# ---STDOUT---
# <all output to STDOUT here>
#
# Blank lines are skipped. The exit status of redir reflects the exit
# status of <command>. Note that on Win32 this value isn't reliable,
# unfortunately.

use strict;

# Exit friendly if invoked with empty arguments
exit 0 unless(@ARGV);
my $cmd = join(' ',@ARGV);
exit 0 if($cmd =~ /^\s*$/);

# flush STDOUT rapidly
$| = 1;

# This is the crucial operation!
open(STDERR,">&STDOUT") || die "Cannot dup STDERR: $!\n";

# print first tag
print "---STDERR---\n";

# execute command and catch it's STDOUT. STDERR goes to STDOUT now!
my $out = `$cmd`;

# Remember the status
my $stat = $? || 0;
# compatibilty hack for Win32/unix
$stat >>= 8 if($stat > 255);

# give the pipes time to flush, we're not in a hurry :-)
sleep 1;

# Print the second tag
print "---STDOUT---\n$out";

# For debugging only
#print "---STAT $stat---\n";

# The end
exit $stat;

