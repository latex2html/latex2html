# $Id: esperant.perl,v 1.1 1998/08/25 03:26:37 RRM Exp $
#
# esperant.perl for esperant babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package esperant;

print " [esperant]";

sub main'esperant_translation {
    local($_) = @_;
s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\|)/&get_esperant_specials($1)/geo;
    $_;
}

sub get_esperant_specials {
    $esperant_specials{@_[0]}
}

%esperant_specials = (
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


package main;

if (defined &addto_languages) { &addto_languages('esperant') };

&do_require_extension('latin3');

sub esperant_titles {
    $toc_title = "Enhavo";
    $lof_title = "Listo de figuroj";
    $lot_title = "Listo de tabeloj";
    $idx_title = "Indekso";
    $ref_title = "Cita\\^joj";
    $bib_title = "Bibliografio";
    $abs_title = "Resumo";
    $app_title = "Apendico";
    $pre_title = "Anta&uuml;parolo";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Figuro";
    $tab_name = "Tabelo";
    $prf_name = "Pruvo";
    $page_name = "Pa\\^go";
  #  Sectioning-level titles
    $part_name = "Parto";
    $chapter_name = "\^Capitro";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
    $subj_name = "Temo";
##    $child_name = "";
##    $info_title = "";
    $also_name = "vidu anka&uuml;";
    $see_name = "vidu";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Aldono(j)";
    $headto_name = "Al";
    $cc_name = "Kopie al";

    @Month = ('', 'januaro', 'februaro', 'marto', 'aprilo', 'majo', 'junio',
	'julio', 'a&uuml;gusto', 'septembro', 'oktobro', 'novembro', 'decembro');
#    $GENERIC_WORDS = "";
}


sub esperant_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2\-a de $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&esperant_titles;
$default_language = 'esperant';
$TITLES_LANGUAGE = 'esperant';
$esperant_encoding = 'iso-8859-3';

# $Log: esperant.perl,v $
# Revision 1.1  1998/08/25 03:26:37  RRM
# 	Babel language support
#
#

1;
