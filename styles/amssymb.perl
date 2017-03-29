# amssymb.perl
#
# Extension to LaTeX2HTML to suppress messages when AMS-fonts
# are loaded, via packages:
#   amsfonts, amssymb, eucal, eufrak or euscript. 
#
# Change Log:
# ===========

package main;

&do_require_package('amsfonts');

1;                              # This must be the last line
