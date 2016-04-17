# $Id: breton.perl,v 1.1 1998/08/25 02:11:21 RRM Exp $
#
# breton.perl for breton babel
# by Ross Moore <ross@mpce.mq.edu.au>


package breton;

print " [breton]";

sub main'breton_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('breton') };

sub breton_titles {
    $toc_title = "Taolenn";
    $lof_title = "Listenn ar Figurenno&ugrave;";
    $lot_title = "Listenn an taolenno&ugrave;";
    $idx_title = "Meneger";
    $ref_title = "Daveenno&ugrave;";
    $bib_title = "Lennadurezh";
    $abs_title = "Dvierra&ntilde;";
    $app_title = "Stagadenn";
    $pre_title = "Rakskrid";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Figurenn";
    $tab_name = "Taolenn";
    $prf_name = "Proof"; # translation needed ?
    $page_name = "Pajenn";
  #  Sectioning-level titles
    $part_name = "Lodenn";
    $chapter_name = "Pennad";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "Gwelout ivez";
    $see_name = "Gwelout";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Diello&ugrave; kevret";
    $headto_name = "evit";
    $cc_name = "Eilskrid da";

    @Month = ('', 'Genver', "C'hwevrer", 'Meurzh', 'Ebrel', 'Mae', 'Mezheven',
	'Gouere', 'Eost', 'Gwengolo', 'Here', 'Du', 'Kerzu');
#    $GENERIC_WORDS = "";
}


sub breton_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&breton_titles;
$default_language = 'breton';
$TITLES_LANGUAGE = 'breton';
$breton_encoding = 'iso-8859-1';

# $Log: breton.perl,v $
# Revision 1.1  1998/08/25 02:11:21  RRM
# 	Babel language support
#
#

1;
