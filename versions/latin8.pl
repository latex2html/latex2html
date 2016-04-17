### File: latin8.pl
### Version 0.1,  September 10, 1999
### Written by Ross Moore <ross@maths.mq.edu.au>
###
### ISO_8859-14 encoding information
###
### based on latin1.pl

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

$CHARSET = "iso-8859-14";
$INPUTENC='latin8';  # empty implies 'latin1'

#Character ranges for lower --> upper-case conversion

$sclower = "\\242\\245\\253\\270\\272\\274\\261\\263\\265\\271\\277\\276\\340-\\376\\377";
$scupper = "\\241\\244\\246\\250\\252\\254\\260\\262\\264\\267\\273\\275\\300-\\336\\257";

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
                 ,'247', '215'
                 ,'248', '216'
                 ,'249', '217'
                 ,'250', '218'
                 ,'251', '219'
                 ,'252', '220'
                 ,'253', '221'
                 ,'254', '222'
	     ,'255', '175'
	     ,'162', '161'
	     ,'165', '164'
	     ,'171', '166'
	     ,'184', '168'
	     ,'186', '170'
	     ,'188', '172'
	     ,'177', '176'
	     ,'179', '178'
	     ,'181', '180'
	     ,'185', '183'
	     ,'191', '187'
	     ,'190', '189'
);



sub do_cmd_ss { join('', &iso_map("sz", "lig"), $_[0]);}


sub do_cmd_textregistered { join('', &iso_map("reg", ""), $_[0]);}
sub do_cmd_P { join('', &iso_map("para", ""), $_[0]);}
sub do_cmd_S { join('', &iso_map("sect", ""), $_[0]);}
#sub do_cmd_minus { join('', &iso_map("shy", ""), $_[0]);}
sub do_cmd_copyright { join('', &iso_map("copy", ""), $_[0]);}
sub do_cmd_pounds { join('', &iso_map("pound", ""), $_[0]);}

%iso_8859_14_character_map
     = (
       'AElig', '&#198;',       # capital AE diphthong (ligature)
       'Aacute', '&#193;',      # capital A, acute accent
       'Acirc', '&#194;',       # capital A, circumflex accent
       'Agrave', '&#192;',      # capital A, grave accent
       'Aring', '&#197;',       # capital A, ring
       'Atilde', '&#195;',      # capital A, tilde
       'Auml', '&#196;',        # capital A, dieresis or umlaut mark
       'Bdot', '&#161;',        # capital B, with dot
       'Ccedil', '&#199;',      # capital C, cedilla
       'Cdot', '&#164;',        # capital C, with dot
       'Ddot', '&#166;',        # capital D, with dot
       'Eacute', '&#201;',      # capital E, acute accent
       'Ecirc', '&#202;',       # capital E, circumflex accent
       'Egrave', '&#200;',      # capital E, grave accent
       'Euml', '&#203;',        # capital E, dieresis or umlaut mark
       'Fdot', '&#176;',        # capital F, with dot
       'Gdot', '&#178;',        # capital G, with dot
       'Iacute', '&#205;',      # capital I, acute accent
       'Icirc', '&#206;',       # capital I, circumflex accent
       'Igrave', '&#204;',      # capital I, grave accent
       'Iuml', '&#207;',        # capital I, dieresis or umlaut mark
       'Mdot', '&#180;',        # capital M, with dot
       'Ntilde', '&#209;',      # capital N, tilde
       'Oacute', '&#211;',      # capital O, acute accent
       'Ocirc', '&#212;',       # capital O, circumflex accent
       'Ograve', '&#210;',      # capital O, grave accent
       'Oslash', '&#216;',      # capital O, slash
       'Otilde', '&#213;',      # capital O, tilde
       'Ouml', '&#214;',        # capital O, dieresis or umlaut mark
       'Pdot', '&#183;',        # capital P, with dot
       'Sdot', '&#187;',        # capital S, with dot
       'Tdot', '&#215;',        # capital T, with dot
       'Uacute', '&#218;',      # capital U, acute accent
       'Ucirc', '&#219;',       # capital U, circumflex accent
       'Ugrave', '&#217;',      # capital U, grave accent
       'Uuml', '&#220;',        # capital U, dieresis or umlaut mark
       'Wacute', '&#170;',      # capital W, acute accent
       'Wcirc', '&#208;',       # capital W, circumflex accent
       'Wgrave', '&#168;',      # capital W, grave accent
       'Wuml', '&#189;',        # capital W, dieresis or umlaut mark
       'Yacute', '&#221;',      # capital Y, acute accent
       'Ygrave', '&#172;',      # capital Y, grave accent
       'Ycirc', '&#222;',       # capital Y, circumflex accent
       'Yuml', '&#175;',        # capital Y, dieresis or umlaut mark
#
       'aacute', '&#225;',      # small a, acute accent
       'acirc', '&#226;',       # small a, circumflex accent
       'aelig', '&#230;',       # small ae diphthong (ligature)
       'agrave', '&#224;',      # small a, grave accent
       'amp', '&amp;',  # ampersand
       'aring', '&#229;',       # small a, ring
       'atilde', '&#227;',      # small a, tilde
       'auml', '&#228;',        # small a, dieresis or umlaut mark
       'bdot', '&#162;',        # small b, with dot
       'cdot', '&#165;',        # small c, with dot
       'ccedil', '&#231;',      # small c, cedilla
       'ddot', '&#171;',        # small d, with dot
       'eacute', '&#233;',      # small e, acute accent
       'ecirc', '&#234;',       # small e, circumflex accent
       'egrave', '&#232;',      # small e, grave accent
       'eth', '&#240;',         # small eth, Icelandic
       'euml', '&#235;',        # small e, dieresis or umlaut mark
       'fdot', '&#177;',        # small f, with dot
       'gdot', '&#179;',        # small g, with dot
       'gt', '&#62;',   # greater than
       'iacute', '&#237;',      # small i, acute accent
       'icirc', '&#238;',       # small i, circumflex accent
       'igrave', '&#236;',      # small i, grave accent
       'iuml', '&#239;',        # small i, dieresis or umlaut mark
       'lt', '&lt;',    # less than
       'mdot', '&#181;',        # small m, with dot
       'ntilde', '&#241;',      # small n, tilde
       'oacute', '&#243;',      # small o, acute accent
       'ocirc', '&#244;',       # small o, circumflex accent
       'ograve', '&#242;',      # small o, grave accent
       'oslash', '&#248;',      # small o, slash
       'otilde', '&#245;',      # small o, tilde
       'ouml', '&#246;',        # small o, dieresis or umlaut mark
       'pdot', '&#185;',        # small p, with dot
       'sdot', '&#191;',        # small s, with dot
       'szlig', '&#223;',       # small sharp s, German (sz ligature)
       'tdot', '&#247;',        # small t, with dot
       'uacute', '&#250;',      # small u, acute accent
       'ucirc', '&#251;',       # small u, circumflex accent
       'ugrave', '&#249;',      # small u, grave accent
       'uuml', '&#252;',        # small u, dieresis or umlaut mark
       'wacute', '&#186;',      # small w, acute accent
       'wcirc', '&#240;',       # small w, circumflex accent
       'wgrave', '&#184;',      # small w, grave accent
       'wuml', '&#190;',        # small w, dieresis or umlaut mark
       'yacute', '&#253;',      # small y, acute accent
       'ycirc', '&#254;',       # small y, circumflex accent
       'ygrave', '&#188;',      # small y, grave accent
       'yuml', '&#255;',        # small y, dieresis or umlaut mark
       'quot', '&quot;',        # double quote

# These have HTML mnemonic names for HTML 4.0 ...
       'nbsp', '&#160;',       # non-breaking space
       'pound', '&#163;',      # pound sign
       'sect', '&#167;',       # section mark
       'copy', '&#169;',       # copyright mark
       'shy', '&#173;',
       'reg', '&#174;',
       'para', '&#182;',   # paragraph mark

# These are character types without arguments ...
       'grave' , "`",
	);


%iso_8859_14_character_map_inv =
    (
     '^'      , '\\^{}',
     '&#62;'  , '\\ensuremath{>}',
     '&lt;'   , '\\ensuremath{<}',
     '&amp;'  , '\\&',
     '&#126;' , '\\~{}',
	'&#160;' , '\\nobreakspace{}',
     '&#161;' , '\\.{B}',
     '&#162;' , '\\.{b}',
     '&#163;' , '\\pounds{}',
     '&#164;' , '\\.{C}',
     '&#165;' , '\\.{c}',
     '&#166;' , '\\.{D}',
     '&#167;' , '\\S{}',
     '&#168;' , '\\`{W}',
     '&#169;' , '\\copyright{}',
     '&#170;' , '\\\'{W}',
     '&#171;' , '\\.{d}',
     '&#172;' , '\\`{Y}',
	'&#173;' , '\\-',
#	'&#174;' , '\\textregistered{}',
	 '&#174;' , '\\ensuremath{\\circledR}',
     '&#175;' , '\\"{Y}',
     '&#176;' , '\\.{F}',
     '&#177;' , '\\.{f}',
     '&#178;' , '\\.{G}',
     '&#179;' , '\\.{g}',
     '&#180;' , '\\.{M}',
     '&#181;' , '\\.{m}',
     '&#182;' , '\\P{}',
     '&#183;' , '\\.{P}',
     '&#184;' , '\\`{w}',
     '&#185;' , '\\.{p}',
     '&#186;' , '\\\'{w}',
     '&#187;' , '\\.{S}',
     '&#188;' , '\\`{y}',
     '&#189;' , '\\"{W}',
     '&#190;' , '\\"{w}',
     '&#191;' , '\\.{s}',
     '&#192;' , '\\`{A}',
     '&#193;' , '\\\'{A}',
     '&#194;' , '\\^{A}',
     '&#195;' , '\\~{A}',
     '&#196;' , '\\"{A}',
#     '&#197;' , '\\AA{}',
     '&#197;' , '\\r{A}',
     '&#198;' , '\\AE{}',
     '&#199;' , '\\c{C}',
     '&#200;' , '\\`{E}',
     '&#201;' , '\\\'{E}',
     '&#202;' , '\\^{E}',
     '&#203;' , '\\"{E}',
     '&#204;' , '\\`{I}',
     '&#205;' , '\\\'{I}',
     '&#206;' , '\\^{I}',
     '&#207;' , '\\"{I}',
     '&#208;' , '\\^{W}',
     '&#209;' , '\\~{N}',
     '&#210;' , '\\`{O}',
     '&#211;' , '\\\'{O}',
     '&#212;' , '\\^{O}',
     '&#213;' , '\\~{O}',
     '&#214;' , '\\"{O}',
     '&#215;' , '\\.{T}',
     '&#216;' , '\\O{}',
     '&#217;' , '\\`{U}',
     '&#218;' , '\\\'{U}',
     '&#219;' , '\\^{U}',
     '&#220;' , '\\"{U}',
     '&#221;' , '\\\'{Y}',
     '&#222;' , '\\^{Y}',
     '&#223;' , '\\ss{}',
     '&#224;' , '\\`{a}',
     '&#225;' , '\\\'{a}',
     '&#226;' , '\\^{a}',
     '&#227;' , '\\~{a}',
     '&#228;' , '\\"{a}',
#     '&#229;' , '\\aa{}',
     '&#229;' , '\\r{a}',
     '&#230;' , '\\ae{}',
     '&#231;' , '\\c{c}',
     '&#232;' , '\\`{e}',
     '&#233;' , '\\\'{e}',
     '&#234;' , '\\^{e}',
     '&#235;' , '\\"{e}',
     '&#236;' , '\\`{\\i}',
     '&#237;' , '\\\'{\\i}',
     '&#238;' , '\\^{\\i}',
     '&#239;' , '\\"{\\i}',
     '&#240;' , '\\^{w}',
     '&#241;' , '\\~{n}',
     '&#242;' , '\\`{o}',
     '&#243;' , '\\\'{o}',
     '&#244;' , '\\^{o}',
     '&#245;' , '\\~{o}',
     '&#246;' , '\\"{o}',
     '&#247;' , '\\.{t}',
     '&#248;' , '\\o{}',
     '&#249;' , '\\`{u}',
     '&#250;' , '\\\'{u}',
     '&#251;' , '\\^{u}',
     '&#252;' , '\\"{u}',
     '&#253;' , '\\\'{y}',
     '&#254;' , '\\^{y}',
     '&#255;' , '\\"{y}'
);

1;






