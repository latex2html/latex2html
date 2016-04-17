### File: latin2.pl
### Version 0.1,  October 25, 1997
### Written by Ross Moore <ross@mpce.mq.edu.au>
### Version 0.2,  November 1, 1997
###   extended to include macros in LaTeX's  latin2.def
### Version 0.3,  December 12, 1997
###   includes lower --> uppercase conversion tables
###
### ISO_8859-2 encoding information
###
### extracted from  i18n.pl  contains...
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


$CHARSET = "iso-8859-2";
$INPUTENC = 'latin2';


#Character ranges for lower --> upper-case conversion

$sclower = "\\261\\263\\265\\266\\271-\\274\\276\\277\\340-\\366\\370-\\376";
$scupper = "\\241\\243\\245\\246\\251-\\254\\256\\257\\300-\\326\\330-\\336";

#extra pattern match preceding  lower --> upper-case conversion
$scextra = "s/\\337/ss/g";

%extra_small_caps = ( '223' , 'ss' );

%low_entities = ( '177', '161'
#	     ,'178', '162'
                 ,'179', '163'
#	     ,'180', '164'
                 ,'181', '165'
                 ,'182', '166'
#	     ,'183', '167'
#	     ,'184', '168'
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
#	     ,'247', '215'
                 ,'248', '216'
                 ,'249', '217'
                 ,'250', '218'
                 ,'251', '219'
                 ,'252', '220'
                 ,'253', '221'
                 ,'254', '222'
#	     ,'255', '223'
);


sub do_cmd_l { join('', &iso_map("l", "strok"), $_[0]);}
sub do_cmd_L { join('', &iso_map("L", "strok"), $_[0]);}
# inhibit later wrapping for an image
$raw_arg_cmds{'l'} = $raw_arg_cmds{'L'} = -1 ;

sub do_cmd_dh { join('', &iso_map("d", "strok"), $_[0]);}
sub do_cmd_DH { join('', &iso_map("D", "strok"), $_[0]);}
sub do_cmd_ss { join('', &iso_map("sz", "lig"), $_[0]);}

sub do_cmd_textcurrency { join('', &iso_map("curren", ""), $_[0]);}

sub do_cmd_mathdegree { join('', &iso_map("deg", ""), $_[0]);}

sub do_cmd_S { join('', &iso_map("sect", ""), $_[0]);}
sub do_cmd_div { join('', &iso_map("divide", ""), $_[0]);}
sub do_cmd_times { join('', &iso_map("times", ""), $_[0]);}
sub do_cmd_minus { join('', &iso_map("shy", ""), $_[0]);}
sub do_cmd_cdot { join('', &iso_map("middot", ""), $_[0]);}


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

# These do not have HTML mnemonic names ...
       'nbsp', '&#160;',      # non-breaking space
       'curren', '&#164;',    # currency sign
       'sect', '&#167;',      # section mark
       'times', '&#215;',
       'divide', '&#247;',

# These are character types without arguments ...
	'grave' , "`",
	'circ', '^',
	'tilde', '&#126;',
	'breve', '&#162;',
	'uml', '&#168;',
	'deg', '&#176;',
	'ogon', '&#178;',
	'acute' , "&#180;",
	'caron', '&#183;',
	'cedil', "&#184;",
	'dblac', "&#189;",
	'dot', '&#255;'
	);


%iso_8859_2_character_map_inv =
    (
     '&#62;'  , '\\ensuremath{>}',
     '&lt;'   , '\\ensuremath{<}',
     '&amp;'  , '&',
     '^'      , '\\^{}',
     '&#126;' , '\\~{}',
     '&quot;' , '"',

     '&#160;' , '\\nobreakspace{}',
     '&#161;' , '\\k{A}',
     '&#162;' , '\\u{}',
     '&#163;' , '\\L{}',
     '&#164;' , '\\textcurrency{}',
     '&#165;' , '\\v{L}',
     '&#166;' , '\\\'{S}',
     '&#167;' , '\\S{}',
     '&#168;' , '\\"{}',
     '&#169;' , '\\v{S}',
     '&#170;' , '\\c{S}',
     '&#171;' , '\\v{T}',
     '&#172;' , '\\\'{Z}',
     '&#173;' , '\\-',
     '&#174;' , '\\v{Z}',
     '&#175;' , '\\.{Z}',
     '&#176;' , '\\r{}',
     '&#177;' , '\\k{a}',
     '&#178;' , '\\k{ }',
     '&#179;' , '\\l{}',
     '&#180;' , '\\\'{}',
     '&#181;' , '\\v{l}',
     '&#182;' , '\\\'{s}',
     '&#183;' , '\\v{}',
     '&#184;' , '\\c{ }',
     '&#185;' , '\\v{s}',
     '&#186;' , '\\c{s}',
     '&#187;' , '\\v{t}',
     '&#188;' , '\\\'{z}',
     '&#189;' , '\\H{}',
     '&#190;' , '\\v{z}',
     '&#191;' , '\\.{z}',
     '&#192;' , '\\\'{R}',
     '&#193;' , '\\\'{A}',
     '&#194;' , '\\^{A}',
     '&#195;' , '\\u{A}',
     '&#196;' , '\\"{A}',
     '&#197;' , '\\\'{L}',
     '&#198;' , '\\\'{C}',
     '&#199;' , '\\c{C}',
     '&#200;' , '\\v{C}',
     '&#201;' , '\\\'{E}',
     '&#202;' , '\\k{E}',
     '&#203;' , '\\"{E}',
     '&#204;' , '\\v{E}',
     '&#205;' , '\\\'{I}',
     '&#206;' , '\\^{I}',
     '&#207;' , '\\v{D}',
     '&#208;' , '\\DH{}',
     '&#209;' , '\\\'{N}',
     '&#210;' , '\\v{N}',
     '&#211;' , '\\\'{O}',
     '&#212;' , '\\^{O}',
     '&#213;' , '\\H{O}',
     '&#214;' , '\\"{O}',
     '&#215;' , '\\ensuremath{\\times}',
     '&#216;' , '\\v{R}',
     '&#217;' , '\\r{U}',
     '&#218;' , '\\\'{U}',
     '&#219;' , '\\H{U}',
     '&#220;' , '\\"{U}',
     '&#221;' , '\\\'{Y}',
     '&#222;' , '\\c{T}',
     '&#223;' , '\\ss{}',
     '&#224;' , '\\\'{r}',
     '&#225;' , '\\\'{a}',
     '&#226;' , '\\^{a}',
     '&#227;' , '\\u{a}',
     '&#228;' , '\\"{a}',
     '&#229;' , '\\\'{l}',
     '&#230;' , '\\\'{c}',
     '&#231;' , '\\c{c}',
     '&#232;' , '\\v{c}',
     '&#233;' , '\\\'{e}',
     '&#234;' , '\\k{e}',
     '&#235;' , '\\"{e}',
     '&#236;' , '\\v{e}',
     '&#237;' , '\\\'{\\i}',
     '&#238;' , '\\^{\\i}',
     '&#239;' , '\\v{d}',
     '&#240;' , '\\dh{}',
     '&#241;' , '\\\'{n}',
     '&#242;' , '\\v{n}',
     '&#243;' , '\\\'{o}',
     '&#244;' , '\\^{o}',
     '&#245;' , '\\H{o}',
     '&#246;' , '\\"{o}',
     '&#247;' , '\\ensuremath{\\div}',
     '&#248;' , '\\v{r}',
     '&#249;' , '\\r{u}',
     '&#250;' , '\\\'{u}',
     '&#251;' , '\\H{u}',
     '&#252;' , '\\"{u}',
     '&#253;' , '\\\'{y}',
     '&#254;' , '\\c{t}',
     '&#255;' , '\\.{}'
);

1;









