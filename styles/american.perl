# $Id: american.perl,v 1.1 1998/08/25 02:11:18 RRM Exp $
#
# american.perl for american babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package american;

print " [american]";

sub main'american_translation { @_[0] }


package main;

if (defined &addto_languages) { &addto_languages('american') };

sub american_titles {
    $toc_title = "Contents";
    $lof_title = "List of Figures";
    $lot_title = "List of Tables";
    $idx_title = "Index";
    $ref_title = "References";
    $bib_title = "Bibliography";
    $abs_title = "Abstract";
    $app_title = "Appendix";
    $pre_title = "Preface";
    $foot_title = "Footnotes";
    $thm_title = "Theorem";
    $fig_name = "Figure";
    $tab_name = "Table";
    $prf_name = "Proof";
    $date_name = "Date";
    $page_name = "Page";
  #  Sectioning-level titles
    $part_name = "Part";
    $chapter_name = "Chapter";
    $section_name = "Section";
    $subsection_name = "Subsection";
    $subsubsection_name = "Subsubsection";
    $paragraph_name = "Paragraph";
  #  Misc. strings
    $child_name = "Subsections";
    $info_title = "About this document ...";
    $also_name = "see also";
    $see_name = "see";
  #  names in navigation panels
    $next_name = "Next";
    $up_name = "Up";
    $prev_name = "Previous";
  #  field names in email headers
    $encl_name = "encl";
    $headto_name = "To";
    $cc_name = "cc";

    @Month = ('', 'January', 'February', 'March', 'April', 'May',
	      'June', 'July', 'August', 'September', 'October',
	      'November', 'December');
    $GENERIC_WORDS = "and|the|of|for|by|a|an|to";
}


sub american_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$Month[$1] $2 |;
    join('',$today,$_[0]);
}



# use'em
&american_titles;
$default_language = 'american';
$TITLES_LANGUAGE = 'american';
$american_encoding = 'iso-8859-1';

# $Log: american.perl,v $
# Revision 1.1  1998/08/25 02:11:18  RRM
# 	Babel language support
#
#

1;
