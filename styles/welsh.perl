# $Id: welsh.perl,v 1.1 1998/08/25 01:59:11 RRM Exp $
#
# welsh.perl for welsh babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package welsh;

print " [welsh]";

sub main'welsh_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('welsh') };

sub welsh_titles {
    $toc_title = "Cynnwys";
    $lof_title = "Rhestr Ddarluniau";
    $lot_title = "Rhestr Dablau";
    $idx_title = "Mynegai";
    $ref_title = "Cyfeiriadau";
    $bib_title = "Llyfryddiaeth";
    $abs_title = "Crynodeb";
    $app_title = "Atodiad";
    $pre_title = "Rhagair";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Darlun";
    $tab_name = "Taflen";
    $prf_name = "Prawf";
    $page_name = "tudalen";
  #  Sectioning-level titles
    $part_name = "Rhan";
    $chapter_name = "Pennod";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "gweler hefyd";
    $see_name = "gweler";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "amgae&euml;dig";
    $headto_name = "At";
    $cc_name = "cop&iuml; au";

    @Month = ('', 'Ionawr', 'Chwefror', 'Mawrth', 'Ebrill', 'Mai', 'Mehefin',
	'Gorffennaf', 'Awst', 'Medi', 'Hydref', 'Tachwedd', 'Rhagfyr');
#    $GENERIC_WORDS = "";
}


sub welsh_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&welsh_titles;
$default_language = 'welsh';
$TITLES_LANGUAGE = 'welsh';
$welsh_encoding = 'iso-8859-1';

# $Log: welsh.perl,v $
# Revision 1.1  1998/08/25 01:59:11  RRM
# 	Babel language support
#
#

1;
