# $Id: slovak.perl,v 1.1 1998/08/25 01:59:09 RRM Exp $
#
# slovak.perl for slovak babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package slovak;

print " [slovak]";

sub main'slovak_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('slovak') };

&do_require_extension ('latin2');

sub slovak_titles {
    $toc_title = "Obsah";
    $lof_title = "Zoznam obr&aacute;zkov";
    $lot_title = "Zoznam tabuliek";
    $idx_title = "Index";
    $ref_title = "Referencia";
    $bib_title = "Literat&uacute;ra";
    $abs_title = "Abstrakt";
    $app_title = "Dodatok";
    $pre_title = "&Uacute;vod";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Obr&aacute;zok";
    $tab_name = "Tabu&lcaron;ka";
    $prf_name = "Proof"; # needs translation
    $page_name = "Strana";
  #  Sectioning-level titles
    $part_name = "&Ccaron;as&tcaron;";
    $chapter_name = "Kapitola";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "vi&dcaron;d tie&zcaron;";
    $see_name = "vi&dcaron;d";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Pr&iacute;loha";
    $headto_name = "Komu";
    $cc_name = "CC";

    @Month = ('', 'janu&aacute;ra', 'febru&aacute;ra', 'marca', 'apr&iacute;la',
	'm&aacute;ja', 'j&uacute;na', 'j&uacute;la', 'augusat', 'septembra',
	'okt&oacute;bra', 'novembra', 'decembra');
#    $GENERIC_WORDS = "";
}


sub slovak_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&slovak_titles;
$default_language = 'slovak';
$TITLES_LANGUAGE = 'slovak';
$slovak_encoding = 'iso-8859-2';

# $Log: slovak.perl,v $
# Revision 1.1  1998/08/25 01:59:09  RRM
# 	Babel language support
#
#

1;
