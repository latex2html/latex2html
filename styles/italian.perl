# $Id: italian.perl,v 1.2 2002/06/18 03:00:52 RRM Exp $
#
# italian.perl for italian babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package italian;

print " [italian]";

sub main'italian_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('italian') };

sub italian_titles {
    $toc_title = "Indice";
    $lof_title = "Elenco delle figure";
    $lot_title = "Elenco delle tabelle";
    $idx_title = "Indice analitico";
    $ref_title = "Riferimenti bibliografici";
    $bib_title = "Bibliografia";
    $abs_title = "Sommario";
    $app_title = "Appendice";
    $pre_title = "Prefazione";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Figura";
    $tab_name = "Tabella";
    $prf_name = "Dimostrazione";
    $page_name = "Pag.";
  #  Sectioning-level titles
    $part_name = "Parte";
    $chapter_name = "Capitolo";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "vedi anche";
    $see_name = "vedi";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Allegati";
    $headto_name = "Per";
    $cc_name = "e p.c.";

    @Month = ('', 'gennaio', 'febbraio', 'marzo', 'aprile', 'maggio', 'giugno',
	'luglio', 'agosto', 'settembre', 'ottobre', 'novembre', 'dicembre');
#    $GENERIC_WORDS = "";
}


sub italian_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&italian_titles;
$default_language = 'italian';
$TITLES_LANGUAGE = 'italian';
$italian_encoding = 'iso-8859-1';

# $Log: italian.perl,v $
# Revision 1.2  2002/06/18 03:00:52  RRM
#  --  &addto_languages('italian')  not 'irish'
#      thanks to Francesco Malvezzi for reporting the error
#
# Revision 1.1  1998/08/25 01:59:03  RRM
# 	Babel language support
#
#

1;
