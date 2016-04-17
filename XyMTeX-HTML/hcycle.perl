# $Id: hcycle.perl,v 1.1 1998/08/24 09:48:47 RRM Exp $
#
#  hcycle.perl   by Ross Moore <ross@mpce.mq.edu.au>
#
# This file is part of the LaTeX2HTML support for the XyM-TeX package
# for TeX and LaTeX by Shinsaku Fujita
#
# Change Log
# ==========
# $Log hcycle.perl,v $
#

package main;

&do_require_package('chemstr');

&ignore_commands( <<_IGNORED_CMDS_);
#pyranose # [] # {}
#furanose # [] # {}
_IGNORED_CMDS_


#
# Each command is treated as generating a separate inlined image.
#
# If this is inadequate for more complicated structures, then make
# use of the \begin{makeimage}...\end{makeimage} environment
# from the  html.sty  package.
#

&process_commands_in_tex ( <<_INLINE_CMDS_);
pyranose # [] # {}
furanose # [] # {}
_INLINE_CMDS_

1;

