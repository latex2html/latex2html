# $Id: english.perl,v 1.1 1998/08/25 02:11:25 RRM Exp $
#
# english.perl for english babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package english;

print " [english]";

sub main'english_translation { @_[0] }


package main;

if (defined &addto_languages) { &addto_languages('english') };

sub do_cmd_englishTeX {
    # Just in case we pass things to LaTeX
    $default_language = 'english';
    $latex_body .= "\\englishTeX\n";
    @_[0];
}

sub do_cmd_originalTeX {
    # Just in case we pass things to LaTeX
    $default_language = 'original';
    $latex_body .= "\\originalTeX\n";
    @_[0];
}

sub english_titles {
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
    $english_see_name = "see";
    $see_name = $english_see_name;
  #  names in navigation panels
    $next_name = "Next";
    $up_name = "Up";
    $prev_name = "Previous";
  #  field names in email headers
    $encl_name = "encl";
    $headto_name = "To";
    $cc_name = "cc";

    @english_Month = ('', 'January', 'February', 'March', 'April', 'May',
		      'June', 'July', 'August', 'September', 'October',
		      'November', 'December');
    @Month = @english_Month;
    $GENERIC_WORDS = "and|the|of|for|by|a|an|to";
}


sub english_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2 $english_Month[$1] |;
    join('',$today,$_[0]);
}

sub english_seename {
  join('',$english_see_name,$_[0]);
}

# use'em
&english_titles;
$default_language = 'english';
$TITLES_LANGUAGE = 'english';
$english_encoding = 'iso-8859-1';

# $Log: english.perl,v $
# Revision 1.1  1998/08/25 02:11:25  RRM
# 	Babel language support
#
#

1;
