# memoir.perl by Georgy Salnikov <sge@nmr.nioch.nsc.ru>  2021/01/29
#
# Extension to LaTeX2HTML V2021 to support the "memoir" document class
# and some of its class options. Currently support is very limited.
#
# Partly adapted from book.perl
#
# Change Log:
# ===========
#
# $Log:  $

package main;

# Suppress option-warning messages:

sub do_memoir_a4paper{}
sub do_memoir_a5paper{}
sub do_memoir_b5paper{}
sub do_memoir_legalpaper{}
sub do_memoir_letterpaper{}
sub do_memoir_executivepaper{}
sub do_memoir_landscape{}
sub do_memoir_final{}
sub do_memoir_draft{}
sub do_memoir_ms{}
sub do_memoir_oneside{}
sub do_memoir_twoside{}
sub do_memoir_openright{}
sub do_memoir_openleft{}
sub do_memoir_openany{}
sub do_memoir_onecolumn{}
sub do_memoir_twocolumn{}
sub do_memoir_openbib{}
sub do_memoir_extrafontsizes{}

sub do_memoir_10pt{ $LATEX_FONT_SIZE = '10pt' unless $LATEX_FONT_SIZE; }
sub do_memoir_11pt{ $LATEX_FONT_SIZE = '11pt' unless $LATEX_FONT_SIZE; }
sub do_memoir_12pt{ $LATEX_FONT_SIZE = '12pt' unless $LATEX_FONT_SIZE; }

sub do_memoir_leqno{ $EQN_TAGS = 'L'; }
sub do_memoir_reqno{ $EQN_TAGS = 'R'; }
sub do_memoir_fleqn{ $FLUSH_EQN = 1; }

&addto_dependents('chapter','equation');
&addto_dependents('chapter','footnote');
&addto_dependents('chapter','figure');
&addto_dependents('chapter','table');

sub do_memoir_article {
    &remove_dependency('chapter','equation');
    &remove_dependency('chapter','footnote');
    &remove_dependency('chapter','figure');
    &remove_dependency('chapter','table');

    delete ($depends_on{'equation'}) if (exists ($depends_on{'equation'}));
    delete ($depends_on{'footnote'}) if (exists ($depends_on{'footnote'}));
    delete ($depends_on{'figure'})   if (exists ($depends_on{'figure'}));
    delete ($depends_on{'table'})    if (exists ($depends_on{'table'}));

    $styles_loaded{'memoir_article'} = 1;
}

sub do_cmd_thepart {
    join('', &do_cmd_Roman("${O}0${C}part${O}0$C"), ".", @_[0]) }

sub do_cmd_thechapter {
    join('', &do_cmd_arabic("${O}0${C}chapter${O}0$C"), ".", @_[0]) }

sub do_cmd_thesection {
# Memoir seems to always prepend chapter number to sections
#    if ($styles_loaded{'memoir_article'}) {
#        join('', &do_cmd_arabic("${O}0${C}section${O}0$C"), @_[0]);
#    } else {
        join('', &translate_commands("\\thechapter"),
	     &do_cmd_arabic("${O}0${C}section${O}0$C"), @_[0]);
#    }
}

sub do_cmd_thesubsection {
    join('', &translate_commands("\\thesection")
	,".", &do_cmd_arabic("${O}0${C}subsection${O}0$C"), @_[0]) }

sub do_cmd_thesubsubsection {
    join('', &translate_commands("\\thesubsection")
	,".", &do_cmd_arabic("${O}0${C}subsubsection${O}0$C"), @_[0]) }

sub do_cmd_theparagraph {
    join('', &translate_commands("\\thesubsubsection")
	,".", &do_cmd_arabic("${O}0${C}paragraph${O}0$C"), @_[0]) }

sub do_cmd_thesubparagraph {
    join('', &translate_commands("\\theparagraph")
	,".", &do_cmd_arabic("${O}0${C}subparagraph${O}0$C"), @_[0]) }

sub do_cmd_theequation {
    local($chap) = '';
    $chap = &translate_commands("\\thechapter")
        unless ($styles_loaded{'memoir_article'});
    join('', (($chap =~ /^(0\.)?$/)? '' : $chap)
        , &do_cmd_arabic("${O}0${C}equation${O}0$C"), @_[0]) }

sub do_cmd_thefootnote {
    local($chap) = '';
# Memoir seems not to prepend chapter number to footnotes
#    $chap = &translate_commands("\\thechapter")
#        unless ($styles_loaded{'memoir_article'});
    join('', (($chap =~ /^(0\.)?$/)? '' : $chap)
        , &do_cmd_arabic("${O}0${C}footnote${O}0$C"), @_[0]) }

sub do_cmd_thefigure {
    local($chap) = '';
    $chap = &translate_commands("\\thechapter")
        unless ($styles_loaded{'memoir_article'});
    join('', (($chap =~ /^(0\.)?$/)? '' : $chap)
        , &do_cmd_arabic("${O}0${C}figure${O}0$C"), @_[0]) }

sub do_cmd_thetable {
    local($chap) = '';
    $chap = &translate_commands("\\thechapter")
        unless ($styles_loaded{'memoir_article'});
    join('', (($chap =~ /^(0\.)?$/)? '' : $chap)
        , &do_cmd_arabic("${O}0${C}table${O}0$C"), @_[0]) }

# bibliography title comes from \bibname
sub make_bibliography_title {
    local($br_id, $title);
    if ((defined &do_cmd_bibname)||$new_command{'bibname'}) {
	$br_id=++$global{'max_id'};
	$title = &translate_environments("$O$br_id$C\\bibname$O$br_id$C");
    } else { $title = $bib_title }
    return $title;
}

# Memoir stimulates to use various adjustment commands which are related
# to typography but completely unrelated to HTML. They have to be
# explicitly ignored otherwise ugly numeric arguments may be left as text.
&ignore_commands (<<_IGNORED_CMDS_);
setstocksize # {} # {}
settrims # {} # {}
settrimmedsize # {} # {} # {}
settypeblocksize # {} # {} # {}
setlrmargins # {} # {} # {}
setlrmarginsandblock # {} # {} # {}
setulmargins # {} # {} # {}
setulmarginsandblock # {} # {} # {}
setbinding # {}
setcolsepandrule # {} # {}
setheadfoot # {} # {}
setheaderspaces # {} # {} # {}
setmarginnotes # {} # {} # {}
setfootins # {} # {}
checkthelayout # []
fixthelayout
fixpdflayout
fixdvipslayout
checkandfixthelayout # []
typeoutlayout
typeoutstandardlayout
settypeoutlayoutunit # {}
medievalpage # []
isopage # []
semiisopage # []
setpagebl # {} # {} # {}
setpageml # {} # {} # {}
setpagetl # {} # {} # {}
setpagetm # {} # {} # {}
setpagetr # {} # {} # {}
setpagemr # {} # {} # {}
setpagebr # {} # {} # {}
setpagebm # {} # {} # {}
setpagecc # {} # {} # {}
_IGNORED_CMDS_

# These are ignored for now but may be implemented later to some extent
&ignore_commands (<<_IGNORED_CMDS_);
settocdepth # {}
maxtocdepth # {}
setsecnumdepth # {}
maxsecnumdepth # {}
addtodef # {} # {} # {}
addtoiargdef # {} # {} # {}
makechapterstyle # {} # {}
chapterstyle # {}
_IGNORED_CMDS_

1;	# Must be last line
