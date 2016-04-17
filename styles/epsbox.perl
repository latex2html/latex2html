# epsbox.perl by Marek Rouchal
#
# Extension to LaTeX2HTML V96.2 to supply support for the "epsbox.sty"
# package.
#
# Last modification: Wed Oct 30 15:31:57 MET 1996
#
# Based on graphics.perl by Herbert Swan <dprhws.edp.Arco.com>  12-22-95
# Thanks to Takafumi Hayasi <takafumi@u-aizu.ac.jp> for supplying
# the information to build this file.

package main;

&process_commands_in_tex (<<_RAW_ARG_CMDS_);
psbox # [] # {}
epsfile # {}
postscriptbox # {} # {} # {}
_RAW_ARG_CMDS_

1;	# Must be last line
