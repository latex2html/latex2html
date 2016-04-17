# $Id: czech.perl,v 1.1 1998/08/25 02:11:23 RRM Exp $
#
# czech.perl for czech babel, inspired heavily by german.perl
# by Ross Moore <ross@mpce.mq.edu.au>


package czech;

print " [czech]";

sub main'czech_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('czech') };

&do_require_extension ('latin2');

sub czech_titles {
    $toc_title = "Obsah";
    $lof_title = "Seznam obr&aacute;zk&uring;";
    $lot_title = "Seznam tabulek";
    $idx_title = "Index";
    $ref_title = "Reference";
    $bib_title = "Literatura";
    $abs_title = "Abstrakt";
    $app_title = "Dodatek";
    $pre_title = "P&rcaron;edmluva";
##    $foot_title = "";
##    $thm_title = "";
    $fig_name = "Obr&aacute;zek";
    $tab_name = "Tabulka";
    $prf_name = "D&uring;kaz";
    $page_name = "Strana";
  #  Sectioning-level titles
    $part_name = "&Ccaron;&aacute;st";
    $chapter_name = "Kapitola";
#    $section_name = "";
#    $subsection_name = "";
#    $subsubsection_name = "";
#    $paragraph_name = "";
  #  Misc. strings
##    $child_name = "";
##    $info_title = "";
    $also_name = "viz tak&eacute;";
    $see_name = "viz";
  #  names in navigation panels
##    $next_name = "";
##    $up_name = "";
##    $prev_name = "";
##    $group_name = "";
  #  mail fields
    $encl_name = "P&uring;&iacute;loha";
    $headto_name = "Komu";
    $cc_name = "Na v&ecaron;dom&iacute;";

    @Month = ('', 'ledna', '&uacute;unora', 'b&rcaron;ezna', 'dubna',
	'kv&ecaron;tna', '&ccaron;ervna', '&ccaron;ervence', 'srpna',
	'z&aacute;&rcaron;&iacute;', '&rcaron;&iacute;jna', 'listopadu', 'prosince');

#    $GENERIC_WORDS = "";
}


sub czech_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}



# use'em
&czech_titles;
$default_language = 'czech';
$TITLES_LANGUAGE = 'czech';
$czech_encoding = 'iso-8859-2';

# $Log: czech.perl,v $
# Revision 1.1  1998/08/25 02:11:23  RRM
# 	Babel language support
#
#

1;
