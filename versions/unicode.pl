### File: unicode.pl
### Version 0.2,  December 12, 1997
### Written by Ross Moore <ross@mpce.mq.edu.au>
###
### ISO_10646 encoding information
###
###
### Copyright (C) 1997 by Ross Moore <ross@mpce.mq.edu.au>
###
### Version 0.2,  December 12, 1997 
###    added lower --> upper-case conversions
###
### Version 0.1,  October 15, 1997
###    information extracted from  i18n.pl 
###    contains...
###
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


# save previous settings before loading  latin1.pl 
$PREV_CHARSET = $CHARSET if ($CHARSET);
$PREV_charset = $charset if ($charset);
require("$LATEX2HTMLVERSIONS${dd}latin1.pl");
$CHARSET = $PREV_CHARSET if ($PREV_CHARSET);

%unicode_table = ();

$CHARSET = "iso-10646" unless ($PREV_CHARSET);
$charset = ($NO_UTF ? ($PREV_charset ? $PREV_charset : $CHARSET) : 'utf-8');
%unicode_table = ();

# This creates a table of translations to Unicode #bignumber; entities,
# used for converting embedded 8-bit font characters in the range \200-\377
#
sub make_unicode_map {
    return unless ($PREV_CHARSET);
    print "\n*** Constructing conversion $PREV_CHARSET -> Unicode ***\n";
    local($character_map,@ents,@nums,$key,$ent);

    $character_map=$PREV_CHARSET;
    $character_map =~ tr/-/_/;
    eval "\@nums = values (\%${character_map}_character_map)";
    eval "\@ents = keys (\%${character_map}_character_map)";
    while (@nums) {
        $key = pop @nums; $ent = pop @ents;
	$unicode_table{$key} = $iso_10646_character_map{$ent}
            if ($key =~ /\#\d+;/);
	    print "\n$key : $ent : ".$unicode_table{$key} if ($VERBOSITY > 2);
    }    
}

sub convert_to_unicode {
    # MRO: by reference; local(*_) = @_;
    my $char, $uchar;
    return($_[0]) if ($NO_UTF && !$USE_UTF);
    $_[0] =~ s/([\200-\377])/$char="\&#".ord($1).";";
	$unicode_table{$char}||$char
    /eg;
#	$uchar = $unicode_table{$char};($uchar ? $uchar : $char)/eg;
}


#<!-- Character entity set. Typical invocation:
#     <!ENTITY % HTMLspecial PUBLIC
#       "-//W3C//ENTITIES Special//EN//HTML">
#     %HTMLspecial; -->
#
#<!-- Portions (C) International Organization for Standardization 1986:
#     Permission to copy in any form is granted for use with
#     conforming SGML systems and applications as defined in
#     ISO 8879, provided this notice is included in all copies.
#-->


sub do_cmd_oe { join('', &iso_map("oe", "lig"), $_[0]);}
sub do_cmd_OE { join('', &iso_map("OE", "lig"), $_[0]);}
sub do_cmd_l { join('', &iso_map("l", "strok"), $_[0]);}
sub do_cmd_L { join('', &iso_map("L", "strok"), $_[0]);}
sub do_cmd_ng { join('', &iso_map("eng", ""), $_[0]);}

# inhibit later wrapping for an image
$raw_arg_cmds{'l'} = $raw_arg_cmds{'L'} = -1 ;
$raw_arg_cmds{'oe'} = $raw_arg_cmds{'OE'} = -1 ;


# this maps lowercase characters to non-entity equivalents
# e.g.  german sharp-s  -->  'ss'
%extra_small_caps = (%iso_8859_xsc);

# this maps lowercase characters to their uppercase equivalents
%low_entities = ( %iso_8859_low_ents
                 ,'255', '376'
                 ,'257', '256'
                 ,'259', '258'
                 ,'261', '260'
                 ,'263', '262'
                 ,'265', '264'
                 ,'267', '266'
                 ,'269', '268'
                 ,'271', '270'
                 ,'273', '272'
                 ,'275', '274'
                 ,'277', '276'
                 ,'279', '278'
                 ,'281', '280'
                 ,'283', '282'
                 ,'285', '284'
                 ,'287', '286'
                 ,'289', '288'
                 ,'291', '290'
                 ,'293', '292'
                 ,'295', '294'
                 ,'297', '296'
                 ,'299', '298'
                 ,'301', '300'
                 ,'303', '302'
                 ,'305', '304'
                 ,'307', '306'
                 ,'309', '308'
                 ,'311', '310'
                 ,'314', '313'
                 ,'316', '315'
                 ,'318', '317'
                 ,'320', '319'
                 ,'322', '321'
                 ,'324', '323'
                 ,'326', '325'
                 ,'328', '327'
                 ,'331', '330'
                 ,'333', '332'
                 ,'335', '334'
                 ,'337', '336'
                 ,'339', '338'
                 ,'341', '340'
                 ,'343', '342'
                 ,'345', '344'
                 ,'347', '346'
                 ,'349', '348'
                 ,'351', '350'
                 ,'353', '352'
                 ,'355', '354'
                 ,'357', '356'
                 ,'359', '358'
                 ,'361', '360'
                 ,'363', '362'
                 ,'365', '364'
                 ,'367', '366'
                 ,'369', '368'
                 ,'371', '370'
                 ,'373', '372'
                 ,'375', '374'
                 ,'378', '377'
                 ,'380', '379'
                 ,'382', '381'
# Greek alphabet
                 ,'945', '913'
                 ,'946', '914'
                 ,'947', '915'
                 ,'948', '916'
                 ,'949', '917'
                 ,'950', '918'
                 ,'951', '919'
                 ,'952', '920'
                 ,'953', '921'
                 ,'954', '922'
                 ,'955', '923'
                 ,'956', '924'
                 ,'957', '925'
                 ,'958', '926'
                 ,'959', '927'
                 ,'960', '928'
                 ,'961', '929'
#	     ,'962', '930'
                 ,'963', '931'
                 ,'964', '932'
                 ,'965', '933'
                 ,'966', '934'
                 ,'967', '935'
                 ,'968', '936'
                 ,'969', '937'
);


%iso_10646_character_map
    = (
	%iso_8859_1_character_map,
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
	'zcaron', '&#382;',	# small z, caron accent

#<!-- Latin Extended-B -->
	'fnof', '&#402;',


#<!-- Spacing Modifier Letters and Accents -->
	'apos', '&#700;',	# apostrophe
	'circ', '&#710;',
	'caron', '&#711;',
	'breve', '&#728;',
	'dot', '&#729;',
	'ring', '&#730;',
	'ogon', '&#731;',
	'tilde', '&#732;',
	'dblac', '&#733;',

#<!-- Greek -->
	'Alpha', '&#913;',
	'Beta', '&#914;',
	'Gamma', '&#915;',
	'Delta', '&#916;',
	'Epsilon', '&#917;',
	'Zeta', '&#918;',
	'Eta', '&#919;',
	'Theta', '&#920;',
	'Iota', '&#921;',
	'Kappa', '&#922;',
	'Lambda', '&#923;',
	'Mu', '&#924;',
	'Nu', '&#925;',
	'Xi', '&#926;',
	'Omicron', '&#927;',
	'Pi', '&#928;',
	'Rho', '&#929;',
#	'Sigmaf', '&#930;',
	'Sigma', '&#931;',
	'Tau', '&#932;',
	'Upsilon', '&#933;',
	'Phi', '&#934;',
	'Chi', '&#935;',
	'Psi', '&#936;',
	'Omega', '&#937;',

	'alpha', '&#945;',
	'beta', '&#946;',
	'gamma', '&#947;',
	'delta', '&#948;',
	'epsilon', '&#949;',
	'zeta', '&#950;',
	'eta', '&#951;',
	'theta', '&#952;',
	'iota', '&#953;',
	'kappa', '&#954;',
	'lambda', '&#955;',
	'mu', '&#956;',
	'nu', '&#957;',
	'xi', '&#958;',
	'omicron', '&#959;',
	'pi', '&#960;',
	'rho', '&#961;',
	'sigmaf', '&#962;',
	'sigma', '&#963;',
	'tau', '&#964;',
	'upsilon', '&#965;',
	'phi', '&#966;',
	'chi', '&#967;',
	'psi', '&#968;',
	'omega', '&#969;',

	'thetasym', '&#977;',
	'upsih', '&#978;',
	'piv', '&#982;',

#<!-- Hebrew vocalization points -->
	'sheva', '&#1456;',
	'hatafsegol', '&#1457;',
	'hatafpatah', '&#1458;',
	'hatafqamats', '&#1459;',
	'hiriq', '&#1460;',
	'tzere', '&#1461;',
	'segol', '&#1462;',
	'patah', '&#1463;',
	'qamats', '&#1464;',
	'holam', '&#1465;',
#	'', '&#1466;',
	'qubuts', '&#1467;',
	'dagesh', '&#1468;',
	'meteg', '&#1469;',
	'maqaf', '&#1470',
	'rafe', '&#1471;',
	'paseq', '&#1472;',
	'sofpasuq', '&#1475;',
	'gershayim', '&#1480;',
	'doublevav', '&#1520;',
	'vavyod', '&#1521;',
	'doubleyod', '&#1522;',
	'geresh', '&#1523;',

#<!-- Hebrew letters -->
	'alef', '&#1488;',
	'bet', '&#1489;',
	'gimel', '&#1490;',
	'dalet', '&#1491;',
	'he', '&#1492;',
	'vav', '&#1493;',
	'zayin', '&#1494;',
	'het', '&#1495;',
	'tet', '&#1496;',
	'yod', '&#1497;',
	'finalkaf', '&#1498;',
	'kaf', '&#1499;',
	'lamed', '&#1500;',
	'finalmem', '&#1501;',
	'mem', '&#1502;',
	'finalnun', '&#1503;',
	'nun', '&#1504;',
	'samekh', '&#1505;',
	'ayin', '&#1506;',
	'finalpe', '&#1507;',
	'pe', '&#1508;',
	'finaltsadi', '&#1509;',
	'tsadi', '&#1510;',
	'qof', '&#1511;',
	'resh', '&#1512;',
	'shin', '&#1513;',
	'tav', '&#1514;',

#<!-- General Punctuation -->
	'ensp', '&#8194;',
	'emsp', '&#8195;',
	'thinsp', '&#8201;',
	'zwnj', '&#8204;',
	'zwj', '&#8205;',
	'lrm', '&#8206;',
	'rlm', '&#8207;',
	'ndash', '&#8211;',
	'mdash', '&#8212;',
	'lsquo', '&#8216;',
	'rsquo', '&#8217;',
	'sbquo', '&#8218;',
	'ldquo', '&#8220;',
	'rdquo', '&#8221;',
	'bdquo', '&#8222;',
	'dagger', '&#8224;',
	'Dagger', '&#8225;',

#<!-- General Punctuation -->
	'bull', '&#8226;',
	'hellip', '&#8230;',  # horiz ellipsis
	'permil', '&#8240;',  # per million
	'prime', '&#8242;',   # prime; e.g. feet
	'Prime', '&#8243;',   # double-prime; e.g. inches
	'lsaquo', '&#8249;',
	'rsaquo', '&#8250;',
	'oline', '&#8254;',
	'frasl', '&#8260;',   # fraction-slash

	'euro', '&#8364;',   # Euro sign


#<!-- Letterlike Symbols -->
	'image', '&#8465;',   # black-letter I
	'weierp', '&#8472;',   # Weierstrasse-P
	'real', '&#8476;',    # black-letter R
	'trade', '&#8482;',   # trademark  # NS4(Mac)
	'alefsym', '&#8501;',   # aleph   # NS4(Mac)
#	'aleph', '&#8501;',   # aleph   # NS4(Mac)
        
#<!-- Arrows -->
	'larr', '&#8592;',
	'uarr', '&#8593;',
	'rarr', '&#8594;',
	'darr', '&#8595;',
	'harr', '&#8596;',
	'crarr', '&#8629;',  # carriage-return arrow
	'lArr', '&#8656;',
	'uArr', '&#8657;',
	'rArr', '&#8658;',
	'dArr', '&#8659;',
	'hArr', '&#8660;',

#<!-- Mathematical Operators -->
	'forall', '&#8704;',
	'part', '&#8706;',
	'exist', '&#8707;',
	'empty', '&#8709;',
	'nabla', '&#8711;',
	'isin', '&#8712;',
	'notin', '&#8713;',
	'ni', '&#8715;',
	'prod', '&#8719;',
	'sum', '&#8721;',
	'minus', '&#8722;',
	'lowast', '&#8727;',
	'radic', '&#8730;',
	'prop', '&#8733;',
	'infin', '&#8734;',
	'ang', '&#8736;',
	'and', '&#8743;',
	'or', '&#8744;',
	'cap', '&#8745;',
	'cup', '&#8746;',
	'int', '&#8747;',
	'there4', '&#8756;',
	'sim', '&#8764;',
	'cong', '&#8773;',
	'asymp', '&#8776;',
	'ne', '&#8800;',
	'equiv', '&#8801;',
	'le', '&#8804;',
	'ge', '&#8805;',
	'sub', '&#8834;',
	'sup', '&#8835;',
	'nsub', '&#8836;',
	'sube', '&#8838;',
	'supe', '&#8839;',
	'oplus', '&#8853;',
	'otimes', '&#8855;',
	'perp', '&#8869;',
	'sdot', '&#8901;',    # dot operator

#<!-- Miscellaneous Technical -->
	'lceil', '&#8968;',
	'rceil', '&#8969;',
	'lfloor', '&#8970;',
	'rfloor', '&#8971;',
	'lang', '&#9001;',
	'rang', '&#9002;',

#<!-- Geometric Shapes -->
	'loz', '&#9674;',

#<!-- Miscellaneous Symbols -->
	'spades', '&#9824;',
	'clubs', '&#9827;',
	'hearts', '&#9829;',
	'diams', '&#9830;'

	);

&make_unicode_map if ($PREV_CHARSET);

%iso_10646_character_map_inv
    = (
	%iso_8859_1_character_map_inv,
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
	'&#382;', '\\v{z}',

	'&#402;', '\\ensuremath{f}',
	'&#710;', '\\hash{}',
	'&#732;', '\\~{\\phantom{x}}',

	'&#913;', '\\Alpha ',
	'&#914;', '\\Beta ',
	'&#915;', '\\Gamma ',
	'&#916;', '\\Delta ', 
	'&#917;', '\\Epsilon ', 
	'&#918;', '\\Zeta ', 
	'&#919;', '\\Eta ', 
	'&#920;', '\\Theta ',
	'&#921;', '\\Iota ',
	'&#922;', '\\Kappa ',
	'&#923;', '\\Lambda ',
	'&#924;', '\\Mu ',
	'&#925;', '\\Nu ',
	'&#926;', '\\Xi ',
	'&#927;', '\\Omicron ',
	'&#928;', '\\Pi ',
	'&#929;', '\\Rho ',
	'&#931;', '\\Sigma ',
	'&#932;', '\\Tau ',
	'&#933;', '\\Upsilon ',
	'&#934;', '\\Phi ',
	'&#935;', '\\Chi ',
	'&#936;', '\\Psi ',
	'&#937;', '\\Omega ',

	'&#945;', '\\alpha ',
	'&#946;', '\\beta',
	'&#947;', '\\gamma ',
	'&#948;', '\\delta ',
	'&#949;', '\\epsilon ',
	'&#950;', '\\zeta ',
	'&#951;', '\\eta ',
	'&#952;', '\\theta ',
	'&#953;', '\\iota ',
	'&#954;', '\\kappa ',
	'&#955;', '\\lambda ',
	'&#956;', '\\mu ',
	'&#957;', '\\nu ',
	'&#958;', '\\xi ',
	'&#959;', '\\omicron ',
	'&#960;', '\\pi ',
	'&#961;', '\\rho ',
	'&#962;', '\\varsigma ',
	'&#963;', '\\sigma ',
	'&#964;', '\\tau ',
	'&#965;', '\\upsilon ',
	'&#966;', '\\phi ',
	'&#967;', '\\chi ',
	'&#968;', '\\psi ',
	'&#969;', '\\omega ',

	'&#977;', '\\vartheta ', 
	'&#978;', '\\upsilon ',    # this is wrong, but close
	'&#982;', '\\varpi ',

     '&#1488;' , '\\alef ',
     '&#1489;' , '\\bet ',
     '&#1490;' , '\\gimel ',
     '&#1491;' , '\\dalet ',
     '&#1492;' , '\\he ',
     '&#1493;' , '\\vav ',
     '&#1494;' , '\\zayin ',
     '&#1495;' , '\\het ',
     '&#1496;' , '\\tet ',
     '&#1497;' , '\\yod ',
     '&#1498;' , '\\finalkaf ',
     '&#1499;' , '\\kaf ',
     '&#1500;' , '\\lamed ',
     '&#1501;' , '\\finalmem ',
     '&#1502;' , '\\mem ',
     '&#1503;' , '\\finalnun ',
     '&#1504;' , '\\nun ',
     '&#1505;' , '\\samekh ',
     '&#1506;' , '\\ayin ',
     '&#1507;' , '\\finalpe ',
     '&#1508;' , '\\pe ',
     '&#1509;' , '\\finaltsadi ',
     '&#1510;' , '\\tsadi ',
     '&#1511;' , '\\qof ',
     '&#1512;' , '\\resh ',
     '&#1513;' , '\\shin ',
     '&#1514;' , '\\tav ',

	'&#8194;', '\\;',
	'&#8195;', '\\>',
	'&#8201;', '\\,',
	'&#8204;', '\\goodbreak{}',
	'&#8205;', '\\nobreak{}',
#	'&#8206;',  # l-r text marker
#	'&#8207;',  # r-l text marker
	'&#8211;', '{--}',
	'&#8212;', '{---}',
	'&#8216;', '\`{}',
	'&#8217;', "\'{}",
	'&#8218;', '\\quotesinglbase{}',
	'&#8220;', '\`\`',
	'&#8221;', "\'\'",
	'&#8222;', '\\quotedblbase{}',
	'&#8224;', '\\dagger{}',
	'&#8225;', '\\ddagger{}',
	'&#8226;', '\\ensuremath{\\bullet}',
	'&#8230;', '\\dots{}',
	'&#8240;', '\\textperthousand{}', # per mille
	'&#8242;', '\\ensuremath{^{\\prime}}',
	'&#8243;', '\\ensuremath{^{\\prime\\prime}}',
	'&#8249;', '\\leftguilsingl{}',
	'&#8250;', '\\rightguilsingl{}',
	'&#8254;', '\\ensuremath{\\overline{\phantom{x}}}',
	'&#8260;', '\\emsuremath{/}',
	'&#8364;', '\\texteuro{}', # Euro sign
	'&#8465;', '\\ensuremath{\\Im}',
	'&#8472;', '\\ensuremath{\\wp}',
	'&#8476;', '\\ensuremath{\\Re}',
	'&#8482;', '\\trademark{}',
	'&#8501;', '\\ensuremath{\\aleph}',

	'&#8592;', '\\leftarrow ',
	'&#8593;', '\\uparrow ', 
	'&#8594;', '\\rightarrow ',
	'&#8595;', '\\downarrow ',
	'&#8596;', '\\leftrightarrow ',
	'&#8629;', '\\downharpoonleft ',
	'&#8656;', '\\Leftarrow ',
	'&#8657;', '\\Uparrow ',
	'&#8658;', '\\Rightarrow ',
	'&#8659;', '\\Downarrow ',
	'&#8660;', '\\Leftrightarrow '

	);

1;
