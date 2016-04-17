# $Id: francais.perl,v 1.16 1998/09/08 12:17:12 RRM Exp $
# FRENCH.PERL by Nikos Drakos <nikos@cbl.leeds.ac.uk> 25-11-93
# Computer Based Learning Unit, University of Leeds.
#
# Extension to LaTeX2HTML to translate LaTeX french special 
# commands to equivalent HTML commands and ISO-LATIN-1 characters.
# Based on a patch to LaTeX2HTML supplied by  Franz Vojik 
# <vojik@de.tu-muenchen.informatik>. 
#
# Change Log:
# ===========
# $Log: francais.perl,v $
# Revision 1.16  1998/09/08 12:17:12  RRM
#  --  implement more of the macros in the Babel package --- thanks Michel
#
# Revision 1.14  1998/08/24 12:50:18  RRM
#  --  updated for the new Babel capabilities
#
# Revision 1.12  1998/05/04 11:58:58  latex2html
#  --  added a translation for  $foot_title
#
# Revision 1.10  1998/03/02 09:46:51  latex2html
#  --  fixed the accents in static titles and dates
#
# Revision 1.8  1998/02/23 11:59:29  latex2html
# *** empty log message ***
#
# Revision 1.7  1998/02/23 11:48:17  latex2html
#  -- in language-titles, use TeX accent-macros, rather than entities
#
# Revision 1.6  1998/02/23 02:26:41  latex2html
#  --  replaced  &get_date  by  &get_date()
#         error reported with SunOS (thanks Yannick Patois)
#  --  added some more $GENERIC_WORDS
#
# Revision 1.4  1998/02/22 05:27:08  latex2html
# revised &german|french_titles
#
# Revision 1.3  1998/02/16 03:33:12  latex2html
#  --  provided $GENERIC_WORDS to be omitted from filenames derived from
# 	section-titles, when using  -long_titles
#
# Revision 1.2  1996/12/23 01:39:54  JCL
# o added informative comments and CVS log history
# o changed usage of <date> to an OS independent construction, the
#   patch is from Piet van Oostrum.
#
#
# 11-MAR-94 Nikos Drakos - Added support for \inferieura and \superrieura

package french;

# Put french equivalents here for headings/dates/ etc when
# latex2html start supporting them ...

sub main'french_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('french') };

sub do_cmd_frenchTeX {
    # Just in case we pass things to LaTeX
    $default_language = 'french';
    $latex_body .= "\\frenchTeX\n";
    @_[0];
}

sub do_cmd_originalTeX {
    # Just in case we pass things to LaTeX
    $default_language = 'original';
    $latex_body .= "\\originalTeX\n";
    @_[0];
}

sub do_cmd_inferieura {
   "&lt @_[0]"
}
 
sub do_cmd_superrieura {
   "&gt @_[0]"
}

#AYS: Prepare the french environment ...
sub french_titles {
    $toc_title = "Table des mati\\`eres";
    $lof_title = "Liste des figures";
    $lot_title = "Liste des tableaux";
    $idx_title = "Index";
    $ref_title = "R\\'ef\\'erences";
    $bib_title = "Bibliographie";
    $abs_title = "R\\'esum\\'e";
    $app_title = "Annexe";
    $pre_title = "Pr\\'eface";
    $foot_title = "Notes";
    $thm_title = "Th\\'eor&agrave;ve";
    $fig_name = "Figure";
    $tab_name = "Tableau";
    $prf_name = "Preuve";
    $date_name = "Date";
    $page_name = "page";
  #  Sectioning-level titles
    $part_name = "Partie";
    $chapter_name = "Chapitre";
    $section_name = "Section";
    $subsection_name = "Sous-section";
    $subsubsection_name = "Sous-sous-section";
    $paragraph_name = "Paragraphe";
  #  Misc. strings
    $child_name = "Sous-sections";
    $info_title = "\\`A propos de ce document..."; 
  #  names in navigation panels
    $also_name = "<EM>voir aussi</EM>";
    $see_name = "<EM>voir</EM>";
    $next_name = "suivant";
    $up_name = "monter";
    $prev_name = "pr&eacute;c&eacute;dent";
    $group_name = "groupe";
  #  mail fields
    $encl_name = "P.J. ";
    $headto_name = "";
    $cc_name = "Copie \\`a";

    @Month = ('', 'janvier', "f\\'evrier", 'mars', 'avril', 'mai',
              'juin', 'juillet', "ao\\^ut", 'septembre', 'octobre',
              'novembre', "d\\'ecembre");
    $GENERIC_WORDS = "a|au|aux|mais|ou|et|donc|or|ni|car|l|la|le|les"
	. "|c|ce|ces|un|une|d|de|du|des";
}

#AYS(JKR): Replace do_cmd_today (\today) with a nicer one, which is more
# similar to the original. 
#JCL introduced &get_date.
sub french_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2 $Month[$1] |;
    join('',$today,$_[0]);
}

sub do_cmd_up {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',"<SUP>",$&,"</SUP>",$_);
}
sub do_cmd_FrenchEnumerate {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',$&,"<SUP>o</SUP>",$_);
}
sub do_cmd_FrenchPopularEnumerate {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    join('',$&,"<SUP>o</SUP>)",$_);
}
sub do_cmd_ieme {join('',"<SUP>e</SUP>",$_[0]);}
sub do_cmd_iemes {join('',"<SUP>es</SUP>",$_[0]);}
sub do_cmd_ier {join('',"<SUP>er</SUP>",$_[0]);}
sub do_cmd_iers {join('',"<SUP>ers</SUP>",$_[0]);}
sub do_cmd_iere {join('',"<SUP>re</SUP>",$_[0]);}
sub do_cmd_ieres {join('',"<SUP>res</SUP>",$_[0]);}
sub do_cmd_primo {join('',"1<SUP>o</SUP>",$_[0]);}
sub do_cmd_secundo {join('',"2<SUP>o</SUP>",$_[0]);}
sub do_cmd_tertio {join('',"3<SUP>o</SUP>",$_[0]);}
sub do_cmd_quatro {join('',"4<SUP>o</SUP>",$_[0]);}
sub do_cmd_fprimo {join('',"1<SUP>o</SUP>",$_[0]);}
sub do_cmd_fsecundo {join('',"2<SUP>o</SUP>",$_[0]);}
sub do_cmd_ftertio {join('',"3<SUP>o</SUP>",$_[0]);}
sub do_cmd_fquatro {join('',"4<SUP>o</SUP>",$_[0]);}
sub do_cmd_No {join('',"N<SUP>o</SUP>",$_[0]);}
sub do_cmd_no {join('',"n<SUP>o</SUP>",$_[0]);}
sub do_cmd_at {join('',"@",$_[0]);}
sub do_cmd_circonflexe {join('',"^",$_[0]);}
sub do_cmd_tild {join('',"~",$_[0]);}
sub do_cmd_boi {join('',"\\",$_[0]);}
sub do_cmd_degre {join('',"&#176",$_[0]);}
sub do_cmd_degres {join('',"&#176",$_[0]);}
sub do_cmd_og {join('',"&#171",$_[0]);}
sub do_cmd_fg {join('',"&#187",$_[0]);}

# ... and use it.
&french_titles;
$default_language = 'french';
$TITLES_LANGUAGE = "french";
$french_encoding = 'iso-8859-1';

1;				# Not really necessary...



