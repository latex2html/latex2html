### File: html2.2.pl
### Language definitions for HTML 2.2 (Tables)
### Written by Marcus E. Hennecke <marcush@leland.stanford.edu>
### Version 0.4,  February 2, 1996

## Revisions:
##	TKM  Tom Miller <tkm@eos.ncsu.edu>

## Copyright (C) 1995 by Marcus E. Hennecke
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

if ($HTML_OPTIONS =~ /table/) {
    $DOCTYPE = '';
    $STRICT_HTML = 0;
}

### The following routines do tables

$content_mark = "<cellcontents>";

## Since the do_env_tabular subroutine does all the work, there is
## nothing left to do.
#sub do_env_table {
#    local($_) = @_;
#    &get_next_optional_argument;
#    $_ = &translate_commands(&translate_environments($_));
#    $_;
#}

#sub do_env_tablestar {
#    local($_) = @_;
#    &get_next_optional_argument;
#    $_ = &translate_commands(&translate_environments($_));
#    $_;
#}

### Define the multicolumn command
# Modifies the $colspec and $colspan variables of the tabular subroutine
sub do_cmd_multicolumn {
    local($_) = @_;
    local($dmy1,$dmy2,$dmy3,$dmy4);
    s/$next_pair_pr_rx//o;
    $colspan = 0+$2;
    $colspec =~ /^<([A-Z]+)/;
    local($celltag) = $1;
    s/$next_pair_pr_rx//o;
    ($dmy1,$dmy2,$dmy3,$dmy4,$colspec) = &translate_colspec($2, $celltag);
    s/$next_pair_pr_rx//o;
    $2;
}

# Since hlines are taken care of in the tabular environment, they
# don't need to do anything. Ideally, this routine should never be
# called anyway. clines are not yet supported.
sub do_cmd_hline {
    $_[$[];
}
sub do_cmd_cline {
    $_[$[] =~ s/$next_pair_pr_rx//o;
    $_[$[];
}

# Attempts to convert latex lengths into some HTML equivalent. This
# can only be an attempt until browsers start implementing units.
# The returned values are: The length according to Netscape (in pixels
# or percent) and the length according to HTML 3.0.

sub convert_length_table {
    local($_) = @_;
    local(%scale) = ("in",72,"pt",72.27/72,"pc",12,"mm",72/25.4,"cm",72/2.54,"\\hsize",100);
    local(%units) = ("in","in","pt","pt","pc","pi","mm","mm","cm","cm","\\hsize","%");
    local($pxs,$len);
    if ( /([0-9.]+)(in|pt|pc|mm|cm|\\hsize)/ ) {
	$pxs = int($1 * $scale{$2} + 0.5);
	$len = $1 . $units{$2};
	if ( $2 eq "\\hsize" ) {
	    $pxs .= '\%';
	};
    };
    ($pxs,$len);
}
# should no longer be needed, as this is defined in latex2html.pin
if (undefined &convert_length) { sub convert_length {&convert_length_table(@_)} }

# Translates LaTeX column specifications to HTML. Again, Netscape
# needs some extra work with its width attributes in the <td> tags.
sub translate_colspec {
    local($colspec,$celltag) = @_;
    local($cellopen) = "<$celltag VALIGN=BASELINE ALIGN";
    local($cellclose) = "</$celltag>";
    local($htmlcolspec,$len,$pts,@colspec,$char,$cols,$repeat);
    local($frames,$rules,$prefix);

    $frames  = "l" if ( $colspec =~ s/^\|+// );
    $frames .= "r" if ( $colspec =~ s/\|+$// );
    $rules = "c" if ( $colspec =~ /\|/ );

    $htmlcolspec = "<COLGROUP>" if ( $rules );

    $cols = 0;
    while ( length($colspec) > 0 ) {
	$char = substr($colspec,0,1);
	$colspec = substr($colspec,1);
	if ( $char eq "c" ) {
	    $htmlcolspec .= "<COL ALIGN=CENTER>";
	    push(@colspec,"$cellopen=CENTER NOWRAP>$content_mark$cellclose");
	    $cols++;
	} elsif ( $char eq "l" ) {
	    $htmlcolspec .= "<COL ALIGN=LEFT>";
	    push(@colspec,"$cellopen=LEFT NOWRAP>$content_mark$cellclose");
	    $cols++;
	} elsif ( $char eq "r" ) {
	    $htmlcolspec .= "<COL ALIGN=RIGHT>";
	    push(@colspec,"$cellopen=RIGHT NOWRAP>$content_mark$cellclose");
	    $cols++;
	} elsif ( $char eq "p" ) {
	    $colspec =~ s/$next_pair_rx//;
	    ($pts,$len) = &convert_length($2);
	    if ( $pts ) {
		$width = " WIDTH=\"$pts\"";
		$htmlcolspec .= "<COL ALIGN=JUSTIFY WIDTH=\"$len\">";
	    } else {
		$width = "";
		$htmlcolspec .= "<COL ALIGN=JUSTIFY>";
	    };
	    push(@colspec,"$cellopen=LEFT$width>$content_mark$cellclose");
	    $cols++;
	} elsif ( $char eq "|" ) {
	    $htmlcolspec .= "<COLGROUP>";
	} elsif ( $char eq "@" ) {
	    $htmlcolspec .= "<COL ALIGN=CENTER>";
	    $colspec =~ s/$next_pair_rx//;
	    $cols++;
	    if ( $#colspec < 0 ) {
		$prefix .= "$cellopen=CENTER NOWRAP>" .
		    &translate_commands($2) . $cellclose;
	    } else {
		$colspec[$#colspec] .= "$cellopen=CENTER NOWRAP>" .
		    &translate_commands($2) . $cellclose;
	    }
	} elsif ( $char eq "*" ) {
	    $colspec =~ s/$next_pair_rx//;
	    $repeat = $2;
	    $colspec =~ s/$next_pair_rx//;
	    $colspec = "$2"x$repeat . $colspec;
	};
    };

    $colspec[0] = $prefix . $colspec[0];
    ($htmlcolspec,$frames,$rules,$cols,@colspec);
}

%frameoptions = ( "l", "LHS", "r", "RHS", "lr", "VSIDES",
		  "t", "ABOVE", "b", "BELOW", "tb", "HSIDES",
		  "lt", "BOX", "rt", "BOX", "lrt", "BOX",
		  "lb", "BOX", "rb", "BOX", "lrb", "BOX", 
		  "ltb", "BOX", "rtb", "BOX", "lrtb", "BOX");

# tabularstar simply calls tabular but with an extra argument---the
# width.
sub do_env_tabularstar {
    local($_) = @_;
    s/$next_pair_rx//;
    local($pts,$len) = &convert_length($2);
    &do_env_tabular($_," width=$pts");
}

sub do_env_tabular {
    local($_) = @_;
    &get_next_optional_argument;
    s/$next_pair_rx//;
    local($colspec) = $2;
    s/\\\\\s*\[([^]]+)\]/\\\\/g;  # TKM - get rid of [N.n pc] on end of rows...
    s/\\newline\s*\[([^]]+)\]/\\newline/g;
    s/\n\s*\n/\n/g;	# Remove empty lines (otherwise will have paragraphs!)
    local($i,@colspec,$char,$cols,$cell,$htmlcolspec,$frames,$rules);
    local(@rows,@cols,$border);
    local($colspan,$cellcount);

    $border = ""; $frame = "";
    ($htmlcolspec,$frames,$rules,$cols,@colspec) =
	&translate_colspec($colspec, 'TD');

    $frames .= "t" if ( s/^\s*\\hline// );
    $frames .= "b" if ( s/\\hline\s*$// );
    $rules .= "r" if ( /\\[ch]line/ );

    if ( $frames || $rules ) {
	$border = " BORDER";
	$rule = " RULES=NONE";
	$frame = " FRAME=$frameoptions{$frames}" if ($frames);
	$rule = " RULES=GROUPS" if ($rules);
    };

    @rows = split(/\\\\/);
    $#rows-- if ( $rows[$#rows] =~ /^\s*$/ );
    local($return) = "<TABLE COLS=$cols$border$frame$rule$_[1]>\n";
    $return .= "$htmlcolspec\n";
    $return .= "<TBODY>\n" if ( $rules =~ /r/ );
    foreach (@rows) {
	if ( s/^(\s*\\hline\s*)+//g ) {
	    $return .= "</TBODY><TBODY>\n";
	};
	$return .= "<TR>";
	@cols = split(/$html_specials{'&'}/o);
	for ( $i = 0; $i <= $#colspec; $i++ ) {
	    $colspec = $colspec[$i];
	    $colspan = 0;
	    # May modify $colspec
	    $cell = &translate_commands(&translate_environments(shift(@cols)));
	    if ( $colspan ) {
		for ( $cellcount = 0; $colspan > 0; $colspan-- ) {
		    $colspec[$i++] =~ s/<TD/$cellcount++;"<TD"/ge;
		}
		$i--;
		$colspec =~ s/>$content_mark/ COLSPAN=$cellcount$&/;
	    };
	    $colspec =~ s/$content_mark/$cell/;
	    $return .= $colspec;
	};
	$return .= "</TR>\n";
    };
    $return .= "</TBODY>\n" if ( $rules =~ /r/ );
    if ($capenv && $captions) {
        $return .= "<CAPTION ALIGN=BOTTOM>$captions</CAPTION>";
	$captions = "";
    }
    $return .= "</TABLE>\n";
    $return;
}

1;
