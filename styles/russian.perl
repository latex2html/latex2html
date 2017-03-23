#  russian.perl corrected by Sergej V. Znamenskij  
#
# $Id: russian.perl,v 1.1 2001/04/18 01:39:21 RRM Exp $
#
# russian.perl for russian babel, inspired heavily by german.perl
# by Georgy Salnikov <sge@nmr.nioch.nsc.ru>


package russian;

print " [russian]";

sub main'russian_translation { @_[0] }


package main;

if (defined &addto_languages) { &addto_languages('russian') };

if ($CHARSET eq 'iso-10646' || $CHARSET eq 'utf-8' || $INPUTENC eq '') {
  &load_language_support('utf8ru');	# UTF-8 cannot be treated universally
}

# use'em
&russian_titles;

$default_language = 'russian';
$TITLES_LANGUAGE = "russian";




sub main'russian_translation {
#print $_;
    local($_) = @_;
    s/;SPMquot;\-\-\-/&#8212;/go;
    s/\-\-\-/&#8212;/go;
    s/;SPMquot;\-\-\*/&#8212;/go;
    s/;SPMquot;\-\-\~/&#8212;/go;
    s/;SPMquot;[~\-=]/&#8208;/go;
    s/\-\-/&#8211;/go;
    s/;SPMlt;;SPMlt;/&#171;/go;
    s/;SPMgt;;SPMgt;/&#187;/go;
    s/;SPMquot;;SPMlt;/&#171;/go;
    s/;SPMquot;;SPMgt;/&#187;/go;
    s/;SPMquot;\`/&#8222;/go;
    s/;SPMquot;\'/&#147;/go;
    s/\`\`/&#147;/go;
    s/\'\'/&#148;/go;
    $_;
 }


sub make_next_char_rx {
    local($chars) = @_;
    local($OP,$CP) = &main'brackets;
    ";SPMquot;\\s*(($chars)|$OP\\d+$CP\\s*($chars)\\s*$OP\\d+$CP)";
}
   

package main;

if (defined &addto_languages) { &addto_languages('russian') };

sub do_cmd_flqq {&do_cmd_guillemotleft( @_) }
sub do_cmd_frqq {&do_cmd_guillemotright(@_)}
sub do_cmd_flq {&do_cmd_guilsinglleft( @_)}
sub do_cmd_frq {&do_cmd_guilsinglright(@_)}
sub do_cmd_glq {&do_cmd_textquoteleft( @_)}
sub do_cmd_grq {&do_cmd_textquoteright(@_)}
sub do_cmd_glqq {&do_cmd_textquotedblleft( @_)}
sub do_cmd_grqq {&do_cmd_textquotedblright(@_)}
sub do_cmd_dag { join('', &iso_map("dagger", ""), $_[0]);}
sub do_cmd_No {join('', "&#8470;", $_[0]);}

sub do_cmd_russianTeX {
    # Just in case we pass things to LaTeX
    $default_language = 'russian';
    $latex_body .= "\\RussianTeX\n";
    $encoding=$russian_encoding;
    @_[0];
}

sub do_cmd_originalTeX {
    # Just in case we pass things to LaTeX
    $default_language = 'original';
    $latex_body .= "\\originalTeX\n";
    @_[0];
}
1;				# Not really necessary...
