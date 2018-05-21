# $Id: luainputenc.perl,v 1.9 2002/07/03 22:58:04 RRM Exp $
#
# luainputenc.perl by Georgy Salnikov <sge@nmr.nioch.nsc.ru>  18/05/02
#
# Extension to LaTeX2HTML V2018 to support the "luainputenc" package
# for dvilualatex support.
#
# Almost identical to inputenc.perl
#
# Change Log:
# ===========
# $Log: luainputenc.perl,v $
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

sub do_luainputenc_latin1{
#   if (&load_language_support('latin1')) {
        $CHARSET = 'iso-8859-1';
#   }
}

sub do_luainputenc_latin0{&load_language_support('latin9');}
sub do_luainputenc_latin2{&load_language_support('latin2');}
sub do_luainputenc_latin3{&load_language_support('latin3');}
sub do_luainputenc_latin4{&load_language_support('latin4');}
sub do_luainputenc_latin5{&load_language_support('latin5');}
sub do_luainputenc_latin6{&load_language_support('latin6');}

sub do_luainputenc_latin7{&load_language_support('latin7');}
sub do_luainputenc_latin8{&load_language_support('latin8');}
sub do_luainputenc_latin9{&load_language_support('latin9');}
sub do_luainputenc_latin10{&no_language_support('latin10');}

sub do_luainputenc_esperanto{&load_language_support('latin3');}
sub do_luainputenc_maltese{&load_language_support('latin3');}
sub do_luainputenc_estonian{&load_language_support('latin4');}
sub do_luainputenc_latvian{&load_language_support('latin4');}
sub do_luainputenc_lithuanian{&load_language_support('latin4');}
sub do_luainputenc_turkish{&load_language_support('latin5');}
sub do_luainputenc_inuit{&load_language_support('latin6');}
sub do_luainputenc_lappish{&load_language_support('latin6');}
sub do_luainputenc_nordic{&load_language_support('latin6');}
sub do_luainputenc_sami{&load_language_support('latin6');}
sub do_luainputenc_baltic{&load_language_support('latin7');}
#sub do_luainputenc_latvian{&load_language_support('latin7');}
sub do_luainputenc_celtic{&load_language_support('latin8');}
sub do_luainputenc_gaelic{&load_language_support('latin8');}
sub do_luainputenc_welsh{&load_language_support('latin8');}
sub do_luainputenc_euro{&load_language_support('latin9');}
sub do_luainputenc_finnish{&load_language_support('latin9');}
sub do_luainputenc_french{&load_language_support('latin9');}
sub do_luainputenc_skolt{&load_language_support('latin9');}

sub do_luainputenc_cyrillic{&no_language_support('iso-8859-5');}
sub do_luainputenc_koi8_r{&load_language_support('koi8');}
sub do_luainputenc_cp1251{&load_language_support('cp1251');}
sub do_luainputenc_arabic{&no_language_support('iso-8859-6');}
sub do_luainputenc_greek{&no_language_support('iso-8859-7');}
#sub do_luainputenc_hebrew{&no_language_support('iso-8859-8');}
sub do_luainputenc_hebrew{&load_language_support('hebrew');}

sub do_luainputenc_thai{&no_language_support('iso-8859-11');}
sub do_luainputenc_vietnamese{&no_language_support('VISCII');}

sub do_luainputenc_japanese{&no_language_support('iso2022');}
sub do_luainputenc_korean{&no_language_support('korean');}

sub do_luainputenc_utf7{&load_language_support('unicode');}
sub do_luainputenc_utf8{&load_language_support('unicode');}

sub do_luainputenc_cp1252{&load_language_support('cp1252');}
sub do_luainputenc_decmulti{&load_language_support('decmulti');}
sub do_luainputenc_applemac{&load_language_support('macroman');}

1;	# Must be last line
