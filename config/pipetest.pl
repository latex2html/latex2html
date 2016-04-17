#! /usr/bin/perl -w

###############################################################################
# $Id: pipetest.pl,v 1.1 1999/05/11 06:10:03 MRO Exp $
#
# pipetest.pl
#
# sample for test if multiple pipes work. Reads a number from STDIN,
# increments it and prints it to STDOUT
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
# $Log: pipetest.pl,v $
# Revision 1.1  1999/05/11 06:10:03  MRO
#
#
# - merged config stuff, did first tries on Linux. Simple document
#   passes! More test required, have to ger rid of Warnings in texexpand
#
# Revision 1.4  1998/12/12 16:39:19  MRO
#
#
# -- cosmetic changes, reworked catching of STDERR in config.pl (Win32)
# -- new configure opt --disable-paths
# -- major cleanups
#
# Revision 1.3  1998/10/31 14:13:10  MRO
# -- changed OS-dependent module loading strategy: Modules are now located in
#    different (OS-specific) directories nut have the same name: Easier to
#    maintain and cleaner code
# -- Cleaned up config procedure
# -- Extended makefile functionality
#
# Revision 1.2  1998/03/02 23:38:46  latex2html
# Reworked configuration procedure substantially. Fixed some killing bugs.
# Should now run on Win32, too.
# The file prefs.pm contains user-configurable stuff for DOS platforms.
# UNIX users can override the settings with the configure utility (preferred).
#
# Revision 1.1  1998/02/14 19:32:01  latex2html
# Preliminary checkin of configuration procedure
#
###############################################################################

require 5.003;
use strict;
#use diagnostics;

my $in = <STDIN>;
chomp $in;
$in++;
print "$in\n";
exit 0;

