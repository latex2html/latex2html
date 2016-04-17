# slides.perl by Ross Moore <ross@mpce.mq.edu.au>  09-14-97
#
# Extension to LaTeX2HTML V97.1 to support the "slides" document class
# and standard LaTeX2e class options.
#
# Change Log:
# ===========

package main;


# Suppress option-warning messages:

sub do_slides_10pt{}
sub do_slides_11pt{}
sub do_slides_12pt{}
sub do_slides_a4paper{}
sub do_slides_a5paper{}
sub do_slides_b5paper{}
sub do_slides_legalpaper{}
sub do_slides_letterpaper{}
sub do_slides_executivepaper{}
sub do_slides_landscape{}
sub do_slides_final{}
sub do_slides_draft{}
sub do_slides_oneside{}
sub do_slides_twoside{}
sub do_slides_openright{}
sub do_slides_openany{}
sub do_slides_onecolumn{}
sub do_slides_twocolumn{}
sub do_slides_notitlepage{}
sub do_slides_titlepage{}
sub do_slides_openbib{}

sub do_slides_leqno{ $EQN_TAGS = 'L'; }
sub do_slides_reqno{ $EQN_TAGS = 'R'; }
sub do_slides_fleqn{ $FLUSH_EQN = 1; }

1;	# Must be last line
