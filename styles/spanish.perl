# $$
# SPANISH.PERL by Jesus M. Gonzalez-Barahona <jgb@gsyc.inf.uc3m.es>
# Based on FRENCH.PERL (1.10 1998/03/02 09:46:51) and
# GERMAN.PERL (1.8 1998/02/22 05:27:07)

package spanish;
print "Spanish style interface for LaTeX2HTML\n";

# Put Spanish equivalents here for headings/dates/ etc when
# latex2html start supporting them ...

sub main'spanish_translation { @_[0] }



package main;

if (defined &addto_languages) { &addto_languages('spanish') };

sub do_cmd_spanishTeX {
    # Just in case we pass things to LaTeX
    $default_language = 'spanish';
    $latex_body .= "\\spanishTeX\n";
    @_[0];
}

sub do_cmd_originalTeX {
    # Just in case we pass things to LaTeX
    $default_language = 'original';
    $latex_body .= "\\originalTeX\n";
    @_[0];
}

# Names selected to match those in spanish.sty
#
sub spanish_titles {
    $toc_title = "\\'Indice General";
    $lof_title = "\\'Indice de Figuras";
    $lot_title = "\\'Indice de Tablas";
    $idx_title = "\\'Indice de Materias";
    $ref_title = "Referencias";
    $bib_title = "Bibliograf\\'ia";
    $abs_title = "Resumen";
    $app_title = "Ap\\'endice";
    $pre_title = "Prefacio";
    $foot_title = "Notas al pie";
    $thm_title = "Teorema";
    $fig_name = "Figura";
    $tab_name = "Tabla";
    $prf_name = "Demostraci\\'on";
    $date_name = "Fecha";
    $page_name = "P\\'agina";
  #  Sectioning-level titles
    $part_name = "Parte";
    $chapter_name = "Cap\\'itulo";
    $section_name = "Seccion";
    $subsection_name = "Subseccion";
    $subsubsection_name = "Subsubseccion";
    $paragraph_name = "Parrafo";
  #  Misc. strings
    $child_name = "Subsecciones";
    $info_title = "Sobre este documento...";
    $also_name = "v\\'ease tambi\\'en";
    $see_name = "v\\'ease";
  #  names in navigation panels
    $next_name = "Siguiente";
    $up_name = "Subir";
    $prev_name = "Anterior";
    $group_name = "Grupo";
  #  mail fields
    $encl_name = "Adjunto";
    $headto_name = "A";
    $cc_name = "Copia a";

    @Month = ('', 'enero', "febrero", 'marzo', 'abril', 'mayo',
              'junio', 'julio', "agosto", 'septiembre', 'octubre',
              'noviembre', "diciembre");
    $GENERIC_WORDS =
      join('|',"a","ante","cabe","con","contra","de","desde","en",
      "entre","hacia","hasta","para","por","si","sin","sobre",
      "tras","un","una","uno","unas","unos","el","la","lo","le",
      "los","las");
}

sub spanish_today {
    local($today) = &get_date();
    $today =~ s|(\d+)/0?(\d+)/|$2 de $Month[$1] |;
    join('',$today,$_[0]);
}

# ... and use it.
&spanish_titles;
$default_language = 'spanish';
$TITLES_LANGUAGE = "spanish";
$spanish_encoding = 'iso-8859-1';

1;                            # Not really necessary...
