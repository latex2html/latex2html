# $Id: locant.perl,v 1.1 1998/08/24 09:48:49 RRM Exp $
#
#  locant.perl   by Ross Moore <ross@mpce.mq.edu.au>
#
# This file is part of the LaTeX2HTML support for the XyM-TeX package
# for TeX and LaTeX by Shinsaku Fujita
#
# Change Log
# ==========
# $Log locant.perl,v $
#

package main;

#
# Each command is treated as generating a separate inlined image.
#
# If this is inadequate for more complicated structures, then make
# use of the \begin{makeimage}...\end{makeimage} environment
# from the  html.sty  package.
#

&process_commands_in_tex ( <<_INLINE_CMDS_);
bdloocant # {} # {} # {} # {} # {} # {}
bdloocnth # {} # {} # {} # {} # {} # {}
sxloocant # {} # {} # {} # {} # {} # {}
sxloocnth # {} # {} # {} # {} # {} # {}
bdlocant
bdlocnth
sxlocant
sxlocnth
_INLINE_CMDS_

1;

