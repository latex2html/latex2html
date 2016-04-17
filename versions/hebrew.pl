### File: hebrew.pl
### Version 0.1,  June 29, 2002
### Written by Ross Moore <ross@maths.mq.edu.au>
###   includes macros in Babel's  8859-8.def  (hebrew_p)
###
### ISO_8859-8 encoding information
###

## Copyright (C) 2002 by Ross Moore
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


$LR_CHARSET = 'iso-8859-8';
$BIDI_CHARSET = 'iso-8859-8-i';
$INPUTENC = 'hebrew';

$CHARSET=$BIDI_CHARSET;


#Character ranges for lower --> upper-case conversion
$sclower = '';
$scupper = '';

#extra pattern match preceding  lower --> upper-case conversion
$scextra = '';

%extra_small_caps = ();
%low_entities = ();


sub do_cmd_textcurrency { join('', &iso_map("curren", ""), $_[0]);}
sub do_cmd_textperiodcentered { join('', &iso_map("middot", ""), $_[0]);}
sub do_cmd_textonequarter { join('', &iso_map("frac14", ""), $_[0]);}
sub do_cmd_textonehalf { join('', &iso_map("frac12", ""), $_[0]);}
sub do_cmd_textthreequarters { join('', &iso_map("frac34", ""), $_[0]);}

sub do_cmd_mathdegree { join('', &iso_map("deg", ""), $_[0]);}
sub do_cmd_mathonesuperior { join('', &iso_map("sup1", ""), $_[0]);}
sub do_cmd_mathtwosuperior { join('', &iso_map("sup2", ""), $_[0]);}
sub do_cmd_maththreesuperior { join('', &iso_map("sup3", ""), $_[0]);}

sub do_cmd_S { join('', &iso_map("sect", ""), $_[0]);}
sub do_cmd_P { join('', &iso_map("para", ""), $_[0]);}

sub do_cmd_div { join('', &iso_map("divide", ""), $_[0]);}
sub do_cmd_times { join('', &iso_map("times", ""), $_[0]);}
sub do_cmd_minus { join('', &iso_map("shy", ""), $_[0]);}
sub do_cmd_pounds { join('', &iso_map("pound", ""), $_[0]);}
sub do_cmd_cdot { join('', &iso_map("middot", ""), $_[0]);}
sub do_cmd_micron { join('', &iso_map("micro", ""), $_[0]);}

sub do_cmd_makafgadol { &do_cmd_textendash(@_) }
sub do_cmd_makafanak { &do_cmd_textemdash(@_) }
sub do_cmd_geresh { &do_cmd_textquoteright(@_) }
sub do_cmd_opengeresh { &do_cmd_textquoteright(@_) }
sub do_cmd_closegeresh { &do_cmd_textquoteleft(@_) }
sub do_cmd_openquote { &do_cmd_textquotedblright(@_) }
sub do_cmd_closequote { &do_cmd_textquotedblleft(@_) }
sub do_cmd_leftquotation { &do_cmd_textquotedblright(@_) }
sub do_cmd_rightquotation { &do_cmd_textquotedblleft(@_) }


# special macros for right-left typesetting
sub do_cmd_L { $_[0] }
sub do_cmd_R { $_[0] }


%iso_8859_8_character_map
     = (
	'alef', '&#224;', 	# Hebrew letter ALEF 
	'bet', '&#225;', 	# Hebrew letter BET 
	'gimel', '&#226;', 	# Hebrew letter GIMEL 
	'dalet', '&#227;', 	# Hebrew letter DALET
	'he', '&#228;', 	# Hebrew letter HE
	'vav', '&#229;', 	# Hebrew letter VAV
	'zayin', '&#230;', 	# Hebrew letter ZAYIN 
	'het', '&#231;', 	# Hebrew letter HET
	'tet', '&#232;', 	# Hebrew letter TET 
	'yod', '&#233;', 	# Hebrew letter YOD 
	'finalkaf', '&#234;', 	# Hebrew letter final KAF 
	'kaf', '&#235;', 	# Hebrew letter KAF
	'lamed', '&#236;', 	# Hebrew letter LAMED 
	'finalmem', '&#237;', 	# Hebrew letter final MEM 
	'mem', '&#238;', 	# Hebrew letter MEM 
	'finalnun', '&#239;', 	# Hebrew letter final NUN 
	'nun', '&#240;', 	# Hebrew letter NUN 
	'samekh', '&#241;', 	# Hebrew letter SAMEKH 
	'ayin', '&#242;', 	# Hebrew letter AYIN 
	'finalpe', '&#243;', 	# Hebrew letter final PE 
	'pe', '&#244;', 	# Hebrew letter PE
	'finaltsadi', '&#245;', 	# Hebrew letter final TSADI 
        'tsadi', '&#246;',	# Hebrew letter TSADI 
        'qof', '&#247;',	# Hebrew letter QOF
        'resh', '&#248;',	# Hebrew letter RESH
        'shin', '&#249;',	# Hebrew letter SHIN
        'tav', '&#250;',	# Hebrew letter TAV
	'amp', '&amp;', 	# ampersand 
	'gt', '&#62;',		# greater than 
	'lt', '&lt;',		# less than 
	'quot', '&quot;',	# double quote


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
       'sup1', '&#185;',
       'frac14', '&#188;',
       'frac12', '&#189;',
       'frac34', '&#190;',
       'times', '&#215;',

# These are character types without arguments ...
	'grave' , "`",
	'circ', '^',
	'tilde', '&#126;',
	'uml', '&#168;',
	'breve', '&#175;',
	'deg', '&#176;',
	'acute' , "&#180;",
	'cedil', "&#184;",
	);

%iso_8859_8_character_map_inv =
    (
     '&#62;'  , '\\ensuremath{>}',
     '&lt;'   , '\\ensuremath{<}',
     '&amp;'  , '&',
     '^'      , '\\^{}',
     '&#126;' , '\\~{}',
     '&quot;' , '"',

     '&#160;' , '\\nobreakspace{}',
     '&#161;' , '',
     '&#162;' , '\\textcent{}',
     '&#163;' , '\\pounds{}',
     '&#164;' , '\\textcurrency{}',
     '&#165;' , '\\textyen{}',
     '&#166;' , '\\textbrokenbar',
     '&#167;' , '\\S{}',
     '&#168;' , '\\"{}',
     '&#169;' , '\\textcopyright{}',
     '&#170;' , '\\ensuremath{\\times}',
     '&#171;' , '\\guillemotleft{}',
     '&#172;' , '\\lnot{}',
     '&#173;' , '\\-',
     '&#174;' , '\\textregistered{}',
     '&#175;' , '\\={}',
     '&#176;' , '\\ensuremath{^{\\circ}}',
     '&#177;' , '\\ensuremath{\\pm}',
     '&#178;' , '\\ensuremath{^{2}}',
     '&#179;' , '\\ensuremath{^{3}}',
     '&#180;' , '\\\'{}',
     '&#181;' , '\ensuremath{\\micron}',
     '&#182;' , '\\P{}',
     '&#183;' , '\\ensuremath{\\cdot{}}',
     '&#184;' , '\\c{}',
     '&#185;' , '\\ensuremath{^{1}}',
     '&#186;' , '\\ensuremath{\\div}',
     '&#187;' , '\\guillemotright',
#	'&#188;' , '\\textonequarter{}',
	'&#188;' , '\\ensuremath{\\frac{1}{4}}',
#	'&#189;' , '\\textonehalf{}',
	'&#189;' , '\\ensuremath{\\frac{1}{2}}',
#	'&#190;' , '\\textthreequarters{}',
	'&#190;' , '\\ensuremath{\\frac{3}{4}}',
     '&#191;' , '',
     '&#192;' , '',
     '&#193;' , '',
     '&#194;' , '',
     '&#195;' , '',
     '&#196;' , '',
     '&#197;' , '',
     '&#198;' , '',
     '&#199;' , '',
     '&#200;' , '',
     '&#201;' , '',
     '&#202;' , '',
     '&#203;' , '',
     '&#204;' , '',
     '&#205;' , '',
     '&#206;' , '',
     '&#207;' , '',
     '&#208;' , '',
     '&#209;' , '',
     '&#210;' , '',
     '&#211;' , '',
     '&#212;' , '',
     '&#213;' , '',
     '&#214;' , '',
     '&#215;' , '',
     '&#216;' , '',
     '&#217;' , '',
     '&#218;' , '',
     '&#219;' , '',
     '&#220;' , '',
     '&#221;' , '',
     '&#222;' , '',
     '&#223;' , '\\doubleunderline{}',
     '&#224;' , '\\alef{}',
     '&#225;' , '\\bet{}',
     '&#226;' , '\\gimel{}',
     '&#227;' , '\\dalet{}',
     '&#228;' , '\\he{}',
     '&#229;' , '\\vav{}',
     '&#230;' , '\\zayin{}',
     '&#231;' , '\\het{}',
     '&#232;' , '\\tet{}',
     '&#233;' , '\\yod{}',
     '&#234;' , '\\finalkaf{}',
     '&#235;' , '\\kaf{}',
     '&#236;' , '\\lamed{}',
     '&#237;' , '\\finalmem{}',
     '&#238;' , '\\mem{}',
     '&#239;' , '\\finalnun{}',
     '&#240;' , '\\nun{}',
     '&#241;' , '\\samekh{}',
     '&#242;' , '\\ayin{}',
     '&#243;' , '\\finalpe{}',
     '&#244;' , '\\pe{}',
     '&#245;' , '\\finaltsadi{}',
     '&#246;' , '\\tsadi{}',
     '&#247;' , '\\qof{}',
     '&#248;' , '\\resh{}',
     '&#249;' , '\\shin{}',
     '&#250;' , '\\tav{}',
     '&#251;' , '',
     '&#252;' , '',
     '&#253;' , '',
     '&#254;' , '',
     '&#255;' , ''
);

1;
