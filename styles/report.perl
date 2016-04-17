# report.perl by Ross Moore <ross@mpce.mq.edu.au>  09-14-97
#
# Extension to LaTeX2HTML V97.1 to support the "report" document class
# and standard LaTeX2e class options.
#
# Change Log:
# ===========

package main;


# Suppress option-warning messages:

sub do_report_a4paper{}
sub do_report_a5paper{}
sub do_report_b5paper{}
sub do_report_legalpaper{}
sub do_report_letterpaper{}
sub do_report_executivepaper{}
sub do_report_landscape{}
sub do_report_final{}
sub do_report_draft{}
sub do_report_oneside{}
sub do_report_twoside{}
sub do_report_openright{}
sub do_report_openany{}
sub do_report_onecolumn{}
sub do_report_twocolumn{}
sub do_report_notitlepage{}
sub do_report_titlepage{}
sub do_report_openbib{}

sub do_report_10pt{ $LATEX_FONT_SIZE = '10pt' unless $LATEX_FONT_SIZE; }
sub do_report_11pt{ $LATEX_FONT_SIZE = '11pt' unless $LATEX_FONT_SIZE; }
sub do_report_12pt{ $LATEX_FONT_SIZE = '12pt' unless $LATEX_FONT_SIZE; }

sub do_report_leqno{ $EQN_TAGS = 'L'; }
sub do_report_reqno{ $EQN_TAGS = 'R'; }
sub do_report_fleqn{ $FLUSH_EQN = 1; }

sub do_cmd_thechapter {
    join('', &do_cmd_arabic("${O}0${C}chapter${O}0$C"), ".", @_[0]) }

sub do_cmd_thesection {
    join('',&translate_commands("\\thechapter")
	, &do_cmd_arabic("${O}0${C}section${O}0$C"), @_[0]) }

sub do_cmd_thesubsection {
    join('',&translate_commands("\\thesection")
	,"." , &do_cmd_arabic("${O}0${C}subsection${O}0$C"), @_[0]) }

sub do_cmd_thesubsubsection {
    join('',&translate_commands("\\thesubsection")
	,"." , &do_cmd_arabic("${O}0${C}subsubsection${O}0$C"), @_[0]) }

sub do_cmd_theparagraph {
    join('',&translate_commands("\\thesubsubsection")
	,"." , &do_cmd_arabic("${O}0${C}paragraph${O}0$C"), @_[0]) }

sub do_cmd_thesubparagraph {
    join('',&translate_commands("\\theparagraph")
	,"." , &do_cmd_arabic("${O}0${C}subparagraph${O}0$C"), @_[0]) }

&addto_dependents('chapter','equation');
&addto_dependents('chapter','footnote');
&addto_dependents('chapter','figure');
&addto_dependents('chapter','table');

sub do_cmd_theequation {
    local($chap) =  &translate_commands("\\thechapter");
    join('', (($chap =~ /^(0\.)?$/)? '' : $chap)
        , &do_cmd_arabic("${O}0${C}equation${O}0$C"), @_[0]) }

sub do_cmd_thefootnote {
    local($chap) =  &translate_commands("\\thechapter");
    join('', (($chap =~ /^(0\.)?$/)? '' : $chap)
        , &do_cmd_arabic("${O}0${C}footnote${O}0$C"), @_[0]) }

sub do_cmd_thefigure {
    local($chap) =  &translate_commands("\\thechapter");
    join('', (($chap =~ /^(0\.)?$/)? '' : $chap)
        , &do_cmd_arabic("${O}0${C}figure${O}0$C"), @_[0]) }

sub do_cmd_thetable {
    local($chap) =  &translate_commands("\\thechapter");
    join('', (($chap =~ /^(0\.)?$/)? '' : $chap)
        , &do_cmd_arabic("${O}0${C}table${O}0$C"), @_[0]) }

1;	# Must be last line
