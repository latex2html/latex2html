# $Id: polski.perl,v 1.1 1999/07/12 13:12:32 RRM Exp $
#
# polski.perl for support of polski.sty, similar to polish babel
# by Ross Moore <ross@mpce.mq.edu.au>


package polski;

sub main'polski_translation {
    local($_) = @_;
    s/(^|\G|[^\\<]|[^\\](\\\\)+)\/\s*('|`|;SPMlt;|;SPMgt;|\\|-|\/|=|\||[aelxcnoszAELXCNOSZ])/
	$1.&get_polski_specials($3)/geom;
    $_;
}

sub get_polski_specials {
    local($char) = @_;
    if($char=~/[ae]/i) {&main'iso_map($char,'ogon')}
    elsif($char=~/[lL]/) {&main'iso_map($char,'strok')}
    elsif($char=~/x/) {&main'iso_map('z','dot')}
    elsif($char=~/X/) {&main'iso_map('Z','dot')}
    elsif($char=~/[cnosz]/i) {&main'iso_map($char,'acute')}
    else{$polski_specials{$char}}
}

%polski_specials = (
    '\''       => "``",
    "\`"       => ",,",
    ';SPMlt;'  => "&laquo;",
    ';SPMgt;'  => "&raquo;",
    '\\'       => "",
    '-'        => "-",
    '/'        => "",
    '='        => "-",
    '|'        => ""
);


package main;

if (defined &addto_languages) { &addto_languages('polski') };

&do_require_extension('latin2');

sub polski_titles {
#    $toc_title = "Spis rzeczy";
    $toc_title = "Spis tre\\'sci";
    $lof_title = "Spis rysunk\\'ow";
#    $lot_title = "Spis tablic";
    $lot_title = "Spis tabel";
#    $idx_title = "Indeks";
    $idx_title = "Skorowidz";
    $ref_title = "Bibliografia";
#    $bib_title = "Literatura";
    $bib_title = "Spis Literatury";
    $abs_title = "Streszczenie";
    $app_title = "Dodatek";
    $pre_title = "Przedmowa";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Rysunek";
#    $tab_name = "Tablica";
    $tab_name = "Tabela";
##    $prf_name = "";
    $page_name = "Strona";
  #  Sectioning-level titles
    $part_name = "Cz&eogon;&sacute;&cacute;";
    $chapter_name = "Rozdzia&lstrok;";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "Por\\'ownaj tak&zdot;e";
    $see_name = "Por\\'ownaj";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Za&lstrok;&aogon;cznik";
    $headto_name = "Do";
#    $cc_name = "Kopie:";
    $cc_name = "Do wiadomo\\'sci:";

    @Month = ('', 'stycznia', 'lutego', 'marca', 'kwietnia', 'maja', 'czerwca', 'lipca',
	'sierpnia', "wrze&sacute;nia", "pa&zacute;dziernika", 'listopada', 'grudnia');

#    $GENERIC_WORDS = "";
}


sub polski_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today, ' roku', $_[0]);
}

sub do_cmd_Slash { '/'.$_[0] }
sub do_cmd_PLSlash {
    local($_) = @_;
    s/^\s*('|`|;SPMlt;|;SPMgt;|\\|-|\/|=|\||[aelxcnoszAELXCNOSZ])/
	&get_polski_specials($1)/eos;
    $_;
}

sub do_cmd_prefixing {
    local($_) = @_;
    my $end_polski;
    $latex_body .= "\n\\prefixing\n";
    s/^(.*?)(\\nonprefixing|$)/$end_polski=$2;
	&polski_translation($1).$end_polski/es;
    $_;
}

sub do_cmd_nonprefixing { $latex_body .= "\n\\nonprefixing\n"; $_[0]}


# redefined math-commands, in case math.pl has been loaded

sub do_math_cmd_ar {
    local($_) = @_; my $arg;
    my $arg = &get_next_token();
    if ($NO_SIMPLE_MATH) { " ar$arg".$_ }
    else {"(<T CLASS=\"FUNCTION\">ar$arg</T>$_"}
}

sub do_math_cmd_arc {
    local($_) = @_; my $arg;
    my $arg = &get_next_token();
    if ($NO_SIMPLE_MATH) { " arc$arg".$_ }
    else {"(<T CLASS=\"FUNCTION\">arc$arg</T>$_"}
}

sub do_math_cmd_tg {
    if ($NO_SIMPLE_MATH) { ' tg'.$_ }
    else {'<T CLASS="FUNCTION">tg</T>'.$_[0]}
}
sub do_math_cmd_ctg {
    if ($NO_SIMPLE_MATH) { ' ctg'.$_[0] }
    else {'<T CLASS="FUNCTION">ctg</T>'.$_[0]}
}
sub do_math_cmd_tgh {
    if ($NO_SIMPLE_MATH) { ' tgh'.$_[0] }
    else {'<T CLASS="FUNCTION">tgh</T>'.$_[0]}
}
sub do_math_cmd_ctgh {
    if ($NO_SIMPLE_MATH) { ' ctgh'.$_ }
    else {'<T CLASS="FUNCTION">ctgh</T>'.$_[0]}
}

sub do_math_cmd_tan { &do_math_cmd_tg(@_) }
sub do_math_cmd_tanh{ &do_math_cmd_tgh(@_)}
sub do_math_cmd_arcsin { &do_math_cmd_arc('<<0>>sin<<0>>').$_[0] }
sub do_math_cmd_arccos { &do_math_cmd_arc('<<0>>cos<<0>>').$_[0] }
sub do_math_cmd_arctan { &do_math_cmd_arc('<<0>>tg<<0>>' ).$_[0] }
sub do_math_cmd_arcctan{ &do_math_cmd_arc('<<0>>ctg<<0>>').$_[0] }



&process_commands_wrap_deferred( <<_RAW_ARG_CMDS_);
#prefixing
#nonprefixing
_RAW_ARG_CMDS_


# use'em
&polski_titles;
$default_language = 'polski';
$TITLES_LANGUAGE = 'polski';
$polski_encoding = 'iso-8859-2';

# $Log: polski.perl,v $
# Revision 1.1  1999/07/12 13:12:32  RRM
# 	implements  polski.sty  for Polish language support
#
#  --  similar to  polish.perl  (based on Babel)
#  --  uses / instead of " for special accents...
#  --    ...between \prefixing  and  \nonprefixing or till end of document
#  --  also implements \Slash and \PLSlash
#  --  implements the Polish style of trig-function names
#
#

1;
