# $Id: romanian.perl,v 1.1 1998/08/25 01:59:07 RRM Exp $
#
# romanian.perl for romanian babel
# by Ross Moore <ross@mpce.mq.edu.au>


package romanian;

print " [romanian]";

sub main'romanian_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('romanian') };

&do_require_extension ('latin10');

sub romanian_titles {
    $toc_title = "Cuprins";
    $lof_title = "List&#103; de figuri";
    $lot_title = "List&#103; de tabele";
    $idx_title = "Glosar";
    $ref_title = "Bibliografie";
    $bib_title = "Bibliografie";
    $abs_title = "Rezumat";
    $app_title = "Anexa";
    $pre_title = "Prefa&#21B;&#103;";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Figura";
    $tab_name = "Tabela";
    $prf_name = "Demonstra&#21B;ie";
    $page_name = "Pagina";
  #  Sectioning-level titles
    $part_name = "Partea";
    $chapter_name = "Capitolul";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "Vezi de asemenea";
    $see_name = "Vezi";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Anex&#103;";
    $headto_name = "Pentru";
    $cc_name = "Copie";

    @Month = ('', 'ianuarie', 'februarie', 'martie', 'aprilie', 'mai',
	'iunie', 'iulie', 'august', 'septembrie', 'octombrie',
	'noiembrie', 'decembrie');
#    $GENERIC_WORDS = "";
}


sub romanian_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2 $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&romanian_titles;
$default_language = 'romanian';
$TITLES_LANGUAGE = 'romanian';
$romanian_encoding = 'is-8859-16';

# $Log: romanian.perl,v $
# Revision 1.1  1998/08/25 01:59:07  RRM
# 	Babel language support
#
#

1;
