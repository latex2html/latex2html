# $Id: portuges.perl,v 1.4 2001/05/20 22:51:02 RRM Exp $
#
# portuges.perl for portuges babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package portuges;

print " [portuges]";

sub main'portuges_translation {
    local($_) = @_;
s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\|)/&get_portuges_specials($1)/geo;
    $_;
}

sub get_portuges_specials {
    $portuges_specials{@_[0]}
}

%portuges_specials = (
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

if (defined &addto_languages) { &addto_languages('portuges') };

sub portuges_titles {
    $toc_title = "Conte\\'udo";
    $lof_title = "Lista de Figuras";
    $lot_title = "Lista de Tabelas";
    $idx_title = "\\'Indice";
    $ref_title = "Refer\\^encias";
    $bib_title = "Bibliografia";
    $abs_title = "Resumo";
    $app_title = "Ap\\^endice";
    $pre_title = "Pref\\'acio";
    $foot_title = "Notas de rodap&eacute;";
    $thm_title = "Teorema";
    $fig_name = "Figura";
    $tab_name = "Tabela";
    $prf_name = "Demonstra&ccedil;&atilde;o";
    $page_name = "P\\'agina";
  #  Sectioning-level titles
    $part_name = "Parte";
    $chapter_name = "Cap\\'itulo";
    $section_name = "Sec&ccedil;&atilde;o";
    $subsection_name = "Subsec&ccedil;&atilde;o";
    $subsubsection_name = "Subsubsec&ccedil;&atilde;o";
    $paragraph_name = "Para&aacute;grafo";
  #  Misc. strings
    $child_name = "Subsec&ccedil;&otilde;es";
    $info_title = "Sobre este documento ...";
    $also_name = "ver tamb\\'em";
    $see_name = "ver";
  #  names in navigation panels
    $next_name = "Seguinte";
    $up_name = "Acima";
    $prev_name = "Anterior";
    $group_name = "Pr&oacute;ximo Grupo";
  #  mail fields
    $encl_name = "Anexo";
    $headto_name = "Para";
    $cc_name = "Com c\\'opia a";

    @Month = ('', 'Janeiro', 'Fevereiro', 'Mar&ccedil;o', 'Abril', 'Maio', 'Junho',
	'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');

    $GENERIC_WORDS = "e|o|a|os|as|de|para|por|um|uma";
}


sub portuges_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&portuges_titles;
$default_language = 'portuges';
$TITLES_LANGUAGE = 'portuges';
$portuges_encoding = 'iso-8859-1';

# $Log: portuges.perl,v $
# Revision 1.4  2001/05/20 22:51:02  RRM
#  --  added values for  $thm_title, $group_name, $GENERIC_WORDS
#
# Revision 1.3  2001/05/19 23:52:21  RRM
#      more additions, from Jose Carlos Oliveira Santos
#
# Revision 1.2  2001/05/19 00:39:01  RRM
#      modifications by  Jose Carlos Oliveira Santos <jcsantos@fc.up.pt>
#  --  added phrases for $foot_title , $child_name , $info_title .
#
# Revision 1.1  1998/08/25 01:59:07  RRM
# 	Babel language support
#
#

1;
