# $Id: polyglossia.perl,v 1.12 2001/04/18 01:39:21 RRM Exp $
#
# polyglossia.perl by Georgy Salnikov <sge@nmr.nioch.nsc.ru>  18/05/05
#
# Extension to LaTeX2HTML V2018 to support the "polyglossia" package
# for lualatex support.
#
# Partly adapted from babel.perl
#
# $Log:  $

package main;

# for debugging only
# print "\nUsing polyglossia.perl\n";

# The necessary language switching environment \begin{<lang>} - \end{<lang>}
# is generated automatically while loading language definitions file.
# The short language switching command \text<lang>{} is also generated.
# But for it to really work, at the end of this file it must be added
# into the list &process_commands_wrap_deferred (<<_RAW_ARG_DEFERRED_CMDS_);
# Additionally, for polyglossia the language definition file must be adapted
# to use UTF-8 encoding, and &do_cmd_<lang>TeX must be defined in it.

# Reusing babel loaders

sub load_babel_package {
  local($dir) = '';
  local($orig_cwd) = ($orig_cwd ? $orig_cwd : '.');
  if (-f "$orig_cwd${dd}babel.perl") {
    if (require("$orig_cwd${dd}babel.perl")) {
      print "\nLoading $orig_cwd${dd}babel.perl";
      return;
    }
  }
  foreach $dir (split(/$envkey/,$LATEX2HTMLSTYLES)) {
    if (-f "$dir${dd}babel.perl") {
      if (require("$dir${dd}babel.perl")) {
	print "\nLoading $dir${dd}babel.perl";
	return;
      }
    }
  } 
}

sub load_luainputenc_package {
  local($dir) = '';
  local($orig_cwd) = ($orig_cwd ? $orig_cwd : '.');
  if (-f "$orig_cwd${dd}luainputenc.perl") {
    if (require("$orig_cwd${dd}luainputenc.perl")) {
      print "\nLoading $orig_cwd${dd}luainputenc.perl";
      return;
    }
  }
  foreach $dir (split(/$envkey/,$LATEX2HTMLSTYLES)) {
    if (-f "$dir${dd}luainputenc.perl") {
      if (require("$dir${dd}luainputenc.perl")) {
	print "\nLoading $dir${dd}luainputenc.perl";
	return;
      }
    }
  } 
}

# Primary language definition - enhanced babel's do_cmd_selectlanguage

sub do_cmd_setdefaultlanguage {
  local($_) = @_;
  #print ("\n$_\n");
  local($dum, $lang);
  ($dum,$lang) = &get_next_optional_argument; # discard optional argument
  $lang = &missing_braces unless(
    (s/$next_pair_pr_rx/$lang=$2;''/eo)
    ||(s/$next_pair_rx/$lang=$2;''/eo));

  local($trans) = "${lang}_translation";
  local($titles) = "${lang}_titles";
  local($encoding) = "${lang}_encoding";

  # load the corresponding language file
  print ("\nPolyglossia primary language:");
  &load_babel_file($lang);

  if (defined &$trans) {
    if ($PREAMBLE) {
      # ensure the list of languages is up-to-date
      &make_language_rx;
      $TITLES_LANGUAGE = $lang;
      $default_language = $lang;
      $CHARSET = $$encoding if ($$encoding);
      if (defined &$titles) {
	eval "&$titles()";
	&translate_titles;
      }
      local($lcode) = $iso_languages{$lang};
      &add_to_body('LANG',$lcode) unless ($HTML_VERSION < 4);

      # generate language switching commands
      local($code) = 'sub do_cmd_text'.$lang.'{'             . "\n"
	. 'local($_) = @_;'                                  . "\n"
	. 'local($dum1,$dum2);'                              . "\n"
	. '($dum1,$dum2) = &get_next_optional_argument;'     . "\n"
	. 'local($text,$br_id)=("","0");'                    . "\n"
	. '$text = &missing_braces unless('                  . "\n"
	. '  (s/$next_pair_pr_rx/$text=$2;$br_id=$1;""/eo)'  . "\n"
	. '  ||(s/$next_pair_rx/$text=$2;$br_id=$1;""/eo));' . "\n"
	. 'join("",&translate_commands('                     . "\n"
	. '&translate_environments("$O$br_id$C\\\\'.$lang.'TeX $text$O$br_id$C")),' . "\n"
	. '$_);'                                             . "\n"
	. '}'                                                . "\n"
	. 'sub do_env_'.$lang.'{'                            . "\n"
	. 'local($_) = @_;'                                  . "\n"
	. 'local($dum1,$dum2);'                              . "\n"
	. '($dum1,$dum2) = &get_next_optional_argument;'     . "\n"
	. 'local($br_id) = ++$global{"max_id"};'             . "\n"
	. '$_ = &translate_environments("$O$br_id$C\\\\'.$lang.'TeX $_$O$br_id$C");' . "\n"
	. '$_ = &translate_commands($_);'                    . "\n"
	. '$_;'                                              . "\n"
	. '}'                                                . "\n";
      #print "\n$code\n";
      eval $code;
    }
  } else { &no_lang_support($lang) }
  $_;
}

# Just synonyms of do_cmd_setdefaultlanguage

sub do_cmd_setmainlanguage {
  &do_cmd_setdefaultlanguage($_[0]);
}

sub do_cmd_resetdefaultlanguage {
  &do_cmd_setdefaultlanguage($_[0]);
}

# Secondary language definitions - must not alter primary language ones

sub do_cmd_setotherlanguage {
  local($_) = @_;
  #print ("\n$_\n");
  local($dum, $lang);
  ($dum,$lang) = &get_next_optional_argument; # discard optional argument
  $lang = &missing_braces unless(
    (s/$next_pair_pr_rx/$lang=$2;''/eo)
    ||(s/$next_pair_rx/$lang=$2;''/eo));

  local($trans) = "${lang}_translation";
  local($titles) = "${lang}_titles";
  local($encoding) = "${lang}_encoding";
  local($save_tit_lang, $save_def_lang, $save_charset) = ('', '', '');

  # save primary language definitions
  if ($PREAMBLE) {
    $save_tit_lang = $TITLES_LANGUAGE  if defined $TITLES_LANGUAGE;
    $save_def_lang = $default_language if defined $default_language;
    $save_charset  = $CHARSET          if defined $CHARSET;
  }

  # load the corresponding language file
  print ("\nPolyglossia secondary language:");
  &load_babel_file($lang);

  # update secondary language definitions
  if (defined &$trans) {
    if ($PREAMBLE) {
      &make_language_rx;
      $TITLES_LANGUAGE = $lang;
      $default_language = $lang;
      $CHARSET = $$encoding if ($$encoding);
      if (defined &$titles) {
	eval "&$titles()";
	&translate_titles;
      }

      # generate language switching commands
      local($code) = 'sub do_cmd_text'.$lang.'{'             . "\n"
	. 'local($_) = @_;'                                  . "\n"
	. 'local($dum1,$dum2);'                              . "\n"
	. '($dum1,$dum2) = &get_next_optional_argument;'     . "\n"
	. 'local($text,$br_id)=("","0");'                    . "\n"
	. '$text = &missing_braces unless('                  . "\n"
	. '  (s/$next_pair_pr_rx/$text=$2;$br_id=$1;""/eo)'  . "\n"
	. '  ||(s/$next_pair_rx/$text=$2;$br_id=$1;""/eo));' . "\n"
	. 'join("",&translate_commands('                     . "\n"
	. '&translate_environments("$O$br_id$C\\\\'.$lang.'TeX $text$O$br_id$C")),' . "\n"
	. '$_);'                                             . "\n"
	. '}'                                                . "\n"
	. 'sub do_env_'.$lang.'{'                            . "\n"
	. 'local($_) = @_;'                                  . "\n"
	. 'local($dum1,$dum2);'                              . "\n"
	. '($dum1,$dum2) = &get_next_optional_argument;'     . "\n"
	. 'local($br_id) = ++$global{"max_id"};'             . "\n"
	. '$_ = &translate_environments("$O$br_id$C\\\\'.$lang.'TeX $_$O$br_id$C");' . "\n"
	. '$_ = &translate_commands($_);'                    . "\n"
	. '$_;'                                              . "\n"
	. '}'                                                . "\n";
      #print "\n$code\n";
      eval $code;

      # revert back to primary language
      $CHARSET = $save_charset if $save_charset  ne '';
      if ($save_tit_lang ne '' || $save_def_lang ne '') {
	$lang = $save_tit_lang || $save_def_lang;
	$TITLES_LANGUAGE = $lang;
	$default_language = $lang;
	$trans = "${lang}_translation";
	$titles = "${lang}_titles";
	&make_language_rx if defined &$trans;
	if (defined &$titles) {
	  eval "&$titles()";
	  &translate_titles;
	}
      }
    }
  } else { &no_lang_support($lang) }
  $_;
}

# Just serialized do_cmd_setotherlanguage

sub do_cmd_setotherlanguages {
  local($_) = @_;
  #print ("\n$_\n");
  local(@langs, $lang, $br_id);
  $lang = &missing_braces unless(
    (s/$next_pair_pr_rx/$lang=$2;''/eo)
    ||(s/$next_pair_rx/$lang=$2;''/eo));
  @langs = split /,/, $lang;
  foreach $lang (@langs) {
    $br_id = ++$global{'max_id'};
    &do_cmd_setotherlanguage("$O$br_id$C$lang$O$br_id$C");
  }
  $_;
}

# Ensure loading the necessary packages and signal presence to the main script

&load_luainputenc_package();
&load_babel_package();

&process_commands_wrap_deferred (<<_RAW_ARG_DEFERRED_CMDS_);
textenglish # [] # {}
textgerman # [] # {}
textrussian # [] # {}
_RAW_ARG_DEFERRED_CMDS_

$POLYGLOSSIA = 1;

1;	# Must be last line
