
package main;

sub do_cmd_multirow {
    local($_) = @_;
    local($dmy1,$dmy2,$dmy3,$dmy4,$spanrows,$pxs,$rwidth,$text);
    $spanrows = &missing_braces unless (
	(s/$next_pair_pr_rx/$spanrows=$2;''/eo)
        ||(s/$next_pair_rx/$spanrows=$2;''/eo));
    my $rowspan = 0+$spanrows;
    # set the counter for this column to the number of rows covered
    @row_spec[$i] = $rowspan;

    $colspec =~ /^<([A-Z]+)/;
    local($celltag) = $1;

    # read the width, save it for later use (the last regex matches '*')
    $rwidth = &missing_braces unless (
	(s/$next_pair_pr_rx/$rwidth=$2;''/eo)
	||(s/$next_pair_rx/$rwidth=$2;''/eo)
	||(s/^[\s%]*(\*)($comment_mark\d*\n?)?/$rwidth=$1;''/eo));

    if ($rwidth eq '*') {
        # automatic width
	$colspec =~ s/>$content_mark/ ROWSPAN=$rowspan$&/;
    } else {
        # catch cases where the \textwidth has been discarded
        $rwidth =~s!^(\w)($OP\d+$CP)\s*(\d|\d*\.\d+)\2$!$1\{$3\\textwidth\}!;
	($pxs,$rwidth) = &convert_length($rwidth);
	$colspec =~ s/>$content_mark/ ROWSPAN=$rowspan WIDTH=$pxs$&/;
    }

    if ($HTML_VERSION < 4.0) {
        s/$next_pair_pr_rx/$text=$2;''/eo;
    } else {
        $text = &styled_text_chunk('SPAN','mrow','','','','', $_);
    }
    $text = &translate_commands($text) if ($text =~ /\\/);
    $text;
}

1;                              # This must be the last line
