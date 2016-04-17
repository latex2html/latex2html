# $Id: polish.perl,v 1.2 1999/07/11 07:44:13 RRM Exp $
#
# polish.perl for polish babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package polish;

print " [polish]";

sub main'polish_translation {
    local($_) = @_;
#s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\|)/&get_polish_specials($1)/geo;
s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\||[aelrcnoszAELRCNOSZ])/&get_polish_specials($1)/geo;
    $_;
}

sub get_polish_specials {
    local($char) = @_;
    if($char=~/[ae]/i) {&main'iso_map($char,'ogon')}
    elsif($char=~/[lL]/) {&main'iso_map($char,'strok')}
    elsif($char=~/r/) {&main'iso_map('z','dot')}
    elsif($char=~/R/) {&main'iso_map('Z','dot')}
    elsif($char=~/[cnosz]/i) {&main'iso_map($char,'acute')}
    else{$polish_specials{$char}}
}

%polish_specials = (
    '\''       => "``",
    "\`"       => ",,",
    ';SPMlt;'  => "&laquo;",
    ';SPMgt;'  => "&raquo;",
    '\\'       => "",
    '-'        => "-",
    ';SPMquot;'=> "",
    '='        => "-",
    '|'        => ""
);


package main;

if (defined &addto_languages) { &addto_languages('polish') };

&do_require_extension('latin2');

sub polish_titles {
    $toc_title = "Spis rzeczy";
    $lof_title = "Spis rysunk\\'ow";
    $lot_title = "Spis tablic";
    $idx_title = "Indeks";
    $ref_title = "Bibliografia";
    $bib_title = "Literatura";
    $abs_title = "Streszczenie";
    $app_title = "Dodatek";
    $pre_title = "Przedmowa";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Rysunek";
    $tab_name = "Tablica";
##    $prf_name = "";
    $page_name = "Strona";
  #  Sectioning-level titles
    $part_name = "Cz&eogon;&sacute;&cacute;";
    $chapter_name = "Rozdzia&lstrok;";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "Por\\'ownaj tak&zdot;e";
    $see_name = "Por\\'ownaj";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Za&lstrok;&aogon;cznik";
    $headto_name = "Do";
    $cc_name = "Kopie:";

    @Month = ('', 'stycznia', 'lutego', 'marca', 'kwietnia', 'maja', 'czerwca', 'lipca',
	'sierpnia', "wrze&sacute;nia", "pa&zacute;dziernika", 'listopada', 'grudnia');

#    $GENERIC_WORDS = "";
}


sub polish_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&polish_titles;
$default_language = 'polish';
$TITLES_LANGUAGE = 'polish';
$polish_encoding = 'iso-8859-2';

# $Log: polish.perl,v $
# Revision 1.2  1999/07/11 07:44:13  RRM
#  --  implements the "<letter> accent shortcuts used by Babel
#
# Revision 1.1  1998/08/25 01:59:06  RRM
# 	Babel language support
#
#

1;
