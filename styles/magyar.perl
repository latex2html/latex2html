# $Id: magyar.perl,v 1.1 1998/08/25 01:59:04 RRM Exp $
#
# magyar.perl for magyar babel
# by Ross Moore <ross@mpce.mq.edu.au>


package magyar;

print " [magyar]";

sub main'magyar_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('magyar') };

&do_require_extension ('latin2');

sub magyar_titles {
    $toc_title = 'Tartalomjegyz&eacute;k';
    $lof_title = '&Aacute;br&aacute;k jegyz&eacute;ke';
    $lot_title = 'T&aacute;bl&aacute;zatok jegyz&eacute;ke';
    $idx_title = 'T&aacute;rgymutat&oacute;';
    $ref_title = 'Hivatkoz&aacute;sok';
    $bib_title = 'Irodalomjegyz&eacute;k';
    $abs_title = 'Kivonat';
    $app_title = 'F&uuml;ggel&eacute;k';
    $pre_title = 'El&odblac;sz&oacute;';
##    $foot_title = '';
##    $thm_title = '';
    $fig_name = '&Aacute;bra';
    $tab_name = 'T&aacute;bl&aacute;zat';
    $prf_name = 'Bizony&iacute;t&aacute;s';
    $page_name = 'oldal';
  #  Sectioning-level titles
    $part_name = 'R&eacute;sz';
    $chapter_name = 'Fejezet';
#    $section_name = '';
#    $subsection_name = '';
#    $subsubsection_name = '';
#    $paragraph_name = '';
  #  Misc. strings
##    $child_name = '';
##    $info_title = '';
    $also_name = 'L&aacute;sd m&eacute;g';
    $see_name = 'L&aacute;sd';
  #  names in navigation panels
##    $next_name = '';
##    $up_name = '';
##    $prev_name = '';
##    $group_name = '';
  #  mail fields
    $encl_name = 'Mell&eacute;klet";
    $headto_name = "C&iacute;mzett';
    $cc_name = 'K&ouml;rlev&eacute;l-c&iacute;mzettek';

    @Month = ('', 'janu&aacute;r', 'febru&aacute;r', 'm&aacute;rcius',
	'&aacute;prilis', 'm&aacute;jus', 'j&uacute;nius', 'j&uacute;lius',
	'augusztus', 'szeptember', 'okt&oacute;ber', 'november', 'december');
#    $GENERIC_WORDS = '';
}


sub magyar_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&magyar_titles;
$default_language = 'magyar';
$TITLES_LANGUAGE = 'magyar';
$magyar_encoding = 'iso-8859-2';

# $Log: magyar.perl,v $
# Revision 1.1  1998/08/25 01:59:04  RRM
# 	Babel language support
#
#

1;
