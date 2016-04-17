# -*- perl -*-
##############################################################################
# $Id: L2hos.pm,v 1.3 2001/07/02 02:21:35 RRM Exp $
#
# L2hos.pm
#
# Wrapper module for OS dependent stuff. Integrates the modules in
# the L2hos:: subdirectory.
#
# Author: Marek Rouchal <marek@saftsack.fs.uni-bayreuth.de>
# using stuff from the former Override.pm and from the File::Spec modules.
#
# This software is part of LaTeX2HTML, originally by Nikos Drakos
# It is published under the GNU Public License and comes without any
# warranty.
#
# You aren't supposed to edit this script.
#
##############################################################################
# Changes History
#
# $Log: L2hos.pm,v $
# Revision 1.3  2001/07/02 02:21:35  RRM
#  --  added recognition of 'darwin' OS, for MacOS X, as a Unix system
#
# Revision 1.2  1999/06/03 12:15:33  MRO
#
#
# - cleaned up the TMP / TMPDIR / TMP_ mechansim. Should work much the
#   same now, but the code should be easier to understand.
#
# - cleaned up L2hos, added an INSTALLation FAQ, beautified the test
#   document a little bit
#
# Revision 1.1  1999/05/11 06:09:50  MRO
#
#
# - merged config stuff, did first tries on Linux. Simple document
#   passes! More test required, have to ger rid of Warnings in texexpand
#
# Revision 1.1  1999/03/15 23:00:51  MRO
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
##############################################################################

package L2hos;

require Exporter;

@ISA = qw(Exporter);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw();
@EXPORT_OK = qw($Verbose);

use strict;
use vars qw(@ISA $VERSION $Verbose);

($VERSION) = q$Revision: 1.3 $ =~ /:\s*(\S+)/;

$Verbose = 0;

sub load {
	my ($class,$OS) = @_;
	if ($OS eq 'os2') {
		require L2hos::OS2;
		'L2hos::OS2'
        # to be done somewhen...
	#elsif ($OS eq 'VMS') {
	#	require L2hos::VMS;
	#	'L2hos::VMS'
	} elsif ($OS eq 'MacOS') {
		require L2hos::Mac;
		'L2hos::Mac'
	} elsif ($OS eq 'darwin') {
		require L2hos::Unix;
		'L2hos::Unix'
	} elsif ($OS eq 'MSWin32') {
		require L2hos::Win32;
		'L2hos::Win32'
	} elsif ($OS =~ /(win|dos)/i) {
		require L2hos::Dos;
		'L2hos::Dos'
	} else {
                require L2hos::Unix;
		'L2hos::Unix'
	}
}

@ISA = load('L2hos', $^O);

1;

