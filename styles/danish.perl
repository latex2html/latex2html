# $Id: danish.perl,v 1.1 1998/08/25 02:11:24 RRM Exp $
#
# danish.perl for danish babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package danish;

print " [danish]";

sub main'danish_translation {
    local($_) = @_;
    s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\||~)/&get_danish_specials($1)/geo;
    local($next_char_rx) = &make_next_char_rx("[aAeEiIoOuU]");
    s/$next_char_rx/&main'iso_map(($2||$3),"uml")/geo;
    $next_char_rx = &make_next_char_rx("[sz]");
    s/$next_char_rx/&main'iso_map("sz","lig")/geo;
    $next_char_rx = &make_next_char_rx("[SZ]"); s/$next_char_rx/S$2/go;
    s/;SPMquot;\s*([cflmnprt])/\1/go;
    s/;SPMquot;/&#34;/go;
    $_;
}

sub make_next_char_rx {
    local($chars) = @_;
    local($OP,$CP) = &main'brackets;
    ";SPMquot;\\s*(($chars)|$OP\\d+$CP\\s*($chars)\\s*$OP\\d+$CP)";
}

sub get_danish_specials {
    $danish_specials{@_[0]}
}

%danish_specials = (
    '\''       => "``",
    "\`"       => ",,",
    ';SPMlt;'  => "&laquo;",
    ';SPMgt;'  => "&raquo;",
    '\\'       => "",
    '-'        => "-",
    ';SPMquot;'=> "",
    '='        => "-",
    '|'        => "" ,
    '~'        => "-"
);

if ($CHARSET =~ /iso_8859_2/) {
    if ($HTML_VERSION > 2.1) {
%danish_specials = (
      ';SPMlt;', '<SMALL>;SPMlt;;SPMlt;</SMALL>'
    , ';SPMgt;', '<SMALL>&#62;&#62;</SMALL>'
    , %danish_specials);
    } else {
%danish_specials = (
      ';SPMlt;', ';SPMlt;;SPMlt;'
    , ';SPMgt;', '&#62;&#62;'
    , %danish_specials);
    }
} else {
%danish_specials = (
      ';SPMlt;', '&#171;'
    , ';SPMgt;', '&#187;'
    , %danish_specials);
}


package main;

if (defined &addto_languages) { &addto_languages('danish') };

sub danish_titles {
    $toc_title = "Indhold";
    $lof_title = "Figurer";
    $lot_title = "Tabeller";
    $idx_title = "Indeks";
    $ref_title = "Litteratur";
    $bib_title = "Litteratur";
    $abs_title = "Resum&eacute;";
    $app_title = "Bilag";
    $pre_title = "Forord";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Figur";
    $tab_name = "Tabel";
    $prf_name = "Bevis";
    $page_name = "Side";
  #  Sectioning-level titles
    $part_name = "Del";
    $chapter_name = "Kapitel";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "Se ogs&aring;";
    $see_name = "Se";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Vedlagt";
    $headto_name = "Til";
    $cc_name = "Kopi til";

    @Month = ('', 'januar', 'februar', 'marts', 'april', 'maj', 'juni',
	'juli', 'august', 'september', 'oktober', 'november', 'december');
#    $GENERIC_WORDS = "";
}


sub danish_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&danish_titles;
$default_language = 'danish';
$TITLES_LANGUAGE = 'danish';
$danish_encoding = 'iso-8859-1';

# $Log: danish.perl,v $
# Revision 1.1  1998/08/25 02:11:24  RRM
# 	Babel language support
#
#

1;
