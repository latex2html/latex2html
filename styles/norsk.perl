# $Id: norsk.perl,v 1.1 1998/08/25 01:59:05 RRM Exp $
#
# norsk.perl for norsk babel
# by Ross Moore <ross@mpce.mq.edu.au>


package norsk;

print " [norsk]";

sub main'norsk_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('norsk') };

sub norsk_titles {
    $toc_title = "Innhold";
    $lof_title = "Figurer";
    $lot_title = "Tabeller";
    $idx_title = "Register";
    $ref_title = "Referanser";
    $bib_title = "Bibliografi";
    $abs_title = "Sammendrag";
    $app_title = "Tillegg";
    $pre_title = "Forord";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Figur";
    $tab_name = "Tabell";
    $prf_name = "Bevis";
    $page_name = "Side";
  #  Sectioning-level titles
    $part_name = "Del";
    $chapter_name = "Kapittel";
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
    $encl_name = "Vedlegg";
    $headto_name = "Til";
    $cc_name = "Kopi sendt";

    @Month = ('', 'januar', 'februar', 'mars', 'april', 'mai', 'juni',
	'juli', 'august', 'september', 'oktober', 'november', 'desember');

#    $GENERIC_WORDS = "";
}


sub norsk_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&norsk_titles;
$default_language = 'norsk';
$TITLES_LANGUAGE = 'norsk';
$norsk_encoding = 'iso-8859-1';

# $Log: norsk.perl,v $
# Revision 1.1  1998/08/25 01:59:05  RRM
# 	Babel language support
#
#

1;
