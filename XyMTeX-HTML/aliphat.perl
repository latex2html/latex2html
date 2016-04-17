# $Id: aliphat.perl,v 1.1 1998/08/24 09:48:44 RRM Exp $
#
#  aliphat.perl   by Ross Moore <ross@mpce.mq.edu.au>
#
# This file is part of the LaTeX2HTML support for the XyM-TeX package
# for TeX and LaTeX by Shinsaku Fujita
#
# Change Log
# ==========
# $Log aliphat.perl,v $
#

package main;

&do_require_package('chemstr');

&process_commands_nowrap_in_tex ( <<_IGNORED_CMDS_);
_IGNORED_CMDS_

&process_commands_wrap_deferred ( <<_DEFERRED_CMDS_);
_DEFERRED_CMDS_

#
# Each command is treated as generating a separate inlined image.
#
# If this is inadequate for more complicated structures, then make
# use of the \begin{makeimage}...\end{makeimage} environment
# from the  html.sty  package.
#

&process_commands_in_tex ( <<_INLINE_CMDS_);
Northbond
Eastbond
Southbond
Westbond
NEBond
NEbond
SEBond
SEbond
NWBond
NWbond
SWBond
SWbond
#  <Macros for tetravalent atoms>
tetrahedral # [] # {}
square # [] # {}
#  <Macros for trivalent atoms>
rtrigonal # [] # {}
ltrigonal # [] # {}
utrigonal # [] # {}
Utrigonal # [] # {}
dtrigonal # [] # {}
Dtrigonal # [] # {}
#  <Macros for two-carbon compounds>
ethylene # [] # {} # {}
ethylenev # [] # {} # {}
Ethylenev # [] # {} # {}
#  <Macros for stereo-projection>
tetrastereo # [] # {}
dtetrastereo # [] # {}
ethanestereo # [] # {} # {}
_INLINE_CMDS_

1;

