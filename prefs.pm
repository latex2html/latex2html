###############################################################################
# $Id: prefs.pm,v 1.7 2002/04/28 12:21:51 RRM Exp $
#
# prefs.pm
#
# This file contains the preferences for the configuration procedure
# of LaTeX2HTML.
# You may modify this file to achieve a correct configuration on your
# system. UNIX users may also use the usual syntax conventioons of
# GNU configure to pass configuration parameters.
#
# Author: Marek Rouchal <marek@saftsack.fs.uni-bayreuth.de>
#
# This software is part of LaTeX2HTML, originally by Nikos Drakos
# It is published under the GNU Public License and comes without any
# warranty.
#

###############################################################################
# Changes History
#
# $Log: prefs.pm,v $
# Revision 1.7  2002/04/28 12:21:51  RRM
#      variables $DVIPSOPT and $ICONSERVER are now configurable via  prefs.pm
#
# Revision 1.5  1999/11/09 00:43:42  MRO
#
#
# -- added some changes suggested on the mail list recently: mainly cleanup
#    of -dir option
# -- added installation support for latex2html styles
#
# Revision 1.4  1999/08/26 23:33:42  MRO
#
# -- added option to load l2hcfg.pm from previous installation
# -- fixed a bunch of bugs reported by Stefan Klupsch (thanks!)
#
# Revision 1.3  1999/06/10 22:59:59  MRO
#
#
# -- fixed an artifact in the *ball icons
# -- cleanups
# -- option documentation added
# -- fixed bug in color perl (determining path to rgb/crayola)
#
# Revision 1.2  1999/06/01 06:55:34  MRO
#
#
# - fixed small bug in L2hos/*
# - added some test_mode related output to latex2html
# - improved documentation
# - fixed small bug in pstoimg wrt. OS2
#
# Revision 1.1  1999/05/11 06:09:58  MRO
#
#
# - merged config stuff, did first tries on Linux. Simple document
#   passes! More test required, have to ger rid of Warnings in texexpand
#
# Revision 1.9  1999/05/05 19:47:02  MRO
#
#
# - many cosmetic changes
# - final backup before merge
#
# Revision 1.8  1998/12/12 16:39:14  MRO
#
#
# -- cosmetic changes, reworked catching of STDERR in config.pl (Win32)
# -- new configure opt --disable-paths
# -- major cleanups
#
# Revision 1.7  1998/10/31 14:13:04  MRO
# -- changed OS-dependent module loading strategy: Modules are now located in
#    different (OS-specific) directories nut have the same name: Easier to
#    maintain and cleaner code
# -- Cleaned up config procedure
# -- Extended makefile functionality
#
# Revision 1.6  1998/08/09 20:45:19  MRO
# -- some cleanup
#
# Revision 1.5  1998/06/30 23:12:13  MRO
# -- Reworked os dependency setup, mainly for TeXlive integration.
#    Started wrapper coding.
#
# Revision 1.4  1998/05/14 22:27:36  latex2html
# -- more work on config procedure (Makefile, GS_LIB)
# -- tested pstoimg in 98.1 environment successfully on Linux
#
# Revision 1.3  1998/05/06 22:31:09  latex2html
# -- Enhancements to the config procedure: Added a "generic" target
#    in the Makefile for the TeXlive CD (not perfect yet)
# -- included test for kpsewhich / Web2C
# -- included latest stuff from Override.pm into os_*.pm
#
# Revision 1.2  1998/03/16 23:31:56  latex2html
# -- lots of cosmetic changes and bugfixes, thanks to Uli Wortmann
#    for OS/2 testing
# -- start of install procedure; checks for installation paths implemented
#
# Revision 1.1  1998/03/02 23:38:39  latex2html
# Reworked configuration procedure substantially. Fixed some killing bugs.
# Should now run on Win32, too.
# The file prefs.pm contains user-configurable stuff for DOS platforms.
# UNIX users can override the settings with the configure utility (preferred).
#

package prefs;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(%prefs);

%prefs = ();

# When executables are specified, you may give either only the name of the
# executable (e.g. 'dvips'), the configuration then searches your system for
# the program. Or you may give a complete path.
# On DOS/Windows platforms you need not specify the extension (e.g. '.exe').
# You may specify multiple executable names, separated by commas ','.

# PLEASE SET THE PERL EXECUTABLE NAME  ON THE COMMAND LINE OR IN
# CONFIG.BAT IF IT DIFFERS FROM 'perl'!!!

# Specify any additional search paths here, use `:' or `;´ as delimiter
$prefs{'EXTRAPATH'} = '';

# This is where the installation will take place. On UNIXish systems
# $prefs{'PREFIX'} = '/usr/local';
# is preferred. On DOS/Win, you might say
# $prefs{'PREFIX'} = 'C:\\progs\\latex2html';
$prefs{'PREFIX'} = '/usr/local';

# The following are derived from PREFIX if empty: BINDIR by adding /bin, and
# LIBDIR by adding /lib or /lib/latex2html, depending on whether PREFIX
# contains l2h or latex2html (case insensitive!), respectively.
# But you may specify something completely different, of course :-)
$prefs{'BINDIR'} = '';
$prefs{'LIBDIR'} = '';
$prefs{'SHLIBDIR'} = '';

# If set, only a short wrapper script is build that is going to be installed
# in BINDIR. This wrapper inludes the latex2html script, that is kept in
# LIBDIR
$prefs{'WRAPPER'} = 'no';

# If set, a special configuration is used to build a LaTeX2HTML that fits
# on the TeXlive cdrom. Only for experts :-)
$prefs{'TEXLIVE'} = 'no';

# This is how the LaTeX2HTML icons can be accessed from your HTTP server.
# It must be a valid URL on the server you are going to put your converted
# documents. Examples:
#   Relative: /icons/latex2html
#   Absolute: http://myserver.net/icons
# Note that this setting should be consistent with the following 
# setting ICONSTORAGE.
# If left empty, an appropriate file: URL is assumed. This will show
# the icons o.k. on your local host, but won't work across the Web.
$prefs{'ICONPATH'} = '';

# This is the directory where the icons have to be copied so that they
# can be accessed with the path given above. Keep this empty if you do
# not want the icons to be installed in your Web server area.
# However, the icons are installed in SHLIBDIR/icons, no matter what.
$prefs{'ICONSTORAGE'} = '';

# Set a URL here, as the place to access icons from across the Web.
# This does not have to be on the local server, or at a related site.
$prefs{'ICONSERVER'} = '';

# set this to no if you do not want any image generation by LaTeX2HTML
$prefs{'IMAGES'} = 'yes';

# TeX and friends
#
# LaTeX and other executables of the TeX typesetting suite are needed to
# render parts of the documents that cannot be translated to HTML in a
# consistent way. If you don't have LaTeX, LaTeX2HTML will run anyway,
# but with reduced capabilities.

# the TeX executable
$prefs{'TEX'} = 'tex';

# the variants for LaTeX executable
# needed for image generation
$prefs{'LATEX'} = 'latex';
$prefs{'PDFLATEX'} = 'pdflatex';
$prefs{'LUALATEX'} = 'lualatex';
$prefs{'DVILUALATEX'} = 'dvilualatex';

# the initex executable
$prefs{'INITEX'} = 'initex';

# the kpsewhich (part of Web2C) executable. If it is found, we have
# Web2C
$prefs{'KPSEWHICH'} = 'kpsewhich';
$prefs{'WEB2C'} = 0;

# the root directory for TeX include files, e.g.
# /usr/lib/texmf/tex. If KPSEWHICH is found, this path is determined
# automatically (using KPSEWHICH -p tex).
# The LaTeX2HTML specific files are installed in
# $TEXPATH(/latex)/latex2html ( /latex added only if it exists )
# You may also specify this with the --with-texpath= configure option.
# This setting overrides the automatic selection.
$prefs{'TEXPATH'} = '';

# the "mktexlsr" update utility. This is needed to build the TeX file
# searching database (aka ls-R) after adding new style files
# This tool is automatically invoked after successful installation of
# the LaTeX2HTML style files (e.g. html.sty)
$prefs{'MKTEXLSR'} = 'mktexlsr,texhash,MakeTeXlsR';

# The dvips executable and its features. dvips32 added for OS/2
$prefs{'DVIPS'} = 'dvips,dvi2ps,dvips32';

# Many options can be used with dvips to produce better quality images
# or speed-up other aspects of image-generation.
# $prefs{'DVIPSOPT'} = ' -E';  # create encapsulated (EPS) images
# $prefs{'DVIPSOPT'} = ' -Ppdf'; # use Type 1 fonts, as for PDF
# $prefs{'DVIPSOPT'} = ' -Pcmz -Pamz'; # use CM and AMS Type 1 fonts
$prefs{'DVIPSOPT'} = ' -Ppdf';

# set this to 1 if you want dvips to create special fonts for better
# image generation. You need to set the following two items to correct
# values then, i.e. the driver with the given DPI must be available.
# To enable this option, set it to 1.
$prefs{'PK'} = 0;

# The MetaFont mode to use and its resolution. Common settings are
# toshiba(180), hppost(180)???
$prefs{'METAMODE'} = 'toshiba';
$prefs{'METADPI'} = 180;

# Set this to 0 if you do not want dvips to create EPS files even if
# it is capable to
$prefs{'EPS'} = 1;

# This must be set to 1 when your DVIPS reverses the order
# of output pages. Rarely needed. Try 0 first.
$prefs{'REVERSE'} = 0;

# Try to implement SVG image support. Set to 0 if you want
# to disable SVG support even if possible.
$prefs{'SVG'} = 1;

# Try to implement GIF image support. Set to 0 if you want
# to disable GIF support even if possible.
$prefs{'GIF'} = 1;

# Try to implement PNG image support. Set to 0 if you want
# to disable PNG support even if possible.
$prefs{'PNG'} = 1;

# The dvipng executable.
$prefs{'DVIPNG'} = 'dvipng';

# The pdftocairo executable.
$prefs{'PDFTOCAIRO'} = 'pdftocairo';

# The ps2pdf executable.
$prefs{'PS2PDF'} = 'ps2pdf';

# the pdfcrop executable needed for cropping PDF images
$prefs{'PDFCROP'} = 'pdfcrop';

# Ghostscript
# this is one of the crucial points. Use the most recent version of gs
# available. Versions known to work well are 3.33 and 4.03

# the Ghostscript executable
# set name depending on platform
if($::newcfg{'plat'} eq 'os2') {
  $prefs{'GS'} = 'gsos2';
}
elsif($::newcfg{'plat'} eq 'win32') {
  #$prefs{'GS'} = 'gswin32c';
  # 2019-12-12 shige: 2-24)
  $prefs{'GS'} = 'rungs,gswin32c';
}
else {
  $prefs{'GS'} = 'gs';
}

# the Ghostscript device to use for regular conversion to portable
# bitmap format. The recommended device is pnmraw. ppmraw is ok, too but
# produces bigger intermediate files.
# The most suitable and available device is chosen automatically.
# Specify it here if you want to use a specific one.
$prefs{'GSDEVICE'} = '';

# the Ghostscript device to use for conversion of LaTeX images, e.g.
# formulas. Anti-aliasing is used then to give better images. Therefore
# a full color or full grey device is recommended (ppmraw, pgmraw)
# The most suitable and available device is chosen automatically.
# Specify it here if you want to use a specific one.
$prefs{'GSALIASDEVICE'} = '';

# the Netpbm utilities
# most of them are needed badly to create images.

# the pnmcrop executable needed for cropping of bitmaps
$prefs{'PNMCROP'} = 'pnmcrop';

# the pnmflip executable needed for flipping and rotating bitmaps
$prefs{'PNMFLIP'} = 'pnmflip';

# the pnmquant executable needed for limiting the number of colors
$prefs{'PNMQUANT'} = 'pnmquant';

# the pnmfile executable needed for determining bitmap properties
$prefs{'PNMFILE'} = 'pnmfile';

# the pnmcat executable needed for concatenating of bitmaps
$prefs{'PNMCAT'} = 'pnmcat';

# the pnmcut executable needed for extracting a portion of bitmaps
$prefs{'PNMCUT'} = 'pnmcut';

# the pnmpad extending bitmaps by padding with pixels of a fixed color
$prefs{'PNMPAD'} = 'pnmpad';

# the pbmrotate executable needed for rotating bitmaps
$prefs{'PNMROTATE'} = 'pnmrotate';

# the pbmscale executable needed for scaling bitmaps
$prefs{'PNMSCALE'} = 'pnmscale';

# the pbmmake executable needed for creation of alignment bitmaps
$prefs{'PBMMAKE'} = 'pbmmake';

# the ppmtogif executable needed for creation of GIF images
$prefs{'PPMTOGIF'} = 'ppmtogif,ppm2gif';

# the ppmtojpeg executable for constructing JPEG images from portable bitmaps
$prefs{'PPMTOJPEG'} = 'ppmtojpeg';

# the following is part of a separate package. Use at least
# the one from pnmtopng-2.31

# the pnmtopng executable needed for creation of PNG images
$prefs{'PNMTOPNG'} = 'pnmtopng,pnm2png';

# the giftopnm executable for converting GIF images to portable form
$prefs{'GIFTOPNM'} = 'giftopnm';

# the jpegtopnm executable for converting JPEG images to portable form
$prefs{'JPEGTOPNM'} = 'jpegtopnm';

# the pngtopnm executable for converting PNG images to portable form
$prefs{'PNGTOPNM'} = 'pngtopnm';

# the tifftopnm executable for converting TIFF images to portable form
$prefs{'TIFFTOPNM'} = 'tifftopnm';

# the anytopnm executable for converting arbitrary images to portable form
$prefs{'ANYTOPNM'} = 'anytopnm';

# the bmptoppm executable for converting BMP images to portable form
$prefs{'BMPTOPPM'} = 'bmptoppm';

# the pcxtoppm executable for converting PCX images to portable form
$prefs{'PCXTOPPM'} = 'pcxtoppm';

# the sgitopnm executable for converting SGI images to portable form
$prefs{'SGITOPNM'} = 'sgitopnm';

# the xbmtopbm executable for converting PBM images to portable form
$prefs{'XBMTOPBM'} = 'xbmtopbm';

# the xwdtopnm executable for converting XWD images to portable form
$prefs{'XWDTOPNM'} = 'xwdtopnm';

# if the Netpbm utility ppmtogif lack certain features (the most
# recent version of Netpbm is ok), the following utilities will
# be useful:

# the giftool executable needed for making GIFs interlaced and/or
# transparent
$prefs{'GIFTOOL'} = 'giftool';

# the giftrans executable needed for making GIFs transparent
$prefs{'GIFTRANS'} = 'giftrans';

# either pygmentize or source-highlight executable needed for colorized listings
$prefs{'SRCHILITE'} = 'pygmentize,source-highlight,pygmentize3,pygmentize2';

# to speed things up, pstoimg issues piped commands. This may fail on
# some systems. On unsafe systems, this is automatically set to 0.
# Say 1 for pipe usage and 0 for no pipes.
$prefs{'PIPES'} = 1;

# if this is true, then the config procedure saves the absolute pathnames
# of the external programs in the perl scripts. This is necessary if 
# running in an environment where e.g. gs is not always in the PATH 
# environment. On the other hand, if this option is disabled, you can move
# the external tools around your filesystems and LaTeX2HTML will keep
# working without reconfiguration as long as the programs can be reached
# through PATH.
# The default is 1 for historical reasons. You can switch it of by saying
# --disable-paths when using configure.
$prefs{'ABSPATHS'} = 1;

# this is the path to a temporary disk space area. If the area is a ram
# drive, this setting may speed up image conversion. The following standard
# paths are checked on the respective platforms:
# UNIX        : /tmp /usr/tmp /var/tmp /usr/local/tmp
# DOS/Windows : C:\TMP C:\TEMP C:\WINDOWS\TEMP
$prefs{'TMPSPACE'} = '';

# The location of the rgb.txt color definition file. If omitted, the
# file that comes with the LaTeX2HTML distribution is used.
$prefs{'RGB'} = '';

# The location of the crayola.txt color definition file. If omitted, the
# file that comes with the LaTeX2HTML distribution is used.
$prefs{'CRAYOLA'} = '';

# The names of HTML validators to look for on the system. Note: These
# tools should accept a single HTML filename as argument.
$prefs{'HTML_VALIDATOR'} = 'html4-check';

###########################################
# no need to edit anything below this line

sub get_preferences {
  return %prefs;
  }

1; # make require happy. DO NOT DELETE THIS LAST LINE!
