# $Id: galician.perl,v 1.1 1998/08/25 01:59:01 RRM Exp $
#
# galician.perl for galician babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package galician;

print " [galician]";

sub main'galician_translation {
    local($_) = @_;
s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\|)/&get_galician_specials($1)/geo;
    $_;
}

sub get_galician_specials {
    $galician_specials{@_[0]}
}

%galician_specials = (
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

if (defined &addto_languages) { &addto_languages('galician') };

sub galician_titles {
    $toc_title = "\\'Indice Xeral";
    $lof_title = "\\'Indice de Figuras";
    $lot_title = "\\'Indice de T\\'aboas";
    $idx_title = "\\'Indice de Materias";
    $ref_title = "Referencias";
    $bib_title = "Bibliograf\\'ia";
    $abs_title = "Resumo";
    $app_title = "Ap\\'endice";
    $pre_title = "Prefacio";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Figura";
    $tab_name = "T\\'aboa";
##    $prf_name = "Proof";
    $page_name = "P\\'axina";
  #  Sectioning-level titles
    $part_name = "Parte";
    $chapter_name = "Cap\\'itulo";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "v\\'exase tam\\'en";
    $see_name = "v\\'exase";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Adxunto";
    $headto_name = "A";
    $cc_name = "Copia a";

    @Month = ('', 'xaneiro', 'febreiro', 'marzo', 'abril', 'maio', 'xu\~no',
	'xullo', 'agosto', 'setembro', 'outubro', 'novembro', 'decembro');

#    $GENERIC_WORDS = "";
}


sub galician_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&galician_titles;
$default_language = 'galician';
$TITLES_LANGUAGE = 'galician';
$galician_encoding = 'iso-8859-1';

# $Log: galician.perl,v $
# Revision 1.1  1998/08/25 01:59:01  RRM
# 	Babel language support
#
#

1;
