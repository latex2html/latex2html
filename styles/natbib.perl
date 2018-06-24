# $Id: natbib.perl,v 1.21 2001/11/08 00:50:15 RRM Exp $
# natbib.perl - LaTeX2HTML support for the LaTeX2e natbib package
#  (flexible author-year citations)
# Martin Wilck, 20.5.1996 (martin@tropos.de)
#
# Change Log:
# jcl = Jens Lippmann <lippmann@rbg.informatik.tu-darmstadt.de>
# mwk = Martin Wilck
# rrm = Ross Moore <ross@mpce.mq.edu.au>
# jab = James A. Bednar <jbednar@cs.utexas.edu>
#
# $Log: natbib.perl,v $
# Revision 1.21  2001/11/08 00:50:15  RRM
#  --  bibtex inserts \penalty<num> in places that can cause page-numbers
#      to be lost. Now a simple scan removes these.
#      Thanks to Stephan Marsland for reporting the problem.
#
# Revision 1.20  1999/04/09 18:14:19  JCL
# changed my e-Mail address
#
# Revision 1.19  1999/02/24 10:33:38  RRM
#  --  fixed the 'exec' instead of 'eval' typo, with  \harvarditem
#
# Revision 1.18  1998/12/02 02:32:48  RRM
#  --  corrections, updates and implementation of package options
# 	by Bruce Miller
#  --  adaptation of certain user-commands for indirection,
# 	e.g. to work correctly with frames
#  --  cosmetic edits
#
# Revision 1.17  1998/06/29 05:13:11  RRM
#  --  loads the new  babelbst.perl  module as well
#
# Revision 1.16  1998/06/18 11:39:24  RRM
#  --  removed a looping problem, with empty citations
#  --  cosmetic edits
#
# Revision 1.15  1998/06/05 05:23:57  latex2html
#  --  allow redefinition of names (e.g. \bibname ) and counter-outputs
#     (e.g. \theequation, \thesection etc.)
#
# Revision 1.14  1998/06/01 07:52:35  latex2html
#  --  fixed the memory problem due to recursion in do_env_bibliography
#  	thanks to Uli Wortmann for the test-file
#  --  properly implemented use of &bibitem_style and $BIBITEM_STYLE
#  --  removed the redundant  $has_punct
#
# Revision 1.13  1998/05/24 05:56:27  latex2html
#  --  fixed \citet  so that it works as in LaTeX now
#  --  cosmetic changes so that this file's code is more easily readable
#  --  changed a use of local($_) which grew memory !
# 	was this the cause of Uli's problem ?
#
# Revision 1.12  1998/05/23 13:33:51  latex2html
#  --  James Bednar's modifications/simplifications
#  --  also \citeauthor \citeyear etc. working with multiple citations
# from James Bednar: <jbednar@cs.utexas.edu>
#  --  consolidated all non-Harvard cite commands except \cite and
#      \cite* into one-line calls to a single function do_cite_common
#      to ensure uniform processing of optional arguments
#  --  fixed \citep -- had $cite_year_mark instead of $cite_par_mark
#  --  changed do_cite_keys to always include every optional argument
#  --  made \citeauthor, \citeauthor*, and \citefullauthor ignore
#      whether mode is numeric (i.e., they should never get any parens)
#  --  made \citealp act like \citealt (temporary)
#
# Revision 1.11  1998/04/29 10:11:07  latex2html
#  --  use the &bibitem_style function, which can be user-defined
#
# Revision 1.10  1998/02/19 22:24:30  latex2html
# th-darmstadt -> tu-darmstadt
#
# Revision 1.9  1997/10/07 06:59:44  RRM
#  --  moved the code to  do_cmd_citestar  up to just after do_cmd_cite
#  --  implemented \citep*  (oops, forgot it last time)
#  --  fixed \harvardurl to work properly and without html.sty
# 	thanks to James A. Bednar <jbednar@cs.utexas.edu> for noticing
#
# Revision 1.8  1997/09/19 10:57:44  RRM
#      Updated for compatibility with natbib.sty v6.6
#  --  all \cite... commands have a *-version and 2 optional arguments
#  --  Harvard emulation is now automatic
#
# Revision 1.7  1997/07/11 11:28:52  RRM
#  -  replace  (.*) patterns with something allowing \n s included
#
# Revision 1.6  1997/06/13 13:52:45  RRM
#  -  renamed $citefile hash to  $citefiles  to avoid clash with scalar
#  -  cosmetic changes in this file
#
# Revision 1.5  1997/04/27 06:29:17  RRM
#      Cosmetic changes, to be more compatible with  Perl 4.
#      (more changes may still be required, for complete compatibility.)
#
# Revision 1.4  1997/03/15 10:53:00  RRM
# Cosmetic.
#
# Revision 1.3  1997/01/26 08:48:42  RRM
# RRM: fixed minor bugs.
#
# Revision 1.2  1996/12/24 10:30:08  JCL
# took &remove_general_markers out of the module, LaTeX2HTML will call
# the cite mark hook in any case (hope that's ok?)
#
# modified for document segmentation by
# Ross Moore, 28.5.1996 <ross@mpce.mq.edu.au>
#
# mwk -- 20.5.1996 -- created

package main;

# CUSTOMIZATION: Delimiters for citations in text 
#   (in natbib.sty, per default round parentheses)
#   POSSIBLE IMPROVEMENT: It should be possible to alter these
#       variables with options to the natbib package
#       (requires change in texexpand)
# The LaTeX \bibpunct command changes the punctuation
# variables
$CITE_OPEN_DELIM = '(' unless $CITE_OPEN_DELIM;
$CITE_CLOSE_DELIM = ')' unless $CITE_CLOSE_DELIM;

# CUSTOMIZATION: Delimiters for seperation of multiple citations
$CITE_ENUM = '; ' unless $CITE_ENUM;

# CUSTOMIZATION: whether multiple citations should be sorted. (BRM)
$SORT_MULTIPLE = 0 unless $SORT_MULTIPLE;

# CUSTOMIZATION: 1 for numeric citations
$NUMERIC=0 unless defined ($NUMERIC);

# CUSTOMIZATION: Delimiter between author and year in parentheses
#  i.e. comma in "(Jones et al., 1990)"
$BEFORE_PAR_YEAR=', ' unless $BEFORE_PAR_YEAR;

# CUSTOMIZATION: Delimiter between multiple citations if authors are common
#  i.e. comma in "Jones et al. (1990,1991)" or "Jones (1990a,b)"
$COMMON_AUTHOR_SEP=',' unless $COMMON_AUTHOR_SEP;

# CUSTOMIZATION: Delimiter before a note in a citation
#  i.e. 2nd comma in "(Jones et al., 1990, page 267)"
$POST_NOTE=',' unless $POST_NOTE;

# CUSTOMIZATION: 
# Boolean value that determines if citations are put in the index
# Can be modified in the text by the \citeindextrue and
# \citeindexfalse commands
$CITEINDEX=0 unless defined ($CITEINDEX);

# The variable $HARVARD makes natbib.perl emulate harvard.perl
# It is usually set to one in the "fake harvard.perl" before
# calling natbib.perl. 
# Users normally shouldn't have to set it "by hand".
$HARVARD=0 unless defined ($HARVARD);

# Instead of $cite_mark, different markers for different manners
# of citation 

# Jones et al. (1990)
$cite_mark = '<tex2html_cite_mark>';
# Jones, Baker, and Williams (1990)
$cite_full_mark = '<tex2html_cite_full_mark>';

# (Jones et al., 1990)
$cite_par_mark = '<tex2html_cite_par_mark>';
# (Jones, Baker, and Williams, 1990)
$cite_par_full_mark = '<tex2html_cite_par_full_mark>';

# Jones et al. [21]
$citet_mark = '<tex2html_citet_mark>';
# Jones, Baker, and Williams [21]
$citet_full_mark = '<tex2html_citet_full_mark>';
$citet_ext_mark = '<tex2html_citet_ext_mark>';

# Jones et al., 1990
$citealp_mark = '<tex2html_citealp_mark>';
# Jones, Baker, and Williams, 1990
$citealp_full_mark = '<tex2html_citealp_full_mark>';

# Jones et al. 1990
$citealt_mark = '<tex2html_citealt_mark>';
# Jones, Baker, and Williams 1990
$citealt_full_mark = '<tex2html_citealt_full_mark>';

# Jones et al.
$cite_author_mark = '<tex2html_cite_author_mark>';
# Jones, Baker, and Williams
$cite_author_full_mark = '<tex2html_cite_author_full_mark>';
# 1990
$cite_year_mark = '<tex2html_cite_year_mark>';

# marker for multiple citations
$cite_multiple_mark = '<tex2html_cite_multiple_mark>';

$HARVARDAND="&amp;";

# bibpunct arrays for citestyle command
@citestyle_chicago  =('(',  ')',  '; ',  'a',  ', ',  ',' );
@citestyle_named    =('[',  ']',  '; ',  'a',  ', ',  ',' );
@citestyle_agu      =('[',  ']',  '; ',  'a',  ', ',  ', ');
@citestyle_egs      =('(',  ')',  '; ',  'a',  ', ',  ',' );
@citestyle_agsm     =('(',  ')',  ', ',  'a',  ''  ,  ',' );
@citestyle_kluwer   =('(',  ')',  ', ',  'a',  ''  ,  ',' );
@citestyle_dcu      =('(',  ')',  '; ',  'a',  '; ',  ',' );
@citestyle_aa       =('(',  ')',  '; ',  'a',  ''  ,  ',' );
@citestyle_pass     =('(',  ')',  '; ',  'a',  ', ',  ',' );
@citestyle_anngeo   =('(',  ')',  '; ',  'a',  ', ',  ',' );
@citestyle_nlinproc =('(',  ')',  '; ',  'a',  ', ',  ',' );

$HARVARDAND_dcu = 'and';

# Implementations of package options (BRM)
sub do_natbib_round {
    $CITE_OPEN_DELIM = '(';
    $CITE_CLOSE_DELIM = ')'; }
sub do_natbib_square {
    $CITE_OPEN_DELIM = '[';
    $CITE_CLOSE_DELIM = ']'; }
sub do_natbib_curly {
    $CITE_OPEN_DELIM = '{';
    $CITE_CLOSE_DELIM = '}'; }
sub do_natbib_angle {
    $CITE_OPEN_DELIM = '&lt;';
    $CITE_CLOSE_DELIM = '&gt;'; }
sub do_natbib_colon {
    $CITE_ENUM = '; '; }
sub do_natbib_comma {
    $CITE_ENUM = ', '; }
sub do_natbib_authoryear {
    $NUMERIC=0; }
sub do_natbib_numbers {
    $NUMERIC=1; }
sub do_natbib_sectionbib {
    $section_commands{'bibliography'} = 3; }
sub do_natbib_sort {
    $SORT_MULTIPLE = 1; }

sub do_cmd_cite {
    local($_) = @_;
    local($cite_key, @cite_keys);
# Look for options of the command in a seperate subroutine
    local($has_optional,$optional1,$optional2)=&cite_check_options;
# Select the correct marker 
    local ($c_mark) = ($has_optional ? $cite_par_mark : $cite_mark);
# In numeric mode, all citations except those by \citet and \citet*
# are marked by $cite_par_mark
    $c_mark = $cite_par_mark if ($NUMERIC);
# The following is standard from the original latex2html routine
    s/^\s*\\space//o;		# Hack - \space is inserted in .aux
    s/$next_pair_pr_rx//o;
    if ($cite_key = $2) {
	local ($br_id)=$1;
	$_ = join(''
# Second argument of &do_cite_keys set to TRUE in numeric mode 
# -> surround citation with parentheses
	    , &do_cite_keys($br_id,($has_optional || $NUMERIC)
		,$optional1,$optional2,$c_mark,$cite_key )
	    , $_); 
    } else {print "Cannot find citation argument\n";}
    $_;
}

sub do_cmd_citestar {
# Same as do_cmd_cite, but uses full author information
    local($_) = @_;
    local($cite_key, @cite_keys);
    local($has_optional,$optional1,$optional2)=&cite_check_options;
    local ($c_mark) = ($has_optional ? $cite_par_full_mark : $cite_full_mark);
    $c_mark = $cite_par_mark if ($NUMERIC);
    s/^\s*\\space//o;           # Hack - \space is inserted in .aux
    s/$next_pair_pr_rx//o;
    if ($cite_key = $2) {
        local ($br_id)=$1;
        $_ = join('',
            &do_cite_keys($br_id,($has_optional || $NUMERIC)
                ,$optional1,$optional2,$c_mark,$cite_key), $_);
    } else {print "Cannot find citation argument\n";}
    $_;
}


# The following are Harvard-specific, but generally defined,
# since they don't conflict with natbib syntax
# They are therefore available in L2H inside a 
# htmlonly environment
sub do_cmd_citeaffixed {
# second argument for additional text inside the parentheses 
# before the citation
    local($_) = @_;
    local($cite_key, @cite_keys);
    local ($optional1,$dummy)=&get_next_optional_argument;
    s/^\s*\\space//o;		# Hack - \space is inserted in .aux
    s/$next_pair_pr_rx//o;
    $cite_key=$2;
# read 2nd argument
    s/$next_pair_pr_rx//o;
    local($optional2)=$2;
    if ($cite_key) {
	local ($br_id)=$1;
	$_ = join('',
	    &do_cite_keys($br_id,1,
		$optional1,$optional2,$cite_par_mark,$cite_key), $_); 
    } else {print "Cannot find citation argument\n";}
    $_;
}

sub do_cmd_citeaffixedstar {
    local($_) = @_;
    local($cite_key, @cite_keys);
    local ($optional1,$dummy)=&get_next_optional_argument;
    s/^\s*\\space//o;		# Hack - \space is inserted in .aux
    s/$next_pair_pr_rx//o;
    $cite_key=$2;
    s/$next_pair_pr_rx//o;
    local($optional2)=$2;
    if ($cite_key) {
	local ($br_id)=$1;
	$_ = join('',
	    &do_cite_keys($br_id,1,
		$optional1,$optional2,
		  ($NUMERIC ? $cite_par_mark: $cite_par_full_mark),
		  $cite_key), $_); 
    } else {print "Cannot find citation argument\n";}
    $_;
}

sub do_cmd_citeasnoun {
# Harvard:
# Jones et al. (1990)
    local($_) = @_;
    local($cite_key, @cite_keys);
# All harvard citation commands take one optional argument:
#   Text to be inserted *after* the citation
    local($optional1,$dummy)=&get_next_optional_argument;
    s/^\s*\\space//o;		# Hack - \space is inserted in .aux
    s/$next_pair_pr_rx//o;
    if ($cite_key = $2) {
	local ($br_id)=$1;
	$_ = join('',
	    &do_cite_keys($br_id,$NUMERIC,
		$optional1,'',($NUMERIC? $cite_par_mark : $cite_mark)
			  ,$cite_key), $_); 
    } else {print "Cannot find citation argument\n";}
    $_;
}

sub do_cmd_citeasnounstar {
# Harvard:
# Jones, Baker and Williams (1990) 
    local($_) = @_;
    local($cite_key, @cite_keys);
    local($optional1,$dummy)=&get_next_optional_argument;
    s/^\s*\\space//o;		# Hack - \space is inserted in .aux
    s/$next_pair_pr_rx//o;
    if ($cite_key = $2) {
	local ($br_id)=$1;
	$_ = join('',
	    &do_cite_keys($br_id,$NUMERIC,
		$optional1,'',($NUMERIC? $cite_par_mark : $cite_full_mark)
			  ,$cite_key), $_); 
    } else {print "Cannot find citation argument\n";}
    $_;
}

sub do_cmd_possessivecite {
# Harvard:
# Jones et al.'s (1990)
# Uses the $citealt_mark marker (only in HARVARD mode)
    local($_) = @_;
    local($cite_key, @cite_keys);
# All harvard citation commands take one optional argument:
#   Text to be inserted *after* the citation
    local($optional1,$dummy)=&get_next_optional_argument;
    s/^\s*\\space//o;		# Hack - \space is inserted in .aux
    s/$next_pair_pr_rx//o;
    if ($cite_key = $2) {
	local ($br_id)=$1;
	$_ = join('',
	    &do_cite_keys($br_id,$NUMERIC,
		$optional1,'',($NUMERIC? $cite_par_mark : $citealt_mark)
			  ,$cite_key), $_); 
    } else {print "Cannot find citation argument\n";}
    $_;
}

sub do_cmd_possessivecitestar {
# Harvard:
# Jones, Baker, and Williams's (1990)
    local($_) = @_;
    local($cite_key, @cite_keys);
    local($optional1,$dummy)=&get_next_optional_argument;
    s/^\s*\\space//o;		# Hack - \space is inserted in .aux
    s/$next_pair_pr_rx//o;
    if ($cite_key = $2) {
	local ($br_id)=$1;
	$_ = join('',
	    &do_cite_keys($br_id,$NUMERIC,
		$optional1,'',($NUMERIC? $cite_par_mark : $citealt_full_mark)
			  ,$cite_key), $_); 
    } else {print "Cannot find citation argument\n";}
    $_;
}

sub do_cmd_citename {
# "Jones et al."
    local($_) = @_;
    local($cite_key, @cite_keys);
    local($optional1,$dummy)=&get_next_optional_argument;
    s/^\s*\\space//o;		# Hack - \space is inserted in .aux
    s/$next_pair_pr_rx//o;
    if ($cite_key = $2) {
	local ($br_id)=$1;
	$_ = join('', 
	    &do_cite_keys($br_id,$NUMERIC,$optional1,'',
		($NUMERIC ? $cite_par_mark : $cite_author_mark)
		,$cite_key),$_);
    }
    else {print "Cannot find citation argument\n";}
    $_;
}

sub do_cmd_citenamestar {
# "Jones, Baker, and Williams"
    local($_) = @_;
    local($optional1,$dummy)=&get_next_optional_argument;
    local($cite_key, @cite_keys);
    s/^\s*\\space//o;		# Hack - \space is inserted in .aux
    s/$next_pair_pr_rx//o;
    if ($cite_key = $2) {
	local ($br_id)=$1;
	$_ = join('', 
	    &do_cite_keys($br_id,$NUMERIC,$optional1,'',
		($NUMERIC ? $cite_par_mark :$cite_author_full_mark)
		,$cite_key),$_);
    }
    else {print "Cannot find citation argument\n";}
    $_;
}

sub do_cmd_harvardparenthesis {
# Harvard command for customizing parentheses.
# \harvardyearparenthesis is ignored, since natbib
# doesn't distinguish the parentheses for citations
# and parentheses for years
    local ($_)=@_;
    s/$next_pair_pr_rx//o;
    local($arg)=$2;
  SWITCH: {
      $arg =~ /round/ && do {
	  $CITE_OPEN_DELIM='(';
	  $CITE_CLOSE_DELIM=')';
	  last SWITCH};
      $arg =~ /curly/ && do {
	  $CITE_OPEN_DELIM='{';
	  $CITE_CLOSE_DELIM='}';
	  last SWITCH};
      $arg =~ /square/ && do {
	  $CITE_OPEN_DELIM='[';
	  $CITE_CLOSE_DELIM=']';
	  last SWITCH};
      $arg =~ /angle/ && do {
	  $CITE_OPEN_DELIM='&lt';
	  $CITE_CLOSE_DELIM='&gt';
	  last SWITCH};
      $arg =~ /none/ && do {
	  $CITE_OPEN_DELIM='';
	  $CITE_CLOSE_DELIM='';
	  last SWITCH};
      print "\nInvalid argument to \\harvardparenthesis: $arg!\n"
      }
    $_;
}

## special subroutine definition for Harvard emulation
#if ($HARVARD) {
#
#print "\nnatbib.perl: Operating in Harvard emulation mode.\n";

# BRM: These should produce the year even in numeric mode.
sub do_cmd_citeyear    {
# "1990a"
    do_cite_common($HARVARD,($HARVARD ? $cite_par_mark : $cite_year_mark), # BRM
	$cite_year_mark,@_); }

sub do_cmd_citeyearpar {
# "(1990a)"
    do_cite_common(1,$cite_year_mark,$cite_year_mark,@_); } # BRM

# Does this command even exist?
sub do_cmd_citeyearstar {
# "1990a"
    do_cite_common($NUMERIC,$cite_par_mark,$cite_year_mark,@_) }

# Does this command even exist?
sub do_cmd_citeyearparstar {
# "(1990a)"
    do_cite_common($NUMERIC,$cite_par_mark,$cite_year_mark,@_) }


##End of special HARVARD definitions
#} else { 
## citeyear syntax differs between natbib and harvard
#print "\nnatbib.perl: Operating in natbib mode.\n";
#
#};

# Citation commands specific for natbib

sub do_cmd_citet { 
# Special citation style in natbib 6.x: Jones et al [21]
# Except in numeric mode, acts like \cite (-> same marker)
# In numeric mode, uses $cite_mark
#    do_cite_common('',$cite_mark,$citet_mark,@_) }
# BRM: actually, it should produce the same output except year -> reference #
    do_cite_common('',$citet_mark,$citet_mark,@_) }

sub do_cmd_citetstar { 
# Special citation style in natbib 6.x: Jones, Baker, and Williams [21]
#    do_cite_common('',$cite_full_mark,$citet_full_mark,@_) }
# BRM: actually, it should produce the same output except year -> reference #
    do_cite_common('',$citet_full_mark,$citet_full_mark,@_) }

sub do_cmd_citep {
# Shortcut for parenthetical citation
    do_cite_common(1,$cite_par_mark,$cite_par_mark,@_) }

sub do_cmd_citepstar {
# Shortcut for full parenthetical citation
    do_cite_common(1,$cite_par_mark,$cite_par_full_mark,@_) }

sub do_cmd_citealt {
# Alternative form of citation: No punctuation between author and year
#    i.e. "Jones et al. 1990"
# First argument = $NUMERIC (In numeric mode, always use parentheses)
# Same in the next subroutine
#    do_cite_common($NUMERIC,$cite_par_mark,$citealt_mark,@_) }
# BRM: actually, it should produce the same output except year -> reference #
    do_cite_common(0,$citealt_mark,$citealt_mark,@_); }

sub do_cmd_citealtstar {
# Full alternative citation, i.e. "Jones, Baker, and Williams 1990"
#    do_cite_common($NUMERIC,$cite_par_mark,$citealt_full_mark,@_) }
# BRM: actually, it should produce the same output except year -> reference #
    do_cite_common(0,$citealt_full_mark,$citealt_full_mark,@_); }

sub do_cmd_citealp {
# Alternative form of citation: like citep without parentheses
#    i.e. "Jones et al., 1990"
    do_cite_common(0,$cite_par_mark,$citealp_mark,@_) }

sub do_cmd_citealpstar {
# Full alternative citation, i.e. "Jones, Baker, and Williams, 1990"
    do_cite_common(0,$cite_par_mark,$citealp_full_mark,@_) }

sub do_cmd_citeauthor {
# "Jones et al."
    do_cite_common(0,$cite_author_mark,$cite_author_mark,@_) }

sub do_cmd_citeauthorstar {   &do_cmd_citefullauthor(@_); }

sub do_cmd_citefullauthor {
# "Jones, Baker, and Williams"
    do_cite_common(0,$cite_author_full_mark,$cite_author_full_mark,@_) }

sub do_cite_common {
# Common interface for citation commands taking two optional
# arguments, except for \cite and \cite* which have special behavior
# when no optional arguments are present
    local($has_parens,$num_mark,$norm_mark,$_) = @_;
    local($cite_key, @cite_keys);
    local($has_optional,$optional1,$optional2)=&cite_check_options;
    s/^\s*\\space//o;		# Hack - \space is inserted in .aux
    if (s/$next_pair_pr_rx//) {
	$cite_key = $2;
	local ($br_id)=$1;
	$_ = join(''
	    , &do_cite_keys ($br_id, $has_parens, $optional1, $optional2
		,($NUMERIC ? $num_mark : $norm_mark)
		,$cite_key)
	    , $_);
    } else {print "Cannot find citation argument\n";}
    $_;
}


sub cite_check_options {
# Check if there's an optional argument (even if it's empty)
# In this case, citation in parentheses is desired.
# If Harvard syntax is selected, just look for one nonempty optional
    if ($HARVARD) {
	local($opt1,$dummy)=&get_next_optional_argument;	
# Always pretend there was an optional, since harvard \cite means
# parenthetical citation
	(1,$opt1,'')
    } else {
	local($hasopt) = (/^\s*\[([^]]*)\]/ && (! $`));
# Look for two possible optional arguments
        local($opt1,$dummy)= &get_next_optional_argument;
        local($opt2,$dummy)= &get_next_optional_argument;
# If optional Nr. 2 is present, exchange 1 and 2
        if ($dummy) {
	    ($opt1,$opt2) = ($opt2,$opt1);
#        if ($opt2) {
#            local($hopt)=$opt1;
#	    $opt1=$opt2;
#	    $opt2=$hopt;
        };
        ($hasopt,$opt1,$opt2)
   }
}

sub do_cite_keys{
# $hasopt indicates that citations should be enclosed in parentheses
    local($br_id,$hasopt,$first,$second,$c_mark,$cite_key) = @_;
    local(@cite_keys) = (split(/,/,$cite_key));
    local ($multiple,$cite_anchor,$key,$extra);
# Create index entries if desired
    if (($CITEINDEX) && (! $NUMERIC)) {
	foreach $key (@cite_keys) {$cite_anchor=&make_cite_index("$br_id",$key);};};
# Is there more than 1 citation ?
# If yes, the multiple citations are enclosed by $cite_multiple_mark's
    if ($#cite_keys > 0){ $multiple = $cite_multiple_mark;}
    else { $multiple = '';};
    local($citauth)=($c_mark =~ /($cite_author_mark|$cite_author_full_mark)/);
    $first = "$POST_NOTE $first" if ($first && !($HARVARD && $citauth));
    grep ( do { &cite_check_segmentation($_);
# MW: change 25.6.: throw out the reference to $bbl_mark.
# The second pair of # remains empty unless we are in HARVARD mode
# and have a single citation with optional text
	if (($first && !$multiple) &&
		(($HARVARD &&!$hasopt)||($c_mark =~ /citet/))) {
	    $extra = $first; $first = '';
	} else { $extra = '' } 
	$_ = "#$_#$c_mark#". $extra ."#";}
#	$_ = "#$_#$c_mark#".(($HARVARD && (!$hasopt) && (!$multiple))? $first: "")."#";}
	    , @cite_keys);
    # Add parentheses and delimiters as appropriate 
    #
    $second .= ' ' if ($second); 
    local($this_cite);
    if ($hasopt) { 
	$this_cite = join('', $CITE_OPEN_DELIM, $second,$multiple
	        , join($CITE_ENUM,@cite_keys)
		, (($first&&($c_mark =~/^($citet_mark|$citet_full_mark)$/))?
			$first.'#'.$citet_ext_mark.$multiple : $multiple.$first)
		, $CITE_CLOSE_DELIM
		);
    } else { 
	$this_cite = join ('',$second,$multiple
		, join($CITE_ENUM,@cite_keys)
		, (($first&&($c_mark =~/^($citet_mark|$citet_full_mark)$/))?
			$first.'#'.$citet_ext_mark.$multiple : $multiple.$first)
		); 
    }
    join ('',$cite_anchor,$this_cite);
}

sub make_cite_index {
    local ($br_id,$cite_key) =@_;
    local ($index_key)="$cite_short{$cite_key} ($cite_year{$cite_key})";
    local ($sort_key)="$cite_short{$cite_key}$cite_year{$cite_key}$cite_key";
#    local ($bib_label)="<A ID=\"III${cite_key}\"<\/A>";
    if (defined  &named_index_entry ) {
	&named_index_entry($br_id,"$sort_key\@$index_key") }
    elsif ($br_id > 0) {
	&do_cmd_index("$OP$br_id$CP$index_key$OP$br_id$CP") }
    else { $name++; &do_cmd_index("$OP$name$CP$index_key$OP$name$CP") }
}

sub parse_citeauthoryear {
    local($_) = @_;
    s/$comment_mark\d+.*\n//gs;		# Strip out darned EOL comments
    s/\n//gs;		# Strip out darned EOL comments
    my ($long,$short,$year);
    s/^\\protect\\citeauthoryear//;
    $long = &missing_braces unless (
	(s/$next_pair_pr_rx/$long=$2;''/eo)
	||(s/$next_pair_rx/$long=$2;''/eo));
    $long =~ s/($O|$OP)(\d+)($C|$CP)($O|$OP)\2($C|$CP)//go; # Remove empty braces
    $short = &missing_braces unless (
	(s/$next_pair_pr_rx/$short=$2;''/eo)
	||(s/$next_pair_rx/$short=$2;''/eo));
    $short =~ s/($O|$OP)(\d+)($C|$CP)($O|$OP)\2($C|$CP)//go; # Remove empty braces
    $year = &missing_braces unless (
	(s/$next_pair_pr_rx/$year=$2;''/eo)
	||(s/$next_pair_rx/$year=$2;''/eo));
    $year =~ s/($O|$OP)(\d+)($C|$CP)($O|$OP)\2($C|$CP)//go; # Remove empty braces
    ($long,$short,$year);
}
 
# Translate \citeauthoryear{long}{short}{year} form bibitems into form 
# Not actually used ...
sub do_cmd_citeauthoryear {
    local($_) = @_;
    my ($long,$short,$year) = parse_citeauthoryear($_);
    join('', "$short($year)$long",$_);
}

sub do_real_bibitem {
# Process the \bibitem command.
    local($thisfile, $_) = @_;
    local ($tmp,$label);
    $bbl_cnt++;
    local($label, $dummy) = &get_next_optional_argument;
    local($short, $year, $long, $supported);
    # BRM: Add check to translate \citeuthordate formatted bibitems.
    # (Mainly to avoid the `not supported' messages!
    if ($label =~ /^\\protect\\citeauthoryear/) {
	($long,$short,$year)=parse_citeauthoryear($label); 
	$supported=1;
    } else {
	# Check if label is of the natbib form ...(1994abc)...
	$tmp = ($label =~ /([^\(]*)(\([^\)]*\))([\w\W]*)$/s);
	($supported) = ($tmp && !($label =~ /\\protect/));
	# Short name: before year, long name: after year
	($short, $year, $long) = ($1,$2,($3 ? $3 : $1));
    }

# If numeric citation is chosen -> standard procedure
    if (! $NUMERIC) { $year =~ s/[\(\)]//g; }
    else { $label=++$bibitem_counter; };
# BRM: parens should be removed in ANY case and put back only if needed
    $year =~ s/[\(\)]//g;
# Throw out brackets that may stem from 1990{\em a} or similar
    $year =~ s/($O|$OP)\d+($C|$CP)//g;

# The compulsory argument is the LaTeX label
    $cite_key = &missing_braces unless (
	(s/$next_pair_pr_rx/$cite_key=$2;''/eo)
	||(s/$next_pair_rx/$cite_key=$2;''/eo));
    $cite_key = &translate_commands($2);
    if ($cite_key) {
# remove tags resulting from excess braces
	$tmp = $_;
	$_ = $short;
	s/$next_pair_pr_rx//o;
	if (!($2 eq $cite_key))
	    {$short =$2; $short =~ s/$OP[^\#>]*$CP//go; }
	$_ = $long;
	s/$next_pair_pr_rx//o;
	if (!($2 eq $cite_key))
	    {$long = $2; $long =~ s/$OP[^\#>]*$CP//go; }
	$_ = "$tmp";
# Three hashes are used to store the information for text citations
	if ($supported) {
	    $cite_short{$cite_key} = &translate_commands($short);
	    $cite_year{$cite_key} = &translate_commands($year);
	    $cite_long{$cite_key} = &translate_commands($long)}
	else {
	    &write_warnings(
	"\n\\bibitem label format not supported, using \\bibcite information!");
	}
# Update the $ref_file entry, if necessary, making sure changes are saved.
	if (!($ref_files{'cite_'."$cite_key"} eq $thisfile)) {
	    $ref_files{'cite_'."$cite_key"} = $thisfile;
	    $changed = 1; }
	$citefiles{$cite_key} = $thisfile;
# Create an anchor around the citation
	$_=&make_cite_reference ($cite_key,$_);
    } else {
	#RRM: apply any special styles
	$label = &bibitem_style($label) if (defined &bibitem_style);
	print "Cannot find bibitem labels: $label\n";
	$_=join('',"\n<DT>$label\n<DD>", $_);
    }
    $_;
}

sub make_cite_reference {
# Make the anchor
    local ($cite_key,$_)=@_;
    local($label)=$cite_info{$cite_key};
    local($next_lines, $after_lines);
    local($sort_key, $indexdata);
    if (defined  &named_index_entry ) { #  makeidx.perl  is loaded
	$sort_key = "$cite_short{$cite_key}$cite_year{$cite_key}$cite_key"; 
        $sort_key =~ tr/A-Z/a-z/;
    } else {$sort_key = "$cite_short{$cite_key} ($cite_year{$cite_key})";}
    if ($index{$sort_key}) { 
# append the index entries as a list of citations
	$indexdata = $index{$sort_key};
	$indexdata =~ s/[\|] $//;
	$indexdata = join('',"\n<DD>cited: ", "$indexdata");
# Create index entry to the Bibliography entry only, if desired
	$index{$sort_key} = '';
	if ($CITEINDEX) { &make_cite_index("$cite_key",$cite_key);} 
	elsif (defined  &named_index_entry ) {$printable_key{$sort_key} = '';}
    } else { $indexdata = '';}
    $indexdata .= "\n<P>";

    local ($found) = /(\\bibitem|\\harvarditem)/o;
    if ($found) { $after_lines = $&.$'; $next_lines = $`;}
    else { $after_lines = ''; $next_lines = $_;}
    $next_lines .= $indexdata;
    $indexdata = '';
    $_ = $next_lines.$after_lines;

    if ($NUMERIC) {
	#RRM: apply any special styles
	if (defined &bibitem_style) {
	    $label = &bibitem_style($label);
	} else {
	    $label = '<STRONG>'.$label.'</STRONG>';
	};
	join('',"\n<DT><A ID=\"$cite_key\">$label</A>\n<DD>",$_);
    } else {
# For Author-year citation: Don't print the label to the bibliography
# Use the first line of the bib entry as description title instead
# First line ends with \newblock or with the next \bibitem  command
#	$found = /\\newblock/o;	# these have been converted to  <BR>s
	$found = /\<BR\>/o;
	local($nbefore,$nafter) = ($`,$');
	if ($found) {
	    if (defined &bibitem_style) {
		$nbefore = &bibitem_style($nbefore); 
	    } elsif ($nbefore =~/\\/) {
		$nbefore = &translate_commands($nbefore);
	    } else {
		$nbefore = join('','<STRONG>',$nbefore,'</STRONG>');
	    }
	    join('',"\n<DT><A ID=\"$cite_key\">", $nbefore
		 , "</A>\n<DD>", &translate_commands($nafter));
	} else {
	    $found= /(\\bibitem|\\harvarditem)/o;
	    if ($found) {
		local($nbefore,$nafter) = ($`,$');
		if (defined &bibitem_style) {
		    $nbefore = &bibitem_style($nbefore);
		} elsif ($nbefore =~/\\/) {
		    $nbefore = &translate_commands($nbefore);
		} else {
		    $nbefore = join('','<STRONG>',$nbefore,'</STRONG>');
		}
#		print "\nBIBITEM:$nafter";
#		$nafter =~ s/\s*<P>\s*<BR>\s*<P>\s*$/\n/s;
		join('',"\n<DT><A ID=\"$cite_key\">", $nbefore
		    ,"</A>\n<DD>", $nafter );
# No call to &translate_commands on $': Avoid recursion
	    } else {
		if (defined &bibitem_style) {
		    $_ = &bibitem_style($_);
		} elsif ($_ =~ /\\/) {
		    $_ = &translate_commands($_);
		} else {
		    $_ = join('','<STRONG>',$_,'</STRONG>');
		}
		# remove extraneous space between items
		join('',"\n<DT><A ID=\"$cite_key\">", $_,"</A>\n<DD>",' ');
	    };
	};
    }
}

if (!(defined &do_cmd_harvarditem)) {
    eval 'sub do_cmd_harvarditem { &do_real_harvarditem($CURRENT_FILE, @_) }';
} else { 
    print "\n *** sub do_cmd_harvarditem  is already defined. ***\n"
}
sub do_real_harvarditem {
# natbib.sty also reads files created by harvard bibstyles 
# (harvard, kluwer, ...)
    local ($thisfile,$_)=@_;
    local ($dum,$short)=&get_next_optional_argument;
    $short =~ s/[\[\]]//g;
    $bbl_cnt++;
# Get full citation text
    s/$next_pair_pr_rx//o; local ($long)=$2; 
# Get year
    s/$next_pair_pr_rx//o; local ($year)=$2;
    $year =~ s/<#\d+#>//g;
# Get the key
    s/$next_pair_pr_rx//o; local ($cite_key)=$2;
    if ($cite_key) {
	if (!($short)) {$short=$long};
# remove tags resulting from excess braces
	local($tmp) = $_;
	$_ = $short;
	s/$next_pair_pr_rx//o;
	if (!($2 eq $cite_key)) 
	    {$short =$2; $short =~ s/<\#[^\#>]*\#>//go; };
	$_ = $long;
	s/$next_pair_pr_rx//o;
	if (!($2 eq $cite_key))
	    {$long = $2; $long =~ s/<\#[^\#>]*\#>//go; };
	$_ = "$tmp";
# Three hashes are used to store the information for text citations
        $cite_short{$cite_key} = &translate_commands($short);
        $cite_year{$cite_key} = &translate_commands($year);
        $cite_long{$cite_key} = &translate_commands($long);
# Update the $ref_file entry, if necessary, making sure changes are saved.
# $citefile is set by  do_env_thebibliography
#	$citefiles{$cite_key} = $citefile;
	if (!($ref_files{'cite_'."$cite_key"} eq $thisfile)) {
	    $ref_files{'cite_'."$cite_key"} = $thisfile;
	    $changed = 1; }
	$citefiles{$cite_key} = $thisfile;
	&make_harvard_reference ($cite_key,$year,$_);
    } else {
	#RRM: apply any special styles
	$label = &bibitem_style($label) if (defined &bibitem_style);
	print "Cannot find bibitem labels: $label\n";
	join('',"\n<DT><STRONG>$label</STRONG>\n<DD>", $_);
    }
}

sub make_harvard_reference {
# Almost the same as &make_cite_reference.
    local ($cite_key,$year,$_)=@_;
    local($label)=$cite_info{$cite_key};
    local($next_lines, $after_lines);
    local($sort_key, $indexdata);
    if (defined  &named_index_entry ) { #  makeidx.perl  is loaded
	$sort_key = "$cite_short{$cite_key}$cite_year{$cite_key}$cite_key"; 
        $sort_key =~ tr/A-Z/a-z/;
    } else {$sort_key = "$cite_short{$cite_key} ($cite_year{$cite_key})";}
    if ($index{$sort_key}) { 
# append the index entries as a list of citations
	$indexdata = $index{$sort_key};
	$indexdata =~ s/[\|] $//;
	$indexdata = join('',"\n<DD>cited: ", "$indexdata");
# Create index entry to the Bibliography entry only, if desired
	$index{$sort_key} = '';
	if ($CITEINDEX) { &make_cite_index("$cite_key",$cite_key);} 
	elsif (defined  &named_index_entry ) {$printable_key{$sort_key} = '';}
    } else { $indexdata = '';}
    $indexdata .= "\n<P>";
    local ($found) = /(\\bibitem|\\harvarditem)/o;
    if ($found) { $after_lines = $&.$'; $next_lines = $`;}
    else { $after_lines = ''; $next_lines = $_;}
    $next_lines .= $indexdata;
    $indexdata = '';
    $_ = $next_lines.$after_lines;
    if ($NUMERIC) {
	#RRM: apply any special styles
	$label = &bibitem_style($label) if (defined &bibitem_style);
	join('',"\n<DT><A ID=\"$cite_key\"><STRONG>$label</STRONG></A>\n<DD>",$_);
    } else {
# For Author-year citation: Don't print the label to the bibliography
# Difference to &make_cite_reference:
# \newblocks are not be used, so use the year stored in $year as delimiter
# for the first line
#	local ($found)= /$year([.:;,\s\)\]\!\?\}]|\\harvardyearright)*/s;
# Extract the numeric part of the year, to avoid confusion by 1991{\em b} or similar
	$year =~ /\d+/;
	local($numyear) = $&;
# Look for the year followed by anything and a punctuation character or newline
	local ($found)= /$numyear(.*?)[.,:;\n]/s;
	if ($found) {
	    join('',"\n<DT><A ID=\"$cite_key\"><STRONG>",
		 &translate_commands($`.$&),"</STRONG></A>\n<DD>", 
# No call to &translate_commands on $': Avoid recursion
		 $')
	} else {
	    $found= /(\\bibitem|\\harvarditem)/o;
	    if ($found) {
		join('',"\n<DT><A ID=\"$cite_key\"><STRONG>",
		     &translate_commands($`),"</STRONG></A>\n<DD>",
# No call to &translate_commands on $': Avoid recursion
		     $');
	    } else {
		join('',"\n<DT><A ID=\"$cite_key\"><STRONG>",
		     &translate_commands($_),"</STRONG></A>\n<DD>",' ');
	    };
	};
    }
}

sub do_cmd_harvardand {
    &translate_commands("$HARVARDAND".$_[0]);
}
sub do_cmd_harvardleft {
    &translate_commands("$CITE_OPEN_DELIM".$_[0]);
}
sub do_cmd_harvardright {
    &translate_commands("$CITE_CLOSE_DELIM".$_[0]);
}
sub do_cmd_harvardyearleft {
    &translate_commands("$CITE_OPEN_DELIM".$_[0]);
}
sub do_cmd_harvardyearright {
    &translate_commands("$CITE_CLOSE_DELIM".$_[0]);
}
sub do_cmd_harvardurl{ 
    local($_) = @_;
    local($text, $url, $href);
    local($name, $dummy) = &get_next_optional_argument;
    $url = &missing_braces unless (
	(s/$next_pair_pr_rx/$url = $2;''/eo)
	||(s/$next_pair_rx/$url = $2;''/eo));
    $url = &translate_commands($url) if ($url=~/\\/);
    $text = "<b>URL:</b> ".$url;
    if ($name) { $href = &make_named_href($name,$url,$text) }
    else { $href = &make_href($url,$text) }
    print "\nHREF:$href" if ($VERBOSITY > 3);
    $_ =~ s/^[ \t]*\n?/\n/;
    join ('',$href,$_);
}

sub do_cmd_bibcite {
# !! This routine reads bibcite commands produced by natbib 6.0 or later !!
# It is used to build the citation information
# (hash tables %cite_info, %cite_short, %cite_long, %cite_year)
    local($_) = @_;
	# extract the key
    s/$next_pair_pr_rx//o;
    local($br_id, $cite_key) = ($1, $2);
	# next group is the information
#    $cite_key =~ s/\W//g;
    s/$next_pair_pr_rx//o;
    local($br_id, $print_key) = ($1, $2);
    local($rest) = "$_";
    $_ = $print_key;
	# first is the numeric value...
    s/$next_pair_pr_rx//o;
    ($br_id, $print_key) = ($1, $2);
    $print_key =~ s/<\#[^\#>]*\#>//go;
# Complain if no label is found: This is not a proper natbib \bibcite command
    print ("\nWARNING: natbib.perl: no valid citation key found in \bibitem.",
	   "\n    Perhaps you are running a natbib.sty version earlier than 6.x?",
	   "\n    Unable to generate citation references correctly.\n")
	if (! $print_key);
    $cite_info{$cite_key} = &translate_commands($print_key);
	# then comes the year
    s/$next_pair_pr_rx//o;
    ($br_id, $print_key) = ($1, $2);
    $print_key =~ s/<\#[^\#>]*\#>//go;
    $cite_year{$cite_key} = &translate_commands($print_key);
# then the short citation
    s/$next_pair_pr_rx//o;
    ($br_id, $print_key) = ($1, $2);
    $print_key =~ s/<\#[^\#>]*\#>//go;
    $cite_short{$cite_key} = &translate_commands($print_key);
	# then the long citation
    s/$next_pair_pr_rx//o;
    ($br_id, $print_key) = ($1, $2);
    $print_key =~ s/<\#[^\#>]*\#>//go;
    if ($print_key) {
	$cite_long{$cite_key} = &translate_commands($print_key);}
    else {$cite_long{$cite_key}=$cite_short{$cite_key}};
# Switch to numeric mode if author or year is undefined
# (this happens if natbib.sty is used with a numerical bibstyle like 
# "plain.bst")
    $NUMERIC=($NUMERIC || 
	      (! $cite_short{$cite_key}) || 
	      (! $cite_year{$cite_key}));
    # just in case anything is left over...
    $rest;
}

sub do_cmd_harvardcite {
# This is used to build the citation information
# (hash tables %cite_info, %cite_short, %cite_long, %cite_year)
# from \harvardcite commands produced by the harvard package.
    local($_) = @_;
	# extract the key
    s/$next_pair_pr_rx//o;
    local($br_id, $cite_key) = ($1, $2);
	# next group is the long citation
    s/$next_pair_pr_rx//o;
    $cite_long{$cite_key}=&translate_commands($2);
	# next group is the short citation
    s/$next_pair_pr_rx//o;
    $cite_short{$cite_key}=&translate_commands($2);
	# next group is the year
    s/$next_pair_pr_rx//o;
    $cite_year{$cite_key}=&translate_commands($2);
    $cite_year{$cite_key} =~ s/<#\d+#>//g;
    $_;
}

# Now come to the correct replacements for all citation styles.
# Text is assembled from the 
# $cite_short, $cite_year, and $cite_long hash tables
sub replace_cite_references_hook {
    local($target) = 'contents';
# Handle multiple citations first!
    if (/$cite_multiple_mark/) {&replace_multiple_cite_references };
    &replace_nat_cite_references if 
/$cite_mark|$cite_full_mark|$cite_year_mark|$cite_par_mark|$cite_par_full_mark|$cite_author_mark|$cite_author_full_mark|$citealt_mark|$citealt_full_mark|$citealp_mark|$citealp_full_mark|$citet_mark|$citet_full_mark/;
}

sub replace_multiple_cite_references {
# Look for $cite_multiple_mark pairs
    local($saved) = $_ ;
    while (s/$cite_multiple_mark(.*?)$cite_multiple_mark/&do_multiple_citation($1)/se) {
	last if ($_ eq $saved);
	$saved = $_;
    };
    undef $saved;
}

sub do_multiple_citation {
    local($cit)=@_;
    local($before_year,$after_year);
    local($author,$thisyear,$lastyear,$lastauth,$theauth,$year);
    local($thetext,$lasttext,$thekey,$lastkey);
    local($mark,$key,$extra,$citet_ext,%second,@sorted);
    local($useindex) = $NUMERIC;
# Clear arrays & hash tables
    undef %second;
    undef @sorted;
# Construct hash table with the labels of the multiple citation as keys
# (Values of hash %second are actually unimportant)
    while ($cit =~
# BRM +)* ??? Perl got hung up here!
#	s/#([^#]+)#(<tex2html_cite\w*_mark>)#([^#]*)#($CITE_ENUM)?(($OP|$CP|[^#]+)*#$citet_ext_mark)?//) {
	s/#([^#]+)#(<tex2html_cite\w*_mark>)#([^#]*)#($CITE_ENUM)?((($OP|$CP|[^#])*)#$citet_ext_mark)?//) {
	$mark=$2;
	$extra=$3;
	$citet_ext = $6 if (($mark eq $citet_mark)||($mark eq $citet_full_mark));
	($key=$1) =~ s/[\s]//g;
	%second=(%second,$key,$extra.$citet_ext);
     };
	
#     if ($NUMERIC) {
# BRM: Actually, \citet can give textual entries too, so do it the hard way.
if (0){
# Numerical Citation: normal procedure
# sort the entries in ascending bibliographic order
# DO WE REALLY WANT THIS ??
#	@sorted=sort {$cite_info{$a} cmp $cite_info{$b}} (keys (%second));
# BRM: No not in general.
	@sorted = keys (%second);
	@sorted=sort {$cite_info{$a} cmp $cite_info{$b}} @sorted if $SORT_MULTIPLE;
	$_=join($CITE_ENUM,
# make_href is used for anchor creation!
		map { &make_href("$citefiles{$_}#$_","$cite_info{$_}");}
		@sorted);
    } else {
# Author-year citation
# Different punctuation for parenthetical, normal, and alternative
# Author-year citation
# citations (\cite[] or \citep, \cite, and \citealt resp. starred versions)

      SWITCH:	{
	# Parenthetical type (\cite[],\citep)
	$mark =~ /^$cite_par_mark|$cite_par_full_mark/ && do {
	    if ($NUMERIC) {
		($before_year,$after_year)=('','');
	    } else {
		($before_year,$after_year)=($BEFORE_PAR_YEAR,'');
	    }
	    last SWITCH;};

	# normal type (\cite)
	$mark =~ /^$cite_mark|$cite_full_mark/ && do {
	      ($before_year,$after_year)=
		  (" $CITE_OPEN_DELIM","$CITE_CLOSE_DELIM");
	      last SWITCH;};

	# normal-t type (\citet)
	# optional arg goes inside parens; how to do this ?
	$mark =~ /^$citet_mark|$citet_full_mark/ && do {
              ($before_year,$after_year) = 
		  (" $CITE_OPEN_DELIM","$CITE_CLOSE_DELIM");
              last SWITCH;};

	# alternative type (\citealp)
	$mark =~ /^$citealp_mark|$citealp_full_mark/ && do {
              ($before_year,$after_year)=($BEFORE_PAR_YEAR,'');
              last SWITCH;};

	$mark =~ /^$cite_year_mark/ && do {
	    ($before_year,$after_year)=(' ','');
	    $useindex=0;
	    last SWITCH;};

	# alternative type (\citealt)
	  ($before_year,$after_year)=(' ','');
	}

# Reference $author is set to %cite_long if full author name citation is
# requested, to  %cite_short otherwise
	if ($NUMERIC && $mark =~ /^$cite_par_mark|$cite_par_full_mark/) { # BRM
	    $author='';
	} elsif ($mark =~
    /^$cite_par_full_mark|$cite_full_mark|$citet_full_mark|$citealt_full_mark|$citealp_full_mark|$cite_author_full_mark/) 
		{ $author=\%cite_long;
	} else { $author=\%cite_short; }
# Sort the citation list according to author and year fields
#   => only subsequent entries must be compared afterwards.
# The citations are always sorted in ascending alphabetic order!
# DO WE REALLY WANT THIS ??
# BRM: No, not generally.
	@sorted = keys (%second);
	@sorted = sort {$$author{$a}.$cite_year{$a} cmp $$author{$b}.$cite_year{$b}}
		@sorted if $SORT_MULTIPLE;
# First entry
	$lastkey=shift(@sorted);
	($lastauth,$lastyear)=($$author{$lastkey},$cite_year{$lastkey});
	$lasttext=join(''
		, (($mark =~ /$cite_year_mark/)? '' : $$author{$lastkey})
		, (($mark =~ /$cite_author_mark|$cite_author_full_mark/)? ''
			: $before_year
		   . ($useindex ? $cite_info{$lastkey}:$cite_year{$lastkey})) # BRM
		, $second{$lastkey}
		);
	$_='';
# The text for the entry can only be written to $_ AFTER the next entry
# was analyzed (different punctuation whether next entry has the same authors
# or not!)
#
# iterate through the other entries
	while ($thekey=shift(@sorted)) {
	    ($theauth,$theyear)=($$author{$thekey},
		 ($useindex ? $cite_info{$thekey}:$cite_year{$thekey})); # BRM
	    if ($lastauth eq $theauth) {
# If authors are the same as last entry: suppress printing
# author information
# Truncate last year field to numeric part ("1994", usually)
		$lastyear =~ /^\d+/;
		$year=$&;
# If year is equal to that of last entry, keep only additional info
# I.e. 1994a, 1994b -> 1994a,b 		    
		$thetext=($theyear =~ /^$year/ ? $' : ' '.$theyear);
# This line is for bibstyles that don't distinguish articles with
# common author list & year by appending letters (1990a, 1990b)
# In this case, $thetext might be empty after execution of the last line
		$thetext=' '.$theyear unless ($thetext);
# At this point, the PRECEDING entry may be written to $_
# Note use of &make_href.
		$_=join('',
			$_,
			&make_href("$citefiles{$lastkey}#$lastkey",
				   $lasttext),
			$COMMON_AUTHOR_SEP);
	    } else {
# New author(s): new list entry
# The last entry needs an $after year character (e.g., ")"), since it's
# the last one in a series of articles by common authors
# This character should go into the anchor text.
		$lasttext=$lasttext.$after_year;
# The new entry will be printed out completely
		$thetext=join(''
		, (($mark =~ /$cite_year_mark/)? '' : $$author{$thekey})
		, (($mark =~ /$cite_author_mark|$cite_author_full_mark/)? ''
		: $before_year
		    . ($useindex ? $cite_info{$thekey}:$cite_year{$thekey})) # BRM
		, $second{$thekey}
		);
# Write the preceding entry
		$_=join('',
			$_,
			&make_href("$citefiles{$lastkey}#$lastkey",
				   $lasttext),
			$CITE_ENUM);
	    };
# Shift last entry
	    ($lastkey,$lastauth,$lastyear,$lasttext)=
		($thekey,$theauth,$theyear,$thetext);
	};
# write the last entry of the list
	$_=join('',$_,
		&make_href("$citefiles{$lastkey}#$lastkey",
			   $lasttext.$after_year));
    };
    $_;
}

sub replace_nat_cite_references { 
# Modifies $_
# Uses $citefile set by the thebibliography environment
# Creates hyperrefs EXCLUSIVELY by calling &make_href
# Note that %citefile is indexed by the latex label ($1) rather than $bbl_nr ($2)
# MW 25.6.96: second pair of #'s may now be empty!
    local($savedRS) = $/; $/='';
    if ($NUMERIC) {
	s/#([^#]+)#$cite_par_mark#([^#]*)#/&make_named_href(""
		,"$citefiles{$1}#$1",$cite_info{$1})/ge;
	s/#([^#]+)#$cite_mark#([^#]*)#/&make_named_href(""
		,"$citefiles{$1}#$1"
		,"$cite_short{$1} $CITE_OPEN_DELIM"."$cite_info{$1}$CITE_CLOSE_DELIM")/ge;
	s/#([^#]+)#$cite_full_mark#([^#]*)#/&make_named_href("","$citefiles{$1}#$1"
		,"$cite_long{$1} $CITE_OPEN_DELIM"."$cite_info{$1}$CITE_CLOSE_DELIM")/ge;
	# BRM: These next several patterns should also appear in numeric mode.
	s/#([^#]+)#$cite_year_mark#([^#]*)#/&make_named_href("","$citefiles{$1}#$1"
		,"$cite_year{$1}$2")/ge;
	s/#([^#]+)#$cite_author_mark#([^#]*)#/&make_named_href("","$citefiles{$1}#$1"
		,"$cite_short{$1}".($2? " $CITE_OPEN_DELIM$2$CITE_CLOSE_DELIM": ""))/ge;
	s/#([^#]+)#$cite_author_full_mark#([^#]*)#/&make_named_href("","$citefiles{$1}#$1"
		,"$cite_long{$1}".($2? " $CITE_OPEN_DELIM$2$CITE_CLOSE_DELIM": ""))/ge;
	# The main (only?) difference between these & their non-numeric counterparts is
	# that the $cite_year is replaced by $cite_info (the reference number)
	s/#([^#]+)#$citet_mark#([^#]*)#((($OP|$CP|[^#\n])*)#$citet_ext_mark)?/
	    &make_named_href(""
		, "$citefiles{$1}#$1"
			     # BRM: Modified to include delimiters and PRE-text
		, join(''
		    ,"$cite_short{$1} $CITE_OPEN_DELIM$cite_info{$1}$2"
		    , ($3 ? $BEFORE_PAR_YEAR.$4 : ''), $CITE_CLOSE_DELIM)
	 	)
	/ge;
	s/#([^#]+)#$citet_full_mark#([^#]*)#((($OP|$CP|[^#\n])*)#$citet_ext_mark)?/
	    &make_named_href(""
		, "$citefiles{$1}#$1"
			     # BRM: Modified to include delimiters around year & pretext.
		, join(''
		    ,"$cite_long{$1} $CITE_OPEN_DELIM$cite_info{$1}$2"
		    , ($3 ? $BEFORE_PAR_YEAR.$3 : ''), $CITE_CLOSE_DELIM)
		)
	/ge;
	s/#([^#]+)#$citealt_mark#([^#]*)#/&make_named_href(""
		,"$citefiles{$1}#$1","$cite_short{$1} $cite_info{$1}")/ge;
	s/#([^#]+)#$citealt_full_mark#([^#]*)#/&make_named_href(""
		,"$citefiles{$1}#$1","$cite_long{$1} $cite_info{$1}")/ge
    } else {
# MW 25.6.96: use $2 eventually as optional text for harvard citations
	s/#([^#]+)#$cite_mark#([^#]*)#/&make_named_href("","$citefiles{$1}#$1"
		,"$cite_short{$1} ". "$CITE_OPEN_DELIM$cite_year{$1}$2$CITE_CLOSE_DELIM")/ge;
	s/#([^#]+)#$cite_full_mark#([^#]*)#/&make_named_href("","$citefiles{$1}#$1"
		,"$cite_long{$1} "."$CITE_OPEN_DELIM$cite_year{$1}$2$CITE_CLOSE_DELIM")/ge;
	if ($HARVARD) {
# in HARVARD mode, $citealt_mark stands for \possessivecite commands
	    s/#([^#]+)#$citealt_mark#([^#]*)#/&make_named_href(""
		,"$citefiles{$1}#$1"
		,"$cite_short{$1}\'s "."$CITE_OPEN_DELIM$cite_year{$1}$2$CITE_CLOSE_DELIM")/ge;
	    s/#([^#]+)#$citealt_full_mark#([^#]*)#/&make_named_href("","$citefiles{$1}#$1"
		,"$cite_long{$1}\'s "."$CITE_OPEN_DELIM$cite_year{$1}$2$CITE_CLOSE_DELIM")/ge
	} else {
# in usual natbib mode, it stands for \citealt commands
	    s/#([^#]+)#$citealt_mark#([^#]*)#/&make_named_href(""
		,"$citefiles{$1}#$1","$cite_short{$1} $cite_year{$1}")/ge;
	    s/#([^#]+)#$citealt_full_mark#([^#]*)#/&make_named_href(""
		,"$citefiles{$1}#$1","$cite_long{$1} $cite_year{$1}")/ge
	}
	s/#([^#]+)#$citealp_mark#([^#]*)#/&make_named_href(""
		,"$citefiles{$1}#$1","$cite_short{$1}$BEFORE_PAR_YEAR$cite_year{$1}")/ge;
	s/#([^#]+)#$citealp_full_mark#([^#]*)#/&make_named_href(""
		,"$citefiles{$1}#$1","$cite_long{$1}$BEFORE_PAR_YEAR$cite_year{$1}")/ge;
# BRM: Somehow the +)* hangs up perl!!!
#	s/#([^#]+)#$citet_mark#([^#]*)#(($OP|$CP|[^#\n]+)*#$citet_ext_mark)?/
# This works
	s/#([^#]+)#$citet_mark#([^#]*)#((($OP|$CP|[^#\n])*)#$citet_ext_mark)?/
	    &make_named_href(""
		, "$citefiles{$1}#$1"
			     # BRM: Modified to include delimiters and PRE-text
		, join(''
		    ,"$cite_short{$1} $CITE_OPEN_DELIM$cite_year{$1}$2"
		    , ($3 ? $BEFORE_PAR_YEAR.$4 : ''), $CITE_CLOSE_DELIM)
	 	)
	/ge;
# BRM: Somehow the +)* hangs up perl!!!
#	s/#([^#]+)#$citet_full_mark#([^#]*)#(($OP|$CP|[^#\n]+)*#$citet_ext_mark)?/
	s/#([^#]+)#$citet_full_mark#([^#]*)#((($OP|$CP|[^#\n])*)#$citet_ext_mark)?/
	    &make_named_href(""
		, "$citefiles{$1}#$1"
			     # BRM: Modified to include delimiters around year.
		, join(''
		    ,"$cite_long{$1} $CITE_OPEN_DELIM$cite_year{$1}$2"
		    , ($3 ? $BEFORE_PAR_YEAR.$4 : ''), $CITE_CLOSE_DELIM)
		)
	    /ge;
	s/#([^#]+)#$cite_par_mark#([^#]*)#/&make_named_href("",
		"$citefiles{$1}#$1","$cite_short{$1}$BEFORE_PAR_YEAR$cite_year{$1}")/ge;
	s/#([^#]+)#$cite_par_full_mark#([^#]*)#/&make_named_href("",
		"$citefiles{$1}#$1","$cite_long{$1}$BEFORE_PAR_YEAR$cite_year{$1}")/ge;
	s/#([^#]+)#$cite_year_mark#([^#]*)#/&make_named_href("","$citefiles{$1}#$1"
		,"$cite_year{$1}$2")/ge;
	s/#([^#]+)#$cite_author_mark#([^#]*)#/&make_named_href("","$citefiles{$1}#$1"
		,"$cite_short{$1}".($2? " $CITE_OPEN_DELIM$2$CITE_CLOSE_DELIM": ""))/ge;
	s/#([^#]+)#$cite_author_full_mark#([^#]*)#/&make_named_href("","$citefiles{$1}#$1"
		,"$cite_long{$1}".($2? " $CITE_OPEN_DELIM$2$CITE_CLOSE_DELIM": ""))/ge;
    }
    $/ = $savedRS;
}

sub cite_check_segmentation {
    local($c_key)=@_;
# This is based on code by Ross Moore
# Important for file segments
# It sets $citefile from the hash $ref_files:
    if  ($ref_files{"cite_$c_key"})  {
	$citefiles{$c_key} = $ref_files{"cite_$c_key" };
    };
## or $external_labels:   not needed (RRM)
# elsif  ($external_labels{"cite_$c_key"}) {
#	$citefiles{$c_key} = $external_labels{"cite_$c_key" };};
    $citefiles{$c_key};
}    

sub do_env_thebibliography {
    # Sets $citefile and $citations defined in translate
    # gives a nicely formatted .html file --- RRM
    local($_) = @_;
    $bibitem_counter = 0;
    $citefile = $CURRENT_FILE;
    $citefiles{$bbl_nr} = $citefile;
    s/$next_pair_rx//o;
#    s/^\s*$//g;	# Remove empty lines (otherwise will have paragraphs!)
#    s/\n//g;	# Remove all \n s --- we format the HTML file ourselves.
#    $* = 0;			# Multiline matching OFF
    s/\\newblock/\<BR\>/gm;	# break at each \newblock
    s/\\penalty\d+//mg;		# Remove \penalty declarations

    local($this_item,$this_kind, $title);
    # skip to the first bibliography entry
    s/\\(bibitem|harvarditem)/$this_kind=$1;''/eo;
    $_ = $';
#    $citations = join('',"\n<DL COMPACT>",
#		&translate_commands(&translate_environments($_)),"\n</DL>");
    local(@bibitems) = split(/\\(bib|harvard)item/, $_);
    while (@bibitems) {
	$this_item = shift (@bibitems);
	# remove extraneous space due to blank lines between items
	$this_item =~ s/$par_rx\s*$/\n/;
	$this_item = &translate_environments("\\$this_kind $this_item\\newblock");
	$citations .= &translate_commands($this_item);
	last unless  (@bibitems);
	$this_kind = shift (@bibitems).'item';
    }
    $citations = join('',"\n<DL class=\"COMPACT\">",$citations,"\n</DL>");
    $citations{$bbl_nr} = $citations;
    if (defined &do_cmd_bibname) {
	$title = &translate_commands('\bibname');
    } else { $title = $bib_title }
    $_ = join('','<P>' , "\n<H2><A ID=\"SECTIONREF\">"
	      , "$title</A>\n</H2>\n$bbl_mark#$bbl_nr#");
    $bbl_nr++ if $bbl_cnt > 1;
    $_;
}

sub do_cmd_bibpunct {
    local($_) = @_;
# six arguments 
    local($post, $dummy) = &get_next_optional_argument;
    $POST_NOTE=$post." " if ($post);
    s/$next_pair_pr_rx//o;
    $CITE_OPEN_DELIM=$2;
    s/$next_pair_pr_rx//o;
    $CITE_CLOSE_DELIM=$2;
    s/$next_pair_pr_rx//o;
    $CITE_ENUM=$2." " if ($2);
    s/$next_pair_pr_rx//o;
    local($style)=$2;
    $NUMERIC=($style =~ /[ns]/);
    s/$next_pair_pr_rx//o;
    $BEFORE_PAR_YEAR=$2." " if ($2);
    s/$next_pair_pr_rx//o;
    $COMMON_AUTHOR_SEP=$2;
    $_;
}

sub do_cmd_citeindexfalse {
    $CITEINDEX=0; $_[0];
}

sub do_cmd_citeindextrue {
    $CITEINDEX=1; $_[0];
}

sub do_cmd_citestyle {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    local($style)="citestyle_$2";
    if (@$style) {
	($CITE_OPEN_DELIM,
	 $CITE_CLOSE_DELIM,
	 $CITE_ENUM,
	 $NUMERIC,
	 $BEFORE_PAR_YEAR,
	 $COMMON_AUTHOR_SEP)=@$style;
	$NUMERIC=($NUMERIC =~ /[sn]/);
	local($and)="HARVARDAND_$2";
	defined $$and && do { $HARVARDAND=$$and }
    } else { print "\nnatbib.perl: invalid argument to \\citestyle!" };
    $_;
}

sub do_cmd_citationstyle {
    &do_cmd_citestyle 
}

#print "\nLoading $LATEX2HTMLSTYLES/babelbst.perl"
#    if (require "$LATEX2HTMLSTYLES/babelbst.perl");
&do_require_package('babelbst');

&ignore_commands ( <<_IGNORED_CMDS_);
bibsection # {}
bibfont # {}
bibhang # &ignore_numeric_argument
bibsep # &ignore_numeric_argument
citeindextype # {}
harvardyearparenthesis # {}
_IGNORED_CMDS_

1;                              # This must be the last line

