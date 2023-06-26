#!/usr/bin/perl

# this file is loaded if a file contains
# \usepackage{hyperref}

# allows latex2html to process files containing
# the \href command defined by hyperref.sty
# and therefore allows latex2html to process files
# written for hyperref.sty without modifying them for latex2html

# WARNING: html.sty / html.perl also declares its own instance of \hyperref
# with an incompatible interface. Additionally declared is \hyperrefhyper
# whose interface is like that of \hyperref from hyperref.sty.
#
# If both hyperref.sty and html.sty are necessary,
# and \hyperref from hyperref.sty is needed, the following workaround may do:
#
# \usepackage{hyperref}
# \usepackage{html}
# \renewcommand{\hyperref}[2][]{\hyperrefhyper[#1]{#2}}

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

sub do_cmd_hyperref {
    local($_) = @_;
    local($opt, $dummy) = &get_next_optional_argument;
    if ($opt ne '') {
        return (&process_hyperref($cross_ref_mark,$opt));
    }
    local($url, $anchor, $name, $text);
    $url = &missing_braces unless (
	(s/$next_pair_pr_rx/$url = $2;''/eo)
	||(s/$next_pair_rx/$url = $2;''/eo));
    $anchor = &missing_braces unless (
	(s/$next_pair_pr_rx/$anchor=$2;''/eo)
	||(s/$next_pair_rx/$anchor=$2;''/eo));
    $name = &missing_braces unless (
	(s/$next_pair_pr_rx/$name=$2;''/eo)
	||(s/$next_pair_rx/$name=$2;''/eo));
    $text = &missing_braces unless (
	(s/$next_pair_pr_rx/$text=$2;''/eo)
	||(s/$next_pair_rx/$text=$2;''/eo));
    $anchor = $anchor . '.' . $name   if $name   ne '';
    $url    = $url    . '#' . $anchor if $anchor ne '';
    # and recode the ~ (don't turn it to space)
    $url =~ s/~/&#126;/go;
    "<a href=\"$url\">$text</a>".$_;
}

sub process_hyperref {
    local($ref_mark, $label) = @_;
    local($id, $text);
    $text = &missing_braces unless
	((s/$next_pair_pr_rx/($id, $text) = ($1, $2); ''/eo)
	||(s/$next_pair_rx/($id, $text) = ($1, $2); ''/eo));
    $label =~ s/<[^>]*>//go ; #RRM: Remove any HTML tags
    $label =~ s/$label_rx/_/g;	# replace non alphanumeric characters

    print "\nLINK: $ref_mark\#$label\#$id  :$text:" if ($VERBOSITY > 3);

    # The quotes around the HREF are inserted later
    join('',"<A HREF=$ref_mark#$label#$id>$text<\/A>", $_);
}

1;
