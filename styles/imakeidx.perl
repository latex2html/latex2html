# imakeidx.perl
# implements \usepackage{imakeidx}
#
# the only feature of imakeidx that is supported
# is the sorting accented characters in the index
# for latex documents that say
#   \usepackage[xindy]{imakeidx}
#

# inherits functionality of \usepackage{makeidx}
do_require_package('makeidx');

use Unicode::Collate::Locale;

$Collator = Unicode::Collate::Locale->new;

# return value as with perl cmp function
# unescapes &#XXX; before comparing the two strings
sub compare_escaped_unicode_strings {
    local($x, $y) = ($a,$b);
    # construct a perl unicode string by replacing escaped character codes
    $x =~ s/\&\#(\d+);/chr($1)/eg;
    $y =~ s/\&\#(\d+);/chr($1)/eg;
    $Collator->cmp($x, $y);
}

# implements
# \usepackage[xindy]{imakeidx}
# this replaces the sort function used in makeidx.perl 
sub do_imakeidx_xindy {
    $makeidx_keysort= \&compare_escaped_unicode_strings;
}

1;
