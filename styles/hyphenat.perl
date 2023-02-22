# hyphenat.perl
#
# LaTeX2HTML implementation of LaTeX package hyphenat
#
# February 22, 2023 

package main;

# In the latex package, these commands allow hyphenation within the
# words on either side of the dot, colon, slash and hyphen.  This
# LaTeX2HTML package doesn't do anything to make hyphenation happen
# within words in HTML, but it does allow the dot, colon slash or
# hyphen in the text to come through.

# There are still some commands from hyphenat.sty that are not
# implemented here.

# period
sub do_cmd_dothyp {
    '.'.@_[0];
}

# colon
sub do_cmd_colonhyp {
    ':'.@_[0];
}

# forward slash
sub do_cmd_fshyp {
    '/'.@_[0];
}

# backslash
sub do_cmd_bshyp {
    '&#92;'.@_[0];
}

# just a hyphen - html can break line after hyphen
sub do_cmd_hyp {
    '-'.@_[0];
}

1;	# must be last line
