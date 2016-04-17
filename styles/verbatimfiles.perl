#
# $Id: verbatimfiles.perl,v 1.6 1999/04/09 18:16:51 JCL Exp $
# verbatimfiles.perl
#   Jens Lippmann <lippmann@rbg.informatik.tu-darmstadt.de> 6-FEB-96
#
# Extension to LaTeX2HTML to support verbatim.sty/verbatimfiles.sty.
#
# Change Log:
# ===========
#  jcl = Jens Lippmann
#
# $Log: verbatimfiles.perl,v $
# Revision 1.6  1999/04/09 18:16:51  JCL
# changed my e-Mail address
#
# Revision 1.5  1998/12/02 01:22:53  RRM
#  --  wrap the \verbatimfile  and  \verbatimlisting  commands
#
# Revision 1.4  1998/03/22 20:52:50  latex2html
# reviewed for 98.1, works & is testable via devel/tests/regr/verbatim/run
#
# Revision 1.3  1998/02/19 22:24:34  latex2html
# th-darmstadt -> tu-darmstadt
#
# Revision 1.2  1996/12/23 01:36:50  JCL
# o added some informative comments and log history
# o uses now shell variable TEXINPUTS (set up before by LaTeX2HTML)
#   to locate input files
# o verbatimlisting is now numbered according to the LaTeX output I
#   got here: empty lines also numbered, but not the first if empty.
#
# Revision 1.1 1996/12/18 04:31:29  JCL
# was formerly verbatim.perl, now renamed to this file
#
# JCL -- 6-FEB-96 -- created
#
#
# Note:
# This module provides translation for the \verbatimfile and
# \verbatimlisting commands of the verbatimfiles.sty package.
#
# The naming of verbatim.sty is a bit blurred.
# Here are the versions which are available, together with their
# identification:
#  o dbtex verbatim.sty by Rowley/Clark
#    Provides:
#    - \verbatimfile, \verbatimlisting
#    It is also named verbatimfiles.sty, and supported by
#    this Perl module.
# 
#  o verbatim.sty 1.4a (jtex), 1.4d (ogfuda), 1.4i (AMS LaTeX),
#    1.5i (LaTeX2e) by Sch"opf
#    Provides:
#    - verbatim environment, comment environment, \verbatiminput
#    Supported by verbatim.perl.
# 
#  o FWEB verbatim.sty
#    Provides:
#    - verbatim environment, \verbfile, \listing, \sublisting
#    Currently not supported by LaTeX2HTML.


package main;

&do_require_package("verbatim");

sub do_cmd_verbatimfile {
    &do_cmd_verbatiminput;
}

sub do_cmd_verbatimlisting {
    local($_,$outer);
    local($counter) = 0;

    # Read in file, get markup ready.
    $outer = &do_cmd_verbatiminput;

    # Postprocess verbatim content.
    $_ = $verbatim{$global{'verbatim_counter'}};

    #insert numbers for every line
    #but not the first line if it's empty (LaTeX'ism?)
    local($firstemptyline);
    $firstemptyline = $1 if s/^([ \t]+\n)//;

    #and not the last end of line
    s/\n$//;
    s/(^|\n)/$1.sprintf("%4d ",++$counter)/ge;

    #add the stuff from the first(if empty) and last line also
    $verbatim{$global{'verbatim_counter'}} = $first.$_;
    $outer;
}

&process_commands_wrap_deferred (<<_RAW_ARG_DEFERRED_CMDS_);
verbatimfile # {}
verbatimlisting # {}
_RAW_ARG_DEFERRED_CMDS_

1; 		# Must be last line
