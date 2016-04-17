# LaTeX2HTML configuration file
# special hand-edited version for the TeXlive CDROM

# Author: Marek Rouchal <marek@saftsack.fs.uni-bayreuth.de>

# This file mainly contains generic paths, i.e. the external programs
# must be locatable through the $PATH environment variable.
# Furthermore some assumptions about the capabilities of the external
# programs are made. These are fulfilled by:
# - the latest Web2C including latex, dvips, kpsewhich etc.
# - gs4.03 or higher
# - netpbm 1mar1994p1 (p1 *is* important)
# - pnmtopng (?)
#
# Currently (TeXlive 3) the following required items are missing:
# - perl
# - gs
# - netpbm (and pnmtopng)
# If they are present in PATH, latex2html seems to work...
#
# TeXlive does not seem to support OS/2...

package cfgcache;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(%cfg);

$cfg{'ANYTOPNM'} = q|anytopnm|;
$cfg{'BINDIR'} = q|/tmp/TeXlive/bin|;
$cfg{'CRAYOLAFILE'} = q|crayola.txt|;
$cfg{'DVIPS'} = q|dvips|;
$cfg{'DVIPSOPT'} = q'-E -Ppdf';
$cfg{'GIFTOPNM'} = q|giftopnm|;
$cfg{'GS'} = q|gs|; # gs is not included on TeXlive!
$cfg{'GSALIASDEVICE'} = q|ppmraw|;
$cfg{'GSDEVICE'} = q|pnmraw|;
$cfg{'GSLANDSCAPE'} = q||;
$cfg{'GS_LIB'} = q||; # this could be set to $TEXLIVEROOT/...
$cfg{'HASHBANG'} = q'0';
$cfg{'ICONPATH'} = q||; # overridden in l2hconf.pin
$cfg{'ICONSTORAGE'} = q||;
$cfg{'IMAGE_TYPES'} = q|gif|;
$cfg{'INITEX'} = q|initex|;
$cfg{'KPSEWHICH'} = q|kpsewhich|;
$cfg{'LATEX'} = q|latex|;
$cfg{'LATEX2HTMLDIR'} = q||; # overridden by the wrapper scripts
$cfg{'LATEX2HTMLPLATDIR'} = q||; # overridden by the wrapper scripts
$cfg{'LIBDIR'} = q|/tmp/TeXlive/latex2html|;
$cfg{'MKTEXLSR'} = q|texhash|;
$cfg{'METADPI'} = q|180|;
$cfg{'METAMODE'} = q|toshiba|;
$cfg{'NULLFILE'} = q|/dev/null|; # overridden by L2hos->nulldev
$cfg{'PBMMAKE'} = q|pbmmake|;
$cfg{'PCXTOPPM'} = q|pcxtoppm|;
$cfg{'PERL'} = q|perl|;
$cfg{'PERLFOOTER'} = '__END__';
$cfg{'PERLHEADER'} = q" -*- perl -*- -w\n";
$cfg{'PERLSCRIPTDIR'} = q'/usr/bin'; # not used with TeXlive
$cfg{'PICTTOPPM'} = q|picttoppm|;
$cfg{'PK_GENERATION'} = q|0|;
$cfg{'PNMBLACK'} = q||;
$cfg{'PNMCAT'} = q|pnmcat|;
$cfg{'PNMCROP'} = q|pnmcrop -verbose |;
$cfg{'PNMCROPOPT'} = q| -sides |;
$cfg{'PNMCUT'} = q|pnmcut|;
$cfg{'PNMFILE'} = q|pnmfile|;
$cfg{'PNMFLIP'} = q|pnmflip|;
$cfg{'PNMPAD'} = q|pnmpad|;
$cfg{'PNMROTATE'} = q|pnmrotate|;
$cfg{'PNMSCALE'} = q|pnmscale|;
$cfg{'PNMTOPNG'} = q|pnmtopng|;
$cfg{'PPMQUANT'} = q|ppmquant|;
$cfg{'PPMTOGIF'} = q|ppmtogif|;
$cfg{'PPMTOJPEG'} = q|ppmtojpeg|;
$cfg{'PREFIX'} = q|/tmp/TeXlive|;
$cfg{'RGBCOLORFILE'} = q|rgb.txt|;
$cfg{'SGITOPNM'} = q|sgitopnm|;
$cfg{'SHLIBDIR'} = q'/tmp/TeXlive/latex2html';
$cfg{'TEX'} = q|tex|;
# is the following correct?
$cfg{'TEXPATH'} = q|/tmp/TeXlive/texmf/tex/latex/latex2html|;
$cfg{'TIFFTOPNM'} = q|tifftopnm|;
$cfg{'TMPSPACE'} = q||; # not needed in TeXlive
$cfg{'WEB2C'} = q|1|;
$cfg{'XBMTOPBM'} = q|xbmtopbm|;
$cfg{'XWDTOPNM'} = q|xwdtopnm|;
$cfg{'dd'} = q|/|; # overridden by L2hos->dd
$cfg{'distver'} = '99.2alpha6';
$cfg{'exec_extension'} = q''; # overridden by build.pl
$cfg{'gif_interlace'} = q|netpbm|;
$cfg{'gif_trans'} = q|netpbm|;
$cfg{'have_dvipsmode'} = q|1|;
$cfg{'have_geometry'} = q|1|;
$cfg{'have_images'} = q|1|;
$cfg{'have_pstoimg'} = q|1|;
$cfg{'perl_starter'} = q''; # automatic
$cfg{'pipes'} = q|0|; # pity...
$cfg{'plat'} = q|unix|; # overridden by build.pl
$cfg{'srcdir'} = q'.';
$cfg{'texlive'} = q|1|;
$cfg{'wrapper'} = q|0|;

1; # must be last line
