### File: latin7.pl
### Version 0.1,  September 10, 1999
### Written by Ross Moore <ross@maths.mq.edu.au>
###
### ISO_8859-13 encoding information
###

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
## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


$CHARSET = 'iso-8859-13';
$INPUTENC = 'latin7';


#Character ranges for lower --> upper-case conversion

$sclower = "\\270\\272\\277\\340-\\366\\370-\\376";
$scupper = "\\250\\252\\257\\300-\\326\\330-\\336";

#extra pattern match preceding  lower --> upper-case conversion
$scextra = "s/\\337/ss/g";

%extra_small_caps = ( '223' , 'ss' );

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
#	     ,'247', '215'
                 ,'248', '216'
                 ,'249', '217'
                 ,'250', '218'
                 ,'251', '219'
                 ,'252', '220'
                 ,'253', '221'
                 ,'254', '222'
#	     ,'255', '223'
                 ,'184', '200'
                 ,'186', '202'
                 ,'191', '207'
);


#sub do_cmd_oe { join('', &iso_map("oe", "lig"), $_[0]);}
#sub do_cmd_OE { join('', &iso_map("OE", "lig"), $_[0]);}
sub do_cmd_l { join('', &iso_map("l", "stroke"), $_[0]);}
sub do_cmd_L { join('', &iso_map("L", "stroke"), $_[0]);}
#sub do_cmd_ng { join('', &iso_map("eng", ""), $_[0]);}
sub do_cmd_ss { join('', &iso_map("sz", "lig"), $_[0]);}
sub do_cmd_i { join('', &iso_map("i", "nodot"), $_[0]);}


sub do_cmd_textonequarter { join('', &iso_map("frac14", ""), $_[0]);}
sub do_cmd_textonehalf { join('', &iso_map("frac12", ""), $_[0]);}
sub do_cmd_textthreequarters { join('', &iso_map("frac34", ""), $_[0]);}
sub do_cmd_textcent { join('', &iso_map("cent", ""), $_[0]);}
sub do_cmd_textyen { join('', &iso_map("yen", ""), $_[0]);}
sub do_cmd_textcurrency { join('', &iso_map("curren", ""), $_[0]);}
sub do_cmd_textbrokenbar { join('', &iso_map("brvbar", ""), $_[0]);}
sub do_cmd_textregistered { join('', &iso_map("reg", ""), $_[0]);}
sub do_cmd_textperiodcentered { join('', &iso_map("middot", ""), $_[0]);}
sub do_cmd_guillemotleft { join('', &iso_map("laquo", ""), $_[0]);}
sub do_cmd_guillemotright { join('', &iso_map("raquo", ""), $_[0]);}
sub do_cmd_quotedblbase { join('', &iso_map("dbquo", ""), $_[0]);}
sub do_cmd_quotesinglbase { join('', &iso_map("sbquo", ""), $_[0]);}

sub do_cmd_mathdegree { join('', &iso_map("deg", ""), $_[0]);}
sub do_cmd_mathonesuperior { join('', &iso_map("sup1", ""), $_[0]);}
sub do_cmd_mathtwosuperior { join('', &iso_map("sup2", ""), $_[0]);}
sub do_cmd_maththreesuperior { join('', &iso_map("sup3", ""), $_[0]);}
sub do_cmd_mathordmasculine { join('', &iso_map("ordm", ""), $_[0]);}
sub do_cmd_mathordfeminine { join('', &iso_map("ordf", ""), $_[0]);}

sub do_cmd_P { join('', &iso_map("para", ""), $_[0]);}
sub do_cmd_S { join('', &iso_map("sect", ""), $_[0]);}

sub do_cmd_pm { join('', &iso_map("plusmn", ""), $_[0]);}
sub do_cmd_div { join('', &iso_map("divide", ""), $_[0]);}
sub do_cmd_times { join('', &iso_map("times", ""), $_[0]);}
sub do_cmd_minus { join('', &iso_map("shy", ""), $_[0]);}
sub do_cmd_copyright { join('', &iso_map("copy", ""), $_[0]);}
sub do_cmd_pounds { join('', &iso_map("pound", ""), $_[0]);}
sub do_cmd_cents { join('', &iso_map("cent", ""), $_[0]);}
sub do_cmd_lnot { join('', &iso_map("not", ""), $_[0]);}
sub do_cmd_cdot { join('', &iso_map("middot", ""), $_[0]);}
sub do_cmd_micron { join('', &iso_map("micro", ""), $_[0]);}

%iso_8859_13_character_map
     = (
       'AElig', '&#191;',       # capital AE diphthong (ligature)
       'Amacr', '&#194;',       # capital A, with macron
       'Aogon', '&#192;',       # capital A, with ogonek
       'Aring', '&#197;',       # capital A, with ring
       'Auml' , '&#196;',       # capital A, dieresis or umlaut mark
       'Cacute','&#195;',       # capital C, acute accent
       'Ccaron','&#200;',       # capital C, with caron
       'Eacute','&#201;',       # capital E, acute accent
       'Edot' , '&#203;',       # capital E, with dot
       'Emacr', '&#199;',       # capital E, with macron
       'Eogon', '&#198;',       # capital E, with ogonek
       'Euml' , '&#203;',       # capital E, dieresis or umlaut mark
       'Gcedil','&#204;',       # capital G, cedilla
       'Imacr', '&#206;',       # capital I, with macron
       'Iogon', '&#193;',       # capital I, with ogonek
       'Kcedil','&#205;',       # capital K, cedilla
       'Lcedil','&#207;',       # capital L, cedilla
       'Lstrok','&#217;',       # capital L, with stroke
       'Nacute','&#209;',       # capital N, acute accent
       'Ncedil','&#210;',       # capital N, cedilla
       'Oacute','&#211;',       # capital O, acute accent
       'Omacr', '&#212;',       # capital O, with macron
       'Oslash','&#168;',       # capital O, slash
       'Otilde','&#213;',       # capital O, tilde
       'Ouml',  '&#214;',       # capital O, dieresis or umlaut mark
       'Rcedil','&#170;',	# capital R, cedil accent
       'Sacute','&#218;',       # capital S, acute accent
       'Scaron','&#208;',	# capital S, caron accent
       'Umacr', '&#219;',       # capital U, with macron
       'Uogon', '&#216;',       # capital U, with ogonek
       'Uuml' , '&#220;',       # capital U, dieresis or umlaut mark
       'Zacute','&#202;',       # capital Z, acute accent
       'Zcaron','&#222;',	# capital Z, caron accent
       'Zdot' , '&#221;',       # capital Z, with dot
#
       'aelig', '&#191;',       # small ae diphthong (ligature)
       'amacr', '&#226;',       # small a, with macron
       'amp', '&amp;',  # ampersand
       'aogon', '&#224;',       # small a, with ogonek
       'aring', '&#229;',       # small a, ring
       'auml' , '&#228;',       # small a, dieresis or umlaut mark
       'cacute','&#227;',       # small c, acute accent
       'cmacr', '&#232;',       # small c, with macron
       'eacute','&#233;',       # small e, acute accent
       'edot'  ,'&#235;',       # small e, with dot
       'emacr', '&#231;',       # small e, with macron
       'eogon', '&#230;',       # small e, with ogonek
       'gcedil','&#236;',       # small g, cedilla
       'gt', '&#62;',   # greater than
       'imacr', '&#238;',       # small i, with macron
       'iogon', '&#225;',       # small i, with ogonek
       'lstrok','&#241;',       # small l, with stroke
       'lt', '&lt;',    # less than
       'nacute','&#241;',       # small n, acute accent
       'ncedil','&#242;',       # small n, cedilla
       'oacute','&#243;',       # small o, acute accent
       'omacr', '&#244;',       # small o, with macron
       'oslash','&#184;',       # small o, slash
       'otilde','&#245;',       # small o, tilde
       'ouml' , '&#246;',       # small o, dieresis or umlaut mark
       'rcedil','&#186;',	# small r, cedil accent
       'sacute','&#250;',       # small s, acute accent
       'scaron','&#240;',	# small s, with caron
       'szlig', '&#223;',       # small sharp s, German (sz ligature)
       'umacr', '&#251;',       # small u, with macron
       'uogon', '&#248;',       # small u, with ogonek
       'uuml' , '&#252;',       # small u, dieresis or umlaut mark
       'zdot'  ,'&#253;',       # small z, with dot
       'zcaron','&#254;',	# small z, with caron
       'quot', '&quot;',        # double quote

# These have HTML mnemonic names for HTML 4.0 ...
       'nbsp', '&#160;',       # non-breaking space
       'rdquo', '&#161;',      # double quote, right
       'cent', '&#162;',       # cents sign
       'pound', '&#163;',      # pound sign
       'curren', '&#164;',     # currency sign
       'dbquo', '&#165;',
       'brvbar', '&#166;',  
       'sect', '&#167;',       # section mark
       'copy', '&#169;',       # copyright mark
       'laquo', '&#171;', 
       'raquo', '&#187;', 
       'not', '&#172;',
       'shy', '&#173;',
       'reg', '&#174;',
       'plusmn', '&#177;',
       'sup1', '&#185;',
       'sup2', '&#178;',
       'sup3', '&#179;',
       'ldquo', '&#180;',
       'micro', '&#181;',
       'para', '&#182;',    # paragraph mark
       'middot', '&#183;',
       'frac14', '&#188;',
       'frac12', '&#189;',
       'frac34', '&#190;',
       'times', '&#215;',
       'divide', '&#247;',
       'rsquo', '&#255;',

# These are character types without arguments ...
       'grave', "`",
       'circ', '^',
       'tilde', '&#126;',
       'dot', '.'
	);

%iso_8859_13_character_map_inv =
    (
     '^'      , '\\^{}',
     '&#62;'  , '\\ensuremath{>}',
     '&lt;'   , '\\ensuremath{<}',
     '&amp;'  , '\\&',
     '&#126;' , '\\~{}',
     '&#160;' , '\\nobreakspace{}',
     '&#161;' , "{''}",
     '&#162;' , '\\textcent{}',
     '&#163;' , '\\pounds{}',
     '&#164;' , '\\textcurrency{}',
     '&#165;' , '\\quotedblbase{}',
     '&#166;' , '\\textbrokenbar{}',
     '&#167;' , '\\S{}',
     '&#168;' , '\\O{}',
     '&#169;' , '\\copyright{}',
	'&#170;' , '\\c{R}',
	'&#171;' , '\\guillemotleft{}',
	'&#172;' , '\\lnot{}',
	'&#173;' , '\\-',
#	'&#174;' , '\\textregistered{}',
	 '&#174;' , '\\ensuremath{\\circledR}',
     '&#175;' , '\\AE{}',
#	'&#176;' , '\\mathdegree{}',
     '&#176;' , '\\ensuremath{^{\\circ}}',
	'&#177;' , '\\ensuremath{\\pm}',
#	'&#178;' , '\\mathtwosuperior{}',
	'&#178;' , '\\ensuremath{^{2}}',
#	'&#179;' , '\\maththreesuperior{}',
	'&#179;' , '\\ensuremath{^{3}}',
     '&#180;' , '{``}',
	'&#181;' , '\\ensuremath{\\mu}',
     '&#182;' , '\\P{}',
#	'&#183;' , '\\textperiodcentered{}',
     '&#183;' , '\\ensuremath{\\cdot{}}',
     '&#184;' , '\\o{}',
#	'&#185;' , '\\mathonesuperior{}',
	'&#185;' , '\\ensuremath{^{1}}',
	'&#186;' , '\\c{r}',
	'&#187;' , '\\guillemotright{}',
#	'&#188;' , '\\textonequarter{}',
	'&#188;' , '\\ensuremath{\\frac{1}{4}}',
#	'&#189;' , '\\textonehalf{}',
	'&#189;' , '\\ensuremath{\\frac{1}{2}}',
#	'&#190;' , '\\textthreequarters{}',
	'&#190;' , '\\ensuremath{\\frac{3}{4}}',
     '&#191;' , '\\ae{}',
     '&#192;' , '\\k{A}',
     '&#193;' , '\\k{I}',
     '&#194;' , '\\={A}',
     '&#195;' , '\\\'{C}',
     '&#196;' , '\\"{A}',
     '&#197;' , '\\r{A}',
     '&#198;' , '\\k{E}',
     '&#199;' , '\\={E}',
     '&#200;' , '\\v{C}',
     '&#201;' , '\\\'{E}',
     '&#202;' , '\\\'{Z}',
     '&#203;' , '\\.{E}',
     '&#204;' , '\\c{G}',
     '&#205;' , '\\c{K}',
     '&#206;' , '\\={I}',
     '&#207;' , '\\c{L}',
     '&#208;' , '\\v{S}',
     '&#209;' , '\\\'{N}',
     '&#210;' , '\\c{N}',
     '&#211;' , '\\\'{O}',
     '&#212;' , '\\={O}',
     '&#213;' , '\\~{O}',
     '&#214;' , '\\"{O}',
	'&#215;' , '\\ensuremath{\\times}',
     '&#216;' , '\\k{U}',
     '&#217;' , '\\L{}',
     '&#218;' , '\\\'{S}',
     '&#219;' , '\\={U}',
     '&#220;' , '\\"{U}',
     '&#221;' , '\\.{Z}',
     '&#222;' , '\\v{Z}',
     '&#223;' , '\\ss{}',
     '&#224;' , '\\k{a}',
     '&#225;' , '\\k{\\i}',
     '&#226;' , '\\={a}',
     '&#227;' , '\\\'{c}',
     '&#228;' , '\\"{a}',
     '&#229;' , '\\r{a}',
     '&#230;' , '\\k{e}',
     '&#231;' , '\\={e}',
     '&#232;' , '\\v{c}',
     '&#233;' , '\\\'{e}',
     '&#234;' , '\\\'{z}',
     '&#235;' , '\\.{e}',
     '&#236;' , '\\c{g}',
     '&#237;' , '\\c{k}',
     '&#238;' , '\\={\\i}',
     '&#239;' , '\\c{l}',
     '&#240;' , '\\v{s}',
     '&#241;' , '\\\'{n}',
     '&#242;' , '\\c{n}',
     '&#243;' , '\\\'{o}',
     '&#244;' , '\\={o}',
     '&#245;' , '\\~{o}',
     '&#246;' , '\\"{o}',
	'&#247;' , '\\ensuremath{\\div}',
     '&#248;' , '\\k{u}',
     '&#249;' , '\\l{}',
     '&#250;' , '\\\'{s}',
     '&#251;' , '\\={u}',
     '&#252;' , '\\"{u}',
     '&#253;' , '\\.{z}',
     '&#254;' , '\\v{z}',
     '&#255;' , "{'}",
);

1;
