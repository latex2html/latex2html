# $Id: carom.perl,v 1.1 1998/08/24 09:48:45 RRM Exp $
#
#  carom.perl   by Ross Moore <ross@mpce.mq.edu.au>
#
# This file is part of the LaTeX2HTML support for the XyM-TeX package
# for TeX and LaTeX by Shinsaku Fujita
#
# Change Log
# ==========
# $Log carom.perl,v $
#

package main;

&do_require_package('chemstr');

#
# Each command is treated as generating a separate inlined image.
#
# If this is inadequate for more complicated structures, then make
# use of the \begin{makeimage}...\end{makeimage} environment
# from the  html.sty  package.
#

&process_commands_in_tex ( <<_INLINE_CMDS_);
cyclohexanev # [] # {}
bzdrv # [] # {}
decalinev  # [] # {}
naphdrv # [] # {}
tetralinev # [] # {}
hanthracenev # [] # {}
anthracenev # [] # {}
hphenanthrenev # [] # {}
phenanthrenev # [] # {}
steroid # [] # {}
steroidchain # [] # {}
cyclohexaneh # [] # {}
bzdrh # [] # {}
decalineh # [] # {}
naphdrh # [] # {}
tetralineh # [] # {}
_INLINE_CMDS_

1;

