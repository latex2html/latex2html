#!/usr/bin/perl

# this file is loaded if a file contains
# \usepackage{hyperref}

# allows latex2html to process files containing
# the \href command defined by hyperref.sty
# and therefore allows latex2html to process files
# written for hyperref.sty without modifying them for latex2html

package main;

# Suppress option warning messages:

sub do_hyperref_colorlinks {}
sub do_hyperref_backref {}
sub do_hyperref_pagebackref {}
sub do_hyperref_pdfstartview_FitH {}
sub do_hyperref_breaklinks {}

sub do_cmd_href {
    local($_) = @_;
    local($url, $anchor);
    $url = &missing_braces unless (
	(s/$next_pair_pr_rx/$url = $2;''/eo)
	||(s/$next_pair_rx/$url = $2;''/eo));
    $anchor = &missing_braces unless (
	(s/$next_pair_pr_rx/$anchor=$2;''/eo)
	||(s/$next_pair_rx/$anchor=$2;''/eo));
    # and recode the ~ (don't turn it to space)
    $url =~ s/~/&#126;/go;
    "<a href=\"$url\">$anchor</a>".$_;
}

1;
