# $Id: afrikaan.perl,v 1.1 1998/08/25 02:11:17 RRM Exp $
#
# afrikaan.perl for afrikaan babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package afrikaans;

print " [afrikaans]";

sub main'afrikaans_translation {
    local($_) = @_;
    s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\|)/&get_afrikaans_specials($1)/geo;
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

sub get_afrikaans_specials {
    $afrikaans_specials{@_[0]}
}

%afrikaans_specials = (
    '\''       => "``",
    "\`"       => ",,",
    ';SPMlt;'  => "&laquo;",
    ';SPMgt;'  => "&raquo;",
    '\\'       => "",
    '-'        => "-",
    ';SPMquot;'=> "",
    '='        => "-",
    '|'        => ""
);

if ($CHARSET =~ /iso_8859_2/) {
    if ($HTML_VERSION > 2.1) {
%afrikaans_specials = (
      ';SPMlt;', '<SMALL>;SPMlt;;SPMlt;</SMALL>'
    , ';SPMgt;', '<SMALL>&#62;&#62;</SMALL>'
    , %afrikaans);
    } else {
%afrikaans_specials = (
      ';SPMlt;', ';SPMlt;;SPMlt;'
    , ';SPMgt;', '&#62;&#62;'
    , %afrikaans_specials);
    }
} else {
%afrikaans_specials = (
      ';SPMlt;', '&#171;'
    , ';SPMgt;', '&#187;'
    , %afrikaans_specials);
}


package main;

if (defined &addto_languages) { &addto_languages('afrikaans') };

sub afrikaans_titles {
    $toc_title = "Inhoudsopgawe";
    $lof_title = "Lys van figure";
    $lot_title = "Lys van tabelle";
    $idx_title = "Inhoud";
    $ref_title = "Verwysings";
    $bib_title = "Bibliografie";
    $abs_title = "Samenvatting";
    $app_title = "Bylae";
    $pre_title = "Voorwoord";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Figuur";
    $tab_name = "Tabel";
    $prf_name = "Bewys";
    $page_name = "Bladsy";
  #  Sectioning-level titles
    $part_name = "Deel";
    $chapter_name = "Hoofstuk";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "sien ook";
    $see_name = "sien";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Bylae(n)";
    $headto_name = "Aan";
    $cc_name = "a.a.";
    @Month = ('', 'Januarie', 'Februarie', 'Maart', 'April', 'Mei', 'Junie',
	'Julie', 'Augustus', 'September', 'Oktober', 'November', 'Desember');
#    $GENERIC_WORDS = "";
}


sub afrikaans_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&afrikaans_titles;
$default_language = 'afrikaans';
$TITLES_LANGUAGE = 'afrikaans';
$afrikaans_encoding = 'iso-8859-1';

# $Log: afrikaan.perl,v $
# Revision 1.1  1998/08/25 02:11:17  RRM
# 	Babel language support
#
#

1;
