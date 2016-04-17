# $Id: lowcycle.perl,v 1.1 1998/08/24 09:48:50 RRM Exp $
#
#  lowcycle.perl   by Ross Moore <ross@mpce.mq.edu.au>
#
# This file is part of the LaTeX2HTML support for the XyM-TeX package
# for TeX and LaTeX by Shinsaku Fujita
#
# Change Log
# ==========
# $Log lowcycle.perl,v $
#

package main;

&do_require_package('chemstr');
&do_require_package('hetarom');
&do_require_package('hetaromh');

&ignore_commands( <<_IGNORED_CMDS_);
#cyclopentanev # [] # {}
#cyclopentanevi # [] # {}
#cyclopentaneh # [] # {}
#cyclopentanehi # [] # {}
#cyclobutane # [] # {}
#cyclopropane # [] # {}
#indanev # [] # {}
#indanevi # [] # {}
#indaneh # [] # {}
#indanehi # [] # {}
_IGNORED_CMDS_


#
# Each command is treated as generating a separate inlined image.
#
# If this is inadequate for more complicated structures, then make
# use of the \begin{makeimage}...\end{makeimage} environment
# from the  html.sty  package.
#

&process_commands_in_tex ( <<_INLINE_CMDS_);
cyclopentanev # [] # {}
cyclopentanevi # [] # {}
cyclopentaneh # [] # {}
cyclopentanehi # [] # {}
cyclobutane # [] # {}
cyclopropane # [] # {}
indanev # [] # {}
indanevi # [] # {}
indaneh # [] # {}
indanehi # [] # {}
_INLINE_CMDS_

1;

