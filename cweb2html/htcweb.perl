
################################################################################
# Copyright 1998-1999 by Jens Lippmann (lippmann@rbg.informatik.tu-darmstadt.de)
#
# Permission to use, copy, modify, and distribute this software for any
# purpose and without fee is hereby granted, provided that the above
# copyright notice appears in all copies. This software is provided "as is"
# and without any express or implied warranties.
#
################################################################################
#
# HTCWEB.PERL
#
# Extension to LaTeX2HTML to translate HyTeX specific commands.
# See also htcweb.tex, htcweb.sty.
#
# $Source: /home/latex2ht/cvs/latex2html/user/cweb2html/htcweb.perl,v $
# $RCSfile: htcweb.perl,v $
# $Revision: 1.3 $
# $Date: 1999/10/15 22:05:37 $
# $Author: JCL $
# $State: Exp $
#
################################################################################
# History
#
# $Log: htcweb.perl,v $
# Revision 1.3  1999/10/15 22:05:37  JCL
# small patch to get real node names with l2h 99.2 instead subsequent M.html or N.html
#
# Revision 1.2  1999/04/09 19:25:33  JCL
# changed my e-Mail address
#
# Revision 1.1  1998/02/24 02:29:50  latex2html
# for 98.1
#
# Revision 1.1  1998/02/24 02:15:57  latex2html
# ready for 98.1
#
# Revision 1.13  1997/11/10 09:24:32  zohar
# th-darmstadt -> tu...
#
# Revision 1.12  1997/09/13 01:07:04  lippmann
# improved support of LoI, LoR navigation buttons
#
# Revision 1.11  1997/06/26 19:00:11  lippmann
# improved input logic for .scn .idx files (seeks TEXINPUTS)
#
# Revision 1.10  1997/06/01 13:20:20  lippmann
# more enhancements depending on HTCwebmode (titles, \A, \As etc.)
#
# Revision 1.9  1997/06/01 11:56:08  lippmann
# o changed name from htmlmac to htcweb
# o htcweb.perl takes different actions depending on $HTCwebmode
#   (\U, \Us, \Q, \Qs string translation currently)
#
# Revision 1.8  1997/06/01 10:42:49  lippmann
# o handles now enumerations of section cited along \U, \Q, \Us and \Qs
#   occurring in cweave generated output
# o variable names adhere to HTCweb name space
# o uses initialisation function
#
# Revision 1.7  1997/06/01 08:18:23  lippmann
# Introduced the name space HTCweb, which will be used both in TeX and Perl
# packages and for mapping to some CWEB internals hidden from LaTeX2HTML.
#
# HTmode, HTpretty, HTnoderef -> HTCweb...
# HTweb -> HTCweb
# \ciao -> \HTCwebdocumentend
# 1 -> HTCweboneright
# 2 -> HTCweboneleft
# 3 -> HTCweboptbreak
# 4 -> HTCwebthisleft
# 5 -> HTCwebbigoptbreak
# 6 -> HTCwebbreak
# 7 -> HTCwebbigbreak
# 8 -> HTCwebclearleft
# 9 -> HTCwebempty
# idit -> HTCwebidit
# idma -> HTCwebidma
# idbo -> HTCwebidbo
# idtt -> HTCwebidtt
# discr -> HTCwebdiscr
# mathque -> HTCwebmathque
# smllspc -> HTCwebsmllspc
#
# Revision 1.6  1997/05/31 01:52:35  lippmann
# handles new synopsis of \HTwebNodeRef to translate multi-part refinement
# types in the list of refinements
#
# Revision 1.5  1997/05/25 22:34:12  lippmann
# added some interesting parsing logic to process list of identifiers/refinements
#  - calls pre_process, substitute_meta_cmds (and wrap_shorthand_environments)
#  - &do_cmd_fin keeps its contents mostly processed  by l2h, this enabled me
#    to remove redundant parsing
#
# Revision 1.4  1997/05/25 21:17:49  lippmann
# o handles cweave generated list of identifiers
# o handling of multi-part refinements is missing
#
# Revision 1.3  1997/01/26 19:31:30  lippmann
# improved handling of external labels
#
# Revision 1.2  1996/12/11 11:16:07  lippmann
# adapted to work with new htmlmac macros
#
# Revision 1.1.1.1  1996/07/08 15:46:25  liefke
# initial version for Darmstadt
#
# Revision 1.1.1.1  1996/07/08 15:46:25  liefke
# initial version for Darmstadt
#
# Revision 1.6  1996/06/25 20:58:52  lippmann
# - external bubble names handled conditionally on whether it's been found
# in label files or not
# - suitable standard output for above cases
#
# Revision 1.5  1996/06/20 02:04:53  lippmann
# - HTweb macros are handled, stand-alone web documents may be
#   interlinked now ... yeah!
#
# Revision 1.4  1996/06/09 17:49:18  lippmann
# slightly revised, glossar feature improved
#
# Revision 1.3  1996/05/16 00:53:34  lippmann
# change for do_cmd_N
# 
# Revision 1.2  1996/05/10 17:38:45  lippmann
# needed to introduce \ciao as substitution for \end{document}.
# This is a hack.
#
# Revision 1.1  1996/04/25 12:31:40  lippmann
# new home for these files
#
################################################################################

package main; 

# latex2html adds <P> when a non-ignored command appears at the line end,
# even if the command has a perl function. Hence we have to ignore some
# commands explicitely if we don't want a <P> (such as \6,\7,\SHC,..).
&ignore_commands( <<"#IGNORED_CMDS");
NODECOMMAND
ADDCONTENTSCOMMAND
HTCwebdiscr
PB
MRL
HTCweboptbreak#{}
HTCwebbigoptbreak
5
LASTM#{}
LIXM#{}
GLOSSARM#{}
HyTeXSetDown
addvspace
HTCwebdocumentend
HTCwebX
fi
hbox
mathrel
#IGNORED_CMDS


%section_commands = ('N', 'H1', 'M', 'H2', 'inx', 'H2', 'fin', 'H2', %section_commands);

$CUSTOM_TITLES = 1;
sub custom_title_hook {
    local($title) = @_;

    print "XXX customize title <$title> to <node$OUT_NODE>\n";
    "node$OUT_NODE";
}

sub top_navigation_panel {
    &navigation_panel;
}

sub bot_navigation_panel {
    &navigation_panel;
}

sub navigation_panel {
    local($GLOSSARY,$LOI,$LOR);
    local($border) = (length($NAV_BORDER) ? "BORDER=\"$NAV_BORDER\"" : "");
    local($url) = ($LOCAL_ICONS ? "" : "$ICONSERVER/");
    local($loi_img) = "<IMG ALIGN=\"BOTTOM\" ALT=\"Identifiers\" $border SRC=\"${url}identifiers_motif.gif\">";
    local($lor_img) = "<IMG ALIGN=\"BOTTOM\" ALT=\"Refinements\" $border SRC=\"${url}refinements_motif.gif\">";

    $GLOSSARY = &add_special_link($glossary_visible_mark, $gls_file, $file)
	if ($styles_loaded{'lips'} && $INDEX_IN_NAVIGATION);

    ($LOI,$LOR) = (&add_special_link($loi_img, $HTCweb_loi_file, $file),
		   &add_special_link($lor_img, $HTCweb_lor_file, $file))
	if $INDEX_IN_NAVIGATION;

    "<!--Navigation Panel-->" .

    # Now add a few buttons with a space between them
    "$NEXT $UP $PREVIOUS $CONTENTS $INDEX $GLOSSARY $LOI $LOR $CUSTOM_BUTTONS" .
    
    "\n<BR>" .		# Line break
	
    # If ``next'' section exists, add its title to the navigation panel
    ($NEXT_TITLE ? "\n<B> Next:</B> $NEXT_TITLE" : undef) . 
    
    # Similarly with the ``up'' title ...
    ($UP_TITLE ? "\n<B> Up:</B> $UP_TITLE" : undef) . 
 
    # ... and the ``previous'' title
    ($PREVIOUS_TITLE ? "\n<B> Previous:</B> $PREVIOUS_TITLE" : undef) .

    # These <BR>s separate it from the text body.
    "\n<BR><BR>"
}


# The following functions reflect the translation of the TeX macro
# as defined in roughly the same order in cwebmac.tex (hywebmac.tex).
#
# A function starting with 'HTCweb' is the translation for the synonym
# to Cweb defined in htcweb.sty and occurs beneath the original one.
#
# Some Cweb macros simply need to be ignored, hereto belongs a list of
# ignored commands defined in this file.
#
# Some of the Cweb macros didn't make sense to get translated, such
# omissions are marked with (#...).
# This had been the case when no occurrence of such macros within
# any of the CWEB generated TeX files (except hycweave.tex) has been
# noticed (sorry but empirical to me are our project sources and I do
# not support esoteric stuff until I see a reason)
#
# Functions #xyz needed no translation, their argument(s)
# are simply passed through LaTeX2HTML.
#
# See also the htcweb.sty documentation.

#...

sub do_cmd_hT {
    join('','<B>HyTeX</B>', $_[0]);
}

sub do_cmd_cweb {
   join('','<B>CWEB </B>', $_[0]);
}

#...

sub do_cmd_CEE {
   join('','<B>C </B>', $_[0]);
}

sub do_cmd_UNIX {
   join('','<B>UNIX </B>', $_[0]);
}

sub do_cmd_TEX {
   join('','<B>TeX</B>', $_[0]);
}

sub do_cmd_CPLUSPLUS {
   join('','<B>C<TT>++</TT> </B>', $_[0]);
}

sub do_cmd_Cee {
   join('','<B>C </B>', $_[0]);
}

sub do_cmd_9{
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    $_;
}
sub do_cmd_HTCwebempty{
    &do_cmd_9;
}

sub do_cmd_HTCwebidit{
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join(''," <I>$2</I> ",$_);
}

sub do_cmd_HTCwebidma{
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join(''," <I>$2</I> ",$_);
}

sub do_cmd_HTCwebidbo{
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join(''," <B>$2</B> ",$_);
}

sub do_cmd_HTCwebidtt{
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join(''," <TT>$2</TT> ",$_);
}

#HTCwebdiscr
#...
#PB

sub do_cmd_AM {
   join('','&amp;', $_[0]);
}

sub do_cmd_BS {
   join('','&#92;', $_[0]);
}

sub do_cmd_LB {
   join('','{', $_[0]);
}

sub do_cmd_RB {
   join('','}', $_[0]);
}

sub do_cmd_SP {
   join('',' ', $_[0]);
}

sub do_cmd_TL {
   join('','&#126;', $_[0]);
}

sub do_cmd_UL {
   join('','_', $_[0]);
}

sub do_cmd_CF {
   join('','^', $_[0]);
}


sub do_cmd_PP {
   join('','+ +', $_[0]);
}

# contiguous minuses might be compressed by LaTeX2HTML
# to mimick TeX behaviour.
sub do_cmd_MM {
   join('','- -', $_[0]);
}

sub do_cmd_MG {
   join('','-&gt;', $_[0]);
}

#MRL

sub do_cmd_GG {
   join('','&gt;&gt;', $_[0]);
}

sub do_cmd_LL {
   join('','&lt;&lt;', $_[0]);
}

sub do_cmd_NULL {
   join('','<TT>NULL</TT>', $_[0]);
}

sub do_cmd_AND {
   join('','&amp;', $_[0]);
}

sub do_cmd_OR {
   join('','|', $_[0]);
}

sub do_cmd_XOR {
   join('','^', $_[0]);
}

sub do_cmd_CM {
   join('','&#126;', $_[0]);
}

sub do_cmd_MOD {
   join('','%', $_[0]);
}

sub do_cmd_DC {
   join('','::', $_[0]);
}

sub do_cmd_PA {
   join('','.*', $_[0]);
}

sub do_cmd_MGA {
   join('','-&gt;*', $_[0]);
}

sub do_cmd_this {
    join('','<TT>this</TT>', $_[0]);
}

sub do_cmd_1 {
    $HTCweb_cmode_indent = join("","</DL>",$HTCweb_cmode_indent);
    $HTCweb_cmode_break = "";
    join('',"<DL>", $_[0]);
}
sub do_cmd_HTCweboneright {
    &do_cmd_1;
}

sub do_cmd_2 {
    $HTCweb_cmode_indent =~ s/<\/DL>//;
    join('',"</DL>", $_[0]);
}
sub do_cmd_HTCweboneleft {
    &do_cmd_2;
}

#3
sub do_cmd_HTCweboptbreak {
    $_[0] =~ s/^\d//;
    $_[0];
}

sub do_cmd_4 {
    $HTCweb_skip_indent = join("","<DL>",$HTCweb_skip_indent);
    $HTCweb_cmode_break = "";
    join('',"</DL>", $_[0]);
}
sub do_cmd_HTCwebthisleft {
    &do_cmd_4;
}

#5

sub do_cmd_6 {
    local($indent,$break) = ($HTCweb_skip_indent,$HTCweb_cmode_break);
    $HTCweb_skip_indent = "";
    $HTCweb_cmode_break = "<BR>";
    join('',"$break$indent", $_[0]);
}
sub do_cmd_HTCwebbreak {
    &do_cmd_6;
}

sub do_cmd_7 {
    local($indent) = $HTCweb_skip_indent;
    $HTCweb_skip_indent = "";
    $HTCweb_cmode_break = "<BR>";
    join('',"$indent<P>", $_[0]);
}
sub do_cmd_HTCwebbigbreak {
    &do_cmd_7;
}

sub do_cmd_8 {
    local($full_skip) = $HTCweb_cmode_indent;
    $full_skip =~ s/<\/DL>//;
    $HTCweb_skip_indent = $full_skip;
    $HTCweb_skip_indent =~ s/\///g;
    $HTCweb_cmode_break = "";
    join('',"$full_skip", $_[0]);
}
sub do_cmd_HTCwebclearleft {
    &do_cmd_8;
}

#...

sub do_cmd_HTCwebmathque {
    join('','?', $_[0]);
}

#...

sub do_cmd_A {
    local($_)=@_;

    # If raw digits follow the command, it's a cweave-like reference.
    # Get a list of numbers terminated by a dot and hyperize them.
    s/^([^\.]*)/&HTCweb_replace_refs($1)/e
	if /^\s*\d/;

   join('', $HTCweb_also_string, ' ', $_);
}

sub do_cmd_As {
    local($_)=@_;

    # If raw digits follow the command, it's a cweave-like reference.
    # Get a list of numbers terminated by a dot and hyperize them.
    s/^([^\.]*)/&HTCweb_replace_refs($1)/e
	if /^\s*\d/;

   join('', $HTCweb_alsos_string, ' ', $_);
}

# Backwards compatiblity
sub do_cmd_B {
    $HTCweb_skip_indent = "";
    $HTCweb_cmode_indent = "</DL></DL>";
    join('','<DL><DL>', $_[0]);
}

# Formerly do_cmd_B
sub do_cmd_HTCwebB {
    $HTCweb_skip_indent = "";
    $HTCweb_cmode_indent = "</DL></DL>";
    join('','<DL><DL>', $_[0]);
}

sub do_cmd_C{
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<TT> /* $2 */</TT>",$_);
}

sub do_cmd_SHC{
    &do_cmd_C;
}

sub do_cmd_D {
   join('','#define ', $_[0]);
}

sub do_cmd_E {
   join('','==', $_[0]);
}

sub do_cmd_ET {
   join('',' and ', $_[0]);
}

sub do_cmd_ETs {
   join('',',and ', $_[0]);
}

sub do_cmd_F {
   join('','format ', $_[0]);
}

sub do_cmd_G {
   join('','&gt;=', $_[0]);
}

sub do_cmd_I {
   join('','!=', $_[0]);
}

sub do_cmd_K {
   join('','=', $_[0]);
}

# This is sectioning command, care for '<<','>>' delimiters of next pair
sub do_cmd_M {
    local($_) = @_;
    s/$next_pair_rx//o;
    local($no) = $2;
    # build title string and capitalize first letter
    $TITLE = "$HTCweb_chunkname $no";
    $TITLE =~ s/^(\w)/chr(ord($1)-32)/e;
    join('',&anchor_label(&HTCweb_seclabel_from_no($no),$CURRENT_FILE,"<H2>$no. </H2>"),$_);
}

sub do_cmd_N {
    local($_) = @_;
    # skip depth
    s/$next_pair_rx//o;
    s/$next_pair_rx//o;
    local($no) = $2;
    # build title string and capitalize first letter
    $TITLE = "$HTCweb_chunkname $no";
    $TITLE =~ s/^(\w)/chr(ord($1)-32)/e;
    local($label) = &HTCweb_seclabel_from_no($no);
    # get the title and build the complete header.
    # Cweb limits its \N caption to the first dot
    s/^([^\.]*)\.//;
    local($head) = $1;
    $head =~ s/\n/ /g;
    local($dot) = ($HTCwebmode eq "hyweb" ? "." : "");
    join('',&anchor_label($label,$CURRENT_FILE,"<H1>$no. $head$dot</H1>"),$_);
}

#LASTM
#LIXM
#GLOSSARM

sub do_cmd_Q {
    local($_)=@_;

    # If raw digits follow the command, it's a cweave-like reference.
    # Get a list of numbers terminated by a dot and hyperize them.
    s/^([^\.]*)/&HTCweb_replace_refs($1)/e
	if /^\s*\d/;

   join('', $HTCweb_cite_string, ' ', $_);
}

sub do_cmd_Qs {
    local($_)=@_;

    # If raw digits follow the command, it's a cweave-like reference.
    # Get a list of numbers terminated by a dot and hyperize them.
    s/^([^\.]*)/&HTCweb_replace_refs($1)/e
	if /^\s*\d/;

   join('', $HTCweb_cites_string, ' ', $_);
}

sub do_cmd_R {
   join('','!', $_[0]);
}

sub do_cmd_T {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    local($value) = $2;
    # care of extras for constants
    # octal, hexadecimal trailer already handled by \oct, \hex
    # exponents
    $value =~ s/_/e/g;
    # next is subcripted suffix, could be <SUB> in some time
    $value =~ s/\$//g;
    join('',"<TT>$value</TT>",$_);
}

sub do_cmd_U {
    local($_)=@_;

    # If raw digits follow the command, it's a cweave-like reference.
    # Get a list of numbers terminated by a dot and hyperize them.
    s/^([^\.]*)/&HTCweb_replace_refs($1)/e
	if /^\s*\d/;

    join('', $HTCweb_use_string, ' ', $_);
}

sub do_cmd_Us {
    local($_)=@_;

    # If raw digits follow the command, it's a cweave-like reference.
    # Get a list of numbers terminated by a dot and hyperize them.
    s/^([^\.]*)/&HTCweb_replace_refs($1)/e
	if /^\s*\d/;

    join('', $HTCweb_uses_string, ' ', $_);
}

sub do_cmd_V {
   join('','||', $_[0]);
}

sub do_cmd_W {
   join('','&amp;&amp;', $_[0]);
}

sub do_cmd_Y {
   join('',"<P>", $_[0]);
}

sub do_cmd_Z {
   join('','&lt;=', $_[0]);
}

#ZZ?

sub do_cmd_secttag {
# section changed tag
    join('','*', $_[0]);
}

sub do_cmd_oct {
    join('','0', $_[0]);
}

sub do_cmd_hex {
    join('','0x', $_[0]);
}

sub do_cmd_vb{
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join(''," <TT>$2</TT> ",$_);
}

#... ?

sub do_cmd_HTCwebsmllspc {
   join('',' ', $_[0]);
}

# Backwards compatiblity
sub do_cmd_cio {
    local($indent) = $HTCweb_skip_indent . $HTCweb_cmode_indent;
    $HTCweb_cmode_indent = "";
    join('',"$indent<P>", $_[0]);
}

# Formerly do_cmd_cio
sub do_cmd_HTCwebpar {
    local($indent) = $HTCweb_skip_indent . $HTCweb_cmode_indent;
    $HTCweb_cmode_indent = "";
    join('',"$indent<P>", $_[0]);
}

sub do_cmd_noderef {
    local($_) = @_;
    local($id,$label);
    s/$next_pair_pr_rx/($id, $label) = ($1, $2);''/eo;
    s/$next_pair_pr_rx//o;
    join('',"<A HREF=$cross_ref_mark#$label#$id>$2<\/A>",$_);
}

sub do_cmd_HTCwebNodeRef {
    local($_) = @_;
    # get comma separated list of {<label>}{<no>} pairs
    s/$next_pair_pr_rx//o;
    # $id is not really needed yet, though it might look like that
    local($id,$labellist) = ($1,$2);
    # get first entry of list (it will contain at least one)
    local(@labellist) = split(", ",$labellist);
    local($labelpair) = shift @labellist;
    $labelpair =~ s/$next_pair_pr_rx//o;
    local($label) = $2;
    $labelpair =~ /$next_pair_pr_rx/;
    local($no) = $2;
    # get refinement name
    s/$next_pair_pr_rx//o;
    # wrap refinement name with anchor respective to first <label>, <no>
    local($out) = "<A HREF=$cross_ref_mark#$label#$id><B>$2</B></A> $no";
    foreach $labelpair (@labellist) {
	# this also affects @labellist, but don't care
	$labelpair =~ s/$next_pair_pr_rx//o;
	$label = $2;
	$labelpair =~ /$next_pair_pr_rx/;
	$out .= ", <A HREF=$cross_ref_mark#$label#$id>$2</A>";
    }
    join('',"&lt;",$out,"&gt;",$_);
}

sub do_env_HTCwebNodeRefExtEnv {
    local($_)=@_;
    s/$any_next_pair_rx//o;
    #get label text, and fold newlines
    local($text) = $2;
#    local($text)=substr($2,1); cut leading space
    $text =~ s/\n/ /g;
    if ($HTCweblabelnode{$text}) {
	print("\n+ \@<$text\@>");
	$_ = "&lt;<A HREF=$HTCweblabelpath{$text}/$HTCweblabelnode{$text}" .
	"#$HTCweblabelname{$text}><B>$text</B></A>" .
	" <CODE>$HTCweblabelfile{$text}.w</CODE> $HTCweblabelno{$text}&gt;";
    } else {
	print("\n- \@<$text\@>");
	$_ = "&lt;<A HREF=$cross_ref_mark#" . &HTCweb_seclabel_from_no("0") .
	    "#0><B>$text</B></A> 0&gt;";
    }
    $_;
}

# Read the cweave or hycweave produced list of identifiers, parse it,
# and produce hyperlinks between index references and text.
# This approach is preferred over passing the contents to LaTeX2HTML,
# because we had to redefine &do_cmd_I in this case.
#
# hycweave produces following format (perl-like regexp):
# HyIndex    ::= HyLine*
# HyLine     ::= \\I(IndexEntry), (NodeRef|\\[NodeRef])(, NodeRef|, \\[NodeRef])*.\n
# IndexEntry ::= String|\\\\\{String\}|\\\&\{String\}|\\\.\{String\}|\\\|\{String\}
# NodeRef    ::= \\noderef\{SecLabel\}\{SecNo\}
# SecLabel   ::= section_\d+
# SecNo      ::= \d+
#
# cweave produces following format (perl-like regexp):
# Index       ::= Line*
# Line        ::= \\I(IndexEntry), (SecNo|\\[SecNo])(, SecNo|, \\[SecNo])*.\n
#
# To get cweave indexes hyperlinked, we do some acrobatics to 'sensify' the SecNo's.
# Bugs:
#    If an index entry contains ", " -> breaks
#
sub do_cmd_inx {
    local($line,$list,$references);

    print("\nDoing the list of identifiers...\n");

    $HTCweb_loi_file = $CURRENT_FILE;
    &HTCweb_texinput("$FILE.idx");
    s/\%\n//g;		# Each line might be truncated with %, care of this first.
    &pre_process;	#care for special chars, verbatim, braces, etc.
    &substitute_meta_cmds;
#    &wrap_shorthand_environments; (wants to wrap \[ \])

    $list = "<H2>List of Identifiers</H2>\n$HTCwebIndexIntro<BR>\n<DL>\n";

    while (s/\\I.*//) {
	$line = $&;
	if ($line =~ /,\ /) {
	    $line = "$`:&nbsp;";
	    $references = $';

	    $line =~ s/\\I/<DD>/;
	    $line =~ s/\\_/_/g;
	    $line =~ s/\\\\$any_next_pair_rx/<I>$2<\/I>/;
	    #the next substitution takes knowledge of some l2h internal quirks. sorry.
	    $line =~ s/\\\\ $any_next_pair_rx/<I>$2<\/I>/;
	    $line =~ s/\\\&$any_next_pair_rx/<B>$2<\/B>/;
	    $line =~ s/\\\.$any_next_pair_rx/<TT>$2<\/TT>/;
	    $line =~ s/\\\|$any_next_pair_rx/<B> $2 <\/B>/;
	    $list .= $line;
	    $references =~ s/\\\[/<B><I>/g;
	    $references =~ s/\]/<\/I><\/B>/g;
	    if ($references =~ /noderef/) {
		# That's a dull way to determine if we have a hycweave generated index.
		# Alternatively we could look at \HTCwebmode.
		$references =~ s/\\noderef$any_next_pair_rx$any_next_pair_rx/
		    "<A HREF=$cross_ref_mark#$2#0>$4<\/A>"/geo;
	    } else {
		# cweave generated index
		$references =~ s/(\d+)/
		    "<A HREF=$cross_ref_mark#" . &HTCweb_seclabel_from_no($1) .
			"#0>$1<\/A>"/geo;
	    }
	    $list .= "$references\n";
	}
    }
    "$list</DL>\n";
}

sub do_cmd_fin {
    print("\nDoing the list of refinements...\n");

    $HTCweb_lor_file = $CURRENT_FILE;
    &HTCweb_texinput("$FILE.scn");
    s/\%\n//g;		# Each line might be truncated with %, care of this first.
    &pre_process;	#care for special chars, verbatim, braces, etc.
    &substitute_meta_cmds;
    &wrap_shorthand_environments;

    s/\\I/<DD>/g;
    s/\\\*/\*/g;
    $HTCweb_cite_string  = "Cited in ${HTCweb_chunkname}";
    $HTCweb_cites_string = "Cited in ${HTCweb_chunkname}";
    $HTCweb_use_string   = "Used in ${HTCweb_chunkname}";
    $HTCweb_uses_string  = "Used in ${HTCweb_chunkname}";

#    local($text);
#    $* = 1;		# Multiline matching ON
#    # bubble names may contain a newline
#
#    s/$match_br_rx\~\\HTCwebX/\000/g; # end marker
#    # the substitution here is pretty equal to &do_env_HTCwebNodeRefExtEnv
#    s/\\HTCwebX\~\\HTCwebNodeRefExt$O ([^\000]*)\000/$text = $1;
#    $text =~ s|\n| |g; $HTCweblabelnode{$text} ?
#	"&lt;<A HREF=$HTCweblabelpath{$text}\/$HTCweblabelnode{$text}" .
#	    "#$HTCweblabelname{$text}><B> $text<\/B><\/A>" .
#		" <CODE>$HTCweblabelfile{$text}.w<\/CODE> $HTCweblabelno{$text}&gt;" :
#		    "&lt;<A HREF=$cross_ref_mark#" . &HTCweb_seclabel_from_no("0") .
#			"#0><B> $text<\/B><\/A> 0&gt;"/geo;
#
#    s/$C\n/\000\n/g;
#    s/\\HTCwebNodeRef$O([^}]*)$C$O([^}]*)$C$O([^\000]*)\000/
#    "&lt;<A HREF=$cross_ref_mark#$1#0><B>$3<\/B><\/A> $2&gt;"/geo;
#$* = 0;			# Multiline matching OFF
#
#s/\\noderef$O([^}]*)$C$O([^}]*)$C/<A HREF=$cross_ref_mark#$1#0>$2<\/A>/go;

    "<H2>List of Refinements</H2>\n<DL>\n$_\n</DL>\n";
}

#
# Translation of Schrod's cweb.sty 'user' interface.
# Yet incomplete.
#
sub do_cmd_cwebIndexIntro {
    local($_)=@_;
    s/$next_pair_pr_rx//o;
    $HTCwebIndexIntro = $2;
    $_;
}

sub do_env_HTCweblabelsEnv {
    local($_)=@_;

    s/$any_next_pair_rx//o;
    local(@dvilabels) = split(/,/,$2);
    s/$any_next_pair_rx//o;
    local(@htmllabels) = split(/,/,$2);

    return("") unless ($#dvilabels == $#htmllabels);

    foreach $dvilabel (@dvilabels) {
	local($htmllabel) = $htmllabels[0];
	$dvilabel =~ s/\s//g;
	$htmllabel =~ s/\s//g;

	if ($dvilabel =~ /\S/ && $htmllabel =~ /\S/) {
	    local($filea,$fileb) = ("$dvilabel.lbl","$htmllabel/labels.pl");
	    local($founda,$foundb) = (0,0);

# env TEXINPUTS is expanded to .., etc. See deal_with_texinputs.
	    foreach $dir (split(/:/,$ENV{'TEXINPUTS'})) {
		if (-f ($_ = "$dir/$filea")) {
		    $filea = $_;
		    $founda++;
		    last;
		}
	    }
	    $founda = -f $filea unless $founda; #is it global?
	    unless ($founda) {
		print "No such label file <$filea> in TEXINPUTS or absolute\n";
		next;
	    }

	    foreach $dir (split(/:/,$ENV{'TEXINPUTS'})) {
		if (-f ($_ = "$dir/$fileb")) {
		    $fileb = $_;
		    $foundb++;
		    last;
		}
	    }
	    $foundb = -f $fileb unless $foundb; #is it global?
	    unless ($foundb) {
		print "No such label file <$fileb> in TEXINPUTS or absolute\n";
		next;
	    }

	    &HTCweb_readlabels($filea,$fileb);
	}
	shift(@htmllabels);
    }
    "";
}

sub HTCweb_readlabels {
    local(%string);
    local($dvilabels,$htmllabels,%htmllabels);
    local($_,$found,$key,$label,$file,$name,$no,$text);

    print "\nReading <$_[0]>..." if $DEBUG;
    open(INPUT,"<$_[0]");
    while (<INPUT>) {
	$string{'STRING'} .= $_;
    }
    $dvilabels = delete $string{'STRING'};

    print "\nReading <$_[1]>..." if $DEBUG;
    open(INPUT,"<$_[1]");
    while (<INPUT>) {
	$string{'STRING'} .= $_;
    }
    $htmllabels = delete $string{'STRING'};

    while ($dvilabels =~ s/^([^:]+):([^:]+):([^:]+):([^\n]+)\n[^\n]+\n//) {
	($file,$name,$no,$text) = ($1,$2,$3,$4);

	print "\nFound label: \@<$text\@>, file <$file>, name <$name>"
	    if $DEBUG;
	# the dummy package will make all assignments local
        %htmllabels = eval("package dummy; $htmllabels; \%external_labels");
	$found = 0;
	while (($key, $label) = each %htmllabels) {
	    if ($key eq $name) {
		$found = 1;
		print "\nMatch label: \@<$text\@>, extern label <$label>"
		    if $DEBUG;
		$HTCweblabelfile{$text} = $file;
		$HTCweblabelname{$text} = $name;
		$HTCweblabelno{$text} = $no;
		# get the last part of the URL without slashes
		$label =~ /([^\/]*)$/;
		$HTCweblabelnode{$text} = $1;
	    }
	}
	unless ($found) {
	    print"\nCorrupted label file $_[1]";
	    return;
	}
	if ($_[1] =~ /(.*)\//) {
	    $HTCweblabelpath{$text} = $1;
	} else {
	    $HTCweblabelpath{$text} = ".";
	}
    }
}

# This function hyperizes a Cweb generated list of section numbers.
#
sub HTCweb_replace_refs {
    local($_)=@_;

    s/(\d+)/"<A HREF=$cross_ref_mark#".&HTCweb_seclabel_from_no($1)."#0>$1<\/A>"/eg;
    $_;
}

# The next two functions reflect the mapping between section number
# and section label.
# It is very global so I put it into functions.
# See also ProcessCwebTex and htcweb.sty.
#
sub HTCweb_seclabel_from_no {
    local($no) = @_;

    "section_$no";
}

sub HTCweb_secno_from_label {
    local($_) = @_;

    s/section_//;
    $_;
}


# Reads the entire input file into a 
# single string. 
sub HTCweb_texinput  {
    local($file) = @_;
    local(%string,$dir);

    # search TeX's input list
    foreach $dir (split(/:/,$ENV{'TEXINPUTS'})) {
	if (-f "$dir/$file") {
	    $file = "$dir/$file";
	    last;
	}
    }
    open(INPUT,"<$file") || die "Could not open $file\n";
    while (<INPUT>) {
	$string{'STRING'} .= $_};
    $_ = delete $string{'STRING'}; # Blow it away and return the result

}


# Initializes the module by setting global variables.
#
sub HTCweb_initialize {
    # the mode might been preset by a wrapper
    $HTCwebmode = "cweb" unless $HTCwebmode;

    # This is inserted in place of \Q, \Qs, \U, \Us respectively.
    $HTCweb_chunkname = ($HTCwebmode eq "hyweb" ? "section" : "chunk" );
    $HTCweb_also_string  = "See also $HTCweb_chunkname";
    $HTCweb_alsos_string = "See also ${HTCweb_chunkname}s";
    $HTCweb_cite_string  = "This code is cited in $HTCweb_chunkname";
    $HTCweb_cites_string = "This code is cited in ${HTCweb_chunkname}s";
    $HTCweb_use_string   = "This code is used in $HTCweb_chunkname";
    $HTCweb_uses_string  = "This code is used in ${HTCweb_chunkname}s";

    # Will be expanded by <DL>'s when \4 or \8 occurs.
    $HTCweb_skip_indent = "";

    # Holds the </DL>'s necessary to close the cmode section.
    $HTCweb_cmode_indent = "";

    # Used to suppress <BR> if \1, \4 or \8 occurs.
    $HTCweb_cmode_break = "<BR>";

    # file name variable for final addition to navigation panel
    $HTCweb_loi_file = $HTCweb_lor_file = undef;

    # return state 'successful'
    1;
}


#
# Initialize module and return control to mother ship.
#
&HTCweb_initialize;

