# amsfonts.perl by Ross Moore <ross@mpce.mq.edu.au>  9-13-96
#
# Extension to LaTeX2HTML to suppress messages when AMS-fonts
# are loaded, via packages:
#   amsfonts, amssymb, eucal, eufrak or euscript. 
#
# Change Log:
# ===========

package main;
#

print "\nLoading AMS-fonts...";
#  Suppress the possible options to   \usepackage[....]{amsfonts}

sub do_amsfonts_psamsfonts {
}
sub do_amssymb_psamsfonts {
}
sub do_eucal_psamsfonts {
}
sub do_eucal_mathcal {
}
sub do_eucal_mathscr {
}
sub do_eufrak_psamsfonts {
}
sub do_euscript_psamsfonts {
}
sub do_euscript_mathcal {
}
sub do_euscript_mathscr {
}


&ignore_commands( <<_IGNORED_CMDS_);
_IGNORED_CMDS_


&process_commands_in_tex (<<_RAW_ARG_CMDS_);
mathbb # {}
_RAW_ARG_CMDS_


&process_commands_inline_in_tex (<<_RAW_ARG_CMDS_);
_RAW_ARG_CMDS_


&process_commands_nowrap_in_tex (<<_RAW_ARG_NOWRAP_CMDS_);
_RAW_ARG_NOWRAP_CMDS_


1;                              # This must be the last line
