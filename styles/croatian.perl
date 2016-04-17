# $Id: croatian.perl,v 1.1 1998/08/25 02:11:22 RRM Exp $
#
# croatian.perl for croatian babel
# by Ross Moore <ross@mpce.mq.edu.au>


package croatian;

print " [croatian]";

sub main'croatian_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('croatian') };

&do_require_extension('latin2');

sub croatian_titles {
    $toc_title = "Sadr&zcaron;aj";
    $lof_title = "Slike";
    $lot_title = "Tablice";
    $idx_title = "Indeks";
    $ref_title = "Literatura";
    $bib_title = "Bibliografija";
    $abs_title = "Sa&zcaron;etak";
    $app_title = "Dodatak";
    $pre_title = "Predgovor";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Slika";
    $tab_name = "Tablica";
    $prf_name = "Dokaz";
    $page_name = "Strana";
  #  Sectioning-level titles
    $part_name = "Dio";
    $chapter_name = "";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "Vidi tako&dstrok;er";
    $see_name = "Vidi";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Prilozi";
    $headto_name = "Prima";
    $cc_name = "Kopije";

    @Month = ('', 'sije&ccaron;nja', 'velja&ccaron;e', 'o&zcaron;ujka', 'travnja', 'svibnja',
	'lipnja', 'srpnja', 'kolovoza', 'rujna', 'listopada', 'studenog', 'prosinca');
#    $GENERIC_WORDS = "";
}


sub croatian_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&croatian_titles;
$default_language = 'croatian';
$TITLES_LANGUAGE = 'croatian';
$croatian_encoding = 'iso-8859-2';

# $Log: croatian.perl,v $
# Revision 1.1  1998/08/25 02:11:22  RRM
# 	Babel language support
#
#

1;
