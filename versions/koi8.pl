### File: koi8.pl
### Version 0.1,  April 17, 2001
### Edited by Georgy Salnikov <sge@nmr.nioch.nsc.ru> from latin1.pl
###
### KOI8-R encoding information
###
### extracted from the  latex2html script  ...
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

$CHARSET = "koi8-r";
$INPUTENC = '' unless ($INPUTENC);  # empty implies 'koi8-r'

#Character ranges for lower --> upper-case conversion

$sclower = "\\243-\\243\\300-\\337";
$scupper = "\\263-\\263\\340-\\377";

%low_entities = ( '163', '179'
                 ,'192', '224'
                 ,'193', '225'
                 ,'194', '226'
                 ,'195', '227'
                 ,'196', '228'
                 ,'197', '229'
                 ,'198', '230'
                 ,'199', '231'
                 ,'200', '232'
                 ,'201', '233'
                 ,'202', '234'
                 ,'203', '235'
                 ,'204', '236'
                 ,'205', '237'
                 ,'206', '238'
                 ,'207', '239'
                 ,'208', '240'
                 ,'209', '241'
                 ,'210', '242'
                 ,'211', '243'
                 ,'212', '244'
                 ,'213', '245'
                 ,'214', '246'
		 ,'215', '247'
                 ,'216', '248'
                 ,'217', '249'
                 ,'218', '250'
                 ,'219', '251'
                 ,'220', '252'
                 ,'221', '253'
                 ,'222', '254'
		 ,'223', '255'
);


sub do_cmd_textonequarter { join('', &iso_map("frac14", ""), $_[0]);}
sub do_cmd_textonehalf { join('', &iso_map("frac12", ""), $_[0]);}
sub do_cmd_textthreequarters { join('', &iso_map("frac34", ""), $_[0]);}
sub do_cmd_textcent { join('', &iso_map("cent", ""), $_[0]);}
sub do_cmd_textyen { join('', &iso_map("yen", ""), $_[0]);}
sub do_cmd_textcurrency { join('', &iso_map("curren", ""), $_[0]);}
sub do_cmd_textbrokenbar { join('', &iso_map("brvbar", ""), $_[0]);}
sub do_cmd_textregistered { join('', &iso_map("reg", ""), $_[0]);}
sub do_cmd_textexclamdown { join('', &iso_map("iexcl", ""), $_[0]);}
sub do_cmd_textquestiondown { join('', &iso_map("iquest", ""), $_[0]);}
sub do_cmd_textperiodcentered { join('', &iso_map("middot", ""), $_[0]);}
sub do_cmd_guillemotleft { join('', &iso_map("laquo", ""), $_[0]);}
sub do_cmd_guillemotright { join('', &iso_map("raquo", ""), $_[0]);}

sub do_cmd_mathdegree { join('', &iso_map("deg", ""), $_[0]);}
sub do_cmd_mathonesuperior { join('', &iso_map("sup1", ""), $_[0]);}
sub do_cmd_mathtwosuperior { join('', &iso_map("sup2", ""), $_[0]);}
sub do_cmd_mathordmasculine { join('', &iso_map("ordm", ""), $_[0]);}
sub do_cmd_mathordfeminine { join('', &iso_map("ordf", ""), $_[0]);}

sub do_cmd_P { join('', &iso_map("para", ""), $_[0]);}
sub do_cmd_S { join('', &iso_map("sect", ""), $_[0]);}

sub do_cmd_pm { join('', &iso_map("plusmn", ""), $_[0]);}
sub do_cmd_copyright { join('', &iso_map("copy", ""), $_[0]);}
sub do_cmd_cents { join('', &iso_map("cent", ""), $_[0]);}
sub do_cmd_lnot { join('', &iso_map("not", ""), $_[0]);}
sub do_cmd_cdot { join('', &iso_map("middot", ""), $_[0]);}
sub do_cmd_micron { join('', &iso_map("micro", ""), $_[0]);}

%iso_8859_1_character_map
     = (
       'amp', '&amp;',  # ampersand
       'gt', '&#62;',   # greater than
       'lt', '&lt;',    # less than
       'quot', '&quot;',        # double quote

# These have HTML mnemonic names for HTML 4.0 ...
       'nbsp', '&#160;',       # non-breaking space
       'iexcl', '&#161;',      # exclamation mark - upside down
       'cent', '&#162;',       # cents sign
       'curren', '&#164;',     # currency sign
       'yen', '&#165;',        # Yen sign
       'brvbar', '&#166;',  
       'sect', '&#167;',       # section mark
       'copy', '&#169;',       # copyright mark
       'ordf', '&#170;',
       'ordm', '&#186;',
       'laquo', '&#171;', 
       'raquo', '&#187;', 
       'not', '&#172;',
       'shy', '&#173;',
       'reg', '&#174;',
       'deg', '&#176;',
       'plusmn', '&#177;',
       'sup1', '&#185;',
       'sup2', '&#178;',
       'micro', '&#181;',
       'para', '&#182;',   # paragraph mark
       'middot', '&#183;',
       'frac14', '&#188;',
       'frac12', '&#189;',
       'frac34', '&#190;',
       'iquest', '&#191;',  # question mark - upside down

# These are character types without arguments ...
       'grave' , "`",
       'acute' , "&#180;",
       'circ', '^',
       'tilde', '&#126;',
       'dot', '.',
       'uml', '&#168;',
       'macr' , '&#175;',
       'dblac', "&#180;&#180;",
       'cedil', "&#184;"
	);

%iso_8859_1_character_map_inv =
    (
     '^'      , '\\^{}',
     '&#62;'  , '\\ensuremath{>}',
     '&lt;'   , '\\ensuremath{<}',
     '&amp;'  , '\\&',
     '&#126;' , '\\~{}',
	'&#160;' , '\\nobreakspace{}',
     '&#161;' , '!`',
	'&#162;' , '\\textcent{}',
	'&#164;' , '\\textcurrency{}',
	'&#165;' , '\\textyen{}',
	'&#166;' , '\\textbrokenbar{}',
     '&#167;' , '\\S{}',
     '&#168;' , '\\"{}',
     '&#169;' , '\\copyright{}',
	'&#170;' , '\\ensuremath{^{a}}',
	'&#171;' , '\\guillemotleft{}',
	'&#172;' , '\\ensuremath{\\lnot{}}',
	'&#173;' , '\\-',
	 '&#174;' , '\\ensuremath{\\circledR}',
     '&#175;' , '\\={}',
     '&#176;' , '\\ensuremath{^{\\circ}}',
	'&#177;' , '\\ensuremath{\\pm}',
	'&#178;' , '\\ensuremath{^{2}}',
     '&#180;' , '\\\'{}',
	'&#181;' , '\\ensuremath{\\mu}',
     '&#182;' , '\\P{}',
     '&#183;' , '\\cdot{}',
     '&#184;' , '\\c{ }',
	'&#185;' , '\\ensuremath{^{1}}',
	'&#186;' , '\\ensuremath{^{o}}',
	'&#187;' , '\\guillemotright{}',
	'&#188;' , '\\ensuremath{\\frac{1}{4}}',
	'&#189;' , '\\ensuremath{\\frac{1}{2}}',
	'&#190;' , '\\ensuremath{\\frac{3}{4}}',
     '&#191;' , '?`'
);

1;






