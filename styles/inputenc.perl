# $Id: inputenc.perl,v 1.9 2002/07/03 22:58:04 RRM Exp $
#
# inputenc.perl by Ross Moore <ross@mpce.mq.edu.au>  97/10/25
#
# Extension to LaTeX2HTML V97.1 to support the "inputenc" package
# and standard LaTeX2e package options.
#
# Change Log:
# ===========
# $Log: inputenc.perl,v $
# Revision 1.9  2002/07/03 22:58:04  RRM
#  --  added [hebrew] as a valid encoding option, to load  hebrew.pl
#
# Revision 1.8  2001/04/18 12:18:21  RRM
#  --  allow the loading of  koi8.pl
#
# Revision 1.7  2001/04/18 01:39:21  RRM
#      support for the Russian language using KOI8-R encoding, and as an
#      option to the Babel package.
#      supplied by:  Georgy Salnikov  <sge@nmr.nioch.nsc.ru>
#
# Revision 1.6  1999/09/22 10:16:03  RRM
#  --  don't require an extension file, when it has already been loaded
#
# Revision 1.5  1999/09/15 12:17:07  RRM
# 	added new encodings, and options for regional encodings
#
# Revision 1.4  1998/08/02 01:38:56  RRM
#  --  fixed the problem that restricted usage to latin1 and latin2 only
# 	unknown subroutine caaused segmentation error otherwise
# 	 --- thanks to H. Turgut Uyar <uyar@leylak.cs.itu.edu.tr>
#
#

package main;


sub load_language_support {
    local($enc) = @_;
    return if ($styles_loaded{$enc});
    my $file = "$LATEX2HTMLVERSIONS${dd}$enc.pl";

    if ( require($file) ) {
        print STDERR "\nLoading $file";
	if ($charset =~ /^utf\-\d$/) {
	    $PREV_CHARSET = $CHARSET;
	    $CHARSET = "iso-10646";
	    &make_unicode_map;
	};1;
    } else {
        print STDERR "\n*** could not load support for $enc encoding ***\n"; 0;
    }
}

sub no_language_support {
    print STDERR "\n*** LaTeX2HTML has no support for the @_[0] encoding yet ***\n";}


# load extension files to implement different encodings:

sub do_inputenc_latin1{
#   if (&load_language_support('latin1')) {
        $CHARSET = 'iso-8859-1';
#   }
}

sub do_inputenc_latin0{&load_language_support('latin9');}
sub do_inputenc_latin2{&load_language_support('latin2');}
sub do_inputenc_latin3{&load_language_support('latin3');}
sub do_inputenc_latin4{&load_language_support('latin4');}
sub do_inputenc_latin5{&load_language_support('latin5');}
sub do_inputenc_latin6{&load_language_support('latin6');}

sub do_inputenc_latin7{&load_language_support('latin7');}
sub do_inputenc_latin8{&load_language_support('latin8');}
sub do_inputenc_latin9{&load_language_support('latin9');}
sub do_inputenc_latin10{&no_language_support('latin10');}

sub do_inputenc_esperanto{&load_language_support('latin3');}
sub do_inputenc_maltese{&load_language_support('latin3');}
sub do_inputenc_estonian{&load_language_support('latin4');}
sub do_inputenc_latvian{&load_language_support('latin4');}
sub do_inputenc_lithuanian{&load_language_support('latin4');}
sub do_inputenc_turkish{&load_language_support('latin5');}
sub do_inputenc_inuit{&load_language_support('latin6');}
sub do_inputenc_lappish{&load_language_support('latin6');}
sub do_inputenc_nordic{&load_language_support('latin6');}
sub do_inputenc_sami{&load_language_support('latin6');}
sub do_inputenc_baltic{&load_language_support('latin7');}
#sub do_inputenc_latvian{&load_language_support('latin7');}
sub do_inputenc_celtic{&load_language_support('latin8');}
sub do_inputenc_gaelic{&load_language_support('latin8');}
sub do_inputenc_welsh{&load_language_support('latin8');}
sub do_inputenc_euro{&load_language_support('latin9');}
sub do_inputenc_finnish{&load_language_support('latin9');}
sub do_inputenc_french{&load_language_support('latin9');}
sub do_inputenc_skolt{&load_language_support('latin9');}


sub do_inputenc_cyrillic{&no_language_support('iso-8859-5');}
sub do_inputenc_koi8_r{&load_language_support('koi8');}
sub do_inputenc_arabic{&no_language_support('iso-8859-6');}
sub do_inputenc_greek{&no_language_support('iso-8859-7');}
#sub do_inputenc_hebrew{&no_language_support('iso-8859-8');}
sub do_inputenc_hebrew{&load_language_support('hebrew');}

sub do_inputenc_thai{&no_language_support('iso-8859-11');}
sub do_inputenc_vietnamese{&no_language_support('VISCII');}

sub do_inputenc_japanese{&no_language_support('iso2022');}
sub do_inputenc_korean{&no_language_support('korean');}

sub do_inputenc_utf7{&load_language_support('unicode');}
sub do_inputenc_utf8{&load_language_support('unicode');}


sub do_inputenc_cp1252{&load_language_support('cp1252');}
sub do_inputenc_decmulti{&load_language_support('decmulti');}
sub do_inputenc_applemac{&load_language_support('macroman');}


1;	# Must be last line








