# $Id: slovene.perl,v 1.2 2002/04/17 23:43:24 RRM Exp $
#
# slovene.perl for slovene babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package slovene;

print " [slovene]";

sub main'slovene_translation {
    local($_) = @_;
    s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\|)/&get_slovene_specials($1)/geo;
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

sub get_slovene_specials {
    $slovene_specials{@_[0]}
}

%slovene_specials = (
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
%slovene_specials = (
      ';SPMlt;', '<SMALL>;SPMlt;;SPMlt;</SMALL>'
    , ';SPMgt;', '<SMALL>&#62;&#62;</SMALL>'
    , %slovene_specials);
    } else {
%slovene_specials = (
      ';SPMlt;', ';SPMlt;;SPMlt;'
    , ';SPMgt;', '&#62;&#62;'
    , %slovene_specials);
    }
} else {
%slovene_specials = (
      ';SPMlt;', '&#171;'
    , ';SPMgt;', '&#187;'
    , %slovene_specials);
}


package main;

if (defined &addto_languages) { &addto_languages('slovene') };

sub slovene_titles {
    $toc_title = "Kazalo";
    $lof_title = "Slike";
    $lot_title = "Tabele";
    $idx_title = "Stvarno kazalo";
    $ref_title = "Literatura";
    $bib_title = "Literatura";
    $abs_title = "Povzetek";
    $app_title = "Dodatek";
    $pre_title = "Predgovor";
    $foot_title = "Opombe v nogi";
    $thm_title = "Izrek";
    $fig_name = "Slika";
    $tab_name = "Tabela";
    $prf_name = "Dokaz";
    $page_name = "Stran";
  #  Sectioning-level titles
    $part_name = "Del";
    $chapter_name = "Poglavje";
    $section_name = "Razdelek";
    $subsection_name = "Podrazdelek";
    $subsubsection_name = "Podpodrazdelek";
    $paragraph_name = "Odstavek";
  #  Misc. strings
    $child_name = "Podrazdelki";
    $info_title = "O tem dokumentu ...";
    $also_name = "glej tudi";
    $see_name = "glej";
  #  names in navigation panels
    $next_name = "Naprej";
    $up_name = "Navzgor";
    $prev_name = "Nazaj";
    $group_name = "skupina";
  #  mail fields
    $encl_name = "Priloge";
    $headto_name = "Prejme";
    $cc_name = "Kopije";

    @Month = ('', 'januar', 'februar', 'marec', 'april', 'maj', 'junij',
	'julij', 'avgust', 'september', 'oktober', 'november', 'december');
#    $GENERIC_WORDS = "";
}


sub slovene_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&slovene_titles;
$default_language = 'slovene';
$TITLES_LANGUAGE = 'slovene';
$slovene_encoding = 'iso-8859-2';

# $Log: slovene.perl,v $
# Revision 1.2  2002/04/17 23:43:24  RRM
#  --  provides missing words and phrases, and correct charset
#      thanks to  Roman Maurer <roman@shark.amis.net>  for these.
#
# Revision 1.1  1998/08/25 01:59:09  RRM
# 	Babel language support
#
#

1;
