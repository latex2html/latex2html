### File: macroman.pl
### Version 0.1,  September 15, 1999
### Written by Ross Moore <ross@maths.mq.edu.au>
###
### CP1252 encoding information
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

$CHARSET = "macroman";
$INPUTENC='macroman';  # empty implies 'latin1'

#Character ranges for lower --> upper-case conversion

$sclower = "\\207-\\237\\276\\277\\317\\330";
$scupper = "\\347\\313\\345\\200\\314\\201\\202\\203\\351\\346\\350\\352\\355\\353\\354"
  . "\\204\\356\\361\\357\\205\\315\\362\\364\\363\\206\\256\\257\\316\\331";

#extra pattern match preceding  lower --> upper-case conversion
$scextra = "s/\\247/ss/g";

%extra_small_caps = ( '167' , 'ss' );
%extra_small_caps_inv = ( '222' , 'FI', '223', 'FL');

%low_entities = ( '135', '231'
	     ,'136', '203'
	     ,'137', '229'
	     ,'138', '128'
	     ,'139', '204'
	     ,'140', '129'
	     ,'141', '130'
	     ,'142', '131'
	     ,'143', '233'
	     ,'144', '230'
	     ,'145', '232'
	     ,'146', '234'
	     ,'147', '237'
	     ,'148', '235'
	     ,'149', '236'
	     ,'150', '132'
	     ,'151', '238'
	     ,'152', '241'
	     ,'153', '239'
	     ,'154', '133'
	     ,'155', '205'
	     ,'156', '242'
	     ,'157', '244'
	     ,'158', '243'
	     ,'159', '134'
	     ,'190', '174'
	     ,'191', '175'
	     ,'207', '206'
	     ,'216', '217'
);



sub do_cmd_oe { join('', &iso_map("oe", "lig"), $_[0]);}
sub do_cmd_OE { join('', &iso_map("OE", "lig"), $_[0]);}
# inhibit later wrapping for an image
$raw_arg_cmds{'oe'} = $raw_arg_cmds{'OE'} = -1 ;

#sub do_cmd_l { join('', &iso_map("l", "strok"), $_[0]);}
#sub do_cmd_L { join('', &iso_map("L", "strok"), $_[0]);}
#sub do_cmd_ng { join('', &iso_map("eng", ""), $_[0]);}

#sub do_cmd_DH { join('', &iso_map("D", "strok"), $_[0]);}
#sub do_cmd_dh { join('', &iso_map("d", "strok"), $_[0]);}
sub do_cmd_ss { join('', &iso_map("sz", "lig"), $_[0]);}

#sub do_cmd_texteuro { join('', &iso_map("euro", ""), $_[0]);}
sub do_cmd_quotesinglbase { join('', &iso_map("sbquo", ""), $_[0]);}
sub do_cmd_quotedblbase { join('', &iso_map("dbquo", ""), $_[0]);}
sub do_cmd_textflorin { join('', &iso_map("florin", ""), $_[0]);}
sub do_cmd_dots { join('', &iso_map("ellip", ""), $_[0]);}
sub do_cmd_dag { join('', &iso_map("dagger", ""), $_[0]);}
sub do_cmd_ddag { join('', &iso_map("Dagger", ""), $_[0]);}
sub do_cmd_textperthousand { join('', &iso_map("permil", ""), $_[0]);}
sub do_cmd_guilsinglleft { join('', &iso_map("lsaquo", ""), $_[0]);}
sub do_cmd_guilsinglright { join('', &iso_map("rsaquo", ""), $_[0]);}
sub do_cmd_textquoteleft { join('', &iso_map("lsquo", ""), $_[0]);}
sub do_cmd_textquoteright { join('', &iso_map("rsquo", ""), $_[0]);}
sub do_cmd_textquotedblleft { join('', &iso_map("ldquo", ""), $_[0]);}
sub do_cmd_textquotedblright { join('', &iso_map("rdquo", ""), $_[0]);}
sub do_cmd_textbullet { join('', &iso_map("bullet", ""), $_[0]);}
sub do_cmd_textendash { join('', &iso_map("ndash", ""), $_[0]);}
sub do_cmd_textemdash { join('', &iso_map("mdash", ""), $_[0]);}
sub do_cmd_texttrademark { join('', &iso_map("trade", ""), $_[0]);}

sub do_cmd_textdegree { join('', &iso_map("deg", ""), $_[0]);}
sub do_cmd_textexclamdown { join('', &iso_map("iexcl", ""), $_[0]);}
sub do_cmd_textcent { join('', &iso_map("cent", ""), $_[0]);}
sub do_cmd_textcurrency { join('', &iso_map("curren", ""), $_[0]);}
sub do_cmd_textyen { join('', &iso_map("yen", ""), $_[0]);}
sub do_cmd_textbrokenbar { join('', &iso_map("brvbar", ""), $_[0]);}
sub do_cmd_textregistered { join('', &iso_map("reg", ""), $_[0]);}
sub do_cmd_textquestiondown { join('', &iso_map("iquest", ""), $_[0]);}
sub do_cmd_textperiodcentered { join('', &iso_map("middot", ""), $_[0]);}
sub do_cmd_guillemotleft { join('', &iso_map("laquo", ""), $_[0]);}
sub do_cmd_guillemotright { join('', &iso_map("raquo", ""), $_[0]);}
#sub do_cmd_textonequarter { join('', &iso_map("frac14", ""), $_[0]);}
#sub do_cmd_textonehalf { join('', &iso_map("frac12", ""), $_[0]);}
#sub do_cmd_textthreequarters { join('', &iso_map("frac34", ""), $_[0]);}

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
#sub do_cmd_minus { join('', &iso_map("shy", ""), $_[0]);}
sub do_cmd_copyright { join('', &iso_map("copy", ""), $_[0]);}
sub do_cmd_pounds { join('', &iso_map("pound", ""), $_[0]);}
sub do_cmd_cents { join('', &iso_map("cent", ""), $_[0]);}
sub do_cmd_lnot { join('', &iso_map("not", ""), $_[0]);}
sub do_cmd_cdot { join('', &iso_map("middot", ""), $_[0]);}
sub do_cmd_micron { join('', &iso_map("micro", ""), $_[0]);}

# non-iso-latin characters
sub do_cmd_approx { join('', &iso_map("approx", ""), $_[0]);}
sub do_cmd_infty { join('', &iso_map("infin", ""), $_[0]);}
sub do_cmd_int { join('', &iso_map("int", ""), $_[0]);}
sub do_cmd_geq { join('', &iso_map("ge", ""), $_[0]);}
sub do_cmd_leq { join('', &iso_map("le", ""), $_[0]);}
sub do_cmd_neq { join('', &iso_map("ne", ""), $_[0]);}
sub do_cmd_partial { join('', &iso_map("part", ""), $_[0]);}
sub do_cmd_surd { join('', &iso_map("radic", ""), $_[0]);}
sub do_cmd_diamond { join('', &iso_map("diamond", ""), $_[0]);}
sub do_cmd_textapplelogo { join('', &iso_map("apple", ""), $_[0]);}

# ...including Greeks:
sub do_cmd_Delta { join('', &iso_map("Delta", ""), $_[0]);}
sub do_cmd_Pi { join('', &iso_map("Pi", ""), $_[0]);}
sub do_cmd_pi { join('', &iso_map("pi", ""), $_[0]);}
sub do_cmd_Sigma { join('', &iso_map("Sigma", ""), $_[0]);}
sub do_cmd_Omega { join('', &iso_map("Omega", ""), $_[0]);}


%macroman_character_map
     = (
       'AElig', '&#174;',       # capital AE diphthong (ligature)
       'Aacute', '&#231;',      # capital A, acute accent
       'Acirc', '&#229;',       # capital A, circumflex accent
       'Agrave', '&#203;',      # capital A, grave accent
       'Aring', '&#129;',       # capital A, ring
       'Atilde', '&#204;',      # capital A, tilde
       'Auml', '&#128;',        # capital A, dieresis or umlaut mark
       'Ccedil', '&#130;',      # capital C, cedilla
#       'ETH', '&#208;',         # capital Eth, Icelandic
       'Eacute', '&#131;',      # capital E, acute accent
       'Ecirc', '&#230;',       # capital E, circumflex accent
       'Egrave', '&#233;',      # capital E, grave accent
       'Euml', '&#232;',        # capital E, dieresis or umlaut mark
       'Iacute', '&#234;',      # capital I, acute accent
       'Icirc', '&#235;',       # capital I, circumflex accent
       'Igrave', '&#237;',      # capital I, grave accent
       'Iuml', '&#236;',        # capital I, dieresis or umlaut mark
       'Ntilde', '&#132;',      # capital N, tilde
       'OElig', '&#206;',
       'Oacute', '&#238;',      # capital O, acute accent
       'Ocirc', '&#239;',       # capital O, circumflex accent
       'Ograve', '&#241;',      # capital O, grave accent
       'Oslash', '&#175;',      # capital O, slash
       'Otilde', '&#205;',      # capital O, tilde
       'Ouml', '&#133;',        # capital O, dieresis or umlaut mark
#       'THORN', '&#222;',       # capital THORN, Icelandic
       'Uacute', '&#242;',      # capital U, acute accent
       'Ucirc', '&#243;',       # capital U, circumflex accent
       'Ugrave', '&#244;',      # capital U, grave accent
       'Uuml', '&#134;',        # capital U, dieresis or umlaut mark
       'Yuml'  , '&#217;',
#
       'aacute', '&#135;',      # small a, acute accent
       'acirc', '&#137;',       # small a, circumflex accent
       'aelig', '&#190;',       # small ae diphthong (ligature)
       'agrave', '&#224;',      # small a, grave accent
       'amp', '&amp;',  # ampersand
       'aring', '&#140;',       # small a, ring
       'atilde', '&#139;',      # small a, tilde
       'auml', '&#138;',        # small a, dieresis or umlaut mark
       'ccedil', '&#141;',      # small c, cedilla
       'inodot', '&#245;',      # dotless i
       'eacute', '&#142;',      # small e, acute accent
       'ecirc', '&#144;',       # small e, circumflex accent
       'egrave', '&#143;',      # small e, grave accent
#       'eth', '&#240;',         # small eth, Icelandic
       'euml', '&#145;',        # small e, dieresis or umlaut mark
       'filig',  '&#222;',      # fi ligature
       'fllig',  '&#223;',      # fl ligature
       'gt', '&#62;',   # greater than
       'iacute', '&#146;',      # small i, acute accent
       'icirc', '&#148;',       # small i, circumflex accent
       'igrave', '&#147;',      # small i, grave accent
       'iuml', '&#149;',        # small i, dieresis or umlaut mark
       'lt', '&lt;',    # less than
       'ntilde', '&#150;',      # small n, tilde
       'oacute', '&#151;',      # small o, acute accent
       'ocirc', '&#153;',       # small o, circumflex accent
       'oelig', '&#207;',
       'ograve', '&#152;',      # small o, grave accent
       'oslash', '&#191;',      # small o, slash
       'otilde', '&#155;',      # small o, tilde
       'ouml', '&#154;',        # small o, dieresis or umlaut mark
       'szlig', '&#167;',       # small sharp s, German (sz ligature)
#       'thorn', '&#254;',       # small thorn, Icelandic
       'uacute', '&#156;',      # small u, acute accent
       'ucirc', '&#158;',       # small u, circumflex accent
       'ugrave', '&#157;',      # small u, grave accent
       'uuml', '&#159;',        # small u, dieresis or umlaut mark
       'yuml', '&#216;',        # small y, dieresis or umlaut mark
       'quot', '&quot;',        # double quote

# These have HTML mnemonic names for HTML 4.0 ...
       'lsaquo', '&#220;',   # 
       'rsaquo', '&#221;',   # 
       'lsquo', '&#212;', 
       'rsquo', '&#213;', 
       'ldquo', '&#210;', 
       'rdquo', '&#211;', 
       'sbquo', '&#226;', 
       'dbquo', '&#227;', 
       'laquo', '&#199;', 
       'raquo', '&#200;', 

       'curren', '&#219;',      # currency symbol
       'hellip',  '&#201;',     # ellipsis dots
       'cent', '&#162;',       # cents sign
       'pound', '&#163;',      # pound sign
       'yen', '&#180;',        # yen symbol
       'florin',  '&#196;',     # florin symbol
       'dagger', '&#160;', 
       'Dagger', '&#224;',       # double-dagger symbol
       'permil', '&228;',      # per thousand symbol
       'frasl',  '&#218;',       # fraction bar

       'bull', '&#165;', 
       'shy', '&#45;', 
       'mdash',  '&#209;',      # emdash
       'ndash',  '&#208;',      # endash
       'trade', '&#170;',      # trademark symbol
#       'nbsp', '&#160;',       # non-breaking space
       'iexcl', '&#193;',      # exclamation mark - upside down
       'iquest', '&#192;',     # inverted question
       'sect', '&#164;',       # section symbol
       'copy', '&#169;',       # copyright mark
       'ordm', '&#188;',
       'ordf', '&#187;',
       'not', '&#194;',        # logical not symbol
       'reg', '&#168;',
       'deg', '&#161;',
       'plusmn', '&#177;',
       'micro', '&#181;',
       'para', '&#166;',         # paragraph symbol
       'ge', '&#179;',
       'le', '&#178;',
       'ne', '&#173;',
       'int', '&#161;',
       'infin', '&#176;',
       'part', '&#182;',
       'radic', '&#195;',
       'diamond', '&#215;',
       'apple', '&#240;',
       'middot', '&#225;',
       'divide', '&#214;',

# These are character types without arguments ...
       'grave' , "&#96;",
       'acute' , "&#171;",
       'circ', '&#246;',
       'breve', '&#249;',       # breve accent
       'caron', '&#255;',       # caron accent
       'cedil', '&#252;',       # cedilla accent
       'ogon', '&#254;',        # ogonek accent
       'tilde', '&#126;',
       'tilacc', '&#247;',      # tilde accent
       'ring', '&#251;',        # ring accent
       'dot', '&#250;',
       'uml', '&#172;',         # dieresis or umlaut accent
       'macr', '&#248;',        # macron accent
       'dblac', '&#253;',       # Hungarian umlaut accent
       'cedil', "&#184;"
	);

%macroman_character_map_inv =
    (
     '^'      , '\\^{}',
     '&#62;'  , '\\ensuremath{>}',
     '&lt;'   , '\\ensuremath{<}',
     '&amp;'  , '\\&',
     '&#126;' , '\\~{}',
     '&#128;' , '\\"{A}',
     '&#129;' , '\\r{A}',
     '&#130;' , '\\c{C}',
     '&#131;' , '\\\'{E}',
     '&#132;' , '\\~{N}',
     '&#133;' , '\\"{O}',
     '&#134;' , '\\"{U}',
     '&#135;' , '\\\'{a}',
     '&#136;' , '\\`{a}',
     '&#137;' , '\\^{a}',
     '&#138;' , '\\"{a}',
     '&#139;' , '\\~{a}',
     '&#140;' , '\\r{a}',
     '&#141;' , '\\c{c}',
     '&#142;' , '\\\'{e}',
     '&#143;' , '\\`{e}',
     '&#144;' , '\\^{e}',
     '&#145;' , '\\"{e}',
     '&#146;' , '\\\'{\\i}',
     '&#147;' , '\\`{\\i}',
     '&#148;' , '\\^{\\i}',
     '&#149;' , '\\"{\\i}',
     '&#150;' , '\\~{n}',
     '&#151;' , '\\\'{o}',
     '&#152;' , '\\`{o}',
     '&#153;' , '\\^{o}',
     '&#154;' , '\\"{o}',
     '&#155;' , '\\~{o}',
     '&#156;' , '\\\'{u}',
     '&#157;' , '\\`{u}',
     '&#158;' , '\\^{u}',
     '&#159;' , '\\"{u}',
	'&#160;' , '\\ensuremath{\\dag{}}',
	'&#161;' , '\\textdegree{}',
	'&#162;' , '\\textcent{}',
     '&#163;' , '\\pounds{}',
	'&#164;' , '\\S{}',
	'&#165;' , '\\textbullet{}',
	'&#166;' , '\\P{}',
     '&#167;' , '\\ss{}',
     '&#168;' , '\\textregistered{}',
     '&#169;' , '\\copyright{}',
	'&#170;' , '\\texttrademark{}',
	'&#171;' , '\\\'{}',
	'&#172;' , '\\"{}',
	'&#173;' , '\\ensuremath{\\neq{}}',
	'&#174;' , '\\AE{}',
	'&#175;' , '\\O{}',
     '&#176;' , '\\ensuremath{\\infty{}}',
	'&#177;' , '\\ensuremath{\\pm}',
	'&#178;' , '\\ensuremath{\\leq{}}',
	'&#179;' , '\\ensuremath{\\geq{}}',
     '&#180;' , '\\textyen{}',
	'&#181;' , '\\ensuremath{\\mu}',
     '&#182;' , '\\ensuremath{\\partial{}}',
     '&#183;' , '\\ensuremath{\\Sigma{}}',
     '&#184;' , '\\ensuremath{\\Pi{}}',
     '&#185;' , '\\ensuremath{\\pi{}}',
     '&#186;' , '\\ensuremath{\\int{}}',
	'&#187;' , '\\textordfeminine{}',
	'&#188;' , '\\textordmasculine{}',
     '&#189;' , '\\ensuremath{\\Omega{}}',
	'&#190;' , '\\ae{}',
	'&#191;' , '\\o{}',
#	'&#192;' , '\\textquestiondown{}',
	'&#192;' , '?`',
#	'&#193;' , '\\textexclamdown{}',
	'&#193;' , '!`',
     '&#194;' , '\\ensuremath{\\lnot{}}',
     '&#195;' , '\\ensuremath{\\surd{}}',
     '&#196;' , '\\textflorin{}',
     '&#197;' , '\\ensuremath{\\approx{}}',
     '&#198;' , '\\ensuremath{\\Delta{}}',
	'&#199;' , '\\guillemotleft{}',
	'&#200;' , '\\guillemotright{}',
     '&#201;' , '\\dots{}',
     '&#202;' , '\\nobreakspace{}',
     '&#203;' , '\\`{A}',
     '&#204;' , '\\~{A}',
     '&#205;' , '\\~{O}',
     '&#206;' , '\\OE{}',
     '&#207;' , '\\oe{}',
#     '&#208;' , '\\textendash{}',
     '&#208;' , '{--}',
#     '&#209;' , '\\textemdash{}',
     '&#209;' , '{---}',
#     '&#210;' , '\\textquotedblleft{}',
     '&#210;' , '{``}',
#     '&#211;' , '\\textquotedblright{}',
     '&#211;' , '{\'\'}',
#     '&#212;' , '\\textquoteleft{}',
     '&#212;' , '{`}',
#     '&#213;' , '\\textquoteright{}',
     '&#213;' , '{\'}',
     '&#214;' , '\\ensuremath{\\div}',
     '&#215;' , '\\ensuremath{\\diamond}',
     '&#216;' , '\\"{y}',
     '&#217;' , '\\"{Y}',
     '&#218;' , '/',
     '&#219;' , '\\textcurrency{}',
	'&#220;' , '\\guilsinglleft{}',
	'&#221;' , '\\guilsinglright{}',
	'&#222;' , 'fi',
	'&#223;' , 'fl',
     '&#224;' , '\\ensuremath{\\ddag}',
#     '&#225;' , '\\textperiodcentered{}',
     '&#225;' , '\\ensuremath{\\cdot{}}',
	'&#226;' , '\\quotesinglbase{}',
	'&#227;' , '\\quotedblbase{}',
     '&#228;' , '\\textperthousand{}',
     '&#229;' , '\\^{A}',
     '&#230;' , '\\^{E}',
     '&#231;' , '\\\'{A}',
     '&#232;' , '\\"{E}',
     '&#233;' , '\\`{E}',
     '&#234;' , '\\\'{I}',
     '&#235;' , '\\^{I}',
     '&#236;' , '\\"{I}',
     '&#237;' , '\\`{I}',
     '&#238;' , '\\\'{O}',
     '&#239;' , '\\^{O}',
     '&#240;' , '\\textapplelogo{}',
     '&#241;' , '\\`{O}',
     '&#242;' , '\\\'{U}',
     '&#243;' , '\\^{U}',
     '&#244;' , '\\`{U}',
     '&#245;' , '\\i{}',
     '&#246;' , '\\^{}',
     '&#247;' , '\\~{}',
     '&#248;' , '\\={}',
     '&#249;' , '\\u{}',
     '&#250;' , '\\.{}',
     '&#251;' , '\\r{}',
     '&#252;' , '\\c{\ }',
     '&#253;' , '\\H{ }',
     '&#254;' , '\\k{\ }',
     '&#255;' , '\\v{}',
);

1;






