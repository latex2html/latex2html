# $Id: amsmath.perl,v 1.23 2003/12/31 13:03:32 RRM Exp $
# amsmath.perl by Ross Moore <ross@mpce.mq.edu.au>  9-30-96
#
# Extension to LaTeX2HTML to load features from AMS-LaTeX
#   amsfonts, amssymb, eucal, eufrak or euscript. 
#
# Change Log:
# ===========
#
# $Log: amsmath.perl,v $
# Revision 1.23  2003/12/31 13:03:32  RRM
#  --  the date was occurring twice with a single author; now fixed
#
# Revision 1.22  2003/12/31 11:57:02  RRM
#  --  added support for multiple authors
#  --  many more math symbols are declared for images
#
# Revision 1.21  2000/11/04 03:32:17  RRM
#  --  fixed typo where $t_author should be $t_address
#      thanks to Bruce Miller for reporting this
#
# Revision 1.20  1999/06/11 09:57:25  RRM
#  --  removed unnecessary tagging for ommitted information on title-page
#
# Revision 1.19  1999/06/03 05:37:41  RRM
#  --  added proper revision control
#  --  fixed error in previous commit
#
# Revision 1.18  1999/06/02 11:15:53  RRM
#  --  the \author and \address commands were not reading their argument
#      safely --- looping could result;  now fixed.
#
# Revision 1.17  1998/07/22 02:03:22  RRM
#  --  implemented {proof} environment and \qed and \qedsymbol
#  --  amsthm  now fully implemented, no longer gets a warning message
#
# Revision 1.16  1998/06/01 08:15:23  latex2html
#  --  bringing up-to-date with amstex.perl
#
# Revision 1.19  1998/05/29 09:46:44  latex2html
#  --  removed unneeded declarations
#  --  added declaration for  \operatornamewithlimits
#  --  load  more_amsmath.perl  under more circumstances; with less parsing
#  	aligned environments can now have images of whole table-cells
#
# Revision 1.18  1998/05/06 11:11:50  latex2html
#  --  implemented the  righttag  option
#  --  suppressed 'No implementation ...' messages
#  --  included CD in  %AMSenvs
#
# Revision 1.17  1998/05/04 12:14:16  latex2html
#  --  included  %EQNO <num> in LaTeX code that constructs image containing
#	equation-numbering, to avoid incorrect image-reuse
#  --  removed ALIGN attributes when using HTML 2.0
#
# Revision 1.16  1998/02/20 22:06:57  latex2html
# added log
#
# ----------------------------
# revision 1.15
# date: 1998/02/13 12:57:33;  author: latex2html;  state: Exp;  lines: +11 -0
#  --  images of {subequations} have the correct numbering and alignment
# ----------------------------
# revision 1.14
# date: 1998/02/06 22:57:13;  author: latex2html;  state: Exp;  lines: +39 -2
#  --  copied &get_eqn_number from the  more_amsmath file
# ----------------------------
# revision 1.13
# date: 1998/01/27 11:33:22;  author: RRM;  state: Exp;  lines: +30 -16
#  --  \title needed updating, in line with changes in  latex2html
# ----------------------------
# revision 1.12
# date: 1998/01/19 08:52:29;  author: RRM;  state: Exp;  lines: +3 -746
#  	That part of  amstex.perl and amsmath.perl that needs the `math'
# 	extension has been split-off into  more_amsmath.perl .
# 	This is loaded automatically with switches:
# 		 -no_math -html_version ...,math
# ----------------------------
# revision 1.11
# date: 1997/12/19 11:36:00;  author: RRM;  state: Exp;  lines: +16 -7
#  --  use a specified WIDTH="10%" for equation-numbering cells
# 	(thanks to Bruce Miller for highlighting the problem)
# ----------------------------
# revision 1.10
# date: 1997/12/18 11:18:31;  author: RRM;  state: Exp;  lines: +14 -9
#  --  removed  do_cmd_numberwithin  which is in the  latex2html  script
#  --  added support for CLASS="MATH"  with $USING_STYLES
# ----------------------------
# revision 1.9
# date: 1997/12/17 10:19:19;  author: RRM;  state: Exp;  lines: +30 -16
#  --  appended environment names to the new $display_env_rx variable
#  --  removed the need for `math' extension to be loaded
#  --  removed a redundant closing-tag `>' --- thanks Bruce Miller
#  --  fixed the missing equation-numbers when on the right-hand side
# ----------------------------
# revision 1.8
# date: 1997/12/11 02:42:44;  author: RRM;  state: Exp;  lines: +1 -1
#  --  missing `;' inserted at end of %AMSenvs array (thanks Bruce Miller)
# ----------------------------
# revision 1.7
# date: 1997/10/10 13:15:30;  author: RRM;  state: Exp;  lines: +10 -2
#  --  made loading of some new environments depend on having the `math'
# 	extension loaded. This probably should be made a requirement ?
# ----------------------------
# revision 1.6
# date: 1997/10/04 07:26:37;  author: RRM;  state: Exp;  lines: +742 -17
#  --  handles most of the amsmath alignment macros/environments
#  --  supports leqno/reqno options
#  --  support for more of the AMSbook/art internal commands, that
# 	can also be used externally; e.g. \chapterrunhead, etc.
# 
#     Note: not *all* of the amsmath package is fully supported in the
# 	best possible way; we are still working on it.
# ----------------------------
# revision 1.5
# date: 1997/07/11 11:28:57;  author: RRM;  state: Exp;  lines: +1 -1
#  -  replace  (.*) patterns with something allowing \n s included
# ----------------------------
# revision 1.4
# date: 1997/07/09 13:28:38;  author: RRM;  state: Exp;  lines: +18 -18
#     Too many commas in assoc-array, Oops --- thanks Michel, well spotted
# ----------------------------
# revision 1.3
# date: 1997/05/19 13:27:50;  author: RRM;  state: Exp;  lines: +29 -28
#  -  AmS-TeX style environment delimiters need a  `\\' .
# ----------------------------
# revision 1.2
# date: 1997/05/02 04:08:16;  author: RRM;  state: Exp;  lines: +189 -16
#      Extensive changes, preparatory to complete support for AmS-LaTeX.
#      This work is not yet complete.
# ----------------------------
# revision 1.1
# date: 1997/03/05 00:27:17;  author: RRM;  state: Exp;
# Support for American Math Society (AMS) packages.
# Mostly just recognises options to the AMS packages, to suppress warnings.


package main;
#


# unknown environments:  alignedat, gathered, alignat, multline
#   \gather([^* ])...\endgather
#   \align([^* ])...\endalign

$abstract_name = "Abstract";
$keywords_name = "Keywords";
$subjclassname = "1991 Subject Classification";
$date_name = "Date published";
$Proof_name = "Proof";


sub do_cmd_title {
    local($_) = @_;
    local($text,$s_title,$rest);
    if (/\\endtitle/) {
	$rest = $';
	$t_title = $text = &translate_commands($`);
	$t_title =~ s/(^\s*|\s*$)//g;
	$s_title = &simplify($text);
	$TITLE = (($s_title)? $s_title : $default_title);
	return($rest);
    }
    &get_next_optional_argument;
    $text = &missing_braces
        unless ((s/$next_pair_pr_rx//o)&&($text = $2));
    $t_title = &translate_environments($text);
    $t_title = &translate_commands($t_title);
    $s_title = &simplify(&translate_commands($text));
    $TITLE = (($s_title)? $s_title : $default_title);
    $_
}

#    local($rest) = $_;
#    $rest =~ s/$next_pair_pr_rx//o;
#    $_ =  &translate_commands($&);
#    &extract_pure_text("liberal");
#    s/([\w\W]*)(<A.*><\/A>)([\w\W]*)/$1$3/;  # HWS:  Remove embedded anchors
#    ($t_title) = $_;
#    $TITLE = $t_title if ($TITLE eq $default_title);
#    $TITLE =~ s/<P>//g;		# Remove Newlines
#    $TITLE =~ s/\s+/ /g;	# meh - remove empty lines 
#    $rest;
#}

sub do_cmd_author {
    local($_) = @_;
    &get_next_optional_argument;
    my $next;
    my $after = '';
    if (/\\endauthor/) {
	$next = $`;
	$after = $';
    } else {
	$next = &missing_braces unless (
        (s/$next_pair_pr_rx/$next = $2;''/seo)
        ||(s/$next_pair_rx/$next = $2;''/seo));
	$after = $_;
   }
    if ($next =~ /\\and/) {
        my @author_list = split(/\s*\\and\s*/, $next);
        my $t_author, $t_affil, $t_address;
        foreach (@author_list) {
            $t_author = &translate_environments($_);
            $t_author =~ s/\s+/ /g;
            $t_author = &simplify(&translate_commands($t_author));
            ($t_author,$t_affil,$t_address) = split (/\s*<BR>s*/, $t_author);
            push @authors, $t_author;
            push @affils, $t_affil;
            push @addresses, $t_address;
        }
    } else {
        $_ = &translate_environments($next);
        $next = &translate_commands($_);
        ($t_author) = &simplify($next);
        ($t_author,$t_affil,$t_address) = split (/\s*<BR>s*/, $t_author);
        push @authors, $t_author;
        push @affils, $t_affil if $t_affil;
        push @addresses, $t_address if $t_address;
    }
    $after;
}

sub do_cmd_address {
    local($_) = @_;
    if (/\\endaddress/) {
	$t_address = &translate_commands($`);
	$t_address =~ s/(^\s*|\s*$)//g;
	push @addresses, $t_address;
	return($');
    }
    &get_next_optional_argument;
    local($rest) = $_;
    $t_address = &missing_braces unless (
	($rest =~ s/$next_pair_pr_rx/$t_address=$&;''/eo)
	||($rest =~ s/$next_pair_rx/$t_address=$&;''/eo));
    ($t_address) =  &translate_commands($t_address);
    push @addresses, $t_address;
    $rest;
}

sub do_cmd_curraddr {
    local($_) = @_;
    &get_next_optional_argument;
    local($rest) = $_;
    $rest =~ s/$next_pair_pr_rx//o;
    ($t_curraddr) =  &translate_commands($&);
    push @curraddr, $t_curraddr;
    $rest;
}

sub do_cmd_affil {
    local($_) = @_;
    if (/\\endaffil/) {
	$t_affil = &translate_commands($`);
	$t_affil =~ s/(^\s*|\s*$)//g;
	push @affils, $t_affil;
	return($');
    }
    &get_next_optional_argument;
    local($rest) = $_;
    $rest =~ s/$next_pair_pr_rx//o;
    ($t_affil) = &translate_commands($&);
    push @affils, $t_affil;
    $rest;
}

sub do_cmd_dedicatory {
    local($_) = @_;
    &get_next_optional_argument;
    local($rest) = $_;
    $rest =~ s/$next_pair_pr_rx//o;
    ($t_dedic) = &translate_commands($&);
    $rest;
}

sub do_cmd_date {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    ($t_date) = &translate_commands($&);
    $_;
}

sub do_cmd_email {
    local($_) = @_;
    &get_next_optional_argument;
    local($rest) = $_;
    $rest =~ s/$next_pair_pr_rx//o;
    ($t_email) = &make_href("mailto:$2","$2");
    push @emails, $t_email;
    $rest;
}

sub do_cmd_urladdr {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    ($t_authorURL) = &translate_commands($2);
    push @authorURLs, $t_authorURL;
    $_;
}

sub do_cmd_keywords {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    ($t_keywords) = &translate_commands($2);
    $_;
}

sub do_cmd_subjclass {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    ($t_subjclass) = &translate_commands($2);
    $_;
}

sub do_cmd_translator {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    ($t_translator) = &translate_commands($2);
    $_;
}

sub do_cmd_MR {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    ($t_math_rev) = &translate_commands($2);
    $_;
}

sub do_cmd_PII {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    ($t_publ_index) = &translate_commands($2);
    $_;
}

sub do_cmd_copyrightinfo {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    ($t_copyright_year) = &translate_commands($2);
    s/$next_pair_pr_rx//o;
    ($t_copyright_holder) = &translate_commands($2);
    $_;
}



sub do_cmd_AmS {
    local($_) = @_;
    "<i>AmS</i>".$_;
}

sub do_cmd_AmSTeX {
    local($_) = @_;
    "<i>AmS-TeX</i>" . $_;
}

sub do_cmd_maketitle {
    local($after) = @_;
    local($the_title) = '';
    if ($t_title) {
	$the_title = "<H1 class=\"CENTER\">$t_title</H1>\n";
    } else { &write_warnings("This document has no title."); }

    if (($#authors > 0)||$MULTIPLE_AUTHOR_TABLE) {
        $the_title .= &make_multipleauthors_title($alignc,$alignl);
    } else {
        $the_title .= &make_singleauthor_title($alignc,$alignl,$t_author
	    , $t_affil,$t_institute,$t_date,$t_address,$t_email,$t_authorURL);
    }

    if (($t_translator)&&!($t_translator=~/^\s*(($O|$OP)\d+($C|$CP))\s*\1\s*$/)) {
	$the_title .= "<BR><P class=\"CENTER\">Translated by $t_translator</P>\n";}
    if (($t_date)&&!($t_date=~/^\s*(($O|$OP)\d+($C|$CP))\s*\1\s*$/)) {
	$the_title .= "<BR><P class=\"CENTER\"><B>Date:</B> $t_date</P>\n";}
    if ($t_keywords) {
	$the_title .= "<BR><P><P class=\"LEFT\"><SMALL>".
	    "Key words and phrases: $t_keywords</SMALL></P>\n";}
    if ($t_subjclass) {
	$the_title .= "<BR><P><P class=\"LEFT\"><SMALL>".
	    "1991 Mathematics Subject Classification: $t_subjclass</SMALL></P>\n";}

    join("\n", $the_title, "<HR>", $after);
}

sub make_singleauthor_title{
    local($alignc,$alignl,$t_author,$t_affil,$t_institute,$t_date,
	$t_address,$t_email,$t_authorURL) = @_;
    my $the_title = '';
    if ($t_author) {
	$the_title .= "<P class=\"CENTER\"><STRONG>$t_author</STRONG>\n";
    } else { &write_warnings("There is no author for this document."); }
    if (($t_affil)&&!($t_affil=~/^\s*(($O|$OP)\d+($C|$CP))\s*\1\s*$/)) {
	$the_title .= "<BR><I>$t_affil</I>\n";}
    if ($t_address&&!($t_address=~/^\s*(($O|$OP)\d+($C|$CP))\s*\1\s*$/)) {
	$the_title .= "<BR><SMALL>$t_address</SMALL>\n"}
    if ($t_email&&!($t_email=~/^\s*(($O|$OP)\d+($C|$CP))\s*\1\s*$/)) {
	$the_title .= "<BR><SMALL>$t_email</SMALL></P>\n";
    } else { $the_title .= "</P>" }
    $the_title;
}



sub do_cmd_boldsymbol {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $_ = join('',"<B><I>$2</I></B>",$_);
    $_;
}



# some simplifying macros that like
# to existing LaTeX constructions.
# are defined already in  latex2html 

#sub do_cmd_eqref {
#    local($_) = @_;
#    join('','(',&process_ref($cross_ref_mark,$cross_ref_mark,'',')'));
#}

#sub do_cmd_numberwithin {
#    local(*_) = @_;
#    local($ctr, $within);
#    $ctr = &get_next(1);
#    $within = &get_next(1);
#    &addto_dependents($within,$ctr) if ($within);
#    $_;
#}

#########  for equation-numbers and tags  ###############

sub get_eqn_number {
    local($outer_num, $scan) = @_;
    # an explicit \tag overrides \notag , \nonumber or *-variant
    local($labels,$tag);
    ($scan,$labels) = &extract_labels($scan); # extract labels
#    $scan =~ s/\n//g;
    if ($scan =~ s/\\tag(\*|star\b)?\s*(($O|$OP)\d+($C|$CP))(.*)\2//s) {
	local($star) = $1; $tag = $5;
	$tag = &translate_environments($tag) if ($tag =~ /\\begin/);
	$tag = &translate_commands($tag) if ($tag =~ /\\/);
	$tag = (($star)? $tag : $EQNO_START.$tag.$EQNO_END );
    } elsif (($outer_num)&&(!($scan)||!($scan =~ s/\\no(tag|number)//))
	&&(!($scan =~ /^\s*\\begin(<(<|#)\d+(>|#)>)($outer_math_rx)/))
      ) { 
        $global{'eqn_number'}++ ;
	if ($subequation_level) {
	    local($sub_tag) =  &get_counter_value('equation');
	    $tag = join('', $EQNO_START
		, $eqno_prefix
		, &falph($sub_tag)
		, $EQNO_END);
	} else {
	    $tag = join('', $EQNO_START
		, &simplify(&translate_commands("\\theequation"))
		, $EQNO_END);
	}
    } else { $tag = ';SPMnbsp;' }
    if ($labels) {
	$labels =~ s/$anchor_mark/$tag/o;
	($labels , $scan);
    } else { ($tag , $scan) }
}

###   Special environments, for mathematics

sub do_env_equationstar {
    local($no_eqn_numbers) = 1;
    &do_env_displaymath(@_);
}
sub do_env_subequations {
    local($_) = @_;
    local($align);
    $align = join('', " ALIGN=\""
	    , (($EQN_TAGS =~ /L/)? 'LEFT' : 'RIGHT'), "\"")
	unless ($HTML_VERSION < 2.2);

    $latex_body .= join('', "\n\\setcounter{equation}{"
		, $global{'eqn_number'} , "}\n");
    $_ .= "%EQNO:".$global{'eqn_number'}."\n";
    $global{'eqn_number'}++;
    local($this) = &process_undefined_environment('subequations'
	    , ++$global{'max_id'}, $_);
    local($div) = (($HTML_VERSION < 3.2)? 'P' : 'DIV');
    join('', "<$div$align>\n" , $this, "<BR></$div>" )
}

sub do_cmd_proofname { ($prf_name ? $prf_name : 'Proof')  . @_[0] }
sub do_cmd_qed {
    local($env) = 'tex2html_wrap_inline';
    join('', &process_math_in_latex('','',0,"\\qedsymbol"), @_[0]) }

sub do_env_proof {
    local($proof_contents) = @_;
    local($bproof, $eproof);
    local($proof_name,$br_id);
    if ((defined &do_cmd_proofname)||$new_command{'proofname'}) {
	$br_id=++$global{'max_id'};
	$proof_name = &translate_environments("$O$br_id$C\\itshape\\proofname$O$br_id$C");
    } else { $proof_name = '<EM>'.$prf_name.'</EM>' }
    $bproof = (($HTML_VERSION > 3.1)? "<DIV$env_id>" : '<P>');
    $eproof = (($HTML_VERSION > 3.1)? '</DIV>' : '</P>') . '<P></P>';
    local($qed);
    if ($new_command{'qed'}) {
	$br_id = ++$global{'max_id'};
	$qed = &translate_commands(&translate_environments("$O$br_id$C\\qed$O$br_id$C"));
    } else { $qed = &do_cmd_qed() }
    $br_id = ++$global{'max_id'};
    join ('', "<P></P>\n", $bproof , $proof_name.".\n" 
	, &translate_commands(&translate_environments("$O$br_id$C$proof_contents$O$br_id$C "))
	, $qed , "\n".$eproof."\n" )
}

#  Suppress the possible options to   \usepackage[....]{amstex}
#  and  {amsmath}  {amsopn}  {amsthm}

sub do_amstex_leqno { $EQN_TAGS = 'L'; }
sub do_amstex_reqno { $EQN_TAGS = 'R'; }
sub do_amsmath_leqno { $EQN_TAGS = 'L'; }
sub do_amsmath_reqno { $EQN_TAGS = 'R'; }
sub do_amsmath_fleqn {}
sub do_amstex_centereqn {
}
sub do_amstex_centertags {
}
sub do_amstex_tbtags {
}
sub do_amstex_righttag { $EQN_TAGS = 'R'; }

sub do_amstex_ctagsplt {
}

%styles_loaded = ( %styles_loaded
     , 'amsbsy' , 1 , 'amscd' , 1 , 'amsfonts' , 1 , 'amsthm' , 1
     , 'amssymb' , 1 , 'amstext' , 1 , 'amsfonts' , 1 , 'amsopn' , 1
     , 'amstex_noamsfonts' , 1 , 'amsmath_noamsfonts' , 1
     , 'amstex_psamsfonts' , 1 , 'amsmath_psamsfonts' , 1
     , 'amstex_intlim' , 1 , 'amsmath_intlim' , 1
     , 'amstex_nonamelm' , 1 , 'amsmath_nonamelm' , 1
     , 'amstex_nosumlim' , 1 , 'amsmath_nosumlim' , 1
    );


%AMSenvs = (
	  'cases' , 'endcases'
	, 'matrix'  , 'endmatrix'
	, 'bmatrix' , 'endbmatrix'
	, 'Bmatrix' , 'endBmatrix'
	, 'pmatrix' , 'endpmatrix'
	, 'vmatrix' , 'endvmatrix'
	, 'Vmatrix' , 'endVmatrix'
	, 'smallmatrix' , 'endsmallmatrix'
	, 'align'    , 'endalign'
	, 'alignat'  , 'endalignat'
	, 'xalignat' , 'endxalignat'
	, 'xxalignat', 'endxxalignat'
	, 'aligned'  , 'endaligned'
	, 'topaligned'  , 'endtopaligned'
	, 'botaligned'  , 'endbotaligned'
	, 'alignedat', 'endalignedat'
	, 'flalign'  , 'endflalign'
	, 'gather'   , 'endgather'
	, 'multline' , 'endmultline'
	, 'heading' , 'endheading'
	, 'proclaim' , 'endproclaim'
	, 'demo' , 'enddemo'
	, 'roster' , 'endroster'
	, 'ref' , 'endref'
	, 'CD' , 'endCD'
);


&ignore_commands( <<_IGNORED_CMDS_);
comment # <<\\endcomment>>
displaybreak
allowdisplaybreak
allowdisplaybreaks
spreadlines
overlong
allowtthyphens
hyphenation
BlackBoxes
NoBlackBoxes
split
operatorname
operatornamewithlimits
qopname # {} # {}
text
thetag
mspace # {}
smash # []
topsmash
botsmash
medspace
negmedspace
thinspace
negthinspace
thickspace
negthickspace
hdots
hdotsfor # &ignore_numeric_argument
hcorrection # &ignore_numeric_argument
vcorrection # &ignore_numeric_argument
delimiterfactor # &ignore_numeric_argument
topmatter
endtopmatter
overlong
nofrills
phantom # {}
hphantom # {}
vphantom # {}
minCDarrowwidth # {}
chapterrunhead # {} # {} # {}
sectionrunhead # {} # {} # {}
partrunhead # {} # {} # {}
_IGNORED_CMDS_


&process_commands_in_tex (<<_RAW_ARG_CMDS_);
cases # <<\\endcases>>
matrix # <<\\endmatrix>>
bmatrix # <<\\endbmatrix>>
Bmatrix # <<\\endBmatrix>>
pmatrix # <<\\endpmatrix>>
vmatrix # <<\\endvmatrix>>
Vmatrix # <<\\endVmatrix>>
smallmatrix # <<\\endsmallmatrix>>
align # <<\\endalign>>
alignat # <<\\endalignat>>
xalignat # <<\\endxalignat>>
xxalignat # <<\\endxxalignat>>
aligned # <<\\endaligned>>
alignedat # <<\\endalignedat>>
flalign # <<\\endflalign>>
gather # <<\\endgather>>
multline # <<\\endmultline>>
#overset # {} # {}
#sideset # {} # {} # {}
#underset # {} # {}
overleftarrow # {}
underleftarrow # {}
overrightarrow # {}
underrightarrow # {}
overleftrightarrow # {}
underleftrightarrow # {}
xleftarrow # [] # {}
xrightarrow # [] # {}
#oversetbrace # <<\\to>> # {}
#undersetbrace # <<\\to>> # {}
genfrac # {} # {} # {} # {} # {} # {}
cfrac # [] # {} # {}
#cfrac # <<\\endcfrac>>
lcfrac # <<\\endcfrac>>
rcfrac # <<\\endcfrac>>
CD # <<\\endCD>>
fracwithdelims # &ignore_numeric_argument(); # {} # {}
thickfrac # <<\\thickness>> # &ignore_numeric_argument(); # {} # {}
thickfracwithdelims # <<\\thickness>> # &ignore_numeric_argument(); # {} # {}
boxed # {}
mathbb # {}
mathfrak # {}
Hat # {}
Breve # {}
Grave # {}
Bar # {}
Dot # {}
Check # {}
Acute # {}
Tilde # {}
Vec # {}
Ddot # {}
dddot # {}
ddddot # {}
_RAW_ARG_CMDS_

&process_commands_inline_in_tex (<<_RAW_ARG_CMDS_);
qedsymbol
_RAW_ARG_CMDS_


&process_commands_nowrap_in_tex (<<_RAW_ARG_NOWRAP_CMDS_);
numberwithin # {} # {}
_RAW_ARG_NOWRAP_CMDS_


#   add later extensions, which require `math' to be loaded

if (($NO_SIMPLE_MATH)&&(defined &make_math)) { 
    &do_require_package('more_amsmath');
} elsif ($HTML_VERSION > 3.1) {
    require "$LATEX2HTMLVERSIONS${dd}math.pl";
    $NO_MATH_PARSING = $NO_SIMPLE_MATH = 1;
    &do_require_package('more_amsmath');
}


1;                              # This must be the last line

