# $Id: usorbian.perl,v 1.1 1998/08/25 01:59:10 RRM Exp $
#
# usorbian.perl for usorbian babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package usorbian;

print " [usorbian]";

&do_require_extension ('latin2');

sub main'usorbian_translation {
    local($_) = @_;
    s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\|)/&get_usorbian_specials($1)/geo;
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

sub get_usorbian_specials {
    $usorbian_specials{@_[0]}
}

%usorbian_specials = (
    '\''       => "``",
    "\`"       => ",,",
#    ';SPMlt;'  => "&laquo;",
#    ';SPMgt;'  => "&raquo;",
    '\\'       => "",
    '-'        => "-",
    ';SPMquot;'=> "",
    '='        => "-",
    '|'        => ""
);



if ($CHARSET =~ /iso_8859_2/) {
    if ($HTML_VERSION > 2.1) {
%usorbian_specials = (
      ';SPMlt;', '<SMALL>;SPMlt;;SPMlt;</SMALL>'
    , ';SPMgt;', '<SMALL>&#62;&#62;</SMALL>'
    , %usorbian_specials );
    } else {
%usorbian_specials = (
      ';SPMlt;', ';SPMlt;;SPMlt;'
    , ';SPMgt;', '&#62;&#62;'
    , %usorbian_specials );
    }
} else {
%usorbian_specials = (
      ';SPMlt;', '&#171;'
    , ';SPMgt;', '&#187;'
    , %usorbian_specials );
}


package main;

if (defined &addto_languages) { &addto_languages('usorbian') };

sub usorbian_titles {
    $toc_title = "Wobsah";
    $lof_title = "Zapis wobrazow";
    $lot_title = "Zapis tabulkow";
    $idx_title = "Indeks";
    $ref_title = "Referency";
    $bib_title = "Literatura";
    $abs_title = "Abstrakt";
    $app_title = "Dodawki";
    $pre_title = "Zawod";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Wobraz";
    $tab_name = "Tabulka";
    $prf_name = "Proof"; # needs translation
    $page_name = "Strona";
  #  Sectioning-level titles
    $part_name = "D&zacute;&ecaron;l";
    $chapter_name = "Kapitl";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "hl.te&zcaron;";
    $see_name = "hl.";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "P&rcaron;&lstrok;oha";
    $headto_name = "Komu";
    $cc_name = "CC";

    @Month = ('', 'januara', 'februara', 'm&ecaron;rca', 'apryla', 'meje', 'junija',
        'julija', 'awgusta', 'septembra', 'oktobra', 'nowembra', 'decembra');
#    $GENERIC_WORDS = "";
}


sub usorbian_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}


# MEH: Make iso_latin1_character_map_inv use more appropriate code
$iso_latin1_character_map_inv{'&#196;'} ='"A';
$iso_latin1_character_map_inv{'&#214;'} ='"O';
$iso_latin1_character_map_inv{'&#220;'} ='"U';
$iso_latin1_character_map_inv{'&#228;'} ='"a';
$iso_latin1_character_map_inv{'&#246;'} ='"o';
$iso_latin1_character_map_inv{'&#223;'} ='"s';
$iso_latin1_character_map_inv{'&#252;'} ='"u';


# use'em
&usorbian_titles;
$default_language = 'usorbian';
$TITLES_LANGUAGE = 'usorbian';
$usorbian_encoding = 'iso-8859-2';

# $Log: usorbian.perl,v $
# Revision 1.1  1998/08/25 01:59:10  RRM
# 	Babel language support
#
#

1;
