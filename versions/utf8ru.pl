### File: utf8ru.pl
### Version 0.1,  January 7, 2017
### Written by Georgy Salnikov <sge@nmr.nioch.nsc.ru>
###
### UTF-8 encoding information especially for Russian usage needed
### as this multilanguage encoding cannot be treated universally
###
### based on cp1251.pl

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

$NO_UTF  = 1;			# all the required mantra for UTF-8 to work
$USE_UTF = 0;
$CHARSET = 'utf-8';
$charset = '';

# Character ranges for lower --> upper-case conversion (Unicode)

$sclower = "\\N{U+0430}-\\N{U+045F}";
$scupper = "\\N{U+0410}-\\N{U+042F}\\N{U+0400}-\\N{U+040F}";

%low_entities = (	# decimal unicodes
     '1072', '1040'	# А
    ,'1073', '1041'	# Б
    ,'1074', '1042'	# В
    ,'1075', '1043'	# Г
    ,'1076', '1044'	# Д
    ,'1077', '1045'	# Е
    ,'1078', '1046'	# Ж
    ,'1079', '1047'	# З
    ,'1080', '1048'	# И
    ,'1081', '1049'	# Й
    ,'1082', '1050'	# К
    ,'1083', '1051'	# Л
    ,'1084', '1052'	# М
    ,'1085', '1053'	# Н
    ,'1086', '1054'	# О
    ,'1087', '1055'	# П
    ,'1088', '1056'	# Р
    ,'1089', '1057'	# С
    ,'1090', '1058'	# Т
    ,'1091', '1059'	# У
    ,'1092', '1060'	# Ф
    ,'1093', '1061'	# Х
    ,'1094', '1062'	# Ц
    ,'1095', '1063'	# Ч
    ,'1096', '1064'	# Ш
    ,'1097', '1065'	# Щ
    ,'1098', '1066'	# Ъ
    ,'1099', '1067'	# Ы
    ,'1100', '1068'	# Ь
    ,'1101', '1069'	# Э
    ,'1102', '1070'	# Ю
    ,'1103', '1071'	# Я
    ,'1104', '1024'
    ,'1105', '1025'	# Ё
    ,'1106', '1026'
    ,'1107', '1027'
    ,'1108', '1028'
    ,'1109', '1029'
    ,'1110', '1030'	# I
    ,'1111', '1031'
    ,'1112', '1032'
    ,'1113', '1033'
    ,'1114', '1034'
    ,'1115', '1035'
    ,'1116', '1036'
    ,'1117', '1037'
    ,'1118', '1038'
    ,'1119', '1039'
# Following letters are from ancient or rare languages
#    ,'1121', '1120'
#    ,'1123', '1122'
#    ,'1125', '1124'
#    ,'1127', '1126'
#    ,'1129', '1128'
#    ,'1131', '1130'
#    ,'1133', '1132'
#    ,'1135', '1134'
#    ,'1137', '1136'
#    ,'1139', '1138'
#    ,'1141', '1140'
#    ,'1143', '1142'
#    ,'1145', '1144'
#    ,'1147', '1146'
#    ,'1149', '1148'
#    ,'1151', '1150'
#    ,'1153', '1152'
#    ,'1163', '1162'
#    ,'1165', '1164'
#    ,'1167', '1166'
#    ,'1169', '1168'
#    ,'1171', '1170'
#    ,'1173', '1172'
#    ,'1175', '1174'
#    ,'1177', '1176'
#    ,'1179', '1178'
#    ,'1181', '1180'
#    ,'1183', '1182'
#    ,'1185', '1184'
#    ,'1187', '1186'
#    ,'1189', '1188'
#    ,'1191', '1190'
#    ,'1193', '1192'
#    ,'1195', '1194'
#    ,'1197', '1196'
#    ,'1199', '1198'
#    ,'1201', '1200'
#    ,'1203', '1202'
#    ,'1205', '1204'
#    ,'1207', '1206'
#    ,'1209', '1208'
#    ,'1211', '1210'
#    ,'1213', '1212'
#    ,'1215', '1214'
#    ,'1218', '1217'
#    ,'1220', '1219'
#    ,'1222', '1221'
#    ,'1224', '1223'
#    ,'1226', '1225'
#    ,'1228', '1227'
#    ,'1230', '1229'
#    ,'1233', '1232'
#    ,'1235', '1234'
#    ,'1237', '1236'
#    ,'1239', '1238'
#    ,'1241', '1240'
#    ,'1243', '1242'
#    ,'1245', '1244'
#    ,'1247', '1246'
#    ,'1249', '1248'
#    ,'1251', '1250'
#    ,'1253', '1252'
#    ,'1255', '1254'
#    ,'1257', '1256'
#    ,'1259', '1258'
#    ,'1261', '1260'
#    ,'1263', '1262'
#    ,'1265', '1264'
#    ,'1267', '1266'
#    ,'1269', '1268'
#    ,'1271', '1270'
#    ,'1273', '1272'
#    ,'1275', '1274'
#    ,'1277', '1276'
#    ,'1279', '1278'
#    ,'1281', '1280'
#    ,'1283', '1282'
#    ,'1285', '1284'
#    ,'1287', '1286'
#    ,'1289', '1288'
#    ,'1291', '1290'
#    ,'1293', '1292'
#    ,'1295', '1294'
#    ,'1297', '1296'
#    ,'1299', '1298'
#    ,'1301', '1300'
#    ,'1303', '1302'
#    ,'1305', '1304'
#    ,'1307', '1306'
#    ,'1309', '1308'
#    ,'1311', '1310'
#    ,'1313', '1312'
#    ,'1315', '1314'
#    ,'1317', '1316'
#    ,'1319', '1318'
#    ,'42561', '42560'
#    ,'42563', '42562'
#    ,'42565', '42564'
#    ,'42567', '42566'
#    ,'42569', '42568'
#    ,'42571', '42570'
#    ,'42573', '42572'
#    ,'42575', '42574'
#    ,'42577', '42576'
#    ,'42579', '42578'
#    ,'42581', '42580'
#    ,'42583', '42582'
#    ,'42585', '42584'
#    ,'42587', '42586'
#    ,'42589', '42588'
#    ,'42591', '42590'
#    ,'42593', '42592'
#    ,'42595', '42594'
#    ,'42597', '42596'
#    ,'42599', '42598'
#    ,'42601', '42600'
#    ,'42603', '42602'
#    ,'42605', '42604'
#    ,'42625', '42624'
#    ,'42627', '42626'
#    ,'42629', '42628'
#    ,'42631', '42630'
#    ,'42633', '42632'
#    ,'42635', '42634'
#    ,'42637', '42636'
#    ,'42639', '42638'
#    ,'42641', '42640'
#    ,'42643', '42642'
#    ,'42645', '42644'
#    ,'42647', '42646'
#    ,'1231', '1231'
#    ,'7467', '7467'
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
sub do_cmd_dots { join('', '&#8230;', $_[0]);}
#sub do_cmd_guillemotleft {join('', '«', $_[0]);}
#sub do_cmd_guillemotleft { join('', &iso_map("laquo", ""), $_[0]);}
sub do_cmd_guillemotleft { join('', '&#171;', $_[0]);}
#sub do_cmd_guillemotright {join('', '»', $_[0]);}
#sub do_cmd_guillemotright { join('', &iso_map("raquo", ""), $_[0]);}
sub do_cmd_guillemotright { join('', '&#187;', $_[0]);}
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
#sub do_cmd_P { join('', &iso_map("para", ""), $_[0]);}
sub do_cmd_P { join('', '&#182;', $_[0]);}
#sub do_cmd_pm {join('', '±', $_[0]);}
sub do_cmd_pm { join('', &iso_map("plusmn", ""), $_[0]);}
sub do_cmd_pounds { join('', &iso_map("pound", ""), $_[0]);}
sub do_cmd_quotedblbase {join('', '„', $_[0]);}
#sub do_cmd_quotedblbase { join('', &iso_map("dbquo", ""), $_[0]);}
sub do_cmd_quotesinglbase {join('', '‚', $_[0]);}
#sub do_cmd_quotesinglbase { join('', &iso_map("sbquo", ""), $_[0]);}
#sub do_cmd_S {join('', '§', $_[0]);}
#sub do_cmd_S { join('', &iso_map("sect", ""), $_[0]);}
sub do_cmd_S { join('', '&#167;', $_[0]);}
sub do_cmd_ss { join('', &iso_map("sz", "lig"), $_[0]);}
#sub do_cmd_textbrokenbar {join('', '¦', $_[0]);}
sub do_cmd_textbrokenbar { join('', &iso_map("brvbar", ""), $_[0]);}
sub do_cmd_textbullet {join('', '•', $_[0]);}
#sub do_cmd_textbullet { join('', &iso_map("bullet", ""), $_[0]);}      # !!!
sub do_cmd_textcent { join('', &iso_map("cent", ""), $_[0]);}
#sub do_cmd_textcurrency {join('', '¤', $_[0]);}
sub do_cmd_textcurrency { join('', &iso_map("curren", ""), $_[0]);}
#sub do_cmd_textdegree {join('', '°', $_[0]);}
#sub do_cmd_textdegree { join('', &iso_map("deg", ""), $_[0]);}
sub do_cmd_textdegree { join('', '&#176;', $_[0]);}
sub do_cmd_textemdash {join('', '—', $_[0]);}
#sub do_cmd_textemdash { join('', &iso_map("mdash", ""), $_[0]);}
sub do_cmd_textendash {join('', '–', $_[0]);}
#sub do_cmd_textendash { join('', &iso_map("ndash", ""), $_[0]);}
#sub do_cmd_texteuro {join('', '€', $_[0]);}
sub do_cmd_texteuro { join('', &iso_map("euro", ""), $_[0]);}
sub do_cmd_textflorin { join('', &iso_map("florin", ""), $_[0]);}
sub do_cmd_textnumero {join('', '№', $_[0]);}
#sub do_cmd_textnumero {join('', '&#8470;', $_[0]);}
#sub do_cmd_textperiodcentered {join('', '·', $_[0]);}
sub do_cmd_textperiodcentered { join('', &iso_map("middot", ""), $_[0]);}
sub do_cmd_textperthousand {join('', '‰', $_[0]);}
#sub do_cmd_textperthousand { join('', &iso_map("permil", ""), $_[0]);}
sub do_cmd_textquotedblleft {join('', '“', $_[0]);}
#sub do_cmd_textquotedblleft { join('', &iso_map("ldquo", ""), $_[0]);} # !!!
sub do_cmd_textquotedblright {join('', '”', $_[0]);}
#sub do_cmd_textquotedblright { join('', &iso_map("rdquo", ""), $_[0]);}# !!!
sub do_cmd_textquoteleft {join('', '‘', $_[0]);}
#sub do_cmd_textquoteleft { join('', &iso_map("lsquo", ""), $_[0]);}    # !!!
sub do_cmd_textquoteright {join('', '’', $_[0]);}
#sub do_cmd_textquoteright { join('', &iso_map("rsquo", ""), $_[0]);}   # !!!
#sub do_cmd_textregistered {join('', '®', $_[0]);}
sub do_cmd_textregistered { join('', &iso_map("reg", ""), $_[0]);}
sub do_cmd_texttrademark {join('', '™', $_[0]);}
#sub do_cmd_texttrademark { join('', &iso_map("trade", ""), $_[0]);}    # !!!
#sub do_cmd_textdiv { join('', '÷', $_[0]);}
#sub do_cmd_textdiv { join('', &iso_map("divide", ""), $_[0]);}
sub do_cmd_textdiv { join('', '&#247;', $_[0]);}
sub do_cmd_times { join('', &iso_map("times", ""), $_[0]);}

sub russian_titles {
  $toc_title = "Содержание";
#  $toc_title = "Оглавление";
  $lof_title = "Список иллюстраций";
  $lot_title = "Список таблиц";
  $idx_title = "Предметный указатель";
#  $idx_title = "Алфавитный указатель";
  $ref_title = "Список литературы";
#  $ref_title = "Ссылки";
  $bib_title = "Литература";
  $abs_title = "Аннотация";
  $app_title = "Приложение";
  $pre_title = "Предисловие";
  $foot_title = "Примечание";
#  $foot_title = "Примечания";
#  $foot_title = "Сноски";
  $thm_title = "Теорема";
  $fig_name = "Рис.";
#  $fig_name = "Рисунок";
  $tab_name = "Таблица";
  $prf_name = "Доказательство";
  $date_name = "Дата";
  $page_name = "с.";
#  $page_name = "стр.";
#  Sectioning-level titles
  $part_name = "Часть";
  $chapter_name = "Глава";
  $section_name = "Параграф";
#  $section_name = "Секция";
#  $section_name = "Раздел";
  $subsection_name = "Пункт";
#  $subsection_name = "Подсекция";
#  $subsection_name = "Подраздел";
  $subsubsection_name = "Подпункт";
#  $subsubsection_name = "Субподсекция";
#  $subsubsection_name = "Секция";
  $paragraph_name = "Абзац";
#  $paragraph_name = "Параграф";
#  Misc. strings
#  $child_name = "Подсекции";
  $child_name = "Разделы";
  $info_title = "Об этом документе ...";
#  $info_title = "Информация об этом документе ...";
  $also_name = "см. также";
#  $also_name = "смотри также";
  $russian_see_name = "см.";
#  $russian_see_name = "смотри";
  $see_name = $russian_see_name;
#  names in navigation panels
#  $next_name = "След.";
  $next_name = "Далее";
#  $next_name = "Следующий раздел";
#  $up_name = "Выше";
  $up_name = "Уровень выше";
#  $up_name = "Выше по контексту";
#  $prev_name = "Пред.";
  $prev_name = "Назад";
#  $prev_name = "Предыдущий раздел";
  $group_name = "Группа";
#  $group_name = "Объединение";
#  field names in email headers
  $encl_name = "вкл.";
  $headto_name = "вх.";
  $cc_name = "исх.";

  @russian_Month = ('', 'января', 'февраля', 'марта', 'апреля', 'мая',
		    'июня', 'июля', 'августа', 'сентября', 'октября',
		    'ноября', 'декабря');
  @Month = @russian_Month;
  $GENERIC_WORDS = "и|или|для|из|в|на";
#  $GENERIC_WORDS = "и|или|не";
}

sub russian_today {
  local($today) = &get_date();
  $today =~ s|(\d+)/0?(\d+)/|$2 $russian_Month[$1] |;
  join('',$today,$_[0],' г.');
}

sub russian_seename {
  join('',$russian_see_name,$_[0]);
}

1;
