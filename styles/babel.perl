# $Id: babel.perl,v 1.12 2001/04/18 01:39:21 RRM Exp $
#
# babel.perl
#
# written by Marek Rouchal <marek@saftsack.fs.uni-bayreuth.de>
# Last modification: Sun Oct 27 20:34:56 MET 1996
#
# extended for more languages by Ross Moore <ross@mpce.mq.edu.au>
# 20 August 1998
#
# $Log: 

package main;

# for debugging only
# print "Using babel.perl\n";

sub load_babel_file {
    local($lang) = @_;
    local($dir) = '';
    local($orig_cwd) = ($orig_cwd ? $orig_cwd : '.');
    if (-f "$orig_cwd$dd$lang.perl") {
	if (require("$orig_cwd$dd$lang.perl")) {
	    print "\nLoading $orig_cwd$dd$lang.perl";
	    return;
	}
    }
    foreach $dir (split(/$envkey/,$LATEX2HTMLSTYLES)) {
	if (-f "$dir$dd$lang.perl") {
	    if (require("$dir$dd$lang.perl")) {
		print "\nLoading $dir$dd$lang.perl";
		return;
	    };
	}
    } 
    &no_lang_support($lang);
}

sub no_lang_support {
    $nolang = @_;
    print "\n *** No support available for $nolang language \n";
    &write_warnings("No support found for $nolang language");
}

sub do_cmd_selectlanguage {
    local($_) = @_;
    local($lang);
    $lang = &missing_braces unless(
    	(s/$next_pair_pr_rx/$lang=$2;''/eo)
    	||(s/$next_pair_rx/$lang=$2;''/eo));

    local($trans) = "${lang}_translation";
    local($titles) = "${lang}_titles";
    local($encoding) = "${lang}_encoding";
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
	} else {
	    &set_default_language($lang,$_);
	    $latex_body .= "\n\n\\selectlanguage{$lang}\n\n";
    	}
    } else { &no_lang_support($lang) }
    $_;
}

sub do_cmd_iflanguage {
    local($_) = @_;
    local($lang, $iflang, $nolang);    
    $lang = &missing_braces unless(
    	(s/$next_pair_pr_rx/$lang=$2;''/eo)
    	||(s/$next_pair_rx/$lang=$2;''/eo));

    $iflang = &missing_braces unless(
    	(s/$next_pair_pr_rx/$iflang=$2;''/eo)
    	||(s/$next_pair_rx/$iflang=$2;''/eo));

    $nolang = &missing_braces unless(
    	(s/$next_pair_pr_rx/$nolang=$2;''/eo)
    	||(s/$next_pair_rx/$nolang=$2;''/eo));

    local($trans) = "${lang}_translation";
    local($lang_out) = ((defined &$trans) ? $iflang : $nolang);
    $lang_out = &translate_environments($lang_out);
    $lang_out = &translate_commands($lang_out) if ($lang_out =~ /\\/);
    join('',  $lang_out, $_);   
}    	

# implement usable options from LaTeX

sub do_babel_afrikaan { &load_babel_file("afrikaan") }
sub do_babel_afrikaans { &load_babel_file("afrikaan") }
sub do_babel_american { &load_babel_file("american") }
sub do_babel_austrian { &load_babel_file("austrian") }
sub do_babel_bahasa { &load_babel_file("bahasa") }
sub do_babel_brazil { &load_babel_file("brazil") }
sub do_babel_brazilian { &load_babel_file("brazil") }
sub do_babel_breton { &load_babel_file("breton") }
sub do_babel_catalan { &load_babel_file("catalan") }
sub do_babel_croatian { &load_babel_file("croatian") }
sub do_babel_czech { &load_babel_file("czech") }
sub do_babel_danish { &load_babel_file("danish") }
sub do_babel_dutch { &load_babel_file("dutch") }
sub do_babel_english { &load_babel_file("english") }
sub do_babel_esperant { &load_babel_file("esperant") }
sub do_babel_esperanto { &load_babel_file("esperant") }
sub do_babel_estonian { &load_babel_file("estonian") }
sub do_babel_finnish { &load_babel_file("finnish") }
sub do_babel_francais { &load_babel_file("french") }
sub do_babel_french { &load_babel_file("french") }
sub do_babel_german { &load_babel_file("german") }
sub do_babel_germanb { &load_babel_file("german") }
sub do_babel_galician { &load_babel_file("galician") }
sub do_babel_greek { &load_babel_file("greek") }
sub do_babel_hungarian { &load_babel_file("magyar") }
sub do_babel_irish { &load_babel_file("irish") }
sub do_babel_italian { &load_babel_file("italian") }
sub do_babel_lsorbian { &load_babel_file("lsorbian") }
sub do_babel_magyar { &load_babel_file("magyar") }
sub do_babel_norsk { &load_babel_file("norsk") }
sub do_babel_nynorsk { &load_babel_file("nynorsk") }
sub do_babel_polish { &load_babel_file("polish") }
sub do_babel_portuges { &load_babel_file("portuges") }
sub do_babel_portuguese { &load_babel_file("portuges") }
sub do_babel_romanian { &load_babel_file("romanian") }
sub do_babel_russian { &load_babel_file("russian") }
sub do_babel_russianb { &load_babel_file("russian") }
sub do_babel_scottish { &load_babel_file("scottish") }
sub do_babel_slovak { &load_babel_file("slovak") }
sub do_babel_slovene { &load_babel_file("slovene") }
sub do_babel_spanish { &load_babel_file("spanish") }
sub do_babel_swedish { &load_babel_file("swedish") }
sub do_babel_turkish { &load_babel_file("turkish") }
sub do_babel_usorbian { &load_babel_file("usorbian") }
sub do_babel_welsh { &load_babel_file("welsh") }


&do_require_extension('lang');

%iso_languages = ( %iso_languages
	, 'original'	, 'en'
	, 'afrikaan'	, 'af'
	, 'american'	, 'en-US'
	, 'austrian'	, 'de-AT'
	, 'brazil'	, 'pt'
	, 'esperant'	, 'eo'
	, 'francais'	, 'fr'
	, 'lsorbian'	, 'sr'	
	, 'magyar'	, 'hu'
	, 'nynorsk'	, 'no'
	, 'portuges'	, 'pt'
	, 'scottish'	, 'gd'
	, 'slovene'	, 'sl'	
	, 'usorbian'	, 'sr'	
	);

# cancel redundant options from LaTeX

# none so far

&process_commands_wrap_deferred (<<_DEFERRED_CMDS_);
#selectlanguage # {}
iflanguage # {} # {} # {}
_DEFERRED_CMDS_


1;	# Must be last line
