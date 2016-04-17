# $Id: russian.perl,v 1.1 2001/04/18 01:39:21 RRM Exp $
#
# russian.perl for russian babel, inspired heavily by german.perl
# by Georgy Salnikov <sge@nmr.nioch.nsc.ru>


package russian;

print " [russian]";

sub main'russian_translation { @_[0] }


package main;

if (defined &addto_languages) { &addto_languages('russian') };

sub russian_titles {
    $toc_title = "Содержание";
    $lof_title = "Список иллюстраций";
    $lot_title = "Список таблиц";
    $idx_title = "Предметный указатель";
    $ref_title = "Список литературы";
    $bib_title = "Литература";
    $abs_title = "Аннотация";
    $app_title = "Приложение";
    $pre_title = "Предисловие";
    $foot_title = "Примечание";
    $thm_title = "Теорема";
    $fig_name = "Рис.";
    $tab_name = "Таблица";
    $prf_name = "Доказательство";
    $date_name = "Дата";
    $page_name = "с.";
  #  Sectioning-level titles
    $part_name = "Часть";
    $chapter_name = "Глава";
    $section_name = "Секция";
    $subsection_name = "Подсекция";
    $subsubsection_name = "Субподсекция";
    $paragraph_name = "Параграф";
  #  Misc. strings
    $child_name = "Подсекции";
    $info_title = "Об этом документе ...";
    $also_name = "см. также";
    $see_name = "см.";
  #  names in navigation panels
    $next_name = "След.";
    $up_name = "Выше";
    $prev_name = "Пред.";
  #  field names in email headers
    $encl_name = "вкл.";
    $headto_name = "вх.";
    $cc_name = "исх.";

    @Month = ('', 'января', 'февраля', 'марта', 'апреля', 'мая',
	      'июня', 'июля', 'августа', 'сентября', 'октября',
	      'ноября', 'декабря');
    $GENERIC_WORDS = "and|the|of|for|by|a|an|to";
}


sub russian_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2 $Month[$1] |;
    join('',$today,$_[0],' г.');
}



# use'em
&russian_titles;
$default_language = 'russian';
$TITLES_LANGUAGE = 'russian';
$russian_encoding = 'koi8-r';

# $Log: russian.perl,v $
# Revision 1.1  2001/04/18 01:39:21  RRM
#      support for the Russian language using KOI8-R encoding, and as an
#      option to the Babel package.
#      supplied by:  Georgy Salnikov  <sge@nmr.nioch.nsc.ru>
#
# Revision 1.1  1998/08/25 02:11:25  RRM
# 	Babel language support
#
#

1;
