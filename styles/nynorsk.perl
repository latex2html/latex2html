# $Id: nynorsk.perl,v 1.1 1998/08/25 01:59:05 RRM Exp $
#
# nynorsk.perl for nynorsk babel
# by Ross Moore <ross@mpce.mq.edu.au>


package nynorsk;

print " [nynorsk]";

sub main'nynorsk_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('nynorsk') };

sub nynorsk_titles {
    $toc_title = "Innhald";
    $lof_title = "Figurar";
    $lot_title = "Tabellar";
    $idx_title = "Register";
    $ref_title = "Referansar";
    $bib_title = "Litteratur";
    $abs_title = "Samandrag";
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
    $also_name = "Sj&aring; ogs&aring;";
    $see_name = "Sj&aring;";
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


sub nynorsk_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&nynorsk_titles;
$default_language = 'nynorsk';
$TITLES_LANGUAGE = 'nynorsk';
$nynorsk_encoding = 'iso-8859-1';

# $Log: nynorsk.perl,v $
# Revision 1.1  1998/08/25 01:59:05  RRM
# 	Babel language support
#
#

1;
