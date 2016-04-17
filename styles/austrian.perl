# $Id: austrian.perl,v 1.1 1998/08/25 02:11:19 RRM Exp $
#
# austrian.perl  for austrian dialect with babel, based on german.perl
# by Ross Moore <ross@mpce.mq.edu.au>
#
# Change Log:
# ===========
# $Log: austrian.perl,v $
# Revision 1.1  1998/08/25 02:11:19  RRM
# 	Babel language support
#

package austrian;
#JKR: print a message.
print " [austrian]";

# Put austrian equivalents here for headings/dates/ etc when
# latex2html start supporting them ...


sub main'austrian_translation {
    local($_) = @_;
    s/;SPMquot;\s*(;SPMlt;|;SPMgt;|'|`|\\|-|=|;SPMquot;|\||~)/&get_austrian_specials($1)/geo;
    local($next_char_rx) = &make_next_char_rx("[aAeEiIoOuU]");
    s/$next_char_rx/&main'iso_map(($2||$3),"uml")/geo;
#    $next_char_rx = &make_next_char_rx("[sSzZ]");
    $next_char_rx = &make_next_char_rx("[sz]");
    s/$next_char_rx/&main'iso_map("sz","lig")/geo;
    $next_char_rx = &make_next_char_rx("[SZ]"); s/$next_char_rx/S$2/go;
    s/;SPMquot;\s*([cflmnprt])/\1/go;
#    s/;SPMquot;\s*([cflmnpt])/\1/go;
#    s/;SPMquot;\s*(;SPMlt;|;SPMgt;|'|`|\\|-|;SPMquot;|\||~)/&get_austrian_specials($1)/geo;
#    s/;SPMquot;/''/go;
    s/;SPMquot;/&#34;/go;
    $_;
}

sub main'do_cmd_3 {
    join('',&main'iso_map("sz", "lig"),@_[0]);
}

sub make_next_char_rx {
    local($chars) = @_;
    local($OP,$CP) = &main'brackets;
    ";SPMquot;\\s*(($chars)|$OP\\d+$CP\\s*($chars)\\s*$OP\\d+$CP)";
}
   
sub get_austrian_specials {
    $austrian_specials{@_[0]}
}

%austrian_specials = (
    '\'', "``",
    "\`", ",,",
    '\\', "",
    '-', "",
    '|', "",
    ';SPMquot;', "",
    '~', "-",
    '=', "-"
);

if ($CHARSET =~ /iso_8859_2/) {
    if ($HTML_VERSION > 2.1) {
%austrian_specials = (
      ';SPMlt;', '<SMALL>;SPMlt;;SPMlt;</SMALL>'    
    , ';SPMgt;', '<SMALL>&#62;&#62;</SMALL>'
    , %austrian_specials );
    } else {
%austrian_specials = (
      ';SPMlt;', ';SPMlt;;SPMlt;'    
    , ';SPMgt;', '&#62;&#62;'
    , %austrian_specials );
    }
} else {
%austrian_specials = (
      ';SPMlt;', '&#171;'    
    , ';SPMgt;', '&#187;'
    , %austrian_specials );
}


package main;

if (defined &addto_languages) { &addto_languages('austrian') };

sub do_cmd_flqq {
    if ($CHARSET =~ /iso_8859_2/) {
	if ($HTML_VERSION > 2.1) {
	    join('', '<SMALL>;SPMlt;;SPMlt;</SMALL>',  @_[0]) }
	else { join('',  ';SPMlt;;SPMlt;',  @_[0]) }
    } else { join('',  '&#171;',  @_[0]) }
}
sub do_cmd_frqq {
    if ($CHARSET =~ /iso_8859_2/) {
	if ($HTML_VERSION > 2.1) {
	    join('', '<SMALL>&#62;&#62;</SMALL>',  @_[0]) }
	else { join('',  '&#62;&#62;',  @_[0]) }
    } else { join('',  '&#187;',  @_[0]) }
}
sub do_cmd_flq {
    if ($HTML_VERSION > 2.1) {
	join('', '<SMALL>;SPMlt;</SMALL>',  @_[0]) }
    else { join('',  ';SPMlt;',  @_[0]) }
}
sub do_cmd_frq {
    if ($HTML_VERSION > 2.1) {
	join('', '<SMALL>&#62;</SMALL>',  @_[0]) }
    else { join('',  '&#62;',  @_[0]) }
}
sub do_cmd_glqq {
    join('',  ",,",  @_[0]);};
sub do_cmd_grqq {
    join('',  "``",  @_[0]);};
sub do_cmd_glq {
    join('',  ",",  @_[0]);};
sub do_cmd_grq {
    join('',  "`",  @_[0]);};
sub do_cmd_dq {
#    join('',  "''",  @_[0]);};
    join('',  '&#34;',  @_[0]);};

sub do_cmd_austrianTeX {
    # Just in case we pass things to LaTeX
    $default_language = 'austrian';
    $latex_body .= "\\austrianTeX\n";
    @_[0];
}

sub do_cmd_originalTeX {
    # Just in case we pass things to LaTeX
    $default_language = 'original';
    $latex_body .= "\\originalTeX\n";
    @_[0];
}

#JKR: Prepare the austrian environment ...
sub austrian_titles {
    $toc_title = "Inhaltsverzeichnis";
    $lof_title = "Abbildungsverzeichnis";
    $lot_title = "Tabellenverzeichnis";
    $idx_title = "Index";
    $ref_title = "Literatur";
    $bib_title = "Literaturverzeichnis";
    $abs_title = "Zusammenfassung";
    $app_title = "Anhang";
    $pre_title = "Vorwort";
    $foot_title = "Fu&szlig;noten";
    $thm_title = "Satz";
    $fig_name = "Abbildung";
    $tab_name = "Tabelle";
    $prf_name = "Beweis";
    $date_name = "Datum";
    $page_name = "Seite";
  #  Sectioning-level titles
    $part_name = "Teil";
    $chapter_name = "Kapitel";
    $section_name = "Abschnitt";
    $subsection_name = "Unterabschnitt";
    $subsubsection_name = "Unter Unterabschnitt";
    $paragraph_name = "Absatz";
  #  Misc. strings
    $child_name = "Unterabschnitte";
    $info_title = "&Uuml;ber dieses Dokument ...";
    $also_name = "siehe auch";
    $see_name = "siehe";
  #  names in navigation panels
    $next_name = "N&auml;chste Seite";
    $up_name = "Aufw&auml;rts";
    $prev_name = "Vorherige Seite";
    $group_name = "gruppe";
  #  mail fields
    $encl_name = "Anlage(n)";
    $headto_name = "An";
    $cc_name = "Verteiler";

    @Month = ('', 'J&auml;nner', 'Februar', 'M&auml;rz', 'April', 'Mai',
	      'Juni', 'Juli', 'August', 'September', 'Oktober',
	      'November', 'Dezember');

    local($uuml,$Uuml) = (&iso_map('u','uml'),&iso_map('U','uml'));
    $GENERIC_WORDS =
	join('|',"aber","oder","und","doch","um","in","im","an","am","${uuml}ber",
	     "${Uuml}ber","unter","auf","durch","der","die","das","des","dem","den",
	     "ein","eine","eines","einem","einen","einer","vor","nach","f${uuml}r",
	     "mit","zu","zur","zum","bei","beim","per","von","vom","aus");
}

#JKR: Replace do_cmd_today (\today) with a nicer one, which is more
# similar to the original. 
#JCL introduced &get_date
sub austrian_today {
    local($today) = &get_date;
    $today =~ s|(\d+)/0?(\d+)/|$2. $Month[$1] |;
    join('',$today,$_[0]);
}

# ... and use it.
&austrian_titles;
$default_language = 'austrian';
$TITLES_LANGUAGE = 'austrian';
$austrian_encoding = 'iso-8859-1';


# MEH: Make iso_latin1_character_map_inv use more appropriate code
$iso_latin1_character_map_inv{'&#171;'} ='\\flqq';
$iso_latin1_character_map_inv{'&#187;'} ='\\frqq';
$iso_latin1_character_map_inv{'&#196;'} ='"A';
$iso_latin1_character_map_inv{'&#214;'} ='"O';
$iso_latin1_character_map_inv{'&#220;'} ='"U';
$iso_latin1_character_map_inv{'&#228;'} ='"a';
$iso_latin1_character_map_inv{'&#246;'} ='"o';
$iso_latin1_character_map_inv{'&#223;'} ='"s';
$iso_latin1_character_map_inv{'&#252;'} ='"u';
$iso_latin1_character_map_inv{'&#34;'} ='\\dq{}';

1;				# Not really necessary...



