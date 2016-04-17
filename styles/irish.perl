# $Id: irish.perl,v 1.1 1998/08/25 01:59:02 RRM Exp $
#
# irish.perl for irish babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package irish;

print " [irish]";

sub main'irish_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('irish') };

sub irish_titles {
    $toc_title = "Cl&aacute;r &Aacute;bhair";
    $lof_title = "L&eacute;ar&aacute;id&iacute;";
    $lot_title = "T&aacute;bla&iacute;";
    $idx_title = "Inn&eacute;acs";
    $ref_title = "Tagairt&iacute;";
    $bib_title = "Leabharliosta";
    $abs_title = "Achoimre";
    $app_title = "Aguis&iacute;n";
    $pre_title = "Preface"; # needs translation
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "L&eacute;ar&aacute;id";
    $tab_name = "T&aacute;bla";
    $prf_name = "Proof"; # needs translation
    $page_name = "Leathanach";
  #  Sectioning-level titles
    $part_name = "Cuid";
    $chapter_name = "Caibidil";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "see also"; # needs translation
    $see_name = "see"; # needs translation 
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "faoi iamh";
    $headto_name = "Go";
    $cc_name = "cc"; # abbrev. for  'c&oacute;ip chuig'

    @Month = ('', 'Ean&aacute;ir', 'Feabhra', 'M&aacute;rta', 'Aibre&aacute;n',
	'Bealtaine', 'Meitheamh', 'I&uacute;il', 'L&uacute;nasa',
	'Me&aacute;n F&oacute;mhair', 'Deireadh F&oacute;mhair',
	'M&iacute; na Samhna', 'M&iacute; na Nollag');
#    $GENERIC_WORDS = "";
}


sub irish_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&irish_titles;
$default_language = 'irish';
$TITLES_LANGUAGE = 'irish';
$irish_encoding = 'iso-8859-1';

# $Log: irish.perl,v $
# Revision 1.1  1998/08/25 01:59:02  RRM
# 	Babel language support
#
#

1;
