# $Id: turkish.perl,v 1.1 1998/08/25 01:59:11 RRM Exp $
#
# turkish.perl for turkish babel, inspired heavily by finnish.perl
# by H. Turgut Uyar <uyar@cs.itu.edu.tr>
#
# Change Log:
# ===========
# $Log: turkish.perl,v $
# Revision 1.1  1998/08/25 01:59:11  RRM
# 	Babel language support
#
# Revision 1.1  1998/08/10 09:46:51  latex2html        ,
#  --  added translation for the info page (from finnish.perl)
#  --  removed french-specific commands
# Revision 1.0  1998/08/07 09:46:51  latex2html
#  --  first pass
#


package turkish;

sub main'turkish_translation {
    @_[0];
}



package main;

if (defined &addto_languages) { &addto_languages('turkish') };

&do_require_extension('latin5');

sub turkish_titles {
    $toc_title = '\.I&ccedil;indekiler';	# "ðÁindekiler";
    $lof_title = '\c Sekil Listesi';		# "Þekil Listesi";
    $lot_title = "Tablo Listesi";
    $idx_title = "Dizin";
    $ref_title = "Kaynaklar";
    $bib_title = 'Kaynak&ccedil;a';		# "KaynakÁa";
    $abs_title = '&Ouml;zet';		# "÷zet";
    $app_title = "Ek";
    $pre_title = '&Ouml;ns&ouml;z';		# "÷ns–z";
##    $foot_title = "";
    $fig_name = '\c Sekil';			# "Þekil";
    $tab_name = "Tablo";
    $prf_name = 'Kan\i t';			# "Kan›t";
    $page_name = 'Sayfa';
  #  Sectioning-level titles
    $part_name = 'K\i s\i m';		# "K›s›m";
    $chapter_name = 'B&ouml;l&uuml;m';
##    $section_name = '';
##    $subsection_name = '';
##    $subsubsection_name = '';
##    $paragraph_name = '';
    $subject_name = '\.Ilgili';
  #  Misc. strings
    $child_name = "Altbl&uuml;mler";		# "Altb–l¸mler";
    $info_title = "Bu belge &uuml;zerine...";	# "Bu belge ¸zerine...";
    $also_name = 'ayr\i ca bkz.';
    $see_name = 'bkz.';
  #  names in navigation panels
##    $next_name = "Next";
##    $up_name = "Up";
##    $prev_name = "Previous";
##    $group_name = "Group";
  #  mail fields
    $encl_name = '\.Ili\c sik';
    $headto_name = 'Al\i c\i';
    $cc_name = 'Di\u ger Al\i c\i lar';
    @Month = ('', 'Ocak', '\c Subat', 'Mart', 'Nisan', 'May\i s',
              'Haziran', 'Temmuz', 'A\v gustos', 'Eyl&uuml;l', 'Ekim',
              'Kas\i m', "Aral\i k");
#    @Month = ('', 'Ocak', "Þubat", 'Mart', 'Nisan', 'May›s',
#              'Haziran', 'Temmuz', "A•ustos", 'Eyl¸l', 'Ekim',
#              'Kas›m', "Aral›k");
    $GENERIC_WORDS = "ve|ile|ki|de|da|mi|m›|mu|m¸|ise";
}

#AYS(JKR): Replace do_cmd_today (\today) with a nicer one, which is more
# similar to the original. 
#JCL introduced &get_date.
sub turkish_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}

sub turkish_infopage {
    local($_) = @_;
    ( ($INFO == 1)
     ? join('', $close_all
        , "<STRONG>$t_title</STRONG><P>\nBu belge\n"
        , "<A
HREF=\"$TEX2HTMLADDRESS\"><STRONG>LaTeX</STRONG>2<tt>HTML</tt></A>"
        , " S&uuml;r&uuml;m $TEX2HTMLVERSION ile haz›rlanm›œt›r.\n"
        , "<P>Copyright &#169; 1993, 1994, 1995, 1996,\n"
        , "<A HREF=\"$AUTHORADDRESS\">Nikos Drakos</A>, \n"
        , "Computer Based Learning Unit, University of Leeds.\n"
        , "<BR>Copyright &#169; 1997, 1998,\n"
        , "<A HREF=\"$AUTHORADDRESS2\">Ross Moore</A>, \n"
        , "Mathematics Department, Macquarie University, Sydney.\n"
        , "<P>Belgenin oluœturulmas›nda kullan›lan komut: <BR>\n "
        , "<STRONG>latex2html</STRONG> <tt>$argv</tt>.\n"
        , (($INIT_FILE ne '')?
          "\n<P><TT>$INIT_FILE</TT>\n$init_file_mark\n" :'')
        , "<P>Belgeyi oluœturan: $address_data[0] $address_data[1]"
        , $open_all, $_)
     : join('', $close_all, $INFO,"\n", $open_all, $_))
}

# use'em
&turkish_titles;
$default_language = 'turkish';
$TITLES_LANGUAGE = "turkish";
$turkish_encoding = 'iso-8859-9';

1;                              # Not really necessary...
