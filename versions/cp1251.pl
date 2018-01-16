### File: cp1251.pl
### Version 0.1,  October 28, 2005
### Written by Sergej Znamenskij <znamensk@rustex.botik.ru>
###
### CP1251 encoding information
###
### based on cp1252.pl

## Copyright (C) 1999 by Ross Moore
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
#<!-- (C) International Organization for Standardization 1986
#     Permission to copy in any form is granted for use with
#     conforming SGML systems and applications as defined in
#     ISO 8879, provided this notice is included in all copies.
#     This has been extended for use with HTML to cover the full
#     set of codes in the range 160-255 decimal.
#-->
#<!-- Character entity set. Typical invocation:
#     <!ENTITY % ISOlat1 PUBLIC
#       "ISO 8879-1986//ENTITIES Added Latin 1//EN//HTML">
#     %ISOlat1;
#-->

$CHARSET = "windows-1251";
$INPUTENC='cp1251';  # empty implies 'latin1'
$russian_encoding=$INPUTENC;

#Character ranges for lower --> upper-case conversion

$sclower = "\\340-\\377";
$scupper = "\\300-\\337";


%low_entities = ( '224', '192'
                 ,'225', '193'
                 ,'226', '194'
                 ,'227', '195'
                 ,'228', '196'
                 ,'229', '197'
                 ,'230', '198'
                 ,'231', '199'
                 ,'232', '200'
                 ,'233', '201'
                 ,'234', '202'
                 ,'235', '203'
                 ,'236', '204'
                 ,'237', '205'
                 ,'238', '206'
                 ,'239', '207'
                 ,'240', '208'
                 ,'241', '209'
                 ,'242', '210'
                 ,'243', '211'
                 ,'244', '212'
                 ,'245', '213'
                 ,'246', '214'
        	     ,'247', '215'
                 ,'248', '216'
                 ,'249', '217'
                 ,'250', '218'
                 ,'251', '219'
                 ,'252', '220'
                 ,'253', '221'
                 ,'254', '222'
	             ,'255', '223'
	             ,'158', '142'
	             ,'190', '189'
	             ,'191', '175'
	             ,'179', '178'
	             ,'188', '163'
	             ,'186', '170'
	             ,'184', '168'
	             ,'180', '165'
	             ,'162', '161'
	             ,'156', '140'
	             ,'159', '143'
	             ,'144', '128'
	             ,'154', '138'
                 ,'131', '129'
);

sub do_cmd_copyright {join('', '©', $_[0]);}
sub do_cmd_cyra {join('', 'а', $_[0]);}
sub do_cmd_CYRA {join('', 'А', $_[0]);}
sub do_cmd_cyrb {join('', 'б', $_[0]);}
sub do_cmd_CYRB {join('', 'Б', $_[0]);}
sub do_cmd_cyrch {join('', 'ч', $_[0]);}
sub do_cmd_CYRCH {join('', 'Ч', $_[0]);}
sub do_cmd_cyrc {join('', 'ц', $_[0]);}
sub do_cmd_CYRC {join('', 'Ц', $_[0]);}
sub do_cmd_cyrdje {join('', 'ђ', $_[0]);}
sub do_cmd_CYRDJE {join('', 'Ђ', $_[0]);}
sub do_cmd_cyrd {join('', 'д', $_[0]);}
sub do_cmd_CYRD {join('', 'Д', $_[0]);}
sub do_cmd_cyrdze {join('', 'ѕ', $_[0]);}
sub do_cmd_CYRDZE {join('', 'Ѕ', $_[0]);}
sub do_cmd_cyrdzhe {join('', 'џ', $_[0]);}
sub do_cmd_CYRDZHE {join('', 'Џ', $_[0]);}
sub do_cmd_cyre {join('', 'е', $_[0]);}
sub do_cmd_CYRE {join('', 'Е', $_[0]);}
sub do_cmd_cyrerev {join('', 'э', $_[0]);}
sub do_cmd_CYREREV {join('', 'Э', $_[0]);}
sub do_cmd_cyrery {join('', 'ы', $_[0]);}
sub do_cmd_CYRERY {join('', 'Ы', $_[0]);}
sub do_cmd_cyrf {join('', 'ф', $_[0]);}
sub do_cmd_CYRF {join('', 'Ф', $_[0]);}
sub do_cmd_cyrg {join('', 'г', $_[0]);}
sub do_cmd_CYRG {join('', 'Г', $_[0]);}
sub do_cmd_cyrgup {join('', 'ґ', $_[0]);}
sub do_cmd_CYRGUP {join('', 'Ґ', $_[0]);}
sub do_cmd_cyrh {join('', 'х', $_[0]);}
sub do_cmd_CYRH {join('', 'Х', $_[0]);}
sub do_cmd_cyrhrdsn {join('', 'ъ', $_[0]);}
sub do_cmd_CYRHRDSN {join('', 'Ъ', $_[0]);}
sub do_cmd_cyrie {join('', 'є', $_[0]);}
sub do_cmd_CYRIE {join('', 'Є', $_[0]);}
sub do_cmd_CYRII {join('', 'І', $_[0]);}
sub do_cmd_cyrii {join('', 'і', $_[0]);}
sub do_cmd_cyri {join('', 'и', $_[0]);}
sub do_cmd_CYRI {join('', 'И', $_[0]);}
sub do_cmd_cyrishrt {join('', 'й', $_[0]);}
sub do_cmd_CYRISHRT {join('', 'Й', $_[0]);}
sub do_cmd_cyrje {join('', 'ј', $_[0]);}
sub do_cmd_CYRJE {join('', 'Ј', $_[0]);}
sub do_cmd_cyrk {join('', 'к', $_[0]);}
sub do_cmd_CYRK {join('', 'К', $_[0]);}
sub do_cmd_CYRLJE {join('', 'Љ', $_[0]);}
sub do_cmd_cyrlje {join('', 'љ', $_[0]);}
sub do_cmd_cyrl {join('', 'л', $_[0]);}
sub do_cmd_CYRL {join('', 'Л', $_[0]);}
sub do_cmd_cyrm {join('', 'м', $_[0]);}
sub do_cmd_CYRM {join('', 'М', $_[0]);}
sub do_cmd_cyrnje {join('', 'њ', $_[0]);}
sub do_cmd_CYRNJE {join('', 'Њ', $_[0]);}
sub do_cmd_cyrn {join('', 'н', $_[0]);}
sub do_cmd_CYRN {join('', 'Н', $_[0]);}
sub do_cmd_cyro {join('', 'о', $_[0]);}
sub do_cmd_CYRO {join('', 'О', $_[0]);}
sub do_cmd_cyrp {join('', 'п', $_[0]);}
sub do_cmd_CYRP {join('', 'П', $_[0]);}
sub do_cmd_cyrr {join('', 'р', $_[0]);}
sub do_cmd_CYRR {join('', 'Р', $_[0]);}
sub do_cmd_cyrsftsn {join('', 'ь', $_[0]);}
sub do_cmd_CYRSFTSN {join('', 'Ь', $_[0]);}
sub do_cmd_cyrshch {join('', 'щ', $_[0]);}
sub do_cmd_CYRSHCH {join('', 'Щ', $_[0]);}
sub do_cmd_cyrsh {join('', 'ш', $_[0]);}
sub do_cmd_CYRSH {join('', 'Ш', $_[0]);}
sub do_cmd_cyrs {join('', 'с', $_[0]);}
sub do_cmd_CYRS {join('', 'С', $_[0]);}
sub do_cmd_cyrt {join('', 'т', $_[0]);}
sub do_cmd_CYRT {join('', 'Т', $_[0]);}
sub do_cmd_cyrtshe {join('', 'ћ', $_[0]);}
sub do_cmd_CYRTSHE {join('', 'Ћ', $_[0]);}
sub do_cmd_cyru {join('', 'у', $_[0]);}
sub do_cmd_CYRU {join('', 'У', $_[0]);}
sub do_cmd_cyrushrt {join('', 'ў', $_[0]);}
sub do_cmd_CYRUSHRT {join('', 'Ў', $_[0]);}
sub do_cmd_cyrv {join('', 'в', $_[0]);}
sub do_cmd_CYRV {join('', 'В', $_[0]);}
sub do_cmd_cyrya {join('', 'я', $_[0]);}
sub do_cmd_CYRYA {join('', 'Я', $_[0]);}
sub do_cmd_cyryi {join('', 'ї', $_[0]);}
sub do_cmd_CYRYI {join('', 'Ї', $_[0]);}
sub do_cmd_cyryo {join('', 'ё', $_[0]);}
sub do_cmd_CYRYO {join('', 'Ё', $_[0]);}
sub do_cmd_cyryu {join('', 'ю', $_[0]);}
sub do_cmd_CYRYU {join('', 'Ю', $_[0]);}
sub do_cmd_cyrzh {join('', 'ж', $_[0]);}
sub do_cmd_CYRZH {join('', 'Ж', $_[0]);}
sub do_cmd_cyrz {join('', 'з', $_[0]);}
sub do_cmd_CYRZ {join('', 'З', $_[0]);}
#sub do_cmd_dots {join('', '…', $_[0]);}
#sub do_cmd_dots { join('', &iso_map("hellip", ""), $_[0]);}
sub do_cmd_dots { join('', '&#133;', $_[0]);}
#sub do_cmd_guillemotleft {join('', '«', $_[0]);}
sub do_cmd_guillemotleft { join('', &iso_map("laquo", ""), $_[0]);}
#sub do_cmd_guillemotright {join('', '»', $_[0]);}
sub do_cmd_guillemotright { join('', &iso_map("raquo", ""), $_[0]);}
sub do_cmd_guilsinglleft {join('', '‹', $_[0]);}
#sub do_cmd_guilsinglleft { join('', &iso_map("lsaquo", ""), $_[0]);}
sub do_cmd_guilsinglright {join('', '›', $_[0]);}
#sub do_cmd_guilsinglright { join('', &iso_map("rsaquo", ""), $_[0]);}
#sub do_cmd_lnot {join('', '¬', $_[0]);}
sub do_cmd_lnot { join('', &iso_map("not", ""), $_[0]);}
sub do_cmd_mathdegree { join('', &iso_map("deg", ""), $_[0]);}
sub do_cmd_mathordfeminine { join('', &iso_map("ordf", ""), $_[0]);}
sub do_cmd_mathordmasculine { join('', &iso_map("ordm", ""), $_[0]);}
sub do_cmd_micron { join('', &iso_map("micro", ""), $_[0]);}
sub do_cmd_minus {join('', '­', $_[0]);}
#sub do_cmd_minus { join('', &iso_map("shy", ""), $_[0]);}
sub do_cmd_mu {join('', 'µ', $_[0]);}
sub do_cmd_nobreakspace {join('', ' ', $_[0]);}
#sub do_cmd_P {join('', '¶', $_[0]);}
sub do_cmd_P { join('', &iso_map("para", ""), $_[0]);}
#sub do_cmd_pm {join('', '±', $_[0]);}
sub do_cmd_pm { join('', &iso_map("plusmn", ""), $_[0]);}
sub do_cmd_pounds { join('', &iso_map("pound", ""), $_[0]);}
sub do_cmd_quotedblbase {join('', '„', $_[0]);}
#sub do_cmd_quotedblbase { join('', &iso_map("dbquo", ""), $_[0]);}
sub do_cmd_quotesinglbase {join('', '‚', $_[0]);}
#sub do_cmd_quotesinglbase { join('', &iso_map("sbquo", ""), $_[0]);}
#sub do_cmd_S {join('', '§', $_[0]);}
sub do_cmd_S { join('', &iso_map("sect", ""), $_[0]);}
sub do_cmd_ss { join('', &iso_map("sz", "lig"), $_[0]);}
#sub do_cmd_textbrokenbar {join('', '¦', $_[0]);}
sub do_cmd_textbrokenbar { join('', &iso_map("brvbar", ""), $_[0]);}
sub do_cmd_textbullet {join('', '•', $_[0]);}
#sub do_cmd_textbullet { join('', &iso_map("bullet", ""), $_[0]);}                               # !!!
sub do_cmd_textcent { join('', &iso_map("cent", ""), $_[0]);}
#sub do_cmd_textcurrency {join('', '¤', $_[0]);}
sub do_cmd_textcurrency { join('', &iso_map("curren", ""), $_[0]);}
#sub do_cmd_textdegree {join('', '°', $_[0]);}
sub do_cmd_textdegree { join('', &iso_map("deg", ""), $_[0]);}
sub do_cmd_textemdash {join('', '—', $_[0]);}
#sub do_cmd_textemdash { join('', &iso_map("mdash", ""), $_[0]);}
sub do_cmd_textendash {join('', '–', $_[0]);}
#sub do_cmd_textendash { join('', &iso_map("ndash", ""), $_[0]);}
#sub do_cmd_texteuro {join('', '€', $_[0]);}
sub do_cmd_texteuro { join('', &iso_map("euro", ""), $_[0]);}
sub do_cmd_textflorin { join('', &iso_map("florin", ""), $_[0]);}
sub do_cmd_textnumero {join('', '№', $_[0]);}
#sub do_cmd_textperiodcentered {join('', '·', $_[0]);}
sub do_cmd_textperiodcentered { join('', &iso_map("middot", ""), $_[0]);}
sub do_cmd_textperthousand {join('', '‰', $_[0]);}
#sub do_cmd_textperthousand { join('', &iso_map("permil", ""), $_[0]);}
sub do_cmd_textquotedblleft {join('', '“', $_[0]);}
#sub do_cmd_textquotedblleft { join('', &iso_map("ldquo", ""), $_[0]);}                               # !!!
sub do_cmd_textquotedblright {join('', '”', $_[0]);}
#sub do_cmd_textquotedblright { join('', &iso_map("rdquo", ""), $_[0]);}                               # !!!
sub do_cmd_textquoteleft {join('', '‘', $_[0]);}
#sub do_cmd_textquoteleft { join('', &iso_map("lsquo", ""), $_[0]);}                               # !!!
sub do_cmd_textquoteright {join('', '’', $_[0]);}
#sub do_cmd_textquoteright { join('', &iso_map("rsquo", ""), $_[0]);}                               # !!!
#sub do_cmd_textregistered {join('', '®', $_[0]);}
sub do_cmd_textregistered { join('', &iso_map("reg", ""), $_[0]);}
sub do_cmd_texttrademark {join('', '™', $_[0]);}
#sub do_cmd_texttrademark { join('', &iso_map("trade", ""), $_[0]);}                               # !!!
sub do_cmd_times { join('', &iso_map("times", ""), $_[0]);}

%windows_1251_character_map
     = (
#    '\\CYRDJE' , '&#128', 
#    '\\@tabacckludge\'\CYRG' , '&#129', 
#    '\\quotesinglbase' , '&#130', 
#    '\\@tabacckludge\'\cyrg' , '&#131', 
#    '\\quotedblbase' , '&#132', 
#    '\\dots' , '&#133', 
#    '\\dag' , '&#134', 
#    '\\ddag' , '&#135', 
#    '\\texteuro' , '&#136', 
#    '\\textperthousand' , '&#137', 
#    '\\CYRLJE' , '&#138', 
#    '\\guilsinglleft' , '&#139', 
#    '\\CYRNJE' , '&#140', 
#    '\\@tabacckludge\'\CYRK' , '&#141', 
#    '\\CYRTSHE' , '&#142', 
#    '\\CYRDZHE' , '&#143', 
#    '\\cyrdje' , '&#144', 
#    '\\textquoteleft' , '&#145', 
#    '\\textquoteright' , '&#146', 
#    '\\textquotedblleft' , '&#147', 
#    '\\textquotedblright' , '&#148', 
#    '\\textbullet' , '&#149', 
#    '\\textendash' , '&#150', 
#    '\\textemdash' , '&#151', 
#    '\\texttrademark' , '&#153', 
#    '\\cyrlje' , '&#154', 
#    '\\guilsinglright' , '&#155', 
#    '\\cyrnje' , '&#156', 
#    '\\@tabacckludge\'\cyrk' , '&#157', 
#    '\\cyrtshe' , '&#158', 
#    '\\cyrdzhe' , '&#159', 
#    '\\nobreakspace' , '&#160', 
#    '\\CYRUSHRT' , '&#161', 
#    '\\cyrushrt' , '&#162', 
#    '\\CYRJE' , '&#163', 
#    '\\textcurrency' , '&#164', 
#    '\\CYRGUP' , '&#165', 
#    '\\textbrokenbar' , '&#166', 
#    '\\S' , '&#167', 
#    '\\CYRYO' , '&#168', 
#    '\\copyright' , '&#169', 
#    '\\CYRIE' , '&#170', 
#    '\\guillemotleft' , '&#171', 
#    '\\lnot' , '&#172', 
#    '\\-' , '&#173', 
#    '\\textregistered' , '&#174', 
#    '\\CYRYI' , '&#175', 
#    'textdegree' , '&#176', 
#    '\\pm' , '&#177', 
#    '\\CYRII' , '&#178', 
#    '\\cyrii' , '&#179', 
#    '\\cyrgup' , '&#180', 
#    '\\mu' , '&#181', 
#    '\\P' , '&#182', 
#    '\\textperiodcentered' , '&#183', 
#    '\\cyryo' , '&#184', 
#    '\\textnumero' , '&#185', 
#    '\\cyrie' , '&#186', 
#    '\\guillemotright' , '&#187', 
#    '\\cyrje' , '&#188', 
#    '\\CYRDZE' , '&#189', 
#    '\\cyrdze' , '&#190', 
#    '\\cyryi' , '&#191', 
       'amp', '&amp;',  # ampersand
       'gt', '&#62;',   # greater than
       'lt', '&lt;',    # less than
       'quot', '&quot;',        # double quote

# These have HTML mnemonic names for HTML 4.0 ...
       'euro',  '&#136;', 
       'sbquo', '&#130;', 
       'florin', '&#131;', 
       'dbquo', '&#132;', 
       'hellip', '&#133;', 
       'dagger', '&#134;', 
       'Dagger', '&#135;', 
       'caret', '&#136;',   # caret accent
       'tilde', '&#152;',   # tilde accent
       'permil', '&#137;',   # 
       'lsaquo', '&#139;',   # 
       'rsaquo', '&#155;',   # 
       'lsquo', '&#145;', 
       'rsquo', '&#146;', 
       'ldquo', '&#147;', 
       'rdquo', '&#148;', 
       'bull', '&#149;', 
       'ndash', '&#150;', 
       'mdash', '&#151;', 
       'trade', '&#152;',   # trademark symbol
       'nbsp', '&#160;',       # non-breaking space
       'curren', '&#164;',     # currency sign
       'brvbar', '&#166;',  
       'sect', '&#167;',       # section mark
       'copy', '&#169;',       # copyright mark
       'laquo', '&#171;', 
       'raquo', '&#187;', 
       'not', '&#172;',
       'shy', '&#173;',
       'reg', '&#174;',
       'deg', '&#176;',
       'plusmn', '&#177;',
       'micro', '&#181;',
       'para', '&#182;',   # paragraph mark
       'middot', '&#183;',

# These are character types without arguments ...
       'grave' , "`",
       'circ', '^',
       'dot', '.',
       'cedil', "&#184;"
	);

%cp1251_character_map_inv =
    (
     '^'      , '\\^{}',
     '&#62;'  , '\\ensuremath{>}',
     '&lt;'   , '\\ensuremath{<}',
     '&amp;'  , '\\&',
    '&#128' , '\\CYRDJE', 
    '&#129' , '\\@tabacckludge\'\CYRG', 
    '&#131' , '\\@tabacckludge\'\cyrg', 
    '&#138' , '\\CYRLJE', 
    '&#140' , '\\CYRNJE', 
    '&#141' , '\\@tabacckludge\'\CYRK', 
    '&#142' , '\\CYRTSHE', 
    '&#143' , '\\CYRDZHE', 
    '&#144' , '\\cyrdje', 
    '&#154' , '\\cyrlje', 
    '&#156' , '\\cyrnje', 
    '&#157' , '\\@tabacckludge\'\cyrk', 
    '&#158' , '\\cyrtshe', 
    '&#159' , '\\cyrdzhe', 
    '&#161' , '\\CYRUSHRT', 
    '&#162' , '\\cyrushrt', 
    '&#163' , '\\CYRJE', 
    '&#165' , '\\CYRGUP', 
    '&#168' , '\\CYRYO', 
    '&#170' , '\\CYRIE', 
    '&#175' , '\\CYRYI', 
    '&#178' , '\\CYRII', 
    '&#179' , '\\cyrii', 
    '&#180' , '\\cyrgup', 
    '&#184' , '\\cyryo', 
    '&#185' , '\\textnumero', 
    '&#186' , '\\cyrie', 
    '&#188' , '\\cyrje', 
    '&#189' , '\\CYRDZE', 
    '&#190' , '\\cyrdze', 
    '&#191' , '\\cyryi', 
     '&#126;' , '\\~{}',
     '&#130;' , '\\quotesinglbase{}',
     '&#131;' , '\\textflorin{}',
     '&#132;' , '\\quotedblbase{}',
     '&#133;' , '\\dots{}',
     '&#134;' , '\\dag{}',
     '&#135;' , '\\ddag{}',
     '&#136;' , '\\texteuro{}',
     '&#137;' , '\\textperthousand{}',
     '&#139;' , '\\guilsinglleft{}',
     '&#145;' , '\\textquoteleft{}',
     '&#146;' , '\\textquoteright{}',
     '&#147;' , '\\textquotedblleft{}',
     '&#148;' , '\\textquotedblright{}',
     '&#149;' , '\\textbullet{}',
     '&#150;' , '\\textendash{}',
     '&#151;' , '\\textemdash{}',
     '&#152;' , '\\~{}',
     '&#153;' , '\\texttrademark{}',
     '&#155;' , '\\guilsinglright{}',
	'&#160;' , '\\nobreakspace{}',
	'&#164;' , '\\textcurrency{}',
	'&#166;' , '\\textbrokenbar{}',
     '&#167;' , '\\S{}',
     '&#169;' , '\\copyright{}',
	'&#171;' , '\\guillemotleft{}',
	'&#172;' , '\\ensuremath{\\lnot{}}',
	'&#173;' , '\\-',
#	'&#174;' , '\\textregistered{}',
	 '&#174;' , '\\ensuremath{\\circledR}',
     '&#176;' , '\\ensuremath{^{\\circ}}',
	'&#177;' , '\\ensuremath{\\pm}',
	'&#181;' , '\\ensuremath{\\mu}',
     '&#182;' , '\\P{}',
#	'&#183;' , '\\textperiodcentered{}',
     '&#183;' , '\\cdot{}',
     '&#184;' , '\\c{ }',
	'&#187;' , '\\guillemotright{}',
);

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
    $section_name = "Параграф";
    $subsection_name = "Пункт";
    $subsubsection_name = "Подпункт";
    $paragraph_name = "Абзац";
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
    $GENERIC_WORDS = "и|или|для|из|в|на";
}

sub russian_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2 $Month[$1] |;
    join('',$today,$_[0],' г.');
}

1;
