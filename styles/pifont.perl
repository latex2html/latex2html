# -*- perl -*-
#
# $Id: pifont.perl,v 1.0 2026/08/18 CF $
#
# pifont.perl
#   Clément Foyer <clement.foyer@univ-reims.fr> 18/08/26
#
# Extension to LaTeX2HTML V2026 to partly support the "pifont" package.
#
# Change Log:
# ===========
#
# $Log: pifont.perl,v1 $
#
# Note:
# This module provides translation for the \pifont commands
# and for some more commands of the pifont.sty package
#

package main;

sub do_cmd_ding {
    local($_) = @_;
    local($contents) = &missing_braces unless (
        (s/$next_pair_pr_rx/$contents = $2;''/e)
        ||(s/$next_pair_rx/$contents = $2;''/e));
    # CF: 9952 = hex(2700) - 32
    #    (start of Zapf block in Unicode minus offset inside block)
    sprintf("&#x%X", 9952 + $contents);
}

1;			# Must be last line
