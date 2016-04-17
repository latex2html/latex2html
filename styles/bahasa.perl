# $Id: bahasa.perl,v 1.1 1998/08/25 02:11:19 RRM Exp $
#
# bahasa.perl for bahasa babel
# by Ross Moore <ross@mpce.mq.edu.au>


package bahasa;

print " [bahasa]";

sub main'bahasa_translation { @_[0] }


package main;

if (defined &addto_languages) { &addto_languages('bahasa') };

sub bahasa_titles {
    $toc_title = "Daftar Isi";
    $lof_title = "Daftar Gambar";
    $lot_title = "Daftar Tabel";
    $idx_title = "Indeks";
    $ref_title = "Pustaka";
    $bib_title = "Bibliografi";
    $abs_title = "Ringkasan";
    $app_title = "Lampiran";
##    $pre_title = "";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Gambar";
    $tab_name = "Tabel";
    $page_name = "Halaman";
  #  Sectioning-level titles
    $part_name = "Bagian";
    $chapter_name = "Bab";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
    $prf_name = "Bukti";
#    $child_name = "";
#    $info_title = " ";
    $also_name = "lihat juga";
    $see_name = "lihat";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Lampiran";
    $headto_name = "Kepada";
    $cc_name = "cc";

    @Month = ('', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
	'Juli', 'Agustus', 'September', 'Oktober', 'Nopember', 'Desember');
#    $GENERIC_WORDS = "ja";
}



sub bahasa_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&bahasa_titles;
$default_language = 'bahasa';
$TITLES_LANGUAGE = 'bahasa';
$bahasa_encoding = 'iso-8859-1';

# $Log: bahasa.perl,v $
# Revision 1.1  1998/08/25 02:11:19  RRM
# 	Babel language support
#
#

1;
