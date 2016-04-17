### File: latin3.pl
### Version 0.1,  November 1, 1997
### Written by Ross Moore <ross@mpce.mq.edu.au>
###   includes macros in LaTeX's  latin3.def
### Version 0.3,  December 12, 1997
###   includes lower --> uppercase conversion tables
###
### ISO_8859-3 encoding information
###

## Copyright (C) 1997 by Ross Moore
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


$CHARSET = 'iso-8859-3';
$INPUTENC = 'latin3';


#Character ranges for lower --> upper-case conversion

$sclower = "\\261\\266\\271-\\274\\277\\340-\\366\\370-\\376";
$scupper = "\\241\\246\\251-\\254\\257\\300-\\326\\330-\\336";

#extra pattern match preceding  lower --> upper-case conversion
$scextra = "s/\\337/ss/g";

%extra_small_caps = ( '223' , 'ss' );

%low_entities = ( '177', '161'
#	     ,'178', '162'
#	     ,'179', '163'
#	     ,'180', '164'
#	     ,'181', '165'
                 ,'182', '166'
#	     ,'183', '167'
#	     ,'184', '168'
                 ,'185', '169'
                 ,'186', '170'
                 ,'187', '171'
                 ,'188', '172'
#	     ,'189', '173'
#	     ,'190', '174'
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


sub do_cmd_ss { join('', &iso_map("sz", "lig"), $_[0]);}
sub do_cmd_i { join('', &iso_map("i", "nodot"), $_[0]);}

sub do_cmd_textcurrency { join('', &iso_map("curren", ""), $_[0]);}
sub do_cmd_textmalteseh { join('', &iso_map("h", "bar"), $_[0]);}
sub do_cmd_textmalteseH { join('', &iso_map("H", "bar"), $_[0]);}
sub do_cmd_textperiodcentered { join('', &iso_map("middot", ""), $_[0]);}
sub do_cmd_textonehalf { join('', &iso_map("frac12", ""), $_[0]);}

sub do_cmd_mathdegree { join('', &iso_map("deg", ""), $_[0]);}
sub do_cmd_mathtwosuperior { join('', &iso_map("sup2", ""), $_[0]);}
sub do_cmd_maththreesuperior { join('', &iso_map("sup3", ""), $_[0]);}

sub do_cmd_S { join('', &iso_map("sect", ""), $_[0]);}

sub do_cmd_hbar { join('', &iso_map("h", "bar"), $_[0]);}
sub do_cmd_div { join('', &iso_map("divide", ""), $_[0]);}
sub do_cmd_times { join('', &iso_map("times", ""), $_[0]);}
sub do_cmd_minus { join('', &iso_map("shy", ""), $_[0]);}
sub do_cmd_pounds { join('', &iso_map("pound", ""), $_[0]);}
sub do_cmd_cdot { join('', &iso_map("middot", ""), $_[0]);}
sub do_cmd_micron { join('', &iso_map("micro", ""), $_[0]);}


%iso_8859_3_character_map
     = (
	'Aacute', '&#193;', 	# capital A, acute accent 
#	'Abreve', '&#195;', 	# capital A, breve accent
	'Acirc', '&#194;', 	# capital A, circumflex accent 
	'Agrave', '&#192;', 	# capital A, grave accent
	'Auml', '&#196;', 	# capital A, dieresis or umlaut mark   
	'Cdot', '&#197;', 	# capital C, dot accent
	'Ccirc', '&#198;', 	# capital C, caron accent 
	'Ccedil', '&#199;', 	# capital C, cedilla 
#	'ETH', '&#208;', 	# capital Eth, Icelandic 
	'Eacute', '&#201;', 	# capital E, acute accent 
	'Egrave', '&#200;', 	# capital E, grave accent 
	'Ecirc', '&#202;', 	# capital E, circumflex accent 
	'Euml', '&#203;', 	# capital E, dieresis or umlaut mark 
	'Gbreve', '&#171;', 	# capital G, breve accent 
	'Gcirc', '&#216;', 	# capital G, circumflex accent 
	'Gdot', '&#213;', 	# capital G, dot accent 
	'Hstrok', '&#161;', 	# maltese H 
	'Hcirc', '&#166;', 	# capital H, circumflex accent 
	'Iacute', '&#205;', 	# capital I, acute accent 
	'Icirc', '&#206;', 	# capital I, circumflex accent 
	'Idot', '&#169;', 	# capital I, dot accent 
	'Igrave', '&#204;', 	# capital I, grave accent 
	'Iuml', '&#207;', 	# capital I, dieresis or umlaut mark 
	'Jcirc', '&#172;', 	# capital J, circumflex accent 
        'Ntilde', '&#209;',     # capital N, tilde
        'Oacute', '&#211;',     # capital O, acute accent
        'Ocirc', '&#212;',      # capital O, circumflex accent
        'Ograve', '&#210;',     # capital O, grave accent
        'Ouml', '&#214;',       # capital O, dieresis or umlaut mark
	'Scedil', '&#170;',	# capital S, cedil accent
	'Scirc', '&#222;',	# capital S, circumflex accent
	'Uacute', '&#218;', 	# capital U, acute accent 
	'Ubreve', '&#221;', 	# capital U, breve accent 
	'Ucirc', '&#219;', 	# capital U, circumflex accent 
	'Ugrave', '&#217;', 	# capital U, grave accent
	'Uuml', '&#220;', 	# capital U, dieresis or umlaut mark 
	'Zdot', '&#175;',	# capital Z, dot above
	'aacute', '&#225;', 	# small a, acute accent 
#	'abreve', '&#227;', 	# small a, breve accent
	'agrave', '&#224;', 	# small a, grave accent
	'acirc', '&#226;', 	# small a, circumflex accent 
	'amp', '&amp;', 	# ampersand 
	'auml', '&#228;', 	# small a, dieresis or umlaut mark   
	'ccirc', '&#230;', 	# small c, circumflex accent
	'cdot', '&#229;', 	# small c, dot accent 
	'ccedil', '&#231;', 	# small c, cedilla 
	'eacute', '&#233;', 	# small e, acute accent 
	'ecirc', '&#234;', 	# small e, circumflex accent 
	'egrave', '&#232;', 	# small e, grave accent 
#	'eth', '&#240;', 	# small eth, Icelandic 
	'euml', '&#235;', 	    # small e, dieresis or umlaut mark 
	'gbreve', '&#187;', 	# small g, breve accent 
	'gcirc', '&#248;', 	# small g, circumflex accent 
	'gdot', '&#245;', 	# small g, dot accent 
	'gt', '&#62;',		# greater than 
	'hstrok', '&#177;', 	# maltese h 
	'hcirc', '&#182;', 	# small h, circumflex accent 
	'iacute', '&#237;', 	# small i, acute accent 
	'icirc', '&#238;', 	# small i, circumflex accent 
	'igrave', '&#236;', 	# small i, grave accent 
	'iuml', '&#239;', 	# small i, dieresis or umlaut mark 
	'inodot', '&#185;', 	# small i, circumflex accent 
	'jcirc', '&#188;', 	# small j, circumflex accent 
	'lt', '&lt;',		# less than 
        'ntilde', '&#241;',     # small n, tilde
        'oacute', '&#243;',     # small O, acute accent
        'ocirc', '&#244;',      # small O, circumflex accent
        'ograve', '&#242;',     # small O, grave accent
	'ouml', '&#246;', 	# small o, dieresis or umlaut mark
	'quot', '&quot;',	# double quote
	'scedil', '&#186;',	# small s, cedil accent
	'scirc', '&#254;',	# small s, circumflex accent
	'szlig', '&#223;', 	# small sharp s, German (sz ligature) 
	'uacute', '&#250;', 	# small u, acute accent 
	'ubreve', '&#253;', 	# small u, breve accent 
	'ucirc', '&#251;', 	# small u, circumflex accent 
	'ugrave', '&#249;', 	# small u, grave accent
	'uuml', '&#252;', 	# small u, dieresis or umlaut mark 
	'zdot', '&#191;',	# small z, dot above


# These have HTML4 mnemonic names ...
       'nbsp', '&#160;',      # non-breaking space
       'pound', '&#163;',     # pound sign
       'curren', '&#164;',    # currency sign
       'sect', '&#167;',      # section mark
       'shy', '&#173;',
       'sup2', '&#178;',
       'sup3', '&#179;',
       'micro', '&#181;',
       'middot', '&#183;',
       'frac12', '&#189;',
       'times', '&#215;',
       'divide', '&#247;',

# These are character types without arguments ...
	'grave' , "`",
	'circ', '^',
	'tilde', '&#126;',
	'breve', '&#162;',
	'uml', '&#168;',
	'deg', '&#176;',
	'acute' , "&#180;",
	'cedil', "&#184;",
	'dot', '&#255;'
	);

%iso_8859_3_character_map_inv =
    (
     '&#62;'  , '\\ensuremath{>}',
     '&lt;'   , '\\ensuremath{<}',
     '&amp;'  , '&',
     '^'      , '\\^{}',
     '&#126;' , '\\~{}',
     '&quot;' , '"',

     '&#160;' , '\\nobreakspace{}',
     '&#161;' , '\\textmalteseH{}',
     '&#162;' , '\\u{}',
     '&#163;' , '\\pounds{}',
     '&#164;' , '\\textcurrency{}',
#     '&#165;' , '\\v{L}',
     '&#166;' , '\\^{H}',
     '&#167;' , '\\S{}',
     '&#168;' , '\\"{}',
     '&#169;' , '\\.{I}',
     '&#170;' , '\\c{S}',
     '&#171;' , '\\u{G}',
     '&#172;' , '\\^{J}',
     '&#173;' , '\\-',
#     '&#174;' , '\\v{Z}',
     '&#175;' , '\\.{Z}',
#	'&#176;' , '\\mathdegree{}',
     '&#176;' , '\\r{}',
     '&#177;' , '\\textmalteseh{}',
#	'&#178;' , '\\mathtwosuperior{}',
	'&#178;' , '\\ensuremath{^{2}}',
#	'&#179;' , '\\maththreesuperior{}',
	'&#179;' , '\\ensuremath{^{3}}',
     '&#180;' , '\\\'{}',
	'&#181;' , '\ensuremath{\\micron}',
     '&#182;' , '\\^{h}',
#	'&#183;' , '\\textperiodcentered{}',
     '&#183;' , '\\ensuremath{\\cdot{}}',
     '&#184;' , '\\c{ }',
     '&#185;' , '{\\i}',
     '&#186;' , '\\c{s}',
     '&#187;' , '\\u{g}',
     '&#188;' , '\\^{\\j}',
#	'&#189;' , '\\textonehalf{}',
	'&#189;' , '\\ensuremath{\\frac{1}{2}}',
#     '&#190;' , '\\v{z}',
     '&#191;' , '\\.{z}',
     '&#192;' , '\\`{A}',
     '&#193;' , '\\\'{A}',
     '&#194;' , '\\^{A}',
#     '&#195;' , '\\~{A}',
     '&#196;' , '\\"{A}',
     '&#197;' , '\\.{C}',
     '&#198;' , '\\^{C}',
     '&#199;' , '\\c{C}',
     '&#200;' , '\\`{E}',
     '&#201;' , '\\\'{E}',
     '&#202;' , '\\^{E}',
     '&#203;' , '\\"{E}',
     '&#204;' , '\\`{I}',
     '&#205;' , '\\\'{I}',
     '&#206;' , '\\^{I}',
     '&#207;' , '\\"{I}',
#     '&#208;' , '\\DH{}',
     '&#209;' , '\\~{N}',
     '&#210;' , '\\`{O}',
     '&#211;' , '\\\'{O}',
     '&#212;' , '\\^{O}',
     '&#213;' , '\\.{G}',
     '&#214;' , '\\"{O}',
	'&#215;' , '\\ensuremath{\\times}',
     '&#216;' , '\\^{G}',
     '&#217;' , '\\`{U}',
     '&#218;' , '\\\'{U}',
     '&#219;' , '\\^{U}',
     '&#220;' , '\\"{U}',
     '&#221;' , '\\u{U}',
     '&#222;' , '\\^{S}',
     '&#223;' , '\\ss{}',
     '&#224;' , '\\`{a}',
     '&#225;' , '\\\'{a}',
     '&#226;' , '\\^{a}',
#     '&#227;' , '\\~{a}',
     '&#228;' , '\\"{a}',
     '&#229;' , '\\.{c}',
     '&#230;' , '\\^{c}',
     '&#231;' , '\\c{c}',
     '&#232;' , '\\`{e}',
     '&#233;' , '\\\'{e}',
     '&#234;' , '\\^{e}',
     '&#235;' , '\\"{e}',
     '&#236;' , '\\`{\\i}',
     '&#237;' , '\\\'{\\i}',
     '&#238;' , '\\^{\\i}',
     '&#239;' , '\\"{\\i}',
#     '&#240;' , '\\dh{}',
     '&#241;' , '\\~{n}',
     '&#242;' , '\\`{o}',
     '&#243;' , '\\\'{o}',
     '&#244;' , '\\^{o}',
     '&#245;' , '\\.{g}',
     '&#246;' , '\\"{o}',
	'&#247;' , '\\ensuremath{\\div}',
     '&#248;' , '\\^{g}',
     '&#249;' , '\\`{u}',
     '&#250;' , '\\\'{u}',
     '&#251;' , '\\^{u}',
     '&#252;' , '\\"{u}',
     '&#253;' , '\\u{u}',
     '&#254;' , '\\^{s}',
     '&#255;' , '\\.{}'
);

1;
