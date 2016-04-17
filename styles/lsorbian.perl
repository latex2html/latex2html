# $Id: lsorbian.perl,v 1.1 1998/08/25 01:59:03 RRM Exp $
#
# lsorbian.perl for lsorbian babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package lsorbian;

print " [lsorbian]";

sub main'lsorbian_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('lsorbian') };

&do_require_extension('latin2');

sub lsorbian_titles {
    $toc_title = "Wop&sacute;imje&sacute;e";
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
    $part_name = "&Zacute;&ecaron;l";
    $chapter_name = "Kapitl";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "gl.teke";
    $see_name = "gl.";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "P&sacute;i&lstrok;oga";
    $headto_name = "Komu";
    $cc_name = "CC";

    @Month = ('', 'januara', 'februara', 'm&ecaron;rca', 'apryla', 'maja', 'junija',
	'julija', 'awgusta', 'septembra', 'oktobra', 'nowembra', 'decembra');
#    $GENERIC_WORDS = "";
}


sub lsorbian_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&lsorbian_titles;
$default_language = 'lsorbian';
$TITLES_LANGUAGE = 'lsorbian';
$lsorbian_encoding = 'iso-8859-2';

# $Log: lsorbian.perl,v $
# Revision 1.1  1998/08/25 01:59:03  RRM
# 	Babel language support
#
#

1;
