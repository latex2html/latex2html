# $Id: TEMPLATE.perl,v 1.1 1998/08/25 02:11:17 RRM Exp $
#
# TEMPLATE.perl for TEMPLATE babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package TEMPLATE;

print " [TEMPLATE]";

sub main'TEMPLATE_translation {
    local($_) = @_;
s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\|)/&get_TEMPLATE_specials($1)/geo;
    $_;
}

sub get_TEMPLATE_specials {
    $TEMPLATE_specials{@_[0]}
}

%TEMPLATE_specials = (
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

if (defined &addto_languages) { &addto_languages('TEMPLATE') };

sub TEMPLATE_titles {
    $toc_title = "";
    $lof_title = "";
    $lot_title = "";
    $idx_title = "";
    $ref_title = "";
    $bib_title = "";
    $abs_title = "";
    $app_title = "";
    $pre_title = "";
    $foot_title = "";
    $thm_title = "";
    $fig_name = "";
    $tab_name = "";
    $prf_name = "";
    $date_name = "";
    $page_name = "";
  #  Sectioning-level titles
    $part_name = "";
    $chapter_name = "";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
    $child_name = "";
    $info_title = "";
    $also_name = "";
    $see_name = "";
  #  names in navigation panels
    $next_name = "";
    $up_name = "";
    $prev_name = "";
    $group_name = "";
  #  mail fields
    $encl_name = "";
    $headto_name = "";
    $cc_name = "";
    @Month = ('', 'tammikuuta', 'helmikuuta', 'maaliskuuta', 'huhtikuuta',
              'toukokuuta', 'kes”&auml;kuuta', 'hein”&auml;kuuta', 'elokuuta',
              'syyskuuta', 'lokakuuta', 'marraskuuta', 'joulukuuta');
#    $GENERIC_WORDS = "";
}


sub TEMPLATE_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&TEMPLATE_titles;
$default_language = 'TEMPLATE';
$TITLES_LANGUAGE = 'TEMPLATE';
$TEMPLATE_encoding = 'iso-8859-1';

# $Log: TEMPLATE.perl,v $
# Revision 1.1  1998/08/25 02:11:17  RRM
# 	Babel language support
#
#

1;
