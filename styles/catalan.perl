# $Id: catalan.perl,v 1.1 1998/08/25 02:11:21 RRM Exp $
#
# catalan.perl for catalan babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package catalan;

print " [catalan]";

sub main'catalan_translation {
    local($_) = @_;
s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\|)/&get_catalan_specials($1)/geo;
    $_;
}

sub get_catalan_specials {
    $catalan_specials{@_[0]}
}

%catalan_specials = (
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

if (defined &addto_languages) { &addto_languages('catalan') };

sub catalan_titles {
    $toc_title = "\\'Index";
    $lof_title = "\\'Index de figures";
    $lot_title = "\\'Index de taules";
    $idx_title = "\\'Index alfab\\`etic";
    $ref_title = "Refer\\`encies";
    $bib_title = "Bibliografia";
    $abs_title = "Resum";
    $app_title = "Ap\\`endix";
    $pre_title = "Pr\\`oleg";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Figura";
    $tab_name = "Taula";
    $prf_name = "Demostraci\\'o";
    $page_name = "P\\`agina";
  #  Sectioning-level titles
    $part_name = "Part";
    $chapter_name = "Cap\\'itol";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "Vegeu tamb\\'e";
    $see_name = "Vegeu";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Adjunt";
    $headto_name = "A";
    $cc_name = "C\\`opies a";

    @Month = ('', 'de gener', 'de febrer', 'de mar&ccedil;', "d'abril", 'de maig',
	'de juny', 'de juliol', "d'agost", 'de setembre', "d'octubre",
	'de novembre', 'de desembre');

#    $GENERIC_WORDS = "";
}


sub catalan_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&catalan_titles;
$default_language = 'catalan';
$TITLES_LANGUAGE = 'catalan';
$catalan_encoding = 'iso-8859-1';

# $Log: catalan.perl,v $
# Revision 1.1  1998/08/25 02:11:21  RRM
# 	Babel language support
#
#

1;
