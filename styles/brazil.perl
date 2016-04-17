# $Id: brazil.perl,v 1.1 1998/08/25 02:11:20 RRM Exp $
#
# brazil.perl for portuges/brazil babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package brazil;

print " [brazil]";

sub main'brazil_translation {
    local($_) = @_;
s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\|)/&get_brazil_specials($1)/geo;
    $_;
}

sub get_brazil_specials {
    $brazil_specials{@_[0]}
}

%brazil_specials = (
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

if (defined &addto_languages) { &addto_languages('brazil') };

sub brazil_titles {
    $toc_title = 'Sum&aacute;rio';
    $lof_title = 'Lista de Figuras';
    $lot_title = 'Lista de Tabelas';
    $idx_title = '&Iacute;ndice Remissivo';
    $ref_title = 'Refer&ecirc;ncias';
    $bib_title = 'Refer&ecirc;ncias Bibliogr&aacute;ficas';
    $abs_title = 'Resumo';
    $app_title = 'Ap&ecirc;ndice';
    $pre_title = 'Pref&aacute;cio';
##    $foot_title = '';
##    $thm_title = '';
    $fig_name = 'Figura';
    $tab_name = 'Tabela';
    $prf_name = 'Demonstra&ccedil;&atilde;o';
    $page_name = 'P&aacute;gina';
  #  Sectioning-level titles
    $part_name = 'Parte';
    $chapter_name = 'Cap&iacute;tulo';
#    $section_name = '';
#    $subsection_name = '';
#    $subsubsection_name = '';
#    $paragraph_name = '';
  #  Misc. strings
##    $child_name = '';
##    $info_title = '';
    $also_name = 'veja tamb&eacute;m';
    $see_name = 'veja';
  #  names in navigation panels
##    $next_name = '';
##    $up_name = '';
##    $prev_name = '';
##    $group_name = '';
  #  mail fields
    $encl_name = 'Anexo';
    $headto_name = 'Para';
    $cc_name = 'C&oacute;pia para';

    @Month = ('', 'Janeiro', 'Fevereiro', 'Mar&ccedil;o', 'Abril', 'Maio', 'Junho',
	'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');

#    $GENERIC_WORDS = '';
}


sub brazil_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&brazil_titles;
$default_language = 'brazil';
$TITLES_LANGUAGE = 'brazil';
$brazil_encoding = 'iso-8859-1';

# $Log: brazil.perl,v $
# Revision 1.1  1998/08/25 02:11:20  RRM
# 	Babel language support
#
#

1;
