
########################################################################
# $Id: CJK.perl,v 1.8 2002/04/26 16:06:52 RRM Exp $
# CJK.perl
#   Jens Lippmann <lippmann@rbg.informatik.tu-darmstadt.de>,
#   Boy Yang <yangboy@math.ntu.edu.tw>,
#   Werner Lemberg <xlwy01@uxp1.hrz.uni-dortmund.de>
#
# Extension to LaTeX2HTML V 96.2 to supply support for the
# "CJK" LaTeX package.
#
########################################################################
# Change Log:
# ===========
#  jcl = Jens Lippmann
#
# $Log: CJK.perl,v $
# Revision 1.8  2002/04/26 16:06:52  RRM
#  --  JIS is EUC-JP, not ISO-2022-JP.
#
# Revision 1.7  2002/04/26 14:17:31  RRM
#  --  fixed MIME names for the encodings; thanks to Jungshik Shin for
#      the correct names
#
# Revision 1.6  2002/04/24 22:27:00  RRM
#  --  automatic recognition of document charset, based upon the
#      encoding in the first {CJK} or {CJK*} environment.
#
# Revision 1.5  1999/06/06 14:24:59  MRO
#
#
# -- many cleanups wrt. to TeXlive
# -- changed $* to /m as far as possible. $* is deprecated in perl5, all
#    occurrences should be removed.
#
# Revision 1.4  1999/04/09 18:11:27  JCL
# changed my e-Mail address
#
# Revision 1.3  1998/02/19 22:24:26  latex2html
# th-darmstadt -> tu-darmstadt
#
# Revision 1.2  1996/12/17 17:11:41  JCL
# typo
#
# Revision 1.1  1996/12/17 17:07:32  JCL
# - introduced to CVS repository
# - adjusted technical notes according to Werner's proposal
# - added support for CJK* environment
#
# jcl  16-DEC-96 - Created
#
########################################################################
# Notes:
# To may view the results only with a browser configured for the
# specific language.
# To configure the browser, use eg. the "document encoding" menu
# of NetScape.
#
# Technical Notes:
# We use the pre_process hook to change any text coming in to
# LaTeX2HTML such that we convert from the outer representation
# of double byte characters to an inner, LaTeX2HTML specific
# representation.
# The two outer representations recognized are described as follows:
# o standard CJK encodings (GB, KS, Big5, SJIS, etc.)
#   Each symbol is formed by two characters, the first in the range
#   [\201-\237\241-\376] (octal) or 0x81-0x9F, 0xA1-0xFE (hexadecimal),
#   the second in the range
#   [\100-\176\200-\377] (octal) or 0x40-0x7E, 0x80-0xFF (hexadecimal).
# o CJK internal encoding (to conveniently use CJK processed files)
#   Each symbol is a sequence with a leading character in the range
#   [\201-\237\241-\376] or 0x81-0x9F, 0xA1-0xFE,
#   a sequence of digits forming the decimal representation of the
#   second character from standard encoded form (eg. "65", "128"),
#   and a trailing 0xFF.
# The internal LaTeX2HTML representation is the same as the CJK
# encoded form.
# Additionally, we handle TeX's normalized representation of special
# characters (eg. ^^e4), which is helpful when LaTeX2HTML processes
# the .aux file.
#
# The post_process hook will convert the LaTeX2HTML internal coding
# into standard Big5/SJIS encoding, which then remains in the
# HTML text.
#
# The revert_to_raw_tex hook will convert the internal encoding
# back to standard encoding to help with image creation.
#
########################################################################


package main;

# possible values for the 1st optional argument to \begin{CJK}
# and the corresponding charset:

%CJK_charset = (
	  'Bg5'    , 'Big5'
	, 'Bg5+'   , 'Big5Plus'
	, 'Bg5hk'  , 'Big5-HKSCS'
	, 'GB'     , 'gb2312'
	, 'GBt'    , 'gbt_12345'
	, 'GBK'    , 'GBK'
#	, 'JIS'    , 'ISO-2022-JP'
	, 'JIS'    , 'EUC-JP'
	, 'SJIS'   , 'Shift_JIS'
	, 'KS'     , 'EUC-KR'
	, 'UTF8'   , 'UTF-8'
	, 'EUC-TW' , 'X-EUC-TW'
	, 'EUC-JP' , 'EUC-JP'
	, 'EUC-KR' , 'EUC-KR'
	, 'CP949'  , 'X-Windows-949'
);

# Use 'Bg5' => 'big5' as default charset, for both input and output,
# unless it is set already with a value for  $CJK_AUTO_CHARSET

$CJK_AUTO_CHARSET = '' unless (defined $CJK_AUTO_CHARSET);
$charset = $CHARSET = $CJK_AUTO_CHARSET || $CJK_charset{'Bg5'};


sub pre_pre_process {
    # Handle TeX's normalized special character encoding.
    # This *might* be done by LaTeX2HTML, too, but yet we don't
    # rely on it.
    s/\^\^([^0-9a-f])/chr((64+ord($1))&127)/gem;
    s/\^\^([0-9a-f][0-9a-f])/chr(hex($1))/gem;
    # Care for standard CJK encoding -> l2h internal form.
    s/([\201-\237\241-\376])([\100-\176\200-\376])/"$1" . ord($2) . "\377"/gem;
}

sub post_post_process {
    # l2h internal form -> standard CJK encoding
    s/([\201-\237\241-\376])(\d+)\377/"$1" . chr($2)/ge;
}

sub revert_to_raw_tex_hook {
    # l2h internal form -> standard CJK encoding
    s/([\201-\237\241-\376])(\d+)\377/"$1" . chr($2)/ge;
}


sub do_cmd_CJKchar {
    local($_) = @_;
    &get_next_optional_argument;
    s/$next_pair_rx/chr($2)/eo;
    s/$next_pair_rx/$2\377/o;
    $_;
}

# Handle CJK environments.
# The usage of \CJKspace, \CJKnospace is not implemented yet.
#
sub do_env_CJK {
    local($_) = @_;
    my ($cjk_enc);
    # skip font encoding
    &get_next_optional_argument;

    # handle CJK encoding
    $cjk_enc = &missing_braces unless 
	((s/$next_pair_pr_rx/$cjk_enc = $2; ''/eo)
	||(s/$next_pair_rx/$cjk_enc = $2; ''/eo));
    $cjk_enc =~ s/^\s+|\s+$//g;
    if ($cjk_enc) {
	if (!defined $CJK_charset{$cjk_enc}) {
	    &write_warning ( "unknown charset code: $cjk_enc in CJK environment.");
	} elsif (!$CJK_AUTO_CHARSET) {
	    $CJK_AUTO_CHARSET = $charset = $CHARSET = $CJK_charset{$cjk_enc};
	} elsif ($CHARSET eq $CJK_charset{$cjk_enc}) {
	    # compatible; do nothing.
	} else {
	    &write_warning ( "Only one charset allowed per document: $CHARSET");
	    &write_warning ( "Ignoring request for ".$CJK_charset{$cjk_enc});
	}
    }
    
    # skip CJK font family
    s/$next_pair_rx//o;
    $_;
}

# Handle CJK* environments.
# The usage of \CJKspace, \CJKnospace is not implemented yet.
# We won't catch single newlines following CJK symbols, because
# this would require to suppress the newlines in the HTML output,
# leading to overly long lines.
#
sub do_env_CJKstar {
    local($_) = &do_env_CJK;
    #CJK symbols eat ensuing white space
    s/([\201-\237\241-\376]\d+\377)[ \t]+/\1/g;
    $_;
}

# most of the commands here need some action which is not implemented yet.

&ignore_commands(<<_IGNORED_CMDS_);
CJKCJKchar
CJKboldshift
CJKcaption # {}
CJKenc # {}
CJKencfamily # [] # {} # {}
CJKfamily # {}
CJKfontenc # {} # {}
CJKglue
CJKhangul
CJKhangulchar
CJKhanja
CJKkern
CJKlatinchar
CJKnospace
CJKspace
CJKtilde
CJKtolerance
CJKuppercase
Unicode # {} # {}
nbs
standardtilde
_IGNORED_CMDS_


# we need \AtBeginDocument and \AtEndDocument

&ignore_commands(<<_IGNORED_CMDS_);
AtBeginDocument # {}
AtEndDocument # {}
_IGNORED_CMDS_

# This must be the last line.
1;
