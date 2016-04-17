### File: html2.1.pl
### Language definitions for HTML 2.1 (I18N, Internationalization)
### Written by Marcus E. Hennecke <marcush@leland.stanford.edu>
### Version 0.3,  March 6, 1996
### Version 0.2,  February 2, 1996

## Copyright (C) 1995 by Marcus E. Hennecke
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
## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

$DOCTYPE = '-//IETF//DTD HTML i18n';

sub do_cmd_oe {
    join('', &iso_map("oe", "lig"), $_[0]);}
sub do_cmd_OE {
    join('', &iso_map("OE", "lig"), $_[0]);}
sub do_cmd_l {
    join('', &iso_map("l", "strok"), $_[0]);}
sub do_cmd_L {
    join('', &iso_map("L", "strok"), $_[0]);}
sub do_cmd_ng {
    join('', &iso_map("eng", ""), $_[0]);}

# Language codes as defined by ISO 639
# http://www.ics.uci.edu/pub/ietf/http/related/iso639.txt
%iso_languages
     = (
	'afar'		=> 'aa',
	'abkhazian'	=> 'ab',
	'afrikaans'	=> 'af',
	'amharic'	=> 'am',
	'arabic'	=> 'ar',
	'assamese'	=> 'as',
	'aymara'	=> 'ay',
	'azerbaijani'	=> 'az',
	'bashkir'	=> 'ba',
	'byelorussian'	=> 'be',
	'bulgarian'	=> 'bg',
	'bihari'	=> 'bh',
	'bislama'	=> 'bi',
	'bengali'	=> 'bn',
	'bangla'	=> 'bn',
	'tibetan'	=> 'bo',
	'breton'	=> 'br',
	'catalan'	=> 'ca',
	'corsican'	=> 'co',
	'czech'		=> 'cs',
	'welsh'		=> 'cy',
	'danish'	=> 'da',
	'german'	=> 'de',
	'austrian'	=> 'de.at',
	'bhutani'	=> 'dz',
	'greek'		=> 'el',
	'english'	=> 'en',
	'original'	=> 'en',
	'USenglish'	=> 'en.us',
	'esperanto'	=> 'eo',
	'spanish'	=> 'es',
	'estonian'	=> 'et',
	'basque'	=> 'eu',
	'persian'	=> 'fa',
	'finnish'	=> 'fi',
	'fiji'		=> 'fj',
	'faeroese'	=> 'fo',
	'french'	=> 'fr',
	'frisian'	=> 'fy',
	'irish'		=> 'ga',
	'scots gaelic'	=> 'gd',
	'galician'	=> 'gl',
	'guarani'	=> 'gn',
	'gujarati'	=> 'gu',
	'hausa'		=> 'ha',
	'hindi'		=> 'hi',
	'croatian'	=> 'hr',
	'hungarian'	=> 'hu',
	'armenian'	=> 'hy',
	'interlingua'	=> 'ia',
	'interlingue'	=> 'ie',
	'inupiak'	=> 'ik',
	'indonesian'	=> 'in',
	'icelandic'	=> 'is',
	'italian'	=> 'it',
	'hebrew'	=> 'iw',
	'japanese'	=> 'ja',
	'yiddish'	=> 'ji',
	'javanese'	=> 'jw',
	'georgian'	=> 'ka',
	'kazakh'	=> 'kk',
	'greenlandic'	=> 'kl',
	'cambodian'	=> 'km',
	'kannada'	=> 'kn',
	'korean'	=> 'ko',
	'kashmiri'	=> 'ks',
	'kurdish'	=> 'ku',
	'kirghiz'	=> 'ky',
	'latin'		=> 'la',
	'lingala'	=> 'ln',
	'laothian'	=> 'lo',
	'lithuanian'	=> 'lt',
	'latvian'	=> 'lv',
	'lettish'	=> 'lv',
	'malagasy'	=> 'mg',
	'maori'		=> 'mi',
	'macedonian'	=> 'mk',
	'malayalam'	=> 'ml',
	'mongolian'	=> 'mn',
	'moldavian'	=> 'mo',
	'marathi'	=> 'mr',
	'malay'		=> 'ms',
	'maltese'	=> 'mt',
	'burmese'	=> 'my',
	'nauru'		=> 'na',
	'nepali'	=> 'ne',
	'dutch'		=> 'nl',
	'norwegian'	=> 'no',
	'occitan'	=> 'oc',
	'afan'		=> 'om',
	'oromo'		=> 'om',
	'oriya'		=> 'or',
	'punjabi'	=> 'pa',
	'polish'	=> 'pl',
	'pashto'	=> 'ps',
	'pushto'	=> 'ps',
	'portuguese'	=> 'pt',
	'quechua'	=> 'qu',
	'rhaeto-romance'=> 'rm',
	'kirundi'	=> 'rn',
	'romanian'	=> 'ro',
	'russian'	=> 'ru',
	'kinyarwanda'	=> 'rw',
	'sanskrit'	=> 'sa',
	'sindhi'	=> 'sd',
	'sangro'	=> 'sg',
	'serbo-croatian'=> 'sh',
	'singhalese'	=> 'si',
	'slovak'	=> 'sk',
	'slovenian'	=> 'sl',
	'samoan'	=> 'sm',
	'shona'		=> 'sn',
	'somali'	=> 'so',
	'albanian'	=> 'sq',
	'serbian'	=> 'sr',
	'siswati'	=> 'ss',
	'sesotho'	=> 'st',
	'sundanese'	=> 'su',
	'swedish'	=> 'sv',
	'swahili'	=> 'sw',
	'tamil'		=> 'ta',
	'telugu'	=> 'te',
	'tajik'		=> 'tg',
	'thai'		=> 'th',
	'tigrinya'	=> 'ti',
	'turkmen'	=> 'tk',
	'tagalog'	=> 'tl',
	'setswana'	=> 'tn',
	'tonga'		=> 'to',
	'turkish'	=> 'tr',
	'tsonga'	=> 'ts',
	'tatar'		=> 'tt',
	'twi'		=> 'tw',
	'ukrainian'	=> 'uk',
	'urdu'		=> 'ur',
	'uzbek'		=> 'uz',
	'vietnamese'	=> 'vi',
	'volapuk'	=> 'vo',
	'wolof'		=> 'wo',
	'xhosa'		=> 'xh',
	'yoruba'	=> 'yo',
	'chinese'	=> 'zh',
	'zulu'		=> 'zu'
	);

%iso_8859_2_character_map
     = (
	'Aacute', '&#193;', 	# capital A, acute accent 
	'Abreve', '&#195;', 	# capital A, breve accent
	'Acirc', '&#194;', 	# capital A, circumflex accent 
	'Aogon', '&#161;',	# capital A, ogonek accent
	'Auml', '&#196;', 	# capital A, dieresis or umlaut mark   
	'Cacute', '&#198;', 	# capital C, acute accent
	'Ccaron', '&#200;', 	# capital C, caron accent 
	'Ccedil', '&#199;', 	# capital C, cedilla 
	'Dcaron', '&#207;', 	# capital D, caron accent
	'Dstrok', '&#208;', 	# capital D, stroke
	'ETH', '&#208;', 	# capital Eth, Icelandic 
	'Eacute', '&#201;', 	# capital E, acute accent 
	'Ecaron', '&#204;', 	# capital E, caron accent 
	'Eogon', '&#202;', 	# capital E, ogonek accent 
	'Euml', '&#203;', 	# capital E, dieresis or umlaut mark 
	'Iacute', '&#205;', 	# capital I, acute accent 
	'Icirc', '&#206;', 	# capital I, circumflex accent 
	'Lacute', '&#197;', 	# capital L, acute accent 
	'Lcaron', '&#165;', 	# capital L, caron accent 
	'Lstrok', '&#163;',	# capital L, stroke
	'Nacute', '&#209;', 	# capital N, acute accent 
	'Ncaron', '&#210;', 	# capital N, caron accent 
	'Oacute', '&#211;', 	# capital O, acute accent 
	'Ocirc', '&#212;', 	# capital O, circumflex accent 
	'Odblac', '&#213;', 	# capital O, double accute accent
	'Ouml', '&#214;', 	# capital O, dieresis or umlaut mark
	'Racute', '&#192;', 	# capital R, acute accent 
	'Rcaron', '&#216;', 	# capital R, caron accent
	'Sacute', '&#166;',	# capital S, acute accent
	'Scaron', '&#169;',	# capital S, caron accent
	'Scedil', '&#170;',	# capital S, cedil accent
	'Tcaron', '&#171;',	# capital T, caron accent
	'Tcedil', '&#222;',	# capital T, cedil accent
	'Uacute', '&#218;', 	# capital U, acute accent 
	'Udblac', '&#219;', 	# capital U, double acute accent 
	'Uring', '&#217;', 	# capital U, ring
	'Uuml', '&#220;', 	# capital U, dieresis or umlaut mark 
	'Yacute', '&#221;', 	# capital Y, acute accent 
	'Zacute', '&#172;',	# capital Z, acute accent
	'Zdot', '&#175;',	# capital Z, dot above
	'Zcaron', '&#174;',	# capital Z, caron accent
	'aacute', '&#225;', 	# small a, acute accent 
	'abreve', '&#227;', 	# small a, breve accent
	'acirc', '&#226;', 	# small a, circumflex accent 
	'amp', '&amp;', 	# ampersand 
	'aogon', '&#177;',	# small a, ogonek accent
	'auml', '&#228;', 	# small a, dieresis or umlaut mark   
	'cacute', '&#230;', 	# small c, acute accent
	'ccaron', '&#232;', 	# small c, caron accent 
	'ccedil', '&#231;', 	# small c, cedilla 
	'dcaron', '&#239;', 	# small d, caron accent
	'dstrok', '&#240;', 	# small d, stroke
	'eacute', '&#233;', 	# small e, acute accent 
	'ecaron', '&#236;', 	# small e, caron accent 
	'eogon', '&#234;', 	# small e, ogonek accent 
	'eth', '&#240;', 	# small eth, Icelandic
	'euml', '&#235;', 	# small e, dieresis or umlaut mark 
	'gt', '&#62;',		# greater than 
	'iacute', '&#237;', 	# small i, acute accent 
	'icirc', '&#238;', 	# small i, circumflex accent 
	'lacute', '&#229;', 	# small l, acute accent 
	'lcaron', '&#181;', 	# small l, caron accent 
	'lstrok', '&#179;',	# small l, stroke
	'lt', '&lt;',		# less than 
	'nacute', '&#241;', 	# small n, acute accent 
	'ncaron', '&#242;', 	# small n, caron accent 
	'oacute', '&#243;', 	# small o, acute accent 
	'ocirc', '&#244;', 	# small o, circumflex accent 
	'odblac', '&#245;', 	# small o, double accute accent
	'ouml', '&#246;', 	# small o, dieresis or umlaut mark
	'quot', '&quot;',	# double quote
	'racute', '&#224;', 	# small r, acute accent 
	'rcaron', '&#248;', 	# small r, caron accent
	'sacute', '&#182;',	# small s, acute accent
	'scaron', '&#185;',	# small s, caron accent
	'scedil', '&#186;',	# small s, cedil accent
	'szlig', '&#223;', 	# small sharp s, German (sz ligature) 
	'tcaron', '&#187;',	# small t, caron accent
	'tcedil', '&#254;',	# small t, cedil accent
	'uacute', '&#250;', 	# small u, acute accent 
	'udblac', '&#251;', 	# small u, double acute accent 
	'uring', '&#249;', 	# small u, ring
	'uuml', '&#252;', 	# small u, dieresis or umlaut mark 
	'yacute', '&#253;', 	# small y, acute accent 
	'zacute', '&#188;',	# small z, acute accent
	'zdot', '&#191;',	# small z, dot above
	'zcaron', '&#190;',	# small z, caron accent

	'sect', '&#167;',	# section mark

# These are character types without arguments ...
	'grave' , "`",
	'circ', '^',
	'tilde', '&#126;',
	'breve', '&#162;',
	'uml', '&#168;',
	'ring', '&#176;',
	'ogon', '&#178;',
	'acute' , "&#180;",
	'caron', '&#183;',
	'cedil', "&#184;",
	'dblac', "&#189;",
	'dot', '&#255;'
	);

%iso_8859_2_character_map_inv =
    (
     '&#193;' , '\\\'{A}',
     '&#195;' , '\\~{A}',
     '&#194;' , '\\^{A}',
     '&#161;' , '\\k{A}',
     '&#196;' , '\\"{A}',
     '&#198;' , '\\\'{C}',
     '&#200;' , '\\v{C}',
     '&#199;' , '\\c{C}',
     '&#207;' , '\\v{D}',
     '&#208;' , '\\DH{}',
     '&#201;' , '\\\'{E}',
     '&#204;' , '\\v{E}',
     '&#202;' , '\\k{E}',
     '&#203;' , '\\"{E}',
     '&#205;' , '\\\'{I}',
     '&#206;' , '\\^{I}',
     '&#197;' , '\\\'{L}',
     '&#165;' , '\\v{L}',
     '&#163;' , '\\L{}',
     '&#209;' , '\\\'{N}',
     '&#210;' , '\\v{N}',
     '&#211;' , '\\\'{O}',
     '&#212;' , '\\^{O}',
     '&#213;' , '\\H{O}',
     '&#214;' , '\\"{O}',
     '&#192;' , '\\\'{R}',
     '&#216;' , '\\v{R}',
     '&#166;' , '\\\'{S}',
     '&#169;' , '\\v{S}',
     '&#170;' , '\\c{S}',
     '&#171;' , '\\v{T}',
     '&#222;' , '\\c{T}',
     '&#218;' , '\\\'{U}',
     '&#219;' , '\\H{U}',
     '&#217;' , '\\r{U}',
     '&#220;' , '\\"{U}',
     '&#221;' , '\\\'{Y}',
     '&#172;' , '\\\'{Z}',
     '&#175;' , '\\.{Z}',
     '&#174;' , '\\v{Z}',
     '&#225;' , '\\\'{a}',
     '&#227;' , '\\~{a}',
     '&#226;' , '\\^{a}',
     '&amp;'  , '&',
     '&#177;' , '\\k{a}',
     '&#228;' , '\\"{a}',
     '&#230;' , '\\\'{c}',
     '&#232;' , '\\v{c}',
     '&#231;' , '\\c{c}',
     '&#239;' , '\\v{d}',
     '&#240;' , '\\dh{}',
     '&#233;' , '\\\'{e}',
     '&#236;' , '\\v{e}',
     '&#234;' , '\\k{e}',
     '&#235;' , '\\"{e}',
     '&#62;'  , '$>$',
     '&#237;' , '\\\'{i}',
     '&#238;' , '\\^{i}',
     '&#229;' , '\\\'{l}',
     '&#181;' , '\\v{l}',
     '&#179;' , '\\l{}',
     '&lt;'   , '$<$',
     '&#241;' , '\\\'{n}',
     '&#242;' , '\\v{n}',
     '&#243;' , '\\\'{o}',
     '&#244;' , '\\^{o}',
     '&#245;' , '\\H{o}',
     '&#246;' , '\\"{o}',
     '&quot;' , '"',
     '&#224;' , '\\\'{r}',
     '&#248;' , '\\v{r}',
     '&#182;' , '\\\'{s}',
     '&#185;' , '\\v{s}',
     '&#186;' , '\\c{s}',
     '&#223;' , '\\ss{}',
     '&#187;' , '\\v{t}',
     '&#254;' , '\\c{t}',
     '&#250;' , '\\\'{u}',
     '&#251;' , '\\H{u}',
     '&#249;' , '\\r{u}',
     '&#252;' , '\\"{u}',
     '&#253;' , '\\\'{y}',
     '&#188;' , '\\\'{z}',
     '&#191;' , '\\.{z}',
     '&#190;' , '\\v{z}',

     '&#167;' , '\\S{}',

     '&#126;' , '\\~{}',
     '&#162;' , '\\u{}',
     '&#168;' , '\\"{}',
     '&#176;' , '\\r{}',
     '&#180;' , '\\\'{}',
     '&#183;' , '\\v{}',
     '&#184;' , '\\c{}',
     '^'      , '\\^{}',
     '&#189;' , '\\H{}',
     '&#255;' , '\\.{}'
);

%iso_10646_character_map
    = (
	'Amacr', '&#256;',	# capital A, macron accent
	'amacr', '&#257;',	# small a, macron accent
	'Abreve', '&#258;',	# capital A, breve accent
	'abreve', '&#259;',	# small a, breve accent
	'Aogon', '&#260;',	# capital A, ogonek accent
	'aogon', '&#261;',	# small a, ogonek accent
	'Cacute', '&#262;',	# capital C, acute accent
	'cacute', '&#263;',	# small c, acute accent
	'Ccirc', '&#264;',	# capital C, circumflex accent
	'ccirc', '&#265;',	# small c, circumflex accent
	'Cdot', '&#266;',	# capital C, dot above
	'cdot', '&#267;',	# small c, dot above
	'Ccaron', '&#268;',	# capital C, caron accent
	'ccaron', '&#269;',	# small c, caron accent
	'Dcaron', '&#270;',	# capital D, caron accent
	'dcaron', '&#271;',	# small d, caron accent
	'Dstrok', '&#272;',	# capital D, stroke
	'dstrok', '&#273;',	# small d, stroke
	'Emacr', '&#274;',	# capital E, macron accent
	'emacr', '&#275;',	# small e, macron accent
	'Ebreve', '&#276;',	# capital E, breve accent
	'ebreve', '&#277;',	# small e, breve accent
	'Edot', '&#278;',	# capital E, dot above
	'edot', '&#279;',	# small e, dot above
	'Eogon', '&#280;',	# capital E, ogonek accent
	'eogon', '&#281;',	# small e, ogonek accent
	'Ecaron', '&#282;',	# capital E, caron accent
	'ecaron', '&#283;',	# small e, caron accent
	'Gcirc', '&#284;',	# capital G, circumflex accent
	'gcirc', '&#285;',	# small g, circumflex accent
	'Gbreve', '&#286;',	# capital G, breve accent
	'gbreve', '&#287;',	# small g, breve accent
	'Gdot', '&#288;',	# capital G, dot above
	'gdot', '&#289;',	# small g, dot above
	'Gcedil', '&#290;',	# capital G, cedilla accent
	'gcedil', '&#291;',	# small g, cedilla accent
	'Hcirc', '&#292;',	# capital H,  accent
	'hcirc', '&#293;',	# small h,  accent
	'Hstrok', '&#294;',	# capital H, stroke
	'hstrok', '&#295;',	# small h, stroke
	'Itilde', '&#296;',	# capital I, tilde accent
	'itilde', '&#297;',	# small i, tilde accent
	'Imacr', '&#298;',	# capital I, macron accent
	'imacr', '&#299;',	# small i, macron accent
	'Ibreve', '&#300;',	# capital I, breve accent
	'ibreve', '&#301;',	# small i, breve accent
	'Iogon', '&#302;',	# capital I, ogonek accent
	'iogon', '&#303;',	# small i, ogonek accent
	'Idot', '&#304;',	# capital I, dot above
	'inodot', '&#305;',	# small i, no dot
	'IJlig', '&#306;',	# capital IJ ligature
	'ijlig', '&#307;',	# small ij ligature
	'Jcirc', '&#308;',	# capital J, circumflex accent
	'jcirc', '&#309;',	# small j, circumflex accent
	'Kcedil', '&#310;',	# capital K, cedilla accent
	'kcedil', '&#311;',	# small k, cedilla accent
	'kgreen', '&#312;',	# small kra (Greenlandic)
	'Lacute', '&#313;',	# capital L, acute accent
	'lacute', '&#314;',	# small l, acute accent
	'Lcedil', '&#315;',	# capital L, cedil accent
	'lcedil', '&#316;',	# small l, cedil accent
	'Lcaron', '&#317;',	# capital L, caron accent
	'lcaron', '&#318;',	# small l, caron accent
	'Lmiddot', '&#319;',	# capital L, middle dot
	'lmiddot', '&#320;',	# small l, middle dot
	'Lstrok', '&#321;',	# capital L, stroke
	'lstrok', '&#322;',	# small l, stroke
	'Nacute', '&#323;',	# capital N, acute accent
	'nacute', '&#324;',	# small n, acute accent
	'Ncedil', '&#325;',	# capital N, cedil accent
	'ncedil', '&#326;',	# small n, cedil accent
	'Ncaron', '&#327;',	# capital N, caron accent
	'ncaron', '&#328;',	# small n, caron accent
	'napo', '&#329;',	# small n, preceded by apostrophe
	'Eng', '&#330;',	# capital Eng (Sami)
	'eng', '&#331;',	# small eng (Sami)
	'Omacr', '&#332;',	# capital O, macron accent
	'omacr', '&#333;',	# small o, macron accent
	'Obreve', '&#334;',	# capital O, breve accent
	'obreve', '&#335;',	# small o, breve accent
	'Odblac', '&#336;',	# capital O, double acute accent
	'odblac', '&#337;',	# small o, double acute accent
	'OElig', '&#338;',	# capital OE ligature
	'oelig', '&#339;',	# small oe ligature
	'Racute', '&#340;',	# capital R, acute accent
	'racute', '&#341;',	# small r, acute accent
	'Rcedil', '&#342;',	# capital R, cedilla accent
	'rcedil', '&#343;',	# small r, cedilla accent
	'Rcaron', '&#344;',	# capital R, caron accent
	'rcaron', '&#345;',	# small r, caron accent
	'Sacute', '&#346;',	# capital S, acute accent
	'sacute', '&#347;',	# small s, acute accent
	'Scirc', '&#348;',	# capital S, circumflex accent
	'scirc', '&#349;',	# small s, circumflex accent
	'Scedil', '&#350;',	# capital S, cedilla accent
	'scedil', '&#351;',	# small s, cedilla accent
	'Scaron', '&#352;',	# capital S, caron accent
	'scaron', '&#353;',	# small s, caron accent
	'Tcedil', '&#354;',	# capital T, cedilla accent
	'tcedil', '&#355;',	# small t, cedilla accent
	'Tcaron', '&#356;',	# capital T, caron accent
	'tcaron', '&#357;',	# small t, caron accent
	'Tstrok', '&#358;',	# capital T, stroke
	'tstrok', '&#359;',	# small t, stroke
	'Utilde', '&#360;',	# capital U, tilde accent
	'utilde', '&#361;',	# small u, tilde accent
	'Umacr', '&#362;',	# capital U, macron accent
	'umacr', '&#363;',	# small u, macron accent
	'Ubreve', '&#364;',	# capital U, breve accent
	'ubreve', '&#365;',	# small u, breve accent
	'Uring', '&#366;',	# capital U, ring above
	'uring', '&#367;',	# small u, ring above
	'Udblac', '&#368;',	# capital U, double acute accent
	'udblac', '&#369;',	# small u, double acute accent
	'Uogon', '&#370;',	# capital U, ogonek accent
	'uogon', '&#371;',	# small u, ogonek accent
	'Wcirc', '&#372;',	# capital W, circumflex accent
	'wcirc', '&#373;',	# small w, circumflex accent
	'Ycirc', '&#374;',	# capital Y, circumflex accent
	'ycirc', '&#375;',	# small y, circumflex accent
	'Yuml', '&#376;',	# capital Y, diaresis accent
	'Zacute', '&#377;',	# capital Z, acute accent
	'zacute', '&#378;',	# small z, acute accent
	'Zdot', '&#379;',	# capital Z, dot above
	'zdot', '&#380;',	# small z, dot above
	'Zcaron', '&#381;',	# capital Z, caron accent
	'zcaron', '&#382;'	# small z, caron accent
	);

%iso_10646_character_map_inv
    = (
	'&#256;', '\\={A}',
	'&#257;', '\\={a}',
	'&#258;', '\\u{A}',
	'&#259;', '\\u{a}',
	'&#260;', '\\k{A}',
	'&#261;', '\\k{a}',
	'&#262;', '\\\'{C}',
	'&#263;', '\\\'{c}',
	'&#264;', '\\^{C}',
	'&#265;', '\\^{c}',
	'&#266;', '\\.{C}',
	'&#267;', '\\.{c}',
	'&#268;', '\\v{C}',
	'&#269;', '\\v{c}',
	'&#270;', '\\v{D}',
	'&#271;', '\\v{d}',
	'&#272;', '\\DH{}',
	'&#273;', '\\dh{}',
	'&#274;', '\\={E}',
	'&#275;', '\\={e}',
	'&#276;', '\\u{E}',
	'&#277;', '\\u{e}',
	'&#278;', '\\.{E}',
	'&#279;', '\\.{e}',
	'&#280;', '\\k{E}',
	'&#281;', '\\k{e}',
	'&#282;', '\\v{E}',
	'&#283;', '\\v{e}',
	'&#284;', '\\^{G}',
	'&#285;', '\\^{g}',
	'&#286;', '\\u{G}',
	'&#287;', '\\u{g}',
	'&#288;', '\\.{G}',
	'&#289;', '\\.{g}',
	'&#290;', '\\c{G}',
	'&#291;', '\\c{g}',
	'&#292;', '\\^{H}',
	'&#293;', '\\^{h}',
#       '&#294;', '\\?{H}',	# Don't know how in LaTeX
#       '&#295;', '\\?{h}',	# Don't know how in LaTeX
	'&#296;', '\\~{I}',
	'&#297;', '\\~{\i}',
	'&#298;', '\\={I}',
	'&#299;', '\\={\i}',
	'&#300;', '\\u{I}',
	'&#301;', '\\u{\i}',
	'&#302;', '\\k{I}',
	'&#303;', '\\k{i}',
	'&#304;', '\\.{I}',
	'&#305;', '\\i{}',
#       '&#306;', '\\??',	# Don't know how in LaTeX
#       '&#307;', '\\??',	# Don't know how in LaTeXy
	'&#308;', '\\^{J}',
	'&#309;', '\\^{\j}',
	'&#310;', '\\c{K}',
	'&#311;', '\\c{k}',
#       '&#312;', '\\??',	# Don't know how in LaTeX
	'&#313;', '\\\'{L}',
	'&#314;', '\\\'{l}',
	'&#315;', '\\c{L}',
	'&#316;', '\\c{l}',
	'&#317;', '\\v{L}',
	'&#318;', '\\v{l}',
#       '&#319;', '\\?{L}',	# Don't know how in LaTeX
#       '&#320;', '\\?{l}',	# Don't know how in LaTeX
	'&#321;', '\\L',
	'&#322;', '\\l',
	'&#323;', '\\\'{N}',
	'&#324;', '\\\'{n}',
	'&#325;', '\\c{N}',
	'&#326;', '\\c{n}',
	'&#327;', '\\v{N}',
	'&#328;', '\\v{n}',
	'&#329;', '\'n',		# Probably never occurs
#       '&#330;', '\\??',	# Don't know how in LaTeX
#       '&#331;', '\\??',	# Don't know how in LaTeX
	'&#332;', '\\={O}',
	'&#333;', '\\={o}',
	'&#334;', '\\u{O}',
	'&#335;', '\\u{o}',
	'&#336;', '\\H{O}',
	'&#337;', '\\H{o}',
	'&#338;', '\\OE',
	'&#339;', '\\oe',
	'&#340;', '\\\'{R}',
	'&#341;', '\\\'{r}',
	'&#342;', '\\c{R}',
	'&#343;', '\\c{r}',
	'&#344;', '\\v{R}',
	'&#345;', '\\v{r}',
	'&#346;', '\\\'{S}',
	'&#347;', '\\\'{s}',
	'&#348;', '\\^{S}',
	'&#349;', '\\^{s}',
	'&#350;', '\\c{S}',
	'&#351;', '\\c{s}',
	'&#352;', '\\v{S}',
	'&#353;', '\\v{s}',
	'&#354;', '\\c{T}',
	'&#355;', '\\c{t}',
	'&#356;', '\\v{T}',
	'&#357;', '\\v{t}',
#       '&#358;', '\\?{T}',	# Don't know how in LaTeX
#       '&#359;', '\\?{t}',	# Don't know how in LaTeX
	'&#360;', '\\~{U}',
	'&#361;', '\\~{u}',
	'&#362;', '\\={U}',
	'&#363;', '\\={u}',
	'&#364;', '\\u{U}',
	'&#365;', '\\u{u}',
	'&#366;', '\\r{U}',
	'&#367;', '\\r{u}',
	'&#368;', '\\H{U}',
	'&#369;', '\\H{u}',
	'&#370;', '\\k{U}',
	'&#371;', '\\k{u}',
	'&#372;', '\\^{W}',
	'&#373;', '\\^{w}',
	'&#374;', '\\^{Y}',
	'&#375;', '\\^{y}',
	'&#376;', '\\"{Y}',
	'&#377;', '\\\'{Z}',
	'&#378;', '\\\'{z}',
	'&#379;', '\\.{Z}',
	'&#380;', '\\.{z}',
	'&#381;', '\\v{Z}',
	'&#382;', '\\v{z}'
	);

1;
