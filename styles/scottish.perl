# $Id: scottish.perl,v 1.1 1998/08/25 01:59:08 RRM Exp $
#
# scottish.perl for scottish babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package scottish;

print " [scottish]";

sub main'scottish_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('scottish') };

sub scottish_titles {
    $toc_title = "Cl&agrave;r-obrach";
    $lof_title = "Liosta Dhealbh";
    $lot_title = "Liosta Chl&agrave;r";
    $idx_title = "Cl&agrave;r-innse";
    $ref_title = "Iomraidh";
    $bib_title = "Leabhraichean";
    $abs_title = "Br&igrave;gh";
    $app_title = "Ath-sgr&igrave;obhadh";
    $pre_title = "Preface"; # needs translation ?
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Dealbh";
    $tab_name = "Cl&agrave;r";
    $prf_name = "Proof"; # needs translation
    $page_name = "t.d.";
  #  Sectioning-level titles
    $part_name = "Cuid";
    $chapter_name = "Caibideil";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
    $child_name = "";
    $info_title = "";
    $also_name = "see also"; # needs translation
    $see_name = "see"; # needs translation
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "a-staigh";
    $headto_name = "gu";
    $cc_name = "lethbhreac gu";

    @Month = ('', 'am Faoilteach', 'an Gearran', 'am M&agrave;rt', 'an Giblean',
	'an C&egrave;itean', 'an t-&Ograve;g mhios', 'an t-Iuchar', 'L&ugrave;nasdal',
	'an Sultuine', 'an D&agrave;mhar', 'an t-Samhainn', 'an Dubhlachd');
#    $GENERIC_WORDS = "";
}


sub scottish_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&scottish_titles;
$default_language = 'scottish';
$TITLES_LANGUAGE = 'scottish';
$scottish_encoding = 'iso-8859-1';

# $Log: scottish.perl,v $
# Revision 1.1  1998/08/25 01:59:08  RRM
# 	Babel language support
#
#

1;
