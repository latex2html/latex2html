# letter.perl by Ross Moore <ross@mpce.mq.edu.au>  09-14-97
#
# Extension to LaTeX2HTML V97.1 to support the "letter" document class
# and standard LaTeX2e class options.
#
# Change Log:
# ===========

package main;


# Suppress option-warning messages:

sub do_letter_10pt{}
sub do_letter_11pt{}
sub do_letter_12pt{}
sub do_letter_a4paper{}
sub do_letter_a5paper{}
sub do_letter_b5paper{}
sub do_letter_legalpaper{}
sub do_letter_letterpaper{}
sub do_letter_executivepaper{}
sub do_letter_landscape{}
sub do_letter_final{}
sub do_letter_draft{}
sub do_letter_oneside{}
sub do_letter_twoside{}
sub do_letter_openright{}
sub do_letter_openany{}
sub do_letter_onecolumn{}
sub do_letter_twocolumn{}
sub do_letter_notitlepage{}
sub do_letter_titlepage{}
sub do_letter_openbib{}
sub do_letter_leqno{ $EQN_TAGS = 'L'; }
sub do_letter_reqno{ $EQN_TAGS = 'R'; }
sub do_letter_fleqn{ $FLUSH_EQN = 1; }

1;	# Must be last line
