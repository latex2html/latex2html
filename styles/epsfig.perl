# epsfig.perl by Michel Goossens <goossens@cern.ch>  01-14-96
#
# Extension to LaTeX2HTML V 96.1 to support epsfig.sty
# which is part of standard LaTeX2e graphics bunble.
#
# ...and epsf.sty  and  psfig.sty  
#	by Ross Moore <ross@mpce.mq.edu.au>  22-05-98
#
# Change Log:
# ===========


# Suppress warning messages for unneeded options

sub do_epsfig_silent {}
sub do_epsfig_noisy {}
sub do_epsfig_prolog {}
sub do_epsfig_draft {}
sub do_epsfig_full {}

sub do_epsfig_dvips {}



package main;

&ignore_commands( <<_IGNORED_CMDS_);
epsfverbosetrue
epsfverbosefalse
pssilent
psnoisy
_IGNORED_CMDS_

&process_commands_nowrap_in_tex (<<_RAW_ARG_CMDS_);
epsfclipon
epsfclipoff
epsfsize # {} # {} # &get_numeric_argument;
epsfxsize # &get_numeric_argument;
epsfysize # &get_numeric_argument;
psdraft
psfull
psfigdriver # {}
_RAW_ARG_CMDS_

&process_commands_in_tex (<<_RAW_ARG_CMDS_);
psfig # {}
epsfig # {}
epsfbox  # [] # {}
epsffile # [] # {}
_RAW_ARG_CMDS_

1;	# Must be last line
