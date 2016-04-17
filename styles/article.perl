# article.perl by Ross Moore <ross@mpce.mq.edu.au>  09-14-97
#
# Extension to LaTeX2HTML V97.1 to support the "article" document class
# and standard LaTeX2e class options.
#
# Change Log:
# ===========
#
# $Log: article.perl,v $
# Revision 1.6  1998/06/18 12:09:35  RRM
#  --  do not override user's $LATEX_FONT_SIZE settings
#
# Revision 1.5  1998/02/20 22:08:30  latex2html
# added log
#
# ----------------------------
# revision 1.4
# date: 1998/02/13 12:58:51;  author: latex2html;  state: Exp;  lines: +2 -2
#  --  corrected the use of `.' in section-numbers
# ----------------------------
# revision 1.3
# date: 1998/02/03 02:06:23;  author: RRM;  state: Exp;  lines: +21 -9
#  --  improved the counter-numbering macros: \the<counter>
# ----------------------------
# revision 1.2
# date: 1998/01/09 02:15:55;  author: RRM;  state: Exp;  lines: +4 -3
#  --  sets  $LATEX_FONT_SIZE  from class options [10pt,11pt,12pt]
# ----------------------------
# revision 1.1
# date: 1997/09/19 11:00:53;  author: RRM;  state: Exp;
#      Document-class emulation file
# 	-- adjusts the \the<counter> macros for sectioning commands
# 	-- suppresses warnings for standard class-options


package main;


# Suppress option-warning messages:

sub do_article_a4paper{}
sub do_article_a5paper{}
sub do_article_b5paper{}
sub do_article_legalpaper{}
sub do_article_letterpaper{}
sub do_article_executivepaper{}
sub do_article_landscape{}
sub do_article_final{}
sub do_article_draft{}
sub do_article_oneside{}
sub do_article_twoside{}
sub do_article_openright{}
sub do_article_openany{}
sub do_article_onecolumn{}
sub do_article_twocolumn{}
sub do_article_notitlepage{}
sub do_article_titlepage{}
sub do_article_openbib{}

sub do_article_10pt{ $LATEX_FONT_SIZE = '10pt' unless $LATEX_FONT_SIZE; }
sub do_article_11pt{ $LATEX_FONT_SIZE = '11pt' unless $LATEX_FONT_SIZE; }
sub do_article_12pt{ $LATEX_FONT_SIZE = '12pt' unless $LATEX_FONT_SIZE; }

sub do_article_leqno{ $EQN_TAGS = 'L'; }
sub do_article_reqno{ $EQN_TAGS = 'R'; }
sub do_article_fleqn{ $FLUSH_EQN = 1; }

sub do_cmd_thesection {
    join('', &do_cmd_arabic("${O}0${C}section${O}0$C"), @_[0]) }
sub do_cmd_thesubsection {
    join('',&translate_commands("\\thesection")
	,".", &do_cmd_arabic("${O}0${C}subsection${O}0$C"), @_[0]) }
sub do_cmd_thesubsubsection {
    join('',&translate_commands("\\thesubsection")
	,"." , &do_cmd_arabic("${O}0${C}subsubsection${O}0$C"), @_[0]) }
sub do_cmd_theparagraph {
    join('',&translate_commands("\\thesubsubsection")
	,"." , &do_cmd_arabic("${O}0${C}paragraph${O}0$C"), @_[0]) }
sub do_cmd_thesubparagraph {
    join('',&translate_commands("\\theparagraph")
	,"." , &do_cmd_arabic("${O}0${C}subparagraph${O}0$C"), @_[0]) }


sub do_cmd_theequation {
    join('', &do_cmd_arabic("${O}0${C}equation${O}0$C"), @_[0]) }

sub do_cmd_thefootnote {
    join('', &do_cmd_arabic("${O}0${C}footnote${O}0$C"), @_[0]) }

sub do_cmd_thefigure {
    join('', &do_cmd_arabic("${O}0${C}figure${O}0$C"), @_[0]) }

sub do_cmd_thetable {
    join('',  &do_cmd_arabic("${O}0${C}table${O}0$C"), @_[0]) }


1;	# Must be last line
