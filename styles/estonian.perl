# $Id: estonian.perl,v 1.1 1998/08/25 01:59:00 RRM Exp $
#
# estonian.perl for estonian babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package estonian;

print " [estonian]";

sub main'estonian_translation {
    local($_) = @_;
s/;SPMquot;\s*('|`|;SPMlt;|;SPMgt;|\\|-|;SPMquot;|=|\|)/&get_estonian_specials($1)/geo;
    $_;
}

sub get_estonian_specials {
    $estonian_specials{@_[0]}
}

%estonian_specials = (
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

if (defined &addto_languages) { &addto_languages('estonian') };

sub estonian_titles {
    $toc_title = "Sisukord";
    $lof_title = "Joonised";
    $lot_title = "Tabelid";
    $idx_title = "Indeks";
    $ref_title = "Viited";
    $bib_title = "Kirjandus";
    $abs_title = "Kokkuv\\~ote";
    $app_title = "Lisa";
    $pre_title = "Sissejuhatus";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Joonis";
    $tab_name = "Tabel";
    $prf_name = "Korrektuur";
    $page_name = "Lk.";
  #  Sectioning-level titles
    $part_name = "Osa";
    $chapter_name = 'Peat\"ukk';
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "vt. ka";
    $see_name = "vt.";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "Lisa(d)";
    $headto_name = "";
    $cc_name = "Koopia(d)";

    @Month = ('', 'jaanuar', 'veebruar', 'm\"arts', 'aprill', 'mai', 'juuni',
	'juuli', 'august', 'september', 'oktoober', 'november', 'detsember');

#    $GENERIC_WORDS = "";
}


sub estonian_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&estonian_titles;
$default_language = 'estonian';
$TITLES_LANGUAGE = 'estonian';
$estonian_encoding = 'iso-8859-1';

# $Log: estonian.perl,v $
# Revision 1.1  1998/08/25 01:59:00  RRM
# 	Babel language support
#
#

1;
