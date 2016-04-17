#
# $Id: lyx.perl,v 1.1 1999/06/10 23:57:12 RRM Exp $
# lyx.perl
#   Ross Moore <ross@maths.mq.edu.au> 10-JUN-99
#
# Extension to LaTeX2HTML to support macros used by lyx .
#
# Change Log:
# ===========
#
# $Log: lyx.perl,v $
# Revision 1.1  1999/06/10 23:57:12  RRM
# 	New file, to support Lyx idiosyncracies
#
#  --  defines \url to understand \url{....} or \url[...]{...}
#  	else \url parses like \verb, so recognises  \url|....|
#

package main;

sub do_lyx_url {
    local($_) = @_;
    my ($delim, $url);
    if (s/^\s*(\S)/$delim=$1;''/es) {
	if ($delim =~ /[\{\[]/) { &do_cmd_htmlurl(@_) }
	else {
	    s/^.+?\Q$delim\E/$url=$`;''/es;
	    join('','<TT>', &make_href($url,$url), '</TT>', $_);	    
	}
    } else { &do_cmd_htmlurl(@_) }
}


# override the default \url to catch lyx syntax

sub do_cmd_url { &do_lyx_url(@_) }

1; 		# Must be last line
