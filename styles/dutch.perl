# $Id: dutch.perl,v 1.1 1998/08/25 02:11:24 RRM Exp $
#
# dutch.perl for dutch babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package dutch;

print " [dutch]";

sub main'dutch_translation {
    local($_) = @_;
    s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\|)/&get_dutch_specials($1)/geo;
    local($next_char_rx) = &make_next_char_rx("[aAeEiIoOuUyY]");
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

sub get_dutch_specials {
    $dutch_specials{@_[0]}
}

%dutch_specials = (
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
%dutch_specials = (
      ';SPMlt;', '<SMALL>;SPMlt;;SPMlt;</SMALL>'
    , ';SPMgt;', '<SMALL>&#62;&#62;</SMALL>'
    , %dutch_specials);
    } else {
%dutch_specials = (
      ';SPMlt;', ';SPMlt;;SPMlt;'
    , ';SPMgt;', '&#62;&#62;'
    , %dutch_specials);
    }
} else {
%dutch_specials = (
      ';SPMlt;', '&#171;'
    , ';SPMgt;', '&#187;'
    , %dutch_specials);
}


package main;

if (defined &addto_languages) { &addto_languages('dutch') };

sub do_dutch_afrikaan { &do_require_package('afrikaan') }
sub do_dutch_afrikaans { &do_require_package('afrikaan') }

sub dutch_titles {
    $toc_title = "Inhoudsopgave";
    $lof_title = "Lijst van figuren";
    $lot_title = "Lijst van tabellen";
    $idx_title = "Index";
    $ref_title = "Referenties";
    $bib_title = "Bibliografie";
    $abs_title = "Samenvatting";
    $app_title = "Bijlage";
    $pre_title = "Voorwoord";
    $foot_title = "Voetnoot";
    $thm_title = "Stelling";
    $fig_name = "Figuur";
    $tab_name = "Tabel";
    $prf_name = "Bewijs";
    $page_name = "Pagina";
  #  Sectioning-level titles
    $part_name = "Deel";
    $chapter_name = "Hoofdstuk";
    $section_name = "Sectie";
    $subsection_name = "Subsectie";
    $subsubsection_name = "Subsubsectie";
    $paragraph_name = "Paragraaf";
  #  Misc. strings
    $child_name = "Subsecties";
    $info_title = "Over dit dokument ...";
    $also_name = "zie ook";
    $see_name = "zie";
  #  names in navigation panels
    $next_name = "Volgende";
    $up_name = "Omhoog";
    $prev_name = "Vorige";
    $group_name = "groep";
  #  mail fields
    $encl_name = "Bijlage(n)";
    $headto_name = "Aan";
    $cc_name = "cc";

    @Month = ('', 'januari', 'februari', 'maart', 'april', 'mei', 'juni',
	'juli', 'augustus', 'september', 'oktober', 'november', 'december');
    $GENERIC_WORDS = "de|het|een|van|voor|door|in|uit|maar|of|dan|en|om|op|toe";
}


sub dutch_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&dutch_titles;
$default_language = 'dutch';
$TITLES_LANGUAGE = 'dutch';
$dutch_encoding = 'iso-8859-1';

# $Log: dutch.perl,v $
# Revision 1.1  1998/08/25 02:11:24  RRM
# 	Babel language support
#
#

1;
