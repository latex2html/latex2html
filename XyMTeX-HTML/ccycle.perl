# $Id: ccycle.perl,v 1.1 1998/08/24 09:48:45 RRM Exp $
#
#  ccycle.perl   by Ross Moore <ross@mpce.mq.edu.au>
#
# This file is part of the LaTeX2HTML support for the XyM-TeX package
# for TeX and LaTeX by Shinsaku Fujita
#
# Change Log
# ==========
# $Log ccycle.perl,v $
#

package main;

&do_require_package('chemstr');

&ignore_commands( <<_IGNORED_CMDS_);
#chair # [] # {}
#bicychepv # [] # {}
#bicycheph # [] # {}
#bornane # [] # {}
#adamantane # [] # {}
_IGNORED_CMDS_


#
# Each command is treated as generating a separate inlined image.
#
# If this is inadequate for more complicated structures, then make
# use of the \begin{makeimage}...\end{makeimage} environment
# from the  html.sty  package.
#

&process_commands_in_tex ( <<_INLINE_CMDS_);
chair # [] # {}
bicychepv # [] # {}
bicycheph # [] # {}
bornane # [] # {}
adamantane # [] # {}
_INLINE_CMDS_

1;

