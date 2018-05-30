
package main;

sub do_cmd_multirow {
    local($_) = @_;
    local($dmy1,$dmy2,$dmy3,$dmy4,$spanrows,$pxs,$rwidth,$valign,$vspec,$text);
    $spanrows = &missing_braces unless (
	(s/$next_pair_pr_rx/$spanrows=$2;''/eo)
        ||(s/$next_pair_rx/$spanrows=$2;''/eo));
    my $rowspan = 0+$spanrows;
    # set the counter for this column to the number of rows covered
    @row_spec[$i] = $rowspan;

    $colspec =~ /^<([A-Z]+)/;
    local($celltag) = $1;

    # read the width, but ignore it
    $rwidth = &missing_braces unless (
	(s/$next_pair_pr_rx/$rwidth=$2;''/eo)
	||(s/$next_pair_rx/$rwidth=$2;''/eo));

    # catch cases where the \textwidth has been discarded
    $rwidth =~s!^(\w)($OP\d+$CP)\s*(\d|\d*\.\d+)\2$!$1\{$3\\textwidth\}!;

    ($pxs,$rwidth) = &convert_length($rwidth);

    # There was an extra argument for vertical alignment - not compatible with latex \multirow 
    #$valign = &missing_braces unless (
    #    (s/$next_pair_pr_rx/$valign=$2;''/eo)
    #    ||(s/$next_pair_rx/$valign=$2;''/eo));
    $vspec = ' VALIGN="TOP"' if $valign;
    if ($valign =~ /m/i) { $vspec =~ s/TOP/MIDDLE/ }
    elsif ($valign =~ /b/i) { $vspec =~ s/TOP/BOTTOM/ }

    $colspec =~ s/VALIGN="\w+"// if $vspec; # avoid duplicate tags
    $colspec =~ s/>$content_mark/$vspec ROWSPAN=$rowspan WIDTH=$pxs$&/;

    $text = &styled_text_chunk('SPAN','mrow','','','','', $_);
    $text = &translate_commands($text) if ($text =~ /\\/);
    $text;
}

1;                              # This must be the last line
