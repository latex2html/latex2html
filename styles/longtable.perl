# -*- perl -*-
# longtable.perl by Denis Koelewijn
#
# Extension to LaTeX2HTML supply support for the "longtable"
# LaTeX style, as described in "The LaTeX Companion," by
# Goossens, Mittelbach and Samarin (ISBN 0-201-54199-8). 
#
# Change Log:
# ===========
# MRO: added changes proposed by Keith Refson

package main;
#
#  Translate the longtable environment as
#  an ordinary table.

sub do_env_longtable {
    local($_) = @_;
    my $cols;
    $cols = &missing_braces unless (
	(s/$next_pair_pr_rx/$cols=$&;''/eo)
	||(s/$next_pair_rx/$cols=$&;''/eo));

    local($cap_env,$captions) = ('table', $captions);
    if (/\\caption\s*(\*?)/) {
	my $star = $1;
	do { local($contents) = $_;
	    &extract_captions($cap_env);
	    $_ = $contents; undef $contents;
	    # remove the artificial prefix, if it's a  \caption*
	    $captions =~ s!^<(STRONG>).*?</\1\s*!!s if ($star);
	}
    };
    my ($this, $head, $foot, $which);
    local($border);
    while (/\\end(((first)?head)|(last)?foot)\b/s ) {
	if ($3) { $head = $`}
	elsif ($2) { $head = $` unless ($head) }
	elsif ($4) { $foot = $` }
	else { $foot = $` unless ($foot) }
	$_ = $'; $this = $`;
	if ($this =~ /(\\[hv]line)\b/) { $border = $1 }
    }
    if ($head) { $head =~ s/\\\\\s*$//s; $head .= '\\\\'."\n"; }
    if ($foot) { $_ =~ s/\\\\\s*$//s; $_ .= '\\\\'."\n"; }
    # Keith Refson: replace \\tabularnewline
    s/\\tabularnewline/\\\\/gs;
    &do_env_tabular("$cols$head$_$foot")
}

&ignore_commands( <<_IGNORED_CMDS_);
LTleft
LTright
LTpre
LTpost
LTcapwidth
LTchunksize
setlongtables
_IGNORED_CMDS_

1;

