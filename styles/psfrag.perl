# psfrag.perl  by Ross Moore  <ross@maths.mq.edu.au>  99-09-06
#
# Extension to LaTeX2HTML V 99.2 to supply support for the "psfrag"
# LaTeX2e supported package.
#
# Change Log:
# ===========

package main;

# Suppress option-warning messages:

sub do_psfrag_scanall {}
sub do_psfrag_2emode {}
sub do_psfrag_209mode {}
sub do_psfrag_debugshow {}
sub do_graphics_debugshow {}


# put commands into  images.tex 

&process_commands_in_tex (<<_RAW_ARG_CMDS_);
epsfbox # {}
_RAW_ARG_CMDS_

&process_commands_nowrap_in_tex (<<_RAW_ARG_CMDS_);
psfragstar # {} # {}
psfrag # {} # {}
_RAW_ARG_CMDS_


&ignore_commands( <<_IGNORED_CMDS_);
\psfragspecial # {} # {} # {} # {} # {} # {}
_IGNORED_CMDS_


1;	# Must be last line
