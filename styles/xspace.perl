#
# $Id: xspace.perl,v 1.3 1999/04/09 18:17:41 JCL Exp $
# xspace.perl
#   Jens Lippmann <lippmann@rbg.informatik.tu-darmstadt.de> 26-JAN-97
#
# Extension to LaTeX2HTML to support xspace.sty.
#
# Change Log:
# ===========
#  jcl = Jens Lippmann
#
# $Log: xspace.perl,v $
# Revision 1.3  1999/04/09 18:17:41  JCL
# changed my e-Mail address
#
# Revision 1.2  1998/02/19 22:24:35  latex2html
# th-darmstadt -> tu-darmstadt
#
# Revision 1.1  1997/01/27 19:40:44  JCL
# initial revision
#
#
# JCL -- 26-JAN-97 -- created
#


package main;

sub do_cmd_xspace {
    local($_) = @_;
    local($space) = " ";
    # the list is taken from xspace.sty 1.04
    $space = "" if /^([{}~.!,:;?\/'\)-]|\\\/|\\ )/;
    $space.$_;
}

1; 		# Must be last line
