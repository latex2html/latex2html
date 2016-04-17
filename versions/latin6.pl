### File: latin6.pl
### Version 0.1,  December 19, 1997
###   includes lower --> uppercase conversion tables
###
### ISO_8859-10 encoding information
###

## Copyright (C) 1995 by Ross Moore
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


$CHARSET = "iso-8859-10";
$INPUTENC='latin6';  # empty implies 'latin1'


#Character ranges for lower --> upper-case conversion

$sclower = "\\261-\\266\\270-\\274\\276\\277\\340-\\376";
$scupper = "\\241-\\246\\250-\\254\\256\\257\\300-\\336";

#extra pattern match preceding  lower --> upper-case conversion
$scextra = "s/\\337/ss/g";

%extra_small_caps = ( '223' , 'ss' );

%low_entities = ( '177', '161'
#	     ,'178', '162'
                 ,'179', '163'
	         ,'180', '164'
                 ,'181', '165'
                 ,'182', '166'
#	     ,'183', '167'
	         ,'184', '168'
                 ,'185', '169'
                 ,'186', '170'
                 ,'187', '171'
                 ,'188', '172'
#	     ,'189', '173'
                 ,'190', '174'
                 ,'191', '175'
                 ,'224', '192'
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
#	     ,'255', '223'
);


sub do_cmd_tl { join('', &iso_map("t", "strok"), $_[0]);}
sub do_cmd_TL { join('', &iso_map("T", "strok"), $_[0]);}
sub do_cmd_dh { join('', &iso_map("d", "strok"), $_[0]);}
sub do_cmd_DH { join('', &iso_map("D", "strok"), $_[0]);}
sub do_cmd_ss { join('', &iso_map("sz", "lig"), $_[0]);}
sub do_cmd_ng { join('', &iso_map("eng", ""), $_[0]);}
sub do_cmd_NG { join('', &iso_map("ENG", ""), $_[0]);}
sub do_cmd_kra { join('', &iso_map("k", "green"), $_[0]);}

sub do_cmd_textcurrency { join('', &iso_map("curren", ""), $_[0]);}

sub do_cmd_mathdegree { join('', &iso_map("deg", ""), $_[0]);}

sub do_cmd_S { join('', &iso_map("sect", ""), $_[0]);}
sub do_cmd_div { join('', &iso_map("divide", ""), $_[0]);}
sub do_cmd_times { join('', &iso_map("times", ""), $_[0]);}
#sub do_cmd_minus { join('', &iso_map("shy", ""), $_[0]);}


%iso_8859_10_character_map
     = (
	'Aacute', '&#193;', 	# capital A, acute accent 
	'Acirc', '&#194;', 	# capital A, circumflex accent 
       'AElig', '&#198;',       # capital AE diphthong (ligature)
	'Aogon', '&#161;',	# capital A, ogonek accent
	'Amacr', '&#192;',	# capital A, macron accent
       'Aring', '&#197;',       # capital A, ring
        'Atilde', '&#195;',     # capital A, tilde
	'Auml', '&#196;', 	# capital A, dieresis or umlaut mark   
	'Ccaron', '&#200;', 	# capital C, caron accent 
	'Dstrok', '&#169;', 	# capital D, stroke
	'ETH', '&#208;', 	# capital Eth, Icelandic 
	'Eacute', '&#201;', 	# capital E, acute accent 
	'Edot', '&#204;',	# capital E, dot above
	'Eng', '&#175;',	# capital Eng (Sami)
	'Eogon', '&#202;', 	# capital E, ogonek accent 
	'Emacr', '&#170;',	# capital E, macron accent
	'Euml', '&#203;', 	# capital E, dieresis or umlaut mark 
	'Gcedil', '&#163;',	# capital G, cedilla accent
	'Iacute', '&#205;', 	# capital I, acute accent 
	'Icirc', '&#206;', 	# capital I, circumflex accent 
	'Imacr', '&#164;',	# capital I, macron accent
	'Iogon', '&#199;',	# capital I, ogonek accent
	'Itilde', '&#165;',	# capital I, tilde accent
       'Iuml', '&#207;',        # capital I, dieresis or umlaut mark
	'Lcedil', '&#168;',	# capital L, cedil accent
	'Kcedil', '&#166;',	# capital K, cedilla accent
	'Ncedil', '&#209;',	# capital N, cedil accent
       'Oacute', '&#211;',      # capital O, acute accent
	'Ocirc', '&#212;', 	# capital O, circumflex accent 
	'Omacr', '&#210;',	# capital O, macron accent
       'Oslash', '&#216;',      # capital O, slash
       'Otilde', '&#213;',      # capital O, tilde
	'Ouml', '&#214;', 	# capital O, dieresis or umlaut mark
	'Racute', '&#192;', 	# capital R, acute accent 
	'Rcedil', '&#163;',	# capital R, cedilla accent
	'Scaron', '&#170;',	# capital S, caron accent
	'Tstrok', '&#171;',	# capital T, stroke
	'Uacute', '&#218;', 	# capital U, acute accent 
       'Ucirc', '&#219;',       # capital U, circumflex accent
	'Umacr', '&#174;',	# capital U, macron accent
	'Uogon', '&#217;',	# capital U, ogonek accent
	'Utilde', '&#215;',	# capital U, tilde accent
	'Uuml', '&#220;', 	# capital U, dieresis or umlaut mark 
       'Yacute', '&#221;',      # capital Y, acute accent
	'Zcaron', '&#172;',	# capital Z, caron accent
	'aacute', '&#225;', 	# small a, acute accent 
	'acirc', '&#226;', 	# small a, circumflex accent 
       'aelig', '&#230;',       # small ae diphthong (ligature)
	'amacr', '&#224;',	# small a, macron accent
	'amp', '&amp;', 	# ampersand 
	'aogon', '&#177;',	# small a, ogonek accent
       'aring', '&#229;',       # small a, ring
        'atilde', '&#227;',     # small a, tilde
	'auml', '&#228;', 	# small a, dieresis or umlaut mark   
	'ccaron', '&#232;', 	# small c, caron accent 
	'dstrok', '&#185;', 	# small d, stroke
	'eacute', '&#233;', 	# small e, acute accent 
	'edot', '&#236;',	# small e, dot above
	'emacr', '&#186;',	# small e, macron accent
	'eogon', '&#234;', 	# small e, ogonek accent 
	'emdash', '&#189;',	# em-dash
	'endash', '&#173;',	# en-dash
	'eng', '&#191;',	# small eng (Sami)
	'eth', '&#240;', 	# small eth, Icelandic
	'euml', '&#235;', 	# small e, dieresis or umlaut mark 
	'gcedil', '&#179;',	# small g, cedilla accent
	'gt', '&#62;',		# greater than 
	'iacute', '&#237;', 	# small i, acute accent 
	'icirc', '&#238;', 	# small i, circumflex accent 
	'imacr', '&#180;',	# small i, macron accent
	'iogon', '&#231;',	# small i, ogonek accent
	'itilde', '&#181;',	# small i, tilde accent
       'iuml', '&#239;',        # small i, dieresis or umlaut mark
	'kcedil', '&#182;',	# small k, cedilla accent
	'kgreen', '&#162;',	# small kra (Greenlandic)
	'lcedil', '&#184;',	# small l, cedil accent
	'lt', '&lt;',		# less than 
	'ncedil', '&#241;',	# small n, cedil accent
       'oacute', '&#243;',      # small o, acute accent
	'ocirc', '&#244;', 	# small o, circumflex accent 
	'omacr', '&#242;',	# small o, macron accent
       'oslash', '&#248;',      # small o, slash
       'otilde', '&#245;',      # small o, tilde
	'ouml', '&#246;', 	# small o, dieresis or umlaut mark
	'quot', '&quot;',	# double quote
	'racute', '&#224;', 	# small r, acute accent 
	'rcedil', '&#179;',	# small r, cedilla accent
	'scaron', '&#186;',	# small s, caron accent
	'szlig', '&#223;', 	# small sharp s, German (sz ligature) 
	'tstrok', '&#187;',	# small t, stroke
	'uacute', '&#250;', 	# small u, acute accent 
       'ucirc', '&#251;',       # small u, circumflex accent
	'umacr', '&#190;',	# small u, macron accent
	'uogon', '&#249;',	# small u, ogonek accent
	'utilde', '&#247;',	# small u, tilde accent
	'uuml', '&#252;', 	# small u, dieresis or umlaut mark 
       'yacute', '&#253;',      # small y, acute accent
	'zcaron', '&#188;',	# small z, caron accent

# These do not have HTML mnemonic names ...
       'nbsp', '&#160;',      # non-breaking space
       'sect', '&#167;',      # section mark

# These are character types without arguments ...
	'grave' , "`",
	'circ', '^',
	'tilde', '&#126;',
	'deg', '&#176;',
	);


%iso_8859_10_character_map_inv =
    (
     '&#62;'  , '\\ensuremath{>}',
     '&lt;'   , '\\ensuremath{<}',
     '&amp;'  , '&',
     '^'      , '\\^{}',
     '&#126;' , '\\~{}',
     '&quot;' , '"',

     '&#160;' , '\\nobreakspace{}',
     '&#161;' , '\\k{A}',
     '&#162;' , '\\={E}',
     '&#163;' , '\\c{G}',
     '&#164;' , '\\={I}',
     '&#165;' , '\\~{I}',
     '&#166;' , '\\c{K}',
     '&#167;' , '\\S{}',
     '&#168;' , '\\c{L}',
     '&#169;' , '\\DH{}',
     '&#170;' , '\\v{S}',
     '&#171;' , '\\TL{}',
     '&#172;' , '\\v{Z}',
     '&#173;' , '{--}',
     '&#174;' , '\\={U}',
     '&#175;' , '\\NG{}',
     '&#176;' , '\\r{}',
     '&#177;' , '\\k{a}',
     '&#178;' , '\\={e}',
     '&#179;' , '\\c{g}',
     '&#180;' , '\\={\i}',
     '&#181;' , '\\~{\i}',
     '&#182;' , '\\c{k}',
     '&#183;' , '\\cdot{}',
     '&#184;' , '\\c{l}',
     '&#185;' , '\\dh{}',
     '&#186;' , '\\v{s}',
     '&#187;' , '\\tl{}',
     '&#188;' , '\\v{z}',
     '&#189;' , '{---}',
     '&#190;' , '\\={u}',
     '&#191;' , '\\ng{}',
     '&#192;' , '\\={A}',
     '&#193;' , '\\\'{A}',
     '&#194;' , '\\^{A}',
     '&#195;' , '\\~{A}',
     '&#196;' , '\\"{A}',
     '&#197;' , '\\r{A}',
     '&#198;' , '\\AE{}',
     '&#199;' , '\\k{I}',
     '&#200;' , '\\v{C}',
     '&#201;' , '\\\'{E}',
     '&#202;' , '\\k{E}',
     '&#203;' , '\\"{E}',
     '&#204;' , '\\dot{E}',
     '&#205;' , '\\\'{I}',
     '&#206;' , '\\^{I}',
     '&#207;' , '\\"{I}',
     '&#208;' , '\\DH{}',
     '&#209;' , '\\c{N}',
     '&#210;' , '\\={O}',
     '&#211;' , '\\\'{O}',
     '&#212;' , '\\^{O}',
     '&#213;' , '\\~{O}',
     '&#214;' , '\\"{O}',
     '&#215;' , '\\~{U}',
     '&#216;' , '\\O{}',
     '&#217;' , '\\k{U}',
     '&#218;' , '\\\'{U}',
     '&#219;' , '\\^{U}',
     '&#220;' , '\\"{U}',
     '&#221;' , '\\\'{Y}',
     '&#222;' , '\\TH{}',
     '&#223;' , '\\ss{}',
     '&#224;' , '\\={a}',
     '&#225;' , '\\\'{a}',
     '&#226;' , '\\^{a}',
     '&#227;' , '\\~{a}',
     '&#228;' , '\\"{a}',
     '&#229;' , '\\r{a}',
     '&#230;' , '\\ae{}',
     '&#231;' , '\\k{\i}',
     '&#232;' , '\\v{c}',
     '&#233;' , '\\\'{e}',
     '&#234;' , '\\k{e}',
     '&#235;' , '\\"{e}',
     '&#236;' , '\\dot{e}',
     '&#237;' , '\\\'{\\i}',
     '&#238;' , '\\^{\\i}',
     '&#239;' , '\\"{\i}',
     '&#240;' , '\\dh{}',
     '&#241;' , '\\c{n}',
     '&#242;' , '\\={o}',
     '&#243;' , '\\\'{o}',
     '&#244;' , '\\^{o}',
     '&#245;' , '\\~{o}',
     '&#246;' , '\\"{o}',
     '&#247;' , '\\~{u}',
     '&#248;' , '\\o{}',
     '&#249;' , '\\k{u}',
     '&#250;' , '\\\'{u}',
     '&#251;' , '\\^{u}',
     '&#252;' , '\\"{u}',
     '&#253;' , '\\\'{y}',
     '&#254;' , '\\th{}',
     '&#255;' , '\\kra{}'
);

1;









