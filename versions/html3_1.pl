# -*- perl -*-
#
### File: html3.1.pl
### Language definitions for HTML 3.1 (Math)
### Written by Marcus E. Hennecke <marcush@leland.stanford.edu>
### Version 0.3,  April 3, 1997

###   extended math-parsing, when $NO_SIMPLE_MATH is set
### Version 0.4,  July, August 1997  by Ross Moore

###   extended math-parsing, when $NO_SIMPLE_MATH is set
### Version 0.5, many modifications and extensions
### made during 1997 and 1998  by Ross Moore


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
## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

if ($HTML_OPTIONS =~ /math/) {
    do { $DOCTYPE = ''; $STRICT_HTML = 0 }
        unless ($NO_SIMPLE_MATH||$NO_MATH_PARSING);
}

#########################
## Support HTML 3.0 math

#### Mathematical Formulas

package main;

sub do_env_math {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment,$img_params) = ("inline",'','');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    if ($failed) {
	$_ = join ('', $comment, $labels 
	    , ($USING_STYLES ? '<SPAN CLASS="MATH">' : '')
            , &process_undefined_environment("tex2html_wrap", $id, $saved)
	    , ($USING_STYLES ? '</SPAN>' : ''))
    } elsif ($NO_SIMPLE_MATH) {
        if ($USING_STYLES) {
            $_ = join('', $comment, $labels
	        , '<SPAN CLASS="MATH">', $_ , "</SPAN>");
	} else {
            $_ = join('', $comment, $labels, " ", $_ );
	}
    } else {
        $_ = join('', $comment, $labels, "<MATH CLASS=\"INLINE\">\n$_\n</MATH>");
    }
    if (($border||($attributes))&&($HTML_VERSION > 2.1 )) { 
	&make_table( $border, $attribs, '', '', '', $_ )
    } else { $_ }
}

$math_start_rx = "(\\\$|\\\\\\(|\\\\math\\b)(\\begin(($O|$OP)\\d+($C|$CP))tex2html_wrap\\4)?";
$math_end_rx = "(\\end(($O|$OP)\\d+($C|$CP))tex2html_wrap\\7)?(\\\$|\\\\\\)|\\\\endmath\\b)";

sub do_env_tex2html_wrap {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment,$img_params) = ("inline",'','');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    s/^\s*|\s*$//gm;
    local($saved) = $_;
#   if (s/^\\\(|^\$|^\\math|\\\)$|\$$|\\endmath//g) {}
    if (s/^$math_start_rx|${math_end_rx}$//g) {}
    elsif (/^\\ensuremath/om) { }
    else { $failed = 1 }; # catch non-math environments or commands
    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    if ($failed) {
	$_ = join ('', $comment, $labels 
             , &process_undefined_environment("tex2html_wrap", $id, $saved));
    } elsif ($NO_SIMPLE_MATH) {
        # no need for comment/labels if already inside a math-env
        if (defined $math_outer) { s/^\s*|\s*$//g }
	else { $_ = $comment . $labels ." ".$_; }
    } else { 
        $_ = $comment . $labels . "<MATH CLASS=\"INLINE\">\n$_\n</MATH>";
    }
    if (($border||($attribs))&&($HTML_VERSION > 2.1 )) { 
	&make_table( $border, $attribs, '', '', '', $_ ) 
    } else { $_ }
}

sub do_env_tex2html_wrap_inline {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment) = ("inline",'','');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
#   s/(^\s*(\$|\\\()\s*|\s*(\$|\\\))\s*$)//g; # remove the \$ signs or \(..\)
#   s/^\\ensuremath(($O|$OP)\d+($C|$CP))(.*)\1/$4/; # remove an ensuremath wrapper
    if (s/^$math_start_rx|$math_end_rx$//gs ) {}
    elsif (s/^\\ensuremath(($O|$OP)\d+($C|$CP))(.*)\1/$4/){} # remove an ensuremath wrapper
    else { $failed = 1 }
    s/\\(begin|end)(($O|$OP)\d+($C|$CP))tex2html_wrap\w*\2//g; # remove wrappers
    $_ = &translate_environments($_) unless (($NO_SIMPLE_MATH)||($failed));
    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    if ($failed) {
        if ($USING_STYLES) {
            $env_id =~ s/\"$/ image\"/;
            $env_id = ' CLASS="MATH"' if ($env_id =~ /^\s*$/);
            $_ = join ('', $labels, $comment, "<SPAN$env_id>"
                , &process_undefined_environment("tex2html_wrap_inline", $id, $saved)
                , "</SPAN>");
        } else {
            $_ = join ('', $labels, $comment
                , &process_undefined_environment("tex2html_wrap_inline", $id, $saved));
        }
    } elsif (($NO_SIMPLE_MATH)&&($USING_STYLES)) {
        $env_id = ' CLASS="MATH"' if ($env_id =~ /^\s*$/);
        $_ = join('', $labels, $comment, "<SPAN$env_id>", $_, "</SPAN>");
    } elsif ($NO_SIMPLE_MATH) {
        $_ = join('', $labels, $comment, $_);
    } else { 
        $_ = join('', $labels, $comment, "<MATH CLASS=\"INLINE\">\n$_\n</MATH>");
    }
    if (($border||($attribs))&&($HTML_VERSION > 2.1 )) { 
	&make_table( $border, $attribs, '', '', '', $_ ) 
    } else { $_ }
}

# Allocate a fixed width for the equation-numbers:
#$seqno = "<TD WIDTH=\"10\" ALIGN=\"CENTER\">\n";
$mvalign = ' VALIGN="MIDDLE"';

sub do_env_equation {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment) = ("equation",'','');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
    local($sbig,$ebig);
    ($sbig,$ebig) = ('<BIG>','</BIG>')
	if (($DISP_SCALE_FACTOR)&&($DISP_SCALE_FACTOR >= 1.2 ));
    local($math_start,$math_end)= ($sbig,$ebig);

    local($eqno) = '&nbsp;'; # spacer, when no numbering
    local($seqno) = join('',"\n<TD$eqno_class WIDTH=10 ALIGN=\""
                         , (($EQN_TAGS =~ /L/)? 'LEFT': 'RIGHT')
		         , "\">\n");
    do { # include the equation number, using a <TABLE>
	$global{'eqn_number'}++;
	$eqno = join('', $EQNO_START
		, &simplify(&translate_commands('\theequation'))
		, $EQNO_END);
    } unless ((s/(\\nonumber|\\notag)//gm)||(/\\tag/));
    if (s/\\tag(\*)?//m){
	# AmS-TEX line-number tags.
	local($nobrack,$before) = ($1,$`);
	$_ = $';
	s/next_pair_pr_rx//om;
	if ($nobrack) { $eqno = $2 }
	else { $eqno = join('',$EQNO_START, $2, $EQNO_END ) }
	$_ = $before;
    }

    local($halign) = " ALIGN=\"CENTER\"" unless $FLUSH_EQN;
    if ($EQN_TAGS =~ /L/) {
	# equation number on left
	($math_start,$math_end) = 
	    ( "\n<TABLE$env_id WIDTH=\"100%\" ALIGN=\"CENTER\""
		. (($border)? " BORDER=\"$border\"" : '')
		. (($attribs)? " $attribs" : '')
		. ">\n<TR$mvalign>" . $seqno . $eqno
		. "</TD>\n<TD$halign NOWRAP>$sbig"
		, "$ebig</TD>\n</TR></TABLE>");
	$border = $attribs = $env_id = '';
    } else {
	# equation number on right
	($math_start,$math_end) = 
	    ("\n<TABLE$env_id WIDTH=\"100%\" ALIGN=\"CENTER\""
		. (($border)? " BORDER=\"$border\"" : '')
		. (($attribs)? " $attribs" : '')
		. ">\n<TR$mvalign><TD></TD>"
		. "<TD$halign NOWRAP>$sbig"
	    , "$ebig</TD>". $seqno . $eqno ."</TD></TR>\n</TABLE>");
	$border = $attribs = $env_id = '';
    }

    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    if ($failed) {
	$_ = join ('', $comment, $labels, $math_start
	    , &process_undefined_environment('displaymath', $id, $saved)
	    , $math_end );
    } elsif ($NO_SIMPLE_MATH) {
	$_ = join('', "<P></P><DIV$math_class>", $labels
		, $comment, $math_start, "\n$_\n"
		, $math_end, "</DIV><P></P>" );
    } else {
	$_ = join('', "<P$math_class>"
	    , $labels, $comment, $math_start
	    , "\n<MATH CLASS=\"EQUATION\">\n"
	    , $_ , "\n</MATH>", $math_end );
    }
    if (($border||($attribs))&&($HTML_VERSION > 2.1 )) { 
	join('',"<BR>\n<DIV$math_class>\n"
	    , &make_table( $border, $attribs, '', '', '', $_ )
	    , "\n<BR CLEAR=\"ALL\">");
    } else { $_ }
}

sub do_env_displaymath {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment) = ("display",'','');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
    local($sbig,$ebig);
    ($sbig,$ebig) = ('<BIG>','</BIG>')
	if (($DISP_SCALE_FACTOR)&&($DISP_SCALE_FACTOR >= 1.2 ));
    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    if ($failed) {
	$_ = join('', $comment, "<P$math_class>" , $labels
            , &process_undefined_environment("displaymath", $id, $saved )
            , '</P>' );
    } elsif ($NO_SIMPLE_MATH) {
	$_ =~ s/<TABLE/$ebig$&/sg; $_ =~ s/<\/TABLE>/$&$sbig/sg;
	$_ = "$comment\n<P></P><DIV$math_class>$labels\n$sbig$_$ebig\n</DIV><P></P>" 
    } else { 
        $_ = join('', $comment, "<P$math_class>", $labels
            , "$sbig\n<MATH CLASS=\"DISPLAYMATH\">\n",$_,"\n</MATH>\n$ebig</P>");
    }
    if (($border||($attribs))&&($HTML_VERSION > 2.1 )) { 
	join('',"<BR>\n<DIV$math_class>\n"
            , &make_table( $border, $attribs, '', '', '', $_ )
	    , "\n<BR CLEAR=\"ALL\">");
    } else { $_ }
}

### Some Common Structures

## Declare math mode and take care of sub- and superscripts. Also make
## sure to treat curly braces right.
sub make_math {
    local($math_mode,$math_style,$math_face,$_) = @_;
    # Do spacing
    s/\\,/;SPMthinsp;/g;
    s/\\!/;SPMnegsp;/g;
    s/\\:/;SPMsp;/g;
    s/\\;/;SPMthicksp;/g;
    s/((^|[^\\])(\\\\)*)\\ /$1\\space /g; # convert \ to \space
    s/\\limits/\&limits;/g; # preserve the \limits commands

    # Find all _ and ^, but not \_ and \^
    s/\\_/\\underscore/g;
    s/\\^/\\circflex/g;

#RRM:  The following code is just plain wrong !!!
#    local(@terms) = split(/([_^])/);
#    local($math,$i,$subsup,$level);
#    # Do the sub- and superscripts
#    $math = $terms[$[];
#    for ( $i = $[+1; $i <= $#terms; $i+=2 ) {
#	$subsup = ( $terms[$i] eq "_" ? "SUB" : "SUP" );
#	$_ = $terms[$i+1];
#	if ( s/$next_pair_rx// ) {
#	    $math .= "<$subsup>$2</$subsup>$_";
#	} else {
#	    s/^\s*(\w|\\[a-zA-Z]+)//;
#	    $math .= "<$subsup>$1</$subsup>$_";
#	};
#    };
#    $_ = $math;
#RRM: This works much better (from   &simple_math_env ).
    if ($NO_SIMPLE_MATH) {
	s/\&ldots;/.../g;
	$_ = &translate_math_commands($math_mode,$math_style,$math_face,0,$_);
	# remove redundant tags
	s/<I>\s*<\/I>//go;
	s/<\/I>(\s*)<I>/$1/go;
    } else {
	s/\^$any_next_pair_rx/<SUP>$2<\/SUP>/go;
	s/_$any_next_pair_rx/<SUB>$2<\/SUB>/go;
	s/\^(\\[a-zA-Z]+|.)/<SUP>$1<\/SUP>/g;
	s/_(\\[a-zA-Z]+|.)/<SUB>$1<\/SUB>/g;
    }

    s/\\underscore/\\_/g;
    s/\\circflex/\\^/g;
    s/&limits;//g; # not implemented, except via an image

    # Translate all commands inside the math environment
    $_ = &translate_commands($_) unless ($NO_SIMPLE_MATH);


    if ($NO_SIMPLE_MATH) {
	s/&lbrace;/{/g; s/&rbrace;/}/g;
	s/\s*&times;\s*/ <TT>x<\/TT> /g;
#	s/\s*&times;\s*/ &#215; /g;
	s/\s*&div;\s*/ &#247; /g;
	s/\s*&circ?;\s*/<TT>o<\/TT>/g;
	s/\s*&ast;\s*/ <TT>\*<\/TT> /g;
	s/\s*&l?dots;\s*/.../g;
	s/\s*&mid;\s*/ | /g;
	s/\s*&vert;\s*/\|/g;
	s/\s*&parallel;\s*/ || /g;
	s/;SPM(thin)?sp;/&nbsp;/g; s/&thinsp;/&nbsp;/g; s/&sp;/&nbsp;/g;
	s/;SPMthicksp;/ &nbsp;/g; s/&thicksp;/ &nbsp;/g; s/&ensp; /&nbsp;/g;
#        &replace_math_constructions($math_mode);
    } else { 
	# Inside <MATH>, { and } have special meaning. Thus, need &lcub;
	# and &rcub;
#    s/{/&lcub;/g; s/}/&rcub;/g; # Where are these defined ?
	s/{/&lbrace;/g;
	s/}/&rbrace;/g;

	# Remove the safety markers for math-entities
	s/(\&\w+)#\w+;/$1;/g; 

	# Substitute <BOX> and </BOX> with { and } to improve readability
	# on browsers that do not support math.
	s/<BOX>/$level++;'{'/ge;
	s/<\/BOX>/$level--;'}'/ge;
	# Make sure braces are matching.
	$_ .= '}' if ( $level > 0 );
	$_ = '{'.$_ if ( $level < 0 );
#	s/<\/?SUB>/_/g; s/<\/?SUP>/^/g;
    }

    # contract spaces
    s/(\s)\s+/\1/g;

    # remove bogus entities
    s/;SPMnegsp;//g;
    s/\&limits;/\\limits/g;

    # remove white space at the extremities
#   do{ $*=1; s/(^\s+|\s+$)//; $*=0; } unless ($NO_SIMPLE_MATH);
    s/^\s//o;s/\s$//m;

    $_;
}



## Fractions
sub do_math_cmd_frac {
    local($_) = @_;
    local($fbarwidth,$optwidth) = &get_next_optional_argument;
    local($numer,$denom);
    local($cmd) = $cmd;
    if ($optwidth) { $optwidth = ''
	unless ($preamble =~ /[\{,]amstex[,\}]/ ) }
    $cmd = "frac" unless ($cmd =~ /frac/);

    $numer = &get_next_token();
#    $numer = &missing_braces unless (
#	(s/$next_pair_pr_rx/$numer = $2;''/e)
#	||(s/$next_pair_rx/$numer = $2;''/e ));
    $denom = &get_next_token();
#    $denom = &missing_braces unless (
#	(s/$next_pair_pr_rx/$denom = $2;''/e)
#	||(s/$next_pair_rx/$denom = $2;''/e ));

    if (($numer =~ /^\d$/)&&($denom =~ /^\d$/)) {
	local($frac) = &check_frac_entity($numer,$denom);
	if ($frac) {
	    if ($NO_SIMPLE_MATH) { return ($frac , $_) }
	    else { return ($frac . $_) }
	}
    }
    if ($NO_SIMPLE_MATH) {
	local($after) = $_;
	local($fracstyle) = "";
	$fracstyle = "\\textstyle" if (
	    ($mode =~ /display|equation|eqnarray/)
	    && ($numer =~ /^[\d\s]+$/)&& ($denom =~ /^[\d\s]+$/));

	( &process_math_in_latex( $mode, $math_style, $slevel
	    , "{$fracstyle\\$cmd${optwidth}{$numer}{$denom}}") , $after )
    } else { "<BOX>$numer<OVER>$denom</BOX>$_" }
}

sub check_frac_entity {
    local($num,$den) = @_;
    local($ent,$cset,$char) = ("frac".$num.$den,$CHARSET,$char);
    $cset =~ s/\-/_/go; $cset = "\$${cset}_character_map{$ent}";
    eval ("\$char = $cset");
    $char;
    '';  # browsers don't recognise these characters yet.
}

## Roots
sub do_math_cmd_sqrt {
    local($_) = @_;
    local($n) = &get_next_optional_argument;
    local($surd) = &get_next_token();
    if ($NO_SIMPLE_MATH) { local($after) = $_;
        ( &process_math_in_latex( $mode, $math_style, $slevel
	    , "\\sqrt".( $n ? "[$n]" : '') . "{$surd}") , $after )
    } else { $n ? "<ROOT>$n<OF>$surd</ROOT>$_" : "<SQRT>$surd</SQRT>$_"; }
}

sub do_math_cmd_thin_sp {
    '&thinsp;';
}
sub do_math_cmd_norm_sp {
    '&sp;';
}
sub do_math_cmd_thick_sp {
    '&ensp;';
}

%mathnomacros = (
                 'omicron', 'o',
		 'Alpha', 'A', 'Beta', 'B', 'Epsilon', 'E', 'Zeta', 'Z',
		 'Eta', 'H', 'Iota', 'J', 'Kappa', 'K', 'Mu', 'M', 'Nu', 'N',
		 'Omicron', 'O', 'Rho', 'R', 'Tau', 'T', 'Chi', 'X'
	     );

do {
    local($key, $val);
    foreach $key (keys %mathnomacros) {
	$val = $mathnomacros{$key};
	$LaTeXmacros .= "\\providecommand{\\$key}{\\textrm{$val}}\n";
    }
};

%greekentities = (
		 # Greek letters  %ISOgrk3;  and  %HTMLsymbol;
		 'alpha', 'alpha', 'beta', 'beta', 'gamma', 'gamma',
		 'delta', 'delta', 'epsilon', 'epsi', 'varepsilon', 'epsiv',
		 'zeta', 'zeta', 'eta', 'eta', 'theta', 'thetas',
		 'vartheta', 'thetav', 'iota', 'iota', 'kappa', 'kappa',
		 'lambda', 'lambda', 'mu', 'mu',
		 'nu', 'nu', 'xi', 'xi', 'pi', 'pi', 'varpi', 'piv',
		 'rho', 'rho', 'varrho', 'rhov', 'sigma', 'sigma',
		 'varsigma', 'sigmav', 'tau', 'tau', 'upsilon', 'upsi',
		 'phi', 'phis', 'varphi', 'phiv', 'chi', 'chi',
		 'psi', 'psi', 'omega', 'omega',
		 'Gamma', 'Gamma', 'Delta', 'Delta', 'Theta', 'Theta',
		 'Lambda', 'Lambda', 'Xi', 'Xi', 'Pi', 'Pi',
		 'Sigma', 'Sigma', 'Upsilon', 'Upsi', 'Phi', 'Phi',
		 'Psi', 'Psi', 'Omega', 'Omega',
		 'Alpha', 'Alpha', 'Beta', 'Beta', 'Epsilon', 'Epsilon',
		 'Zeta', 'Zeta', 'Eta', 'Eta', 'Iota', 'Iota',
		 'Kappa', 'Kappa', 'Mu', 'Mu', 'Nu', 'Nu',
		 'Omicron', 'Omicron', 'Rho', 'Rho', 'Tau', 'Tau', 'Chi', 'Chi',
		 'straightepsilon', 'epsis', 'omicron', 'omicron'
);

%mathentities = (
		 # Ellipsis  %ISOpub 
		 'ldots', 'hellip', 'cdots', 'cdots', 'vdots', 'vellip',
		 'ddots', 'ddots', 'dotfill', 'dotfill',
### Mathematical Symbols
		 %greekentities ,

		 # Binary operators   %ISOnum  %ISOamsb
		 'pm', 'plusmn', 'mp', 'mnplus', 'times', 'times',
		 'div', 'divide', 'ast', 'ast', 'star', 'sstarf',
		 'circ', 'cir', 'bullet', 'bull', 'cdot', 'sdot',
		 'cap', 'cap', 'cup', 'cup', 'uplus', 'uplus',
		 'sqcap', 'sqcap', 'sqcup', 'sqcup',
		 'vee', 'or', 'wedge', 'and', 'setminus', 'setmn',
		 'wr', 'wreath', 'diamond', 'diam',
		 'bigtriangleup', 'xutri', 'bigtriangledown', 'xdtri',
		 'triangleleft', 'ltri', 'triangleright', 'rtri',
		 'lhd', '', 'rhd', '', 'unlhd', '', 'unrhd', '',
		 'oplus', 'oplus', 'ominus', 'ominus', 'otimes', 'otimes',
		 'oslash', 'osol', 'odot', 'odot', 'bigcirc', 'xcirc',
		 'dagger', 'dagger', 'ddagger', 'Dagger', 'amalg', 'amalg',

		 # Relations  %ISOamsr  %ISOtech
		 'leq', 'le', 'le', 'le', 'prec', 'pr', 'preceq', 'pre', 'll', 'Lt',
		 'subset', 'sub', 'subseteq', 'sube', 'sqsubset', 'sqsub',
		 'sqsubseteq', 'sqsube', 'in', 'isin', 'vdash', 'vdash',
		 'geq', 'ge', 'ge', 'ge', 'succ', 'sc', 'succeq', 'sce', 'gg', 'Gt',
		 'supset', 'sup', 'supseteq', 'supe', 'sqsupset', 'sqsup',
		 'sqsupseteq', 'sqsupe', 'ni', 'ni', 'dashv', 'dashv', 'owns', 'ni',
		 'equiv', 'equiv', 'sim', 'sim', 'simeq', 'sime', 'smallamalg', 'samalg',
		 'asymp', 'asymp', 'approx', 'ap', 'cong', 'cong',
		 'neq', 'ne', 'ne', 'ne', 'doteq', 'esdot', 'propto', 'prop',
		 'models', 'models', 'perp', 'perp', 'mid', 'mid',
		 'parallel', 'par', 'bowtie', 'bowtie', 'Join', '',
		 'smile', 'smile', 'frown', 'frown', 
		 'vee', 'or', 'land', 'and', 'lor', 'or',

		 # Arrows and pointers  %ISOamsa  %ISOnum
		 'leftarrow', 'larr', 'rightarrow', 'rarr',
		 'uparrow', 'uarr', 'downarrow', 'darr',
		 'Leftarrow', 'lArr', 'Rightarrow', 'rArr',
		 'Uparrow', 'uArr', 'Downarrow', 'dArr',
		 'longleftarrow', 'larr', 'longrightarrow', 'rarr',
		 'Longleftarrow', 'xlArr', 'Longrightarrow', 'xrArr',
		 'leftrightarrow', 'harr', 'Leftrightarrow', 'hArr',
		 'longleftrightarrow', 'xharr', 'Longleftrightarrow', 'xhArr',
		 'updownarrow', 'varr', 'Updownarrow', 'vArr',
		 'mapsto', 'map', 'longmapsto', 'map',
		 'hookleftarrow', 'larrhk', 'hookrightarrow', 'rarrhk',
		 'nearrow', 'nearr', 'searrow', 'drarr',
		 'swarrow', 'dlarr', 'nwarrow', 'nwarr',
		 'leftharpoonup', 'lharu', 'leftharpoondown', 'lhard',
		 'rightharpoonup', 'rharu', 'rightharpoondown', 'rhard',
		 'rightleftharpoons', 'rlhar2', 'leadsto', '',
		 'gets', 'larr', 'to', 'rarr', 'iff', 'iff',

		 # Various other symbols   %ISOpub  %ISOamso  %ISOnum  %ISOtech
		 'aleph', 'aleph', 'hbar', 'planck',
		 'imath', 'inodot', 'jmath', 'jnodot', 'ell', 'ell',
		 'wp', 'weierp', 'Re', 'real', 'Im', 'image',
		 'beth', 'beth', 'gimel', 'gimel', 'daleth', 'daleth',
		 'emptyset', 'empty', 'nabla', 'nabla', 'surd', 'radic',
		 'top', 'top', 'bot', 'bottom', 'angle', 'ang',
		 'forall', 'forall', 'exists', 'exist', 'neg', 'not',
		 'flat', 'flat', 'natural', 'natur', 'sharp', 'sharp',
		 'partial', 'part', 'infty', 'infin', 'sphericalangle', 'angsph',
		 'varprime', 'vprime', 'sbs', 'sbsol', 'yen', 'yen',
		 'Box', '', 'Diamond', '', 'triangle', 'utri',
		 'clubsuit', 'clubs', 'diamondsuit', 'diams',
		 'heartsuit', 'hearts', 'spadesuit', 'spades',
		 'checkmark', 'check', 'maltese', 'malt',
		 'backslash', 'bsol', 'circledR', 'reg', 'centerdot', 'middot',
		 'prime', 'prime', 'square', 'square',

		 # Integral type entities   %ISOamsb
		 'sum', 'sum', 'prod', 'prod', 'coprod', 'coprod',
		 'int', 'int', 'oint', 'conint',

		 # Delimiters  %ISOamsc   %ISOtech
		 'lfloor', 'lfloor', 'rfloor', 'rfloor',
		 'lceil', 'lceil', 'rceil', 'rceil',
		 'langle', 'lang', 'rangle', 'rang',
		 'lbrace', 'lcub', 'rbrace', 'rcub',
		 'lbrack', 'lsqb', 'rbrack', 'rsqb',
		 'Vert', 'Verbar', 'vert', 'vert',

		 # AMS package
		 # Greek letters
		 'digamma', 'gammad', 'varkappa', 'kappav',

		 # Delimiters %ISOamsc
		 'ulcorner', 'ulcorn', 'urcorner', 'urcorn',
		 'llcorner', 'dlcorn', 'lrcorner', 'drcorn',
		 'leftparengtr', 'lpargt', 'rightparengtr', 'rpargt',

		 # Arrows  %ISOamsa 
		 'dashrightarrow', '', 'dashleftarrow', '',
		 'leftleftarrows', 'larr2', 'leftrightarrows', 'lrarr2',
		 'Lleftarrow', 'lArr', 'twoheadleftarrow', 'Larr',
		 'leftarrowtail', 'larrtl', 'looparrowleft', 'larrlp',
		 'leftrightharpoons', 'lrhar2', 'curvearrowleft', 'cularr',
		 'circlearrowleft', 'olarr', 'Lsh', 'lsh',
		 'upuparrows', 'uarr2', 'upharpoonleft', 'uharl',
		 'downharpoonleft', 'dharl', 'multimap', 'mumap',
		 'leftrightsquigarrow', 'harrw',
		 'rightrightarrows', 'rarr2', 'rightleftarrows', 'rlarr2',
		 'Rrightarrow', 'rArr', 'twoheadrightarrow', 'Rarr',
		 'rightarrowtail', 'rarrtl', 'looparrowright', 'rarrlp',
		 'rightleftharpoons', 'rlhar2', 'curvearrowright', 'curarr',
		 'circlearrowright', 'orarr', 'Rsh', 'rsh',
		 'downdownarrows', 'darr2', 'upharpoonright', 'uharr',
		 'downharpoonright', 'dharr','rightsquigarrow', 'rarrw',

		 # Negated arrows  %ISOamsa
		 'nleftarrow', 'nlarr', 'nrightarrow', 'nrarr',
		 'nLeftarrow', 'nlArr', 'nRightarrow', 'nrArr',
		 'nleftrightarrow', 'nharr', 'nLeftrightarrow', 'nhArr',

		 # Binary relations  %ISOamsr  %ISOamsb
		 'leqq', 'lE', 'leqslant', 'les', 'eqslantless', 'els',
		 'lesssim', 'lsim', 'lessapprox', 'lap', 'approxeq', 'ape',
		 'lessdot', 'ldot', 'lll', 'Ll', 'Ll', 'Ll', 'llless', 'Ll',
		 'lessgtr', 'lg', 'lesseqgtr', 'leg', 'lesseqqgtr', 'lEg',
		 'backcong', 'bcong', 
		 'barwedge', 'barwed', 'doublebarwedge', 'Barwed',
		 'doublecap', 'Cap', 'doublecup', 'Cup',
		 'curlyvee', 'cuvee', 'curlywedge', 'cuwed',
		 'divideontimes', 'divonx', 'intercal', 'intcal',
		 'doteqdot', 'eDot', 'risingdotseq', 'erDot', 'Doteq', 'eDot',
		 'leftthreetimes', 'lthree', 'rightthreetimes', 'rthree',
		 'ltimes', 'ltimes', 'rtimes', 'rtimes',
		 'boxminus', 'minusb', 'boxplus', 'plusb', 'boxtimes', 'timesb',
		 'circledast', 'oast', 'circledcirc', 'ocirc', 'circleddash', 'odash',
		 'dotplus', 'plusdo', 'dotsquare', 'sdotb', 'smallsetminus', 'ssetmn',
		 'fallingdotseq', 'efDot', 'backsim', 'bsim',
		 'backsimeq', 'bsime', 'subseteqq', 'subE', 'Subset', 'Sub',
		 'curlypreceq', 'cupre', 'curlyeqprec', 'cuepr', 
		 'precsim', 'prsim', 'precapprox', 'prap', 
		 'vartriangleleft', 'vltri', 'trianglelefteq', 'ltrie', 
		 'vDash', 'vDash', 'Vvdash', 'Vvdash', 'Vdash', 'Vdash',
		 'smallsmile', 'ssmile', 'smallfrown', 'sfrown', 
		 'bumpeq', 'bumpe', 'Bumpeq', 'bump',
		 'coloneq', 'colone', 'eqcolon', 'ecolon',
		 'geqq', 'gE', 'geqslant', 'ges', 'eqslantgtr', 'egs',
		 'gtrsim', 'gsim', 'gtrapprox', 'gap', 'gtrdot', 'gsdot',
		 'ggg', 'Gg', 'Gg', 'Gg', 'gggtr', 'Gg',
		 'gtrless', 'gl', 'gtreqless', 'gel',
		 'gtreqqless', 'gEl', 'eqcirc', 'ecir', 'circeq', 'cire',
		 'triangleeq', 'trie', 'thicksim', 'thksim',
		 'thickapprox', 'thkap', 'supseteqq', 'supE', 'Supset', 'Sup',
		 'succcurlyeq', 'sccue', 'veebar', 'veebar',
		 'curlyeqsucc', 'cuesc', 'succsim', 'scsim',
		 'succapprox', 'scap', 'vartriangleright', 'vrtri',
		 'trianglerighteq', 'rtrie',
		 'shortmid', 'smid', 'shortparallel', 'spar',
		 'between', 'twixt', 'pitchfork', 'fork', 'bigstar', 'starf',
		 'varpropto', 'vprop', 'because', 'becaus',
		 'therefore', 'there4', 'backepsilon', 'bepsi',
		 'blacksquare', 'squf', 'lozenge', 'loz', 'blacklozenge', 'lozf',
		 'blacktriangle', 'utrif', 'blacktriangledown', 'dtrif',
		 'blacktriangleleft', 'ltrif', 'blacktriangleright', 'rtrif',

		 # Negated binary relations  %ISOamsn 
		 'gnapprox', 'gnap', 'gneq', 'gne', 'gneqq', 'gnE', 
		 'lnapprox', 'lnap', 'lneq', 'lne', 'lneqq', 'lnE', 
		 'gnsim', 'gnsim', 'gvertneqq', 'gvnE',
		 'lnsim', 'lnsim', 'lvertneqq', 'lvnE',
		 'nsim', 'nsim', 'nsimeq', 'nsime',
		 'napprox', 'nap', 'ncong', 'ncong', 'nequiv', 'nequiv',
		 'ngeq', 'nge', 'ngeqq', 'ngE', 'ngeqslant', 'nges', 'ngtr', 'ngt',
		 'nleq', 'nle', 'nleqq', 'nlE', 'nleqslant', 'nles', 'nless', 'nlt',
		 'ntriangleleft', 'nltri', 'ntrianglelefteq', 'nltrie', 
		 'ntriangleright', 'nrtri', 'ntrianglerighteq', 'nrtrie',
		 'nmid', 'nmid', 'nparallel', 'npar',
		 'nprec', 'npr', 'npreceq', 'npre', 'nsucc', 'nps', 'nsucceq', 'npse',
		 'nshortmid', 'nsmid', 'nshortparallel', 'nspar',
		 'nsubset', 'nsub', 'nsubseteq', 'nsube', 'nsubseteqq', 'nsubE',
		 'nsupset', 'nsup', 'nsupseteq', 'nsupe', 'nsupseteqq', 'nsupE',
		 'nvdash', 'nvdash', 'nvDash', 'nvDash',
		 'nVdash', 'nVdash', 'nVDash', 'nVDash',
		 'precnapprox', 'prnap', 'precneqq', 'prnE', 'precnsim', 'prnsim',
		 'succnapprox', 'scnap', 'succneqq', 'scnE', 'succnsim', 'scnsim',
		 'subsetneq', 'subne', 'subsetneqq', 'subnE',
		 'supsetneq', 'supne', 'supsetneqq', 'supnE',
		 'varsubsetneq', 'vsubne', 'varsubsetneqq', 'vsubnE',
		 'varsupsetneq', 'vsupne', 'varsupsetneqq', 'vsupnE',

		 # Binary operators
		 'Cup', 'Cup', 'Cap', 'Cap',
		 # miscellaneous  %ISOamso 
		 'hslash', 'planck', 'circledS', 'oS', 
		 'nexists', 'nexist', 'varnothing', 'empty',
		 'measuredangle', 'angmsd',
		 'complement', 'comp', 'backprime', 'bprime',
);

## environments with alignment
$array_env_rx = "array|cases|\\w*matrix";


## from AMS-packages
$array_env_rx .= "|\\w*align\\w*|split|gather|multline|(fl|x|xx)?align(at|ed)?";
$subAMS_array_env_rx = "\\w*align\\w*|split|gather|multline";
$sub_array_env_rx .= '|'.$subAMS_array_env_rx;

## Log-like Functions
@mathfunctions = ('arccos', 'arcsin', 'arctan', 'arg', 'cos', 'cosh',
		  'cot', 'coth', 'csc', 'deg', 'dim', 'exp', 'hom',
		  'ker', 'lg', 'ln', 'log', 'sec', 'sin', 'sinh',
		  'tan', 'tanh', 'mod'
		  );
@limitfunctions = ('det', 'gcd', 'inf', 'lim', 'liminf'
		   , 'limsup', 'max', 'min', 'Pr', 'sup'
		   );
		   
foreach (@mathfunctions) {
    eval "sub do_math_cmd_$_\{\"<T CLASS=\\\"FUNCTION\\\">$_</T>\$_[\$[]\";}";
}
foreach (@limitfunctions) {
    eval "sub do_math_cmd_$_\{
    local(\$_) = \@_;
    s/^\\s*<SUB>/<SUB ALIGN=\\\"CENTER\\\">/ unless ( \$math_mode eq \"inline\" );
    \"<T CLASS=\\\"FUNCTION\\\">$_</T>\$_\";}";
}


sub do_math_cmd_pmod {
    local($_) = @_;
    local($mod) = &get_next_token();
    if ($NO_SIMPLE_MATH) { local($after) = $_;
	$mod = &process_math_toks($mode, $math_style, $face, $slevel, 0, $mod);
	join( '', "(mod $mod)", $after)
    } else {"(<T CLASS=\"FUNCTION\">mod</T> $mod)$_"}
 }

sub do_math_cmd_bmod {
    local($_) = @_;
    local($mod) = '';
    if ($NO_SIMPLE_MATH) { join( '', " mod " , $_) }
    else {"(<T CLASS=\"FUNCTION\"> mod </T>)$_"}
 }
 
sub do_math_cmd_circ {
    if ($NO_SIMPLE_MATH) { ("<TT>o</TT>","@_") }
    else { "o@_"}
}

### Arrays
sub do_env_array {
    local($_) = @_;
    if (($NO_SIMPLE_MATH)&&(!$math_mode)) {
#    if ($NO_SIMPLE_MATH) {
        # make an image
        $_ = &process_math_in_latex( $mode, $style, $slevel
            , "\\begin{array}". $_ . "\\end{array}");
#           , "\\begin{array}". $_ );
        return($_);
    } 
    
    local($failed, $labels, $comment) = ('','');
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
    local($sbig,$ebig);
    ($sbig,$ebig) = ('<BIG>','</BIG>')
	if (($DISP_SCALE_FACTOR)&&($DISP_SCALE_FACTOR >= 1.2 )
        &&($slevel == 0)&&(!($mode =~/inline/)));
#    $failed = 1 if ($NO_SIMPLE_MATH); # simplifies the next call
#    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    if (($failed)&&!($NO_SIMPLE_MATH)) {
	$_ = join ('', $labels, $comment
	    , &process_undefined_environment("array", $id, $saved));
	$_ = join('','<P'
            , (($HTML_VERSION >2.0)? "$math_class" : '')
            ,'>', $labels, $comment, $_, '<BR'
            , (($HTML_VERSION >2.0)? " CLEAR=\"ALL\"" : '')
	    , '>',"\n<P>");
	if (($border||($attribs))&&($HTML_VERSION > 2.1 )) { 
	    $_ = join('',"<BR>\n<DIV$math_class>\n"
            , &make_table( $border, $attribs, '', '', '', $_ )
	    , "\n<BR CLEAR=\"ALL\">");
	}
        return ($_);
    }

    local($valign) = &get_next_optional_argument;
    if ( $valign =~ /^\s*b/ ) { $valign = " VALIGN=\"BOTTOM\"" } 
    elsif ( $valign =~ /^\s*t/ ) { $valign = " VALIGN=\"TOP\"" } 
    elsif (($NO_SIMPLE_MATH)&&($mode=~/inline/)) { $valign = "" } 
    else { $valign = $mvalign };
    local($colspec);
    $colspec = &missing_braces unless (
	(s/$next_pair_pr_rx/$colspec = $2;''/e)
        ||(s/$next_pair_rx/$colspec = $2;''/e ));

    s/\n\s*\n/\n/g;	# Remove empty lines (otherwise will have paragraphs!)
    local($i,@colspec,$char,$cols,$cell,$htmlcolspec,$frames,$rules);
    local(@rows,@cols,$border);
    local($colspan);
    
    $_ = &revert_array_envs($_);
    if ($NO_SIMPLE_MATH) {
        local($return) = "<TABLE$env_id>"; $env_id = '';
        ($htmlcolspec,$frames,$rules,$cols,@colspec) =
	    &translate_colspec($colspec, 'TD');

	s/\\\\[ \t]*\[[^\]]*]/\\\\/g; # remove forced line-heights
        @rows = split(/\\\\/);

	$#rows-- if ( $rows[$#rows] =~ /^\s*$/ );
	foreach (@rows) {
	    $return .= "\n<TR$valign>";
	    @cols = split(/$html_specials{'&'}/o);
	    for ( $i = 0; $i <= $#colspec; $i++ ) {
		$colspec = $colspec[$i];
		$colspan = 0;
		$cell = shift(@cols);

	    # remove any \parbox commands, leaving the contents
		$cell =~ s/\\parbox[^<]*<<(\d*)>>([\w\W]*)<<\1>>/$1/g;
		if ($cell =~ /\\multicolumn/) {
		    $id = $global{'max_id'}++;
		    $cell = (($cell) ? &make_math($mode,'','', $cell) : "$cell");
		} else {
		    $id = $global{'max_id'}++;
		    $cell = (($cell) ? &make_math($mode,'','', $cell) : "$cell");
		}
		# remove leading/trailing space
		$cell =~ s/^\s*|\s*$//g;
		$cell = "\&nbsp;" if ($cell eq '');

		if ( $colspan ) {
		    for ( $cellcount = 0; $colspan > 0; $colspan-- ) {
			$i++; $cellcount++;
		    }
		    $i--;
		    $colspec =~ s/>$content_mark/ COLSPAN=$cellcount$&/;
		};
		$colspec =~ s/$content_mark/${sbig}${cell}$ebig/;
		$return .= $colspec;
	    };
	    $return .= "</TR>";
	};
	$_ = $return . "\n</TABLE>";

	if (($border||($attribs))&&($HTML_VERSION > 2.1 )) { 
	    $_ = join('',"<BR>\n<DIV$math_class>\n"
		, &make_table( $border, $attribs, '', '', '', $_ )
		, "\n<BR CLEAR=\"ALL\">");
	}
	return ($_);
    }

    ($htmlcolspec,$frames,$rules,$cols,@colspec) =
	&translate_colspec($colspec, 'ITEM');

    s/\\\\[ \t]*\[[^\]]*]/\\\\/g; # remove forced line-heights
    @rows = split(/\\\\/);

    $#rows-- if ( $rows[$#rows] =~ /^\s*$/ );
    local($return) = "<ARRAY COLS=${cols}$valign>\n$htmlcolspec\n";
    foreach (@rows) {
	$return .= "<ROW>";
	@cols = split(/$html_specials{'&'}/o);
	for ( $i = 0; $i <= $#colspec; $i++ ) {
	    $colspec = $colspec[$i];
	    $colspan = 0;
	    $cell = &make_math("", '', '', shift(@cols)); # May modify $colspan, $colspec
	    if ( $colspan ) {
		for ( $cellcount = 0; $colspan > 0; $colspan-- ) {
		    $colspec[$i++] =~ s/<ITEM/$cellcount++;"<ITEM"/ge;
		}
		$i--;
		$colspec =~ s/>$content_mark/ COLSPAN=$cellcount$&/;
	    };
	    $colspec =~ s/$content_mark/$cell/;
	    $return .= $colspec;
	};
	$return .= "</ROW>\n";
    };
    $return .= "</ARRAY>\n";
    $failed = 1 if ($NO_SIMPLE_MATH);
    $return;
}

### Delimiters

$math_delimiters_rx = "^\\s*(\\[|\\(|\\\\{|\\\\lfloor|\\\\lceil|\\\\langle|\\/|\\||\\)|\\]|\\\\}|\\\\rfloor|\\\\rceil|\\\\rangle|\\\\backslash|\\\\\\||\\\\uparrow|\\\\downarrow|\\\\updownarrow|\\\\Uparrow|\\\\Downarrow|\\\\Updownarrow|\\.)";

%ord_brackets = ( 'le' , '{', 're', '}', 'lk', '[', 'rk', ']' );

### Variable-sized operators

$var_sized_ops_rx = "(sum|(co)?prod|(o|i+|idots)?int|big(cap|cup|vee|wedge|o(dot|times|plus)|uplus))";

$var_limits_rx = "(var(inj|proj)?lim(sup|inf)?)";
$arrow_over_ops_rx = "((ov|und)er(left|right)+arrow)";


sub do_math_cmd_left {
    local($_) = @_;
    s/$math_delimiters_rx//;
    $failed = 1 if ($NO_SIMPLE_MATH);
    "<BOX>" . ( $1 && $1 ne "." ? "$1<LEFT>" : "" ) . $_ .
	( /\\right/ ? "" : "</BOX>" );
}

sub do_math_cmd_right {
    local($_) = @_;
    s/$math_delimiters_rx//;
    if ( !($ref_before =~ /<LEFT>/) ) {
	$ref_before = "<BOX>" . $ref_before;
    };
    $failed = 1 if ($NO_SIMPLE_MATH);
    ( $1 eq "." ? "" : "<RIGHT>$1" ) . "</BOX>$_";
}

### Multiline formulas

sub do_env_eqnarray {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment, $doimage) = ("equation",'','');
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($eqnarray_warning) =
	"{eqnarray} does not have 3 columns, inserting blank cell";
    local($saved) = $_;
    local($sbig,$ebig,$falign) = ('','','CENTER');
    ($sbig,$ebig) = ('<BIG>','</BIG>')
	if (($DISP_SCALE_FACTOR)&&($DISP_SCALE_FACTOR >= 1.2 ));
    $failed = 1 if ($NO_SIMPLE_MATH); # simplifies the next call
    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    if (( $failed && !($NO_SIMPLE_MATH))
	||(/$htmlimage_rx|$htmlimage_pr_rx/)) {
#	||((/$htmlimage_rx|$htmlimage_pr_rx/)&&($& =~/thumb/))) {
	# image of whole environment, no equation-numbers
	$failed = 1;
	$falign = (($EQN_TAGS =~ /L/)? 'LEFT' : 'RIGHT')
	    unless $no_eqn_numbers;
	$_ = &process_undefined_environment(
		"eqnarray".(($no_eqn_numbers) ? "star" : '')
		, $id, $saved );
	$_ = join(''
	    , (($HTML_VERSION >2.0)? "<P ALIGN=\"$falign\">" : '')
	    , $labels, $comment, $_
	    , (($HTML_VERSION >2.0)? "<BR CLEAR=\"ALL\">\n<P>" : '')
	    );

    } elsif ($NO_SIMPLE_MATH) {
	$failed = 0;
	s/$htmlimage_rx/$doimage = $&;''/eo ; # force an image
	s/$htmlimage_pr_rx/$doimage .= $&;''/eo ; # force an image
	local($valign) = join('', " VALIGN=\"",
	    ($NETSCAPE_HTML)? "BASELINE" : "MIDDLE", "\"");
	local($sarray, $srow, $slcell, $eccell, $srcell, $ercell, $erow, $earray);
	($sarray, $eccell, $srcell, $erow, $earray, $sempty) = ( 
	    "\n<TABLE$env_id CELLPADDING=\"0\" "
	    , "</TD>\n<TD WIDTH=\"10\" ALIGN=\"CENTER\" NOWRAP>"
	    , "</TD>\n<TD ALIGN=\"LEFT\" NOWRAP>"
	    , "</TD></TR>", "\n</TABLE>", "</TD>\n<TD>" );
	$sarray .= "ALIGN=\"CENTER\" WIDTH=\"100%\">";
	$env_id = '';

	local($seqno) = join('',"\n<TD$eqno_class WIDTH=10 ALIGN=\""
		, (($EQN_TAGS =~ /L/)? 'LEFT': 'RIGHT')
		, "\">\n");
	if ($EQN_TAGS =~ /L/) { # number on left
	    ($srow, $slcell, $ercell) = (
		"\n<TR$valign>". $seqno
		, "</TD>\n<TD NOWRAP ALIGN=", '');
	} else { # equation number on right
	    ($srow, $slcell, $ercell) = (
		"\n<TR$valign>" , "<TD NOWRAP ALIGN="
		, '</TD>'. $seqno );
	}

	$_ = &protect_array_envs($_);

	local(@rows,@cols,$eqno,$return,$thismath);
	s/\\\\[ \t]*\[[^\]]*]/\\\\/g; # remove forced line-heights
	@rows = split(/\\\\/);

	$#rows-- if ( $rows[$#rows] =~ /^\s*$/ );
	$return = join(''
	    , (($border||($attribs))? '': "<BR>")
	    , (($doimage)? '' : "\n<DIV$math_class>")
	    , (($labels)? $labels : "\n") , $comment, $sarray);

	foreach (@rows) { # displaymath
	    $eqno = '&nbsp;';
	    do { 
		$global{'eqn_number'}++ ;
		$eqno = join('', $EQNO_START
	            , &simplify(&translate_commands('\theequation'))
	            , $EQNO_END );
		} unless ((s/\\nonumber//)||($no_eqn_numbers));
	    $return .= $srow;
	    $return .= $eqno if ($EQN_TAGS =~ /L/);
	    $return .= $slcell;

	    if (s/\\lefteqn//) {
		$return .= "\"LEFT\" COLSPAN=\"3\">";
		s/(^\s*|$html_specials{'&'}|\s*$)//gm;
		if (($doimage)||($failed)) {
		    $_ = (($_)? &process_math_in_latex(
			"indisplay" , '', '', $doimage.$_ ):'');
		} else {
		    $_ = &revert_array_envs($_);
		    $_ = (($_) ? &make_math('display', '', '', $_) : "$_");
		}
		if ($_) {
		    $return .= join('', $sbig, $_, $ebig, $erow);
		} else { $return .= join('',"\&nbsp;", $erow); } 
		next;
	    }

	    # columns to be set using math-modes
	    @cols = split(/$html_specials{'&'}/o);

	    # left column, set using \displaystyle
	    $thismath = shift(@cols); 
	    $thismath =~ s/(^\s*|\s*$)//gm;
	    if (($doimage)||($failed)) {
		$thismath = (($thismath ne '')? &process_math_in_latex(
		    "indisplay" , '', '', $doimage.$thismath ):'');
	    } elsif ($thismath ne '') {
		$id = $global{'max_id'}++;
		$thismath = &revert_array_envs($thismath);
		$thismath = &make_math('displaymath', '', '', $thismath);
	    }
	    if ($thismath ne '') {
		$return .= join('',"\"RIGHT\">$sbig",$thismath,"$ebig");
	    } else { $return .= "\"RIGHT\">\&nbsp;" }

	    # center column, set using \textstyle
	    $thismath = shift(@cols);
	    if (!($#cols < 0)) {
#print "\nEQNARRAY:$#cols : $thismath";
		$thismath =~ s/(^\s*|\s*$)//gm;
		if (($doimage)||($failed)) {
		    $thismath = (($thismath ne '')? &process_math_in_latex(
			"indisplay" , 'text', '', $doimage.$thismath ):'');
		} elsif ($thismath ne '') {
		    $id = $global{'max_id'}++;
		    $thismath = &revert_array_envs($thismath);
		    $thismath = &make_math('displaymath', '', '', $thismath);
		}
		if ($thismath ne '') {
		    $return .= join('', $eccell, $sbig , $thismath, $ebig);
		} else { $return .= join('', $sempty,"\&nbsp;") }

	    # right column, set using \displaystyle
		$thismath = shift(@cols);
	    } else {
		$return .= join('', $sempty,"\&nbsp;");
		&write_warnings($eqnarray_warning);
		print "\n\n *** $eqnarray_warning \n";
	    }
	    $thismath =~ s/(^\s*|\s*$)//gm;
	    if (($doimage)||($failed)) {
		$thismath = (($thismath ne '')? &process_math_in_latex(
		    "indisplay" , '', '', $doimage.$thismath ):'');
	    } elsif ($thismath ne '') {
		$id = $global{'max_id'}++;
		$thismath = &revert_array_envs($thismath);
		$thismath = &make_math('displaymath', '', '', $thismath);
	    }
	    if ($thismath ne '') {
		$return .= join('', $srcell, $sbig, $thismath, $ebig, $ercell);
	    } else { $return .= join('', $sempty, "\&nbsp;", $ercell) }

	    $return .= $eqno unless ($EQN_TAGS =~ /L/);
	    $return .= $erow;
	}
	$_ = join('', $return , $earray, (($doimage)? '' : "</DIV>" ));
    } else {
	$_ = join('', $comment, "<P$math_class>$sbig"
	    , $labels, "\n<MATH CLASS=\"EQNARRAY\">"
	    , &do_env_array("$O$max_id${C}rcl$O$max_id$C$_")
	    , "</MATH>\n$ebig</P>" )
    }
    if (($border||($attribs))&&($HTML_VERSION > 2.1 )) { 
	join('',"<BR>\n<DIV$math_class>\n"
	    , &make_table( $border, $attribs, '', '', '', $_ )
	    , "\n<BR CLEAR=\"ALL\"></DIV>");
    } elsif ($failed &&($HTML_VERSION > 2.1 )) {
	local($fclass) = $math_class;
	$fclass =~ s/(ALIGN=\")[^"]*/$1$falign/;
	join('',"<BR>\n<DIV$fclass>\n"
	    , $_ , "\n<BR CLEAR=\"ALL\"></DIV><P></P>")
    } else { 
	join('', $_ , "\n<BR CLEAR=\"ALL\"><P></P>");
    }
}

sub do_env_eqnarraystar {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment) = ("equation",'','');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border);
    local($saved) = $_;
    local($sbig,$ebig);
    ($sbig,$ebig) = ('<BIG>','</BIG>')
	if (($DISP_SCALE_FACTOR)&&($DISP_SCALE_FACTOR >= 1.2 ));

    if (($NO_SIMPLE_MATH)||($failed)) {
        local($no_eqn_numbers) = 1;
	$_ = &do_env_eqnarray($_) unless ($failed);
	if ($failed) {
            if ($saved =~ s/$htmlborder_rx//o)  {
	        $attribs = $2; $border = (($4)? "$4" : 1)
            } elsif ($saved =~ s/$htmlborder_pr_rx//o) {
	        $attribs = $2; $border = (($4)? "$4" : 1)
	    }
            $_ = join('', $labels
#	    , &process_undefined_environment("eqnarraystar", $id, $saved));
	    , &process_undefined_environment("eqnarray*", $id, $saved));
	}
    } else {
	if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
	elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
	$saved = $_;
	($labels, $comment, $_) = &process_math_env($math_mode,$_);
	if ($failed) {
	    $_ = join('', $labels
#	        , &process_undefined_environment("eqnarraystar", $id, $saved));
	        , &process_undefined_environment("eqnarray*", $id, $saved));
	} else {
	    $_ = join('', $comment, "<P$math_class>$sbig", $labels
	        , "\n<MATH CLASS=\"EQNARRAYSTAR\">"
	        , &do_env_array("$O$max_id${C}rcl$O$max_id$C$_")
	        , "</MATH>\n$ebig</P>" );
	}
    }
    if (($border||($attribs))&&($HTML_VERSION > 2.1 )) { 
	$_ = &make_table( $border, $attribs, '', '', '', $_ ) 
    } else { $_ }
}

sub do_math_cmd_nonumber {
    $_[$[];
};

### Putting One Thing Above Another

## Over- and Underlining

sub do_math_cmd_overline {
    local($_) = @_;
    local($over) = &get_next_token(1);
    if ($NO_SIMPLE_MATH) { 
        local($supsub) = &get_supsub;
        local($after) = $_;
        ( &process_math_in_latex( $mode, $math_style, $slevel
            , "\\overline{$over}$supsub") , $after)
    } else {"<ABOVE>$over</ABOVE>$_" }
}

sub do_math_cmd_underline {
    local($_) = @_;
    local($under) = &get_next_token(1);
    if ($NO_SIMPLE_MATH) {
        local($supsub) = &get_supsub;
        local($after) = $_;
        ( &process_math_in_latex( $mode, $math_style, $slevel
            , "\\underline{$under}$supsub") , $after)
    } else { "<BELOW>$under</BELOW>$_" }
}

sub do_math_cmd_overbrace {
    local($_) = @_;
    local($over) = &get_next_token(1);
    if ($NO_SIMPLE_MATH) {
        local($supsub) = &get_supsub;
        local($after) = $_;
        ( &process_math_in_latex( $mode, $math_style, $slevel
            , "\\overbrace{$over}$supsub\\,") , $after)
    } else { "<ABOVE SYM=\"CUB\">$over</ABOVE>$_" }
}

sub do_math_cmd_underbrace {
    local($_) = @_;
    local($under) = &get_next_token(1);
    if ($NO_SIMPLE_MATH) {
        local($supsub) = &get_supsub;
        local($after) = $_;
        ( &process_math_in_latex( $mode, $math_style, $slevel
            , "\\underbrace{$under}$supsub\\,") , $after)
    } else { "<BELOW SYM=\"CUB\">$under</BELOW>$_" }
}

## Accents

sub do_math_cmd_vec {
    local($_) = @_;
    local($over) = &get_next_token(1);
    if ($NO_SIMPLE_MATH) {
	local($supsub) = &get_supsub;
	# \vec often makes the arrowhead fall outside its box
	# fix this by adding small space when at the end
	$supsub = "\\," unless ($supsub);
	local($after) = $_;
	( &process_math_in_latex( $mode, $math_style, $slevel
	    , "\\vec{$over}$supsub") , $after)
    } else { "<VEC>$over</VEC>$_" }
}

sub do_math_cmd_bar {
    local($_) = @_;
    local($over) = &get_next_token(1);
    if ($NO_SIMPLE_MATH) {
	local($supsub) = &get_supsub;
	local($after) = $_;
	( &process_math_in_latex( $mode, $math_style, $slevel
	    , "\\bar{$over}$supsub") , $after)
    } else { "<BAR>$over</BAR>$_" }
}

sub do_math_cmd_dot {
    local($_) = @_;
    local($over) = &get_next_token(1);
    if ($NO_SIMPLE_MATH) {
	local($supsub) = &get_supsub;
	local($after) = $_;
	( &process_math_in_latex( $mode, $math_style, $slevel
	    , "\\dot{$over}$supsub") , $after)
    } else { "<DOT>$over</DOT>$_" }
}

sub do_math_cmd_ddot {
    local($_) = @_;
    local($over) = &get_next_token(1);
    if ($NO_SIMPLE_MATH) {
	local($supsub) = &get_supsub;
	local($after) = $_;
	( &process_math_in_latex( $mode, $math_style, $slevel
	    , "\\ddot{$over}$supsub") , $after)
    } else { "<DDOT>$over</DDOT>$_" }
}

sub do_math_cmd_hat {
    local($_) = @_;
    local($over) = &get_next_token(1);
    if ($NO_SIMPLE_MATH) {
	local($supsub) = &get_supsub;
	local($after) = $_;
	( &process_math_in_latex( $mode, $math_style, $slevel
	    , "\\hat{$over}$supsub") , $after)
    } else { "<HAT>$over</HAT>$_" }
}

sub do_math_cmd_tilde {
    local($_) = @_;
    local($over) = &get_next_token(1);
    if ($NO_SIMPLE_MATH) {
	local($supsub) = &get_supsub;
	local($after) = $_;
	( &process_math_in_latex( $mode, $math_style, $slevel
	    , "\\tilde{$over}$supsub") , $after)
    } else { "<TILDE>$over</TILDE>$_" }
}

sub do_math_cmd_widehat {
    local($_) = @_;
    local($over) = &get_next_token(1);
    if ($NO_SIMPLE_MATH) {
	local($supsub) = &get_supsub;
	local($after) = $_;
	( &process_math_in_latex( $mode, $math_style, $slevel
	    , "\\widehat{$over}$supsub") , $after)
    } else { "<ABOVE SYM=\"HAT\">$over</ABOVE>$_" }
}

sub do_math_cmd_widetilde {
    local($_) = @_;
    local($over) = &get_next_token(1);
    if ($NO_SIMPLE_MATH) {
	local($supsub) = &get_supsub;
	local($after) = $_;
	( &process_math_in_latex( $mode, $math_style, $slevel
	    , "\\widetilde{$over}$supsub") , $after)
    } else { "<ABOVE SYM=\"TILDE\">$over</ABOVE>$_" }
}

## Stacking Symbols

sub do_math_cmd_stackrel {
    local ($_) = @_;
    local($top,$bot);
    $top = &get_next_token(1);
    $bot = &get_next_token(1);
    if ($NO_SIMPLE_MATH) { 
	local($after) = $_;
	( &process_math_in_latex( $mode, $math_style, $slevel
	    , "\\;\\stackrel{$top}{$bot}\\;") , $after)
    } else { "<BOX>$2</BOX><SUP ALIGN=\"CENTER\">$top</SUP>$_" }
}

# Kill $ref_before in case we're not in math mode.
sub do_math_cmd_atop {
    local ($before) = $ref_before;
    $before =~ s/^[\s%]*//; $before =~ s/[\s%]*$//;
    $ref_before = "";
    $failed = 1 if ($NO_MATH_MARKUP);
    "<BOX>$before<ATOP>$_[$[]</BOX>";
}

sub do_math_cmd_choose {
    local ($before) = $ref_before;
    $before =~ s/^\s*//; $before =~ s/\s*$//;
    $ref_before = "";
    $failed = 1 if ($NO_MATH_MARKUP);
    "<BOX>$before<CHOOSE>$_[$[]</BOX>";
}
sub do_math_cmd_binom { &do_math_cmd_choose(@_) }

sub do_math_cmd_mbox {
    local($_) = @_;
    local($cmd,$text,$after)=('mbox','','');
    $text = &missing_braces
	unless ((s/$next_pair_pr_rx[\s%]*/$text = $2;''/eo)
		||(s/$next_pair_rx[\s%]*/$text = $2;''/eo));

    # incomplete macro replacement
    if ($text =~ /(^|[^\\<])#\d/) { return($_) }

    if ($NO_SIMPLE_MATH) {
	$after = $_;
	if (!($text)||($text =~ /^\s*$/)) { ("\&nbsp; ", $after) }
	elsif (!($text =~ 
	    /tex2html_wrap_inline|^(($O|$OP)\d+($C|$CP))?\$|\$(($O|$OP)\d+($C|$CP))\4\$/)) { 
	    $text =~ s/$OP(\d+)$CP/$O$1$C/g;
	    if ($text =~ /\$/) {
	    	$_ = $text;
	    	$text = &wrap_math_environment;
	    }
	    $text = &translate_environments("${O}1$C$text${O}1$C") if $text;
	    $text = &translate_commands($text) if ($text =~ /\\/);
	    $text =~ s/ $/;SPMnbsp;/; # preserve trailing spaces
	    ($text, $after)
	} else {
	    ( &process_math_in_latex( $mode, $math_style, $slevel
	    , "\\mbox{$text}") , $after)
	}
    } else { "<TEXT>$text</TEXT>$_" }
}

sub do_math_cmd_display {
    $_[$[];
}

sub do_math_cmd_text {
    $_[$[];
}

sub do_math_cmd_script {
    $_[$[];
}

sub do_math_cmd_scriptscript {
    $_[$[];
}

# This is supposed to put the font back into math italics.
# Since there is no HTML equivalent for reverting 
# to math italics we keep track of the open font tags in 
# the current context and close them.
# *** POTENTIAL ERROR ****#  
# This will produce incorrect results in the exceptional
# case where \mit is followed by another context
# containing font tags of the type we are trying to close
# e.g. {a \bf b \mit c {\bf d} e} will produce
#       a <b> b </b> c   <b> d   e</b>
# i.e. it should move closing tags from the end 
sub do_math_cmd_mit {
    local($_, @open_font_tags) = @_;
    local($next);
    for $next (@open_font_tags) {
	$next = ($declarations{$next});
	s/<\/$next>//;
	$_ = join('',"<\/$next>",$_);
    }
    $_;
}



$ams_aligned_envs_rx = "((\\w*align\\w*|gather\\w*|split|multline|array|cases)(\\*|star)?)";
$space_commands_rx = "(\\\\(q+uad|[,; ]|hs(kip|pace)(($O|$OP)\\d+($C|$CP))[^<]+\\4)|\\s)*";

sub translate_math_commands {
    local($mode,$style,$face,$slevel,$_) = @_;
    local($pre_text, $labels);
    if ($NO_MATH_PARSING) {
	s/\\\n/\\ \n/g;
    	if ($_ =~ /$space_commands_rx\\(text|mbox)\b/) {
	    $pre_text = $`; $_ = $& . $';
            # Do not split if inside any kind of grouping
	    local($pre_test,$use_all)=($pre_text,'');
	    while ($pre_test =~ s/(($O|$OP)\d+($C|$CP))(.*)\1/$4/) {}
	    $use_all = 1 if ($pre_test=~s/($O|$OP)\d+($C|$CP)//);
	    if (!$use_all) {
	        while ($pre_test =~ s/\\begin(($O|$OP)\d+($C|$CP))(.*)\\end\1/$4/){};
		$use_all = 1 if ($pre_test=~s/\\(begin|end)($O|$OP)\d+($C|$CP)//);
	    };
	    if (!$use_all) {
	        local($gp_cnt) = 0;
		$pre_test =~ s/\\left\b/$gp_cnt++;''/eg;
		$pre_test =~ s/\\right\b/$gp_cnt--;''/eg;
		$use_all = 1 if $gp_cnt;
            };
	    if ($use_all) { $pre_text .= $_ ; $_ = '' };
    	} else {
	    $pre_text = $_; $_ = '';
    	}

	($pre_text,$labels) = &extract_labels($pre_text);
	local($savedRS) = $/; $/ = '';
#	if ($pre_text =~ m/^((.|\n)*)\\begin\s*(($O|$OP)\d+($C|$CP))$ams_aligned_envs_rx\3/m) {
	if ($pre_text =~ m/^()\\begin\s*(($O|$OP)\d+($C|$CP))$ams_aligned_envs_rx\3/m) {
	    local($env,$star,$orig,$cnt) = ($7,$8,$pre_text.$_,1);
	    local($this_env,$pre_pre_text, $post_pre_text,$found) = ('', $1, $'.$_ , 1);
	    $pre_text = $_ = '';
#	    local($savedRS) = $/; $/ = ''; $*=1;
	    while ( $cnt && $found ) {
		$found = '';
		if ($post_pre_text =~ /\\(begin|end)(($O|$OP)\d+($C|$CP))$env$star\2/sm)
		    { $pre_text .= $`; $found = $1;
		      $this_env = $&; $post_pre_text = $'; }
		if ($found =~ /begin/) {
		    $cnt++; $pre_text .= $this_env;
		} elsif ($found =~ /end/) {
		    $cnt--; $pre_text .= $this_env if ($cnt > 0) ;
		}
	    }
	    $/ = $savedRS;
	    $env .= 'star' if $star;
	    local($env_cmd) = 'do_env_'.$env;
	    # parse it further, when possible...
	    if ((defined &$env_cmd) && !$cnt) {
		$_ = $post_pre_text . $_;
		$pre_text = join( '', $labels
		    , &$env_cmd($pre_text)
		    , (($_)? &translate_math_commands($mode
		         ,$style,$face,$slevel,$_):'')
		    );
		return( $pre_pre_text . $pre_text );
	    }
	    # ...else put it back inside a {displaymath} for an image
	    if ($cnt) { $orig .= $_; $_ = ''; }
	    local($math_env) = 'displaymath';
	    $math_env = $outer_math if ($outer_math =~ /^subequations/);
	    $pre_text = join('', '\begin{',$math_env,'}'
			, $orig ,'\end{',$math_env,'}' );
	    local($after_undef) = $_;
	    $pre_text = &process_undefined_environment(
		$math_env, ++$global{'max_id'}, $orig);
	    $_ = $after_undef;
	} else {
	    $pre_text = &process_math_in_latex($mode,$style,$slevel,$pre_text)
		if ($pre_text);
	}
	$/ = $savedRS;
	return($labels . $pre_text) unless ($_);

	local($post_text, $this_text, $which_text);
	if (/^$space_commands_rx\\(text|mbox)\b(($O|$OP)\d+($C|$CP))/){
	    local($end_text) = $8; $which_text = $7;
	    $post_text = $';
	    $pre_text .= ";SPMnbsp; ;SPMnbsp;" if ($1);
	    if ($post_text =~ /$end_text/) {
		$post_text = $'; $this_text = $`;
		if ($which_text =~ /mbox/) {
		    $this_text = join('',$end_text,$this_text,$end_text);
		    ($this_text) = &do_math_cmd_mbox($this_text);
		} else {
		    $this_text = &translate_environments($this_text);
		    $this_text = &translate_commands($this_text);
		}
		$post_text = &translate_math_commands( $mode
		    ,$style,$face,$slevel,$post_text) if ($post_text);
	    }
	    $pre_text = join('', $pre_text, $this_text, $post_text);
	    return($labels . $pre_text);
	}
	if ($pre_text) {
	    $_ = join('', $labels , $pre_text ,
		&translate_math_commands($mode,$style,$face,$slevel,$_));
	} else {
	    $_ = join('', $labels , $pre_text ,
		&process_math_in_latex($mode,$style,$slevel,$_));
        }
	return($_);
    }
    &replace_strange_accents;
    for (;;) {			# For each opening bracket ...
	last unless (/$begin_cmd_rx/o);
	local($before, $contents, $br_id, $after, $pattern);
	($before, $br_id, $after, $pattern) = ($`, $1, $', $&);
	local($end_cmd_rx) = &make_end_cmd_rx($br_id);
	if ($after =~ /$end_cmd_rx/) { # ... find the the matching closing one
	    $NESTING_LEVEL++;
	    ($contents, $after) = ($`, $');
	    $_ = join("", $before,"$OP$br_id$CP", $contents,"$OP$br_id$CP", $after);
	    $NESTING_LEVEL--;
	}
	else {
	    $pattern = &escape_rx_chars($pattern);
	    s/$pattern//;
	    print STDERR "\nCannot find matching bracket for $br_id";
	}
    }
#    &parse_math_toks($mode,$style,$face,$slevel,1,$_);
    &process_math_toks($mode,$style,$face,$slevel,1,$_);
}


sub make_math_comment{
    local($_) = @_;
    local($scomm,$ecomm)=("\$","\$");
    return() if (/$image_mark/);
    do {
	$scomm = "\\begin{$env}\n";
	$ecomm = "\n\\end{$env}";
    } unless ($env =~/tex2html/);
    $_ = &revert_to_raw_tex;
    s/^\s+//; s/\s+$//m;
    $_ = $scomm . $_ . $ecomm;
    return() if (length($_) < 12);
    $global{'verbatim_counter'}++;
    $verbatim{$global{'verbatim_counter'}} = $_;
    &write_mydb('verbatim_counter', $global{'verbatim_counter'}, $_ );
    join('', $verbatim_mark, '#math' , $global{'verbatim_counter'},'#')
} 

sub process_math_env {
    local($mode,$_) = @_;
    local($labels, $comment);
    ($_,$labels) = &extract_labels($_); # extract labels
    $comment = &make_math_comment($_);
    local($max_id) = ++$global{'max_id'};
    if ($failed) { return($labels, $comment, $_) };
    $_ = &protect_array_envs($_);
    if ($BOLD_MATH) {
        ($labels, $comment
            , join('','<B>',&make_math($mode,'','',$_),'</B>'))
    } else { ($labels, $comment, &make_math($mode,'','',$_)) }
}

sub process_math_toks {
    if ($NO_MATH_PARSING) {
	local($mode,$style,$face,$slevel,$math_outer,$_) = @_;
	if (/(aligned|gathered|alignedat|split)/) {
#print "\n***SPECIAL AMS:\n$_\n";
	}
	$_ = &process_math_in_latex($mode,$style,$slevel,$_);
	return($_);
    }
    &parse_math_toks(@_);
}
	
sub parse_math_toks {
    local($mode,$style,$face,$slevel,$math_outer,$_) = @_;
    local($pre,$keep,$this,$cmd,$tmp);
    local($lastclosespace, $joinspace) = (1,1);
    $face = "I" unless (($face)||($slevel));  # default text is italiced
    $face =~ s/math//;
    local($afterint) = 0;    # device to detect integral d
    print "\$";
    print STDERR "\nMATH_IN:$_" if ($VERBOSITY > 4);
    while (
	/[\s%]*(\\([a-zA-Z]+|.)|$image_mark#[^#]+#|(<#\d*#>)|(<[^>]*>)(#math\d+#)?|\^|\_|&[a-zA-Z]+;|;SPM[a-z]+;|&)/
	) {
	$lastclosespace = 1; $joinspace=1;
	#  $keep  holds the results from processed tokens
	#  $pre  should be all simple letters and other characters
	$pre = $`;
	#  $_  holds the tokens yet to come
	$_ = $';
	#  $this  holds the current token
	$this = $1;
	if ($4) {
	    # tags already processed from an earlier cycle
	    #    includes math-comment markers
	    $this = $4.$5;
	    $lastclosespace = 0; $joinspace=0;
	} elsif ($3) {
	    # an opening brace
	    local($br_idm) = $3;
	    $_ = $br_idm.$_;
	    if (s/$next_pair_pr_rx/$br_idm=$1; $this=$2;''/eo) {
		$this =~ s/^\s*//; $this =~ s/\s*$//;
	    } else {
		s/$br_idm//;
		print "\n ** ignoring unmatched brace $br_idm in math **\n";
		$this = ''; $br_idm = '';
	    }

	    # if there is \atop.. or \over.. then make an image
	    # Better would be to create a table after establishing 
	    # the minimum number of tokens involved...
	    #    ...but that's getting pretty complicated.
	    if ($this =~ /\\(atop|over([^a-zA-Z]|withdelims))/) {
		print ".";
		print STDERR "$1" if ($VERBOSITY > 2);
		$this = "{".$this."}";
		$this .= &get_supsub;
		$this = &process_math_in_latex($mode, $style, $slevel,$this);
		$lastclosespace = 0;
	    } else {
		local($extra) = &get_supsub;
# contents of $extra may require an image !!
		# revert the brace-pairs
		if ($extra =~ /{|}/) { 
		    &mark_string($extra);
		    $extra =~ s/$O(\d+)$C/$OP$1$CP/g;
		}
		$this .= $extra; undef $extra;
		# otherwise the braces may delimit style-changes...
		do{
		    local(@save_open_tags) = @$open_tags_R;
		    local($open_tags_R) = [ @save_open_tags ];
		    local($env_id) = $br_idm;
		    $this = &parse_math_toks($mode,$style,$face,$slevel,0,$this);
#		    $this .= &balance_tags();
		    undef $open_tags_R; undef @save_open_tags;
		};
		# ...perhaps deliberate, to suppress space.
		$lastclosespace = 0; $joinspace=0;
	    }
	} elsif (($2) && $new_command{$2}) {
	    # macro-replacement required
	    print "\nReplacing \\$2 " if ($VERBOSITY > 5);
	    do {
		local($cmd,$after) = ($2,$_);
		$_ = &substitute_newcmd;
		print " with: $_\n" if ($VERBOSITY > 5);
		$_ .= $after;
		undef $cmd; undef $after;
	    };
	    $this = '';
	} elsif (($2) && ($2 =~/^latex$/)) { # discard the argument
	    $this = &missing_braces unless (
            	(s/$next_pair_pr_rx\s*/$this = $2;''/eo)
		||(s/$next_pair_rx\s*/$this = $2;''/eo));
	    $this = '';
	} elsif (($2) && ($2 =~/(acute|breve|check|grave)$/)) {
	    # accented characters, not implemented separately
	    print ".";
	    print STDERR "$1" if ($VERBOSITY > 2);
	    $this .= join('', "{", &get_next_token(1), "}");
	    $this .= &get_supsub;
	    $this = &process_math_in_latex($mode, $style, $slevel,$this);
	} elsif (($2) && ($2 =~/^end$/)) {
	    s/^\s*(<[<#]\d+[#>]>)[^<>]*\1//o;
	    $this = '';
	} elsif (($2) && ($2 =~/^begin$/)) {
	    # embedded environment; e.g.  tex2html_wrap 
	    if (s/^\s*<([<#])(\d+)([#>])>(tex2html_(deferred|wrap(\w*)))<\1\2\3>//so) {
		$this = '';	        
	    } elsif (s/^\s*(<[<#](\d+)[#>]>)($array_env_rx)(\*|star)?\1//so) {
	        print ".";
	        print STDERR "$4$9" if ($VERBOSITY > 2);
	        # make image, including any sup/sub-scripts
	        local($id,$env,$star) = ($2,$3,$8);
	        $this = "\\begin".$&;
	        local ($saved) = $_;
	        $_ = $';
	        # find the \end, including nested environments of same type.
	        local($cnt, $thisbit, $which) = (1,'','');
	        while ( /\\(begin|end)(<#\d+#>)($env|$array_env_rx)(\*|star)?\2/sm ) {
		   $thisbit = $` . $&; $_ = $'; $which = $1;
		   do {
		        # mark rows/columns in nested arrays
		        $thisbit =~ s/;SPMamp;/$array_col_mark/gm;
		        $thisbit =~ s/\\(\\|cr(cr)?(\b|$|\d|\W))/$array_row_mark$3/gm;
		   } if ($cnt > 1);
		   $this .= $thisbit;
	            if ($which =~ /begin/) {$cnt++} else {$cnt--};
	            last if (!$cnt);
	        }

#		$this =~ s/\\cr(cr)?(\b|$|\d|\\|\W)/\\\\$2/g;
	        local($env_cmd) = "do_env_$env".(($star)? "star" : '');
	        if ($cnt) {
		   print "\n *** cannot find end of environment: $this ";
		   &write_warnings("\n *** failed to find \\end for: $this ");
	            $this = ''; $_ = $saved;
#		} elsif ($env =~ /^tex2html_wrap_(inline)?$/) {
#		    $this =~ 
#	s/^\\begin(($O|$OP)\d+($C|$CP))$env\1\s*|\\end(($O|$OP)\d+($C|$CP))$env\4\s*$//sg;
#		    $_ = $this.$_; $this = '';
		} elsif ($env =~ /^array/) {
		    local($extra) = &get_supsub;
		    if (($in_array)||($extra)||($pre)||($keep)) {
			$this .= $extra;
			$this = &process_math_in_latex($mode,$style,$slevel,$this);
		    } else { 
			$star =~ s/\*/\\\*/om if ($star);
			$this =~ s/^\\begin(<#\d+#>)$env$star\1//m;
			$this =~ s/\\end(<#\d+#>)$env$star\1\s*$//m;
			do {
			    local($in_array) = 1;
			    local($_) = $this;
			    $this = &do_env_array($this);
			};
		    }
		} elsif (defined &$env_cmd) {
		    $star =~ s/\*/\\\*/o if ($star);
		    $this =~ s/^\\begin(<#\d+#>)$env$star\1//;
		    $this =~ s/\\end(<#\d+#>)$env$star\1\s*$//;
		    local($contents) = $_;
		    $this =  &$env_cmd($this);
		    undef $contents;
		} else {
		    $this .= &get_supsub;
		    $this = &process_math_in_latex($mode,$style,$slevel,$this);
		};
		undef $cnt;
	    } else {
		#RRM: revert brace-processing, else translation loops
		s/$OP(\d+)$CP/$O$1$C/g;
		$this = '';
		do {
		    $_ = '\begin'.$_;  $_ =~ s/^$begin_env_rx//;
		    local($env, $mpat, $inner_math) = ($5, $&, $mode);
		    &find_end_env($env,$this,$_);
		    s/$O(\d+)$C/$OP$1$CP/g;

		    local($br_id) = ++$global{'max_id'};
		    $this .= "\\end$O$br_id$C$env$O$br_id$C";

		    if ($env =~ /$ams_aligned_envs_rx/) {
			do {
			    $NO_MATH_PARSING = 1; # $inner_math = '';
			    $this = &make_math($mode,$style,$face,$mpat.$this);
			    $NO_MATH_PARSING = '';
			};
		    } else {
			$this = &translate_environments($mpat.$this);
			$this = &translate_commands($this) if ($this =~ /\\/);
			s/$O(\d+)$C/$OP$1$CP/g;
		    }
		    undef $env; undef $mafter; undef $mpat; undef $inner_math;
		};
	    }
	} elsif (($2) && ($2 =~ /(\{|\}|\%|\|)/ )) {
             $this = $1;
	} elsif (($2) && ($2 =~ /\w+/)) {
	    # macro or math-entity
	    $cmd = $&; 
	    print ".";
	    print STDERR "$cmd" if ($VERBOSITY > 2);
	    local($dum1, $dum2) = ($cmd, '');
	    $dum1 = $cmd unless ($dum1 = &normalize($dum1, $dum2));
	    local($mtmp, $ctmp, $wtmp) = 
		("do_math_cmd_$dum1","do_cmd_$dum1", "wrap_cmd_$dum1");
	    if ($cmd =~/color/) {
		do {
		    local($color_env,$inside_math) = ($color_env,1);
		    local(@save_open_tags) = @$open_tags_R;
		    $open_tags_R = [];
		    ($this, $_) = &$ctmp($_);
		    $this = &parse_math_toks($mode,$style,$face,$slevel,1,$this);
		    $open_tags_R = [ @save_open_tags ];
		    undef $color_env; undef $inside_math; undef @save_open_tags;
		};
	    } elsif ($cmd eq 'left') {
		#expandable delimiter: make an image
		$this = "\\$cmd";
		local($blevel, $delim, $lfence, $rfence) = (1,'','','');
		$delim = &get_next_token();
		$lfence = $this . $delim; $this = '';
		while (($blevel)&&(/(\\(left|right))([^a-zA-Z])/)) {
		    $this .= $`.$1; $_ = $3.$';
		    if ($2 =~ /left/) { $blevel++ }
		    else { $blevel-- }
		}
		$this =~ s/(\\right)$/$rfence=$1;''/e;
		local($mfence) = $this;
		local($fenced) = $this;
		$mfence =~ s/>\\par\\/>\\phantompar\\/g; # else \mathpalette fails
		$delim = &get_next_token(); $rfence .= $delim;
		if ($blevel) {
		    print STDERR "\n *** unclosed \\left$delim  starting:\n$this$_\n\n";
		    &write_warnings("\nunclosed \\left$delim  found");
		}
		undef $blevel;
		undef $delim;

		# make an image of the left-fence
		$this = &process_math_in_latex($mode,$style,$slevel
		    , "$lfence\\vphantom{$mfence}\\right.")
			unless ($lfence eq '.');
		#parse the  math for the contents, as if in an array-env
		do { local($in_array) = 1;
		    $infence = &parse_math_toks($mode,$style,$face,$slevel,1,$fenced);
		    # and remove any paragraphing that may wrap the math contents.
		    $infence =~ s/^<P[^>]*>|<BR[^>]*>(\s*<P>\s*)?$//g;
		    $this .= $infence;
		};
		# make an image of the right-fence
		local($endthis) = "\\left.\\vphantom{$mfence}$rfence";
		# include any super/sub scripts, to position them correctly
		local($rsub) = &get_supsub;
		$endthis .= $rsub;
		$this .= &process_math_in_latex($mode,$style,$slevel,$endthis)
		    unless (($rfence =~ /\.$/) && !$rsub);
		$lastclosespace = 0;
		undef $endthis; undef $rsub; undef $infence; undef $in_array;
	    } elsif ($cmd =~ /^brace(vert|[rl][ud])$/) {
		$this = $cmd; $this .= &get_supsub;
		$this = &process_math_in_latex($mode,$style,$slevel,"\\$this");
	    } elsif ($cmd =~ /(b|p)(m)?od$/) {
		local($pod) = $2;
		if ($cmd =~ /p/) {
	             $this = &get_next_token();
		    $this = &parse_math_toks($mode,$style,$face,$slevel,1,$this);
		    $this = "(".(($pod)? "mod " : '')."$this)";
		} elsif (/^\s*\w/) { 
	             $this = " mod ";
		}else { $this = " mod" }
	    } elsif ($cmd =~ /^(t|d)?frac$/) {
	        ($this, $_) = &do_math_cmd_frac($_);
	    } elsif ($cmd =~ /^(cases|matrix)$/) {
   		$this = &missing_braces unless (
		    (s/$next_pair_pr_rx\s*/$this = $&;''/eo)
		    ||(s/$next_pair_rx\s*/$this = $&;''/eo));
		$this .= &get_supsub;
		$this = &process_math_in_latex($mode,$style,$slevel,"\\$cmd$this");
	    } elsif ($cmd =~ /^(under|over|side)set$/) {
   		# from AMS-math packages
   		$this = &missing_braces unless (
		    (s/$next_pair_pr_rx\s*/$this = $&;''/eo)
		    ||(s/$next_pair_rx\s*/$this = $&;''/eo));
   		$this .= &get_next_token();
#   		$this .= &missing_braces unless (
#		    (s/$next_pair_pr_rx\s*/$this .= $&;''/eo)
#		    ||(s/$next_pair_rx\s*/$this .= $&;''/eo));
		if ($cmd =~ /side/) {
		    s/\s*\\\w+/$this .= $&;''/e;
		    $this .= &get_supsub;
		}
		$this = &process_math_in_latex($mode,$style,$slevel,"\\$cmd$this");
	    } elsif ($cmd =~ /^raisebox$/) {
   		$this = &missing_braces unless (
		    (s/$next_pair_pr_rx\s*/$this = $&;''/eo)
		    ||(s/$next_pair_rx\s*/$this = $&;''/eo));
		local($arg, $pat) = &get_next_optional_argument;
   		$this .= $pat;
		($arg, $pat) = &get_next_optional_argument;
   		$this .= $pat;
   		$this .= &missing_braces unless (
		    (s/$next_pair_pr_rx\s*/$this .= $&;''/eo)
		    ||(s/$next_pair_rx\s*/$this .= $&;''/eo));
		undef $arg; undef $pat;
		$this = &process_math_in_latex($mode,$style,$slevel,"\\$cmd$this");	    
	    } elsif ($cmd =~ /^choose|binom$/) {
   		$this = &missing_braces unless (
		    (s/$next_pair_pr_rx\s*/$this = $&;''/eo)
		    ||(s/$next_pair_rx\s*/$this = $&;''/eo));
   		$this .= &missing_braces unless (
		    (s/$next_pair_pr_rx\s*/$this .= $&;''/eo)
		    ||(s/$next_pair_rx\s*/$this .= $&;''/eo));
		$this .= &get_supsub;
		$this = &process_math_in_latex($mode,$style,$slevel,"\\$cmd$this");	    
	    } elsif ($cmd =~ /^$var_sized_ops_rx|$var_limits_rx$/) {
		# entities generally come out too small for these
		$this = $cmd . &get_supsub;
		$this = &process_math_in_latex($mode,$style,$slevel,"\\$this");
		$lastclosespace = 0;
		if ($cmd =~ /^(o|i+|idots)?int$/) { $afterint++; }
	    } elsif (defined &$mtmp) {
		if ( grep(/\b$cmd\b/, @mathfunctions)
		    || grep(/\b$cmd\b/, @limitfunctions)) {
		    # it's a named function, to be set in upright text.
		    $this = "$cmd";
		    local($orig) = $_;
		    local($supsub) = &get_supsub;
		    if ($supsub =~ /^\\limits/) {
			undef $orig;
			# let LaTeX handle the vertical alignment
			$this = &process_math_in_latex($mode,$style,$slevel
				      , "\\$cmd$supsub" );
		    } elsif (($supsub)&&(grep(/\b$cmd\b/, @limitfunctions))) {
			undef $orig;
			# vertical alignment is implicit, use LaTeX
			$this = &process_math_in_latex($mode,$style,$slevel
				      , "\\$cmd$supsub" );
		    } elsif ($supsub) {
# contents of $supsub may require an image !!
			# parse the sup/subscripts
			$_ = $orig; undef $orig;
		    } elsif (/^\s*\w/) {
			# ...else just put in the name + a space.
			$this .= "\&nbsp;"; undef $orig;
		    } else  {
			# ...else just put in the name, no space needed.
			undef $orig;
		    }
		    undef $supsub;
		} elsif ($cmd =~ /^(circ)$/) {
		    if ($_ =~ /^$/) {$this = "\&cir;"} # ...\degrees 
		    else { $this = " \&cir; " }  # ... as a binary relation
		} elsif ($cmd =~ /^text$/) {
		    $this = &missing_braces unless (
		        (s/$next_pair_pr_rx\s*/$this = $2;''/eo)
		        ||(s/$next_pair_rx\s*/$this = $2;''/eo));
		    $this =~ s/$OP/$O/og; $this =~ s/$CP/$C/og; 
		    $this = &translate_environments($this);
		    $this = &translate_commands($this) if ($this =~ /\\/);
		} elsif ($cmd =~ /^h?phantom$/) {
		    $this = &missing_braces unless (
		        (s/$next_pair_pr_rx\s*/$this = $2;''/eo)
		        ||(s/$next_pair_rx\s*/$this = $2;''/eo));
		    #reduce all control sequences to a single character.
		    $this =~ s/\\\w+/A/g; $this =~ s/\\./A/g;
		    #approximate width with hard-spaces.
		    $this = ";SPMnbsp;" x length($this);
		} elsif ($cmd =~ /^${var_sized_ops_rx}$/) {
		    # entities generally come out too small for these
		    $this = $cmd . &get_supsub;
		    $this = &process_math_in_latex($mode,$style,$slevel,"\\$this");
		    $lastclosespace = 0;
		    if ($cmd =~ /^o?int$/) { $afterint++; }
		} else {
		    # do what comes naturally ...
		    ($this, $_) = &$mtmp($_); s/^\s+//;
		    # if not a box and doesn't return a pair, then add it to $_
		    # the result should be separated off in subsequent cycles.
		    if (($this)&&(! $_)&&(!$cmd =~ /box/))
		        { $_= $this; $this ='' };
		}
	    } elsif (($mathentities{$cmd})||($latexsyms{$cmd})) {
		$ent = ($mathentities{$cmd} || $latexsyms{$cmd});
		do {
		    local($cset) = "${CHARSET}_character_map{$ent}";
		    $cset =~ s/\-/_/go;
		    local($char); eval "\$char = \$$cset";
		    do {
			$cset = "${CHARSET}_character_map{$cmd}";
			$cset =~ s/\-/_/go; eval "\$char = \$$cset";
			$ent = $cmd if ($char);
		    } unless ($char);
		    $this = ($char ? $char : ''); undef($char);
		};
		if ($this) {
		    # do we want the character-code ...
		    if ($USE_ENTITY_NAMES) {
			# ...or the entity ?
			$this = ";SPM$ent;";
		    }
		    if ($greekentities{$cmd}) {
		        # italicise greek symbols
		        $this = "<I>$this</I>";
		    }
		} elsif ($cmd =~ /^(en|l?dots|gt|lt|times|div|mid|vert|parallel|ast)$/) {
		    # standard entity
		    $this = &get_supsub;
		    if ($this) {
		        $this = &process_math_in_latex($mode,$style,$slevel
		            ,"\\$cmd$this" );
		    } else {
		        $this = "\&$cmd;";
		    }
		} elsif ($cmd =~ /^(l|r)brac(k|e)$/) {
		    $this = $ord_brackets{$1.$2};
		} elsif ($cmd =~ /^cdot(s)?$/) {
		    $this = join('',"<SUP> \.",(($1)? "\.\." : '')," <\/SUP>");
		} elsif ($cmd =~ /^l?dot(s)?$/) {
		    $this = "\. ".(($1)? "\.\." : '')." ";
		} elsif ($cmd =~ /^backslash$/) {
		    $this = "\&#92;";
		} elsif ($mathnomacros{$cmd}) {
		    # standard entity, no-macro needed
		    $cmd = $mathnomacros{$cmd};
		    $this = &get_supsub;
		    if ($this) {
		        $this = &process_math_in_latex($mode,$style,$slevel
		            ,"\\textrm{$cmd}$this" );
		    } else {
		        $this = "$cmd";
		    }
		} else {
		    if ($cmd =~ /^int$/) { $afterint++; }
		    # need an image
		    $this = &get_supsub;
		    $this = &process_math_in_latex($mode,$style,$slevel,"\\$cmd$this" );
		    # relations, known to need more space
		    $this = " $this "
			if ($cmd =~ /$binary_ops_rx|$binary_rels_rx|$arrow_rels_rx/);
		}
	    } elsif (defined &$wtmp) {
		if ($cmd =~ /^(math(bb|cal|sf|sfsl)|cal)$/) {    # not accessible !!
		    # make images of these, including any sup/sub-scripts
		    $this = &missing_braces unless (
			(s/$next_pair_pr_rx\s*/$this = $2;''/e)
			||(s/$next_pair_rx\s*/$this = $2;''/e));
		    $this = "\{".$this."\}";
#		    $this .= &get_supsub;
		    $this = &process_math_in_latex($mode,$style,$slevel,"\\$cmd$this" );	
		} elsif (defined &$ctmp) {
		    # do what comes naturally ...
		    ($this, $_) = &$ctmp($_);
		    if (($this =~/\\/)||!($_)) {$_= $this; $this ='' };
		} else {
		    # make an image of all of it
#		    $this = &missing_braces
#			unless ((s/$next_pair_pr_rx\s*//o)&&($this = "{$2}"));
#		    $this .= &get_supsub;
		    $this = &process_math_in_latex($mode,$style,$slevel,"\\$cmd$_" );
		    $_ = '';
		}
	    } elsif ($cmd =~ /big+[lrm]?$/i ) {
		s/\s*(\\(\W|[a-zA-Z]+)|\W)/$this=$1;''/eo;
		$this .= &get_supsub;
		$this = &process_math_in_latex($mode,$style,$slevel,"\\$cmd$this" );
		$lastclosespace = 0; $joinspace=0;
	    } elsif ($cmd =~ /big(\w+)/ ) {
		local($tmpname) = $1;
		if (($mathentities{$tmpname})||($latexsyms{$tmpname})) {
		    # big version standard entity
		    $this = &get_supsub;
		    $this = &process_math_in_latex($mode,$style,$slevel,"\\$cmd$this" );
	        } else {
		    # need an image
		    $this = &get_supsub;
		    $this = &process_math_in_latex($mode,$style,$slevel,"\\$cmd$this" );
		    # relations, known to need more space
		    $this = " $this "
			if ($tmpname =~ /$binary_ops_rx|$binary_rels_rx|$arrow_rels_rx/);
		}

	    } elsif ($cmd =~ /begin$/) {
		local ($contents, $before, $br_id, $env, $after, $pattern);
		if ( s/^$begin_env_rx//o ) {
		    local ($contents, $before, $br_id, $env, $after, $senv);
		    ($before, $br_id, $env, $after, $senv) = ($`, $1, $2, $', $&);
		} else { print "\n *** badly formed $cmd *** "; }
		if (&find_end_env($env,$contents,$after)) {
		    local($eenv) = "\\end$O$br_id$C";
		    $this = &translate_environments($senv.$contents.$eenv);
		} else { print "\n *** badly formed environment in math ***"  }
		$_ = $after;
	    } elsif ($cmd =~ /^not$/) {
		$this = &get_next_token();
		$this = " ".&process_math_in_latex($mode,$style,$slevel,"\\$cmd$this" );
	    } elsif ($cmd =~ /(display|text|(script)+)style$/) {
		if ($1 =~ /scriptscript/) {
		    $this = ""; # $slevel = 2; $this = "";
		    $pre .= "<SMALL><SMALL>";
		    $_ .= "</SMALL></SMALL>";
		} elsif ($1 =~ /script/) {
		    $this = ""; # $slevel = 1; $this = "";
		    $pre .= "<SMALL>";
		    $_ .= "</SMALL>";
		} elsif ($slevel) {
		    if ($1 =~ /display/) { $mode = "display" }# ; $slevel = 0 }
		    elsif ($1 =~ /text/) { $mode = "inline"  }# ; $slevel = 0 }
		    $this = "";  # &process_math_in_latex($mode,$style,0,$_);
		    $pre .= "<BIG>"; $_ .= "</BIG>";
		} elsif ($1 =~ /display/) { 
		    $mode = "display";  $this = ''; # $slevel = 0; $this = '';
		} elsif ($1 =~ /text/) { 
		    $mode = "inline"; $this = ''; # $slevel = 0; $this = '';
		}
	    } elsif (defined &$ctmp) {
		if ($cmd =~ /(bm|boldsymbol|(text|math)?(rm|tt|bf|it))$/) {
		    # simulate these with ordinary fonts
		    $this = &missing_braces
		        unless ((s/$next_pair_pr_rx\s*/$this = $2;''/oe)
		            ||(s/$next_pair_rx\s*/$this = $2;''/oe));
		    $this = &parse_math_toks($mode,$style
		        ,$cmd,$slevel,$math_outer,$this);
		    if ($cmd =~ /tt/)    { 
		        $this =~ s/<(\/)?tt>/<$1TT>/g
		    } elsif ($cmd =~ /bf|bm|boldsymbol/) {
		        $this =~ s/<(\/)?($cmd|bf)>/<$1B>/g;
		    } elsif ($cmd =~ /it/) {
		        $this =~ s/<(\/)?($cmd|it)>/<$1I>/g
		    } elsif ($cmd =~ /rm/) { 
		        $this =~ s/<(\/)?($cmd|rm)>//g
		    }
		    $this =~ s/\s+$//; # remove trailing space
	        } elsif ($cmd =~ /^text$/) {
		    $this = &missing_braces
		        unless ((s/$next_pair_pr_rx\s*/$this = $2;''/oe)
		            ||(s/$next_pair_rx\s*/$this = $2;''/oe));
		    $this = &translate_environments($this);
		    $this = &translate_commands($this);
                } elsif ($cmd =~ /^math(op(en)?|ord|bin|rel|punct|close)/io) {
		    # explicit math-class
		    local($mtype,$orig,$supsub) = ($1,'');
		    # get the contents
		    $this = &missing_braces unless (
			(s/$next_pair_pr_rx\s*/$this = $2;''/oe)
			||(s/$next_pair_rx\s*/$this = $2;''/oe));
		    # see if there are sup/sub-scripts
		    local($orig) = $_;
		    local($supsub) = &get_supsub;
		    if (($mtype =~/^op$/i) && ($supsub =~ /^\\limits/)) {
			# need an image for the vertical alignment
			undef $orig;
			do {
			    $this = "${O}0$P$this${O}0$P";
			    &make_unique($this);
			    };
			$this = " ". &process_math_in_latex($mode,$style
		                ,$slevel,"\\$cmd$this$supsub" );
		    } elsif (($mtype =~/^close$/i) && ($supsub)) {
		        # need an image for the sup/sub placement
		        undef $orig;
			do {
			    $this = "${O}0$P$this${O}0$P";
			    &make_unique($this);
			    };
			$this = " ". &process_math_in_latex($mode,$style
		                ,$slevel,"\\$cmd$this$supsub" );
		    } else {
			$_ = $orig; undef $orig;
			$this = &parse_math_toks($mode,$style
			        ,'',$slevel,'',$this);
			$this =~ s/^\s*|\s*$//go;
			$this = " ".$this unless ($mstyle =~ /ord/i);
			$this .= " " if (!($supsub)&&($mstyle =~ /bin|rel|punct/i));
		    }
		    undef $supsub;
	        } elsif ($cmd =~ /^operatorname(\*|star|withlimits)?$/) {
		    do {
			local($has_limits);
			$has_limits = 1 if ((s/^\*//)||($cmd=~/limits/));
			$this = &missing_braces
			    unless ((s/$next_pair_pr_rx\s*/$this = $2;''/oe)
				||(s/$next_pair_rx\s*/$this = $2;''/oe));
			local($this_cmd) = "<#0#>".$this."<#0#>";
			local($cmd_name) = $this;
			local($pre_subp) = $_;
			local($cmd_supsub) = &get_supsub; 
			if (($cmd_supsub)&&($has_limits)) {
			    $this_cmd .= $cmd_supsub;
			    $this = &process_math_in_latex($mode,$style,$slevel
				, "\\$cmd$this_cmd" );
			} else {
			    $_ = $pre_subp;
			    $this = &parse_math_toks($mode,$style, "mathrm"
				,$slevel, $math_outer, $cmd_name );
			    $this =~ s/<(\/)?rm>//g;
			}
		    }
		} elsif ($cmd =~ /qopname/) {
		    do{
			$this = &missing_braces
			    unless ((s/$next_pair_pr_rx\s*/$this = $2;''/oe)
				||(s/$next_pair_rx\s*/$this = $2;''/oe));
			local($this_cmd) = "<#0#>".$this."<#0#>";
			$this = &missing_braces
			    unless ((s/$next_pair_pr_rx\s*/$this = $2;''/oe)
				||(s/$next_pair_rx\s*/$this = $2;''/oe));
			$this_cmd .= "<#1#>".$this."<#1#>";
			local($has_limits) = $this;
			$this = &missing_braces
			    unless ((s/$next_pair_pr_rx\s*/$this = $2;''/oe)
				||(s/$next_pair_rx\s*/$this = $2;''/oe));
			$this_cmd .= "<#2#>".$this."<#2#>";
			local($cmd_name) = $this;
			local($pre_subp) = $_;
			local($cmd_supsub) = &get_supsub;
			if (($cmd_supsub)&&!($has_limits =~ /^o$/)) {
			    $this_cmd .= $cmd_supsub;
			    $this = &process_math_in_latex($mode,$style,$slevel
		       		, "\\$cmd$this_cmd" );
			} else {
			    $_ = $pre_subp;
			    $this = &parse_math_toks($mode,$style, "mathrm"
				,$slevel, $math_outer, $cmd_name );
			    $this =~ s/<(\/)?rm>//g;
			}
		    }
		} elsif ($cmd =~ /^(math|cal$)/io) {
		    # catches \mathcal \mathsf \mathbb etc. and \cal
		    $this = &missing_braces unless (
		        (s/$next_pair_pr_rx\s*/$this = $2;''/e)
		        ||(s/$next_pair_rx\s*/$this = $2;''/e));
		    $this = "<#2#>".$this."<#2#>";
#		    $this .= &get_supsub;
		    $this = &process_math_in_latex($mode,$style,$slevel
                            , "\\$cmd $this" );
		} elsif ($cmd =~ /(\w*)space/) {
		    $this = "\&nbsp;";
		    if (($1 =~ /h/)&&((s/$next_pair_pr_rx\s*//)
		            ||(s/$next_pair_rx\s*//)))
			{ $this = " \&nbsp; " }
		} else {
		    # do what comes naturally ...
		    ($this, $_) = &$ctmp($_);
		    if (($this =~/\\/)||!($_)) {$_= $this; $this ='' };
		}
	    } elsif ($newcommand{$cmd}) {
		$_ = &replace_new_command($cmd);
	    } elsif ($cmd =~ /strut$/) { # ignore it
		print "\nignoring \\$cmd ";
	    } elsif ($cmd =~ /^[vh]rule$/) { # ignore it
		$this = "$cmd";
		do{ local($which,$len,$pxs,%dims);
		    while (s/^\s*(height|width|depth)/$which=$1;''/e) {
			$this .= " ".$&;
			s/^\s*(\d+\.?\d*\w*)//; $this .= $&;
			($pxs,$len) = &convert_length($1); 
			$dims{$which} = $pxs;
		    }
		    if ($dims{'width'} == 0 || ($dims{'height'}+$dims{'depth'} == 0)) {
			print "\nignoring \\$cmd "; $this = '';
		    } else {
			$this = &process_math_in_latex($mode,$style,$slevel,"\\$this");
		    }
		};
	    } elsif ($cmd =~ /^$arrow_over_ops_rx$/) {
		$this = &missing_braces unless (
		    (s/$next_pair_pr_rx\s*/$this = $&;''/oe)
		    ||(s/$next_pair_rx\s*/$this = $&;''/oe));
		$this .= &get_supsub;
		$this = &process_math_in_latex($mode,$style,$slevel, "\\$cmd$this" );	    
	    } else {
		# Unknown: send it to LaTeX and hope for the best.
		&write_warnings("\nUnknown math command: \\$cmd , image needed.");
		$this = &get_supsub;
		$this = &process_math_in_latex($mode,$style,$slevel,"\\$cmd$this" );
	    }
	} elsif ($this =~ /^\&(\w+)(#(\w+))?;/) {
	    # math-entity code
	    $cmd = $3;
	    print ".";
	    print STDERR "$cmd" if ($VERBOSITY > 2);
	    do {
	        $this = &get_supsub;
	        $this = &process_math_in_latex($mode,$style,$slevel,"\\$cmd$this" )
	    } if ($cmd);
	    $this = " $this "
	        if ($cmd =~ /$binary_ops_rx|$binary_rels_rx|$arrow_rels_rx/);
	} elsif ($this =~ /^\s*((\^)|\_)/) {
	    # super/sub-script
	    print "$1";
	    print STDERR "$2" if ($VERBOSITY > 2);
	    $slevel++;
	    local($BP) = (($2) ? "P" : "B"); $tmp = "<SU$BP>";
	    $this = &get_next_token(1);
	    if ($this =~ /$array_env_rx/) {
		$this = &process_math_in_latex($mode,$style,$slevel
			,(($BP =~/P/)? '^':'_')."{$this}" );
	    } else {
		$this = &parse_math_toks($mode,$style,$face,$slevel,1,$this);
	    }
	    $this =~ s/^\s+//; $this =~ s/\s+$//;
	    $this = join('', $tmp, $this, "</SU$BP>");
	    $slevel--;
	    $lastclosespace = 0;
	} elsif ($this =~ /^;SPM([a-z]+)/) {
	    $this = " $this " if ($this =~ /;SPM(gt|lt|amp);/);
	} else {
	    # just append it; e.g. images, etc.
	}
	$pre =~ s/\s+//g; #remove all spaces...
	if ($pre) {
	    # put space back around numbers
#	    $pre =~ s/([\d\.,]+)($|\W)/"$1".(($2)? " $2" :'')/eg;
#	    $pre =~ s/([^\s\.,\(\[\/\w])(\d+)/$1 $2/g;
	    #...italiced alphabetics, except if sup/subscripts
	    if ($face eq "I") {
		$pre =~ s/([a-zA-Z][a-zA-Z\']*)/<$face>$1<\/$face>/go unless ($slevel);
		# ... but not inside <...> tags
		$pre =~ s/(<\/?)<$face>([a-zA-Z][a-zA-Z\']*)<\/$face>>/$1$2>/go;
	    } else {
	    # but all alphanumerics, with a special style 
		$pre =~ s/(([\.\,]?\w[\w\']*)+)/<$face>$1<\/$face>/go
	    }
	    # but don't split multipliers from multiplicands
	    $pre =~ s/(\d) </$1</g; 
	    # remove spaces just created around brackets etc.
	    $pre =~ s/\s*(^|[\{\}\(\)\[\]\|\!\/]|$)\s*/$1/g;

	    # ensure space around = + - signs
	    $pre =~ s/([=\+\-\:])\s*/ $1 /g if ($math_outer);
	    # ... but some operators should not have a preceding space...
	    $pre =~ s/(\s|&nbsp;)+([\}\)\]])/$2/g;
	    # and some should not have a trailing space
	    $pre =~ s/([\{\(\[])(\s|&nbsp;)+/$1/g;
	    # some letters usually slope too far
	    $pre =~ s/([dfl]<\/$face>)([\(\)\/])\s*/$1 $2/g;
	    # ...and sometimes don't want spaces at the end
	    $pre =~ s/([\w>\!\)\]\|])\s+$/$1/;
#	    # ensure a space after last closing bracket, without sub/sub
#	    $pre =~ s/([\)\]\|])$/$1 /  if ($lastclosespace);
	    $pre =~ s/\s+/ /g;
	}
	# remove redundant <SUP/B> tags
	$this =~ s/<SU(P|B)><\/SU\1>//g;
	$this =~ s/<\/SU(P|B)><SU\1>//g;

	# append processed tokens, forbidding some spaces; e.g. "> <".
	if ($pre) {
	    if (( $keep =~/>\s*$/ )&&( $pre =~ /^\s*[<\(\{\[\w]/ )) {
	        $keep =~ s/\s+$//; $pre =~ s/^\s+//;
	    }
	    if (( $keep =~/\w\s*$/ )&&( $pre =~ /^\s*[<\(\{[]/ )) {
	        $keep =~ s/\s+$//; $pre =~ s/^\s+//;
	    }
#	    if (($pre =~/>\s*$/)&&($this =~ /^\s*</)) {
#	        $pre =~ s/\s+$//; $this =~ s/^\s+//;
#	    }
	}
#	elsif (($keep =~/>\s*$/)&&($this =~ /^\s*([<\([\w])/)) {
#	    $keep =~ s/\s+$//; $this =~ s/^\s+//;
#	}

	print STDERR "\nMATH:${math_outer}:${keep}:${pre}:${this}:" if ($VERBOSITY > 4);
	$keep .= $pre . $this;
    }

    # the leftovers should be all simple characters also.
    s/\s*//g;
    if ($_) {
#	s/([\d\.,]+)($|\W)/"$1".(($2)? " $2" :'')/eg;
#	s/([^\s\.,\(\[\/\w])(\d+)/$1 $2/g;
	if ($face eq "I") {
            s/([a-zA-Z][a-zA-Z\']*)/<I>$1<\/I>/go unless ($slevel);
	    # ...but not inside <...> tags
	    s/(<\/?)<I>([a-zA-Z\']+)<\/I>>/$1$2>/go;
	} elsif ($face) {
            s/(([\.\,]?\w[\w\']*)+)/<$face>$1<\/$face>/go
	}
	s/<I>(\d+)<\/I>/$1/go unless ($slevel);
	s/(\d) </$1</g;
	s/\s*(^|[\{\}\(\)\[\]\|\!\/]|$)\s*/$1/g;
	s/([=\+\-\:])\s*/ $1 /g if ($math_outer);
	s/([\(\[\{])(\s|&nbsp;)+/$1/g;
	s/(\s|&nbsp;)+([\)\]\}])/$2/g;
	s/([\!\)\]\|])\s*([\(\[\|])/$1$2/g;
	s/([dfl]<\/$face>)([\(\)\/])\s*/$1 $2/g;
	# ensure a space after some final characters, but not all
	# suppress this by enclosing the whole expression in {}s
#	s/([\)\]\|\.,!>\w])$/$1 /;  # Why ?
#	$_ .= " " if ($math_outer);
	s/ +$//; # ignore trailing spaces
    } elsif ($math_outer) {
	# final space unless ending with </SUP> or </SUB>
	$keep .=" " unless (($keep =~/SU[BP]>$/)||(!$joinspace));
    }
    # don't allow this space: "> <"
    if (($keep =~/>\s*$/)&&($_ =~ /^\s*</)) {
	$keep =~ s/\s+$//; $_=~s/^\s+//;
    }
    print STDERR "\nMATH_OUT:${math_outer}:${keep}$_:" if ($VERBOSITY > 4);
    $keep .= $_;
#    # italiced superscripts can be too close to some letters... (what a hack!)
#    $keep =~ s/([a-zA-Z]<\/I><SUP>)\s*/$1 /g unless ($face =~ /it/);
#    $keep =~ s/([a-zA-Z\d]<\/it><SUP>)\s*/$1 /g if ($face =~ /it/);
#    # ...but nested superscripts are OK
#    $keep =~ s/([a-zA-Z]<\/(I|it)><SUP> <\2>[^<]+<\/\2><SUP>)( |\s)+/$1/g;
#    $keep =~ s/\s*(&nbsp;)+\s*/&nbsp;/g; 
    $keep =~ s/\s(\s)\s*/\1/g;
    $keep =~ s/^(\s*[\+\-]) ([\w\d])/$1$2/o; # unary plus/minus, not binary
#    $keep =~ s/([\,\:\|])(<I>|\w)/$1 $2/g;  # space after punctuation
    $keep =~ s/([\,\|])(<I>|\w)/$1 $2/g;  # space after punctuation
    # recognise an integral's differential; e.g. dx 
    if (($afterint)&&($keep =~ s/(;SPM(thin|nb)sp;|~)\s*<I>d/$1d<I>/g)) {
	$afterint--; $keep =~ s/<I><\/I>// }
    $keep;
}

# the next token is either {...} or \<name> or an entity.
sub get_next_token {
    local($strict) = @_;
    local($this,$cmd)=('',"^ or \_ ");
    do {
	s/$next_token_rx/$this = $&;''/eo;
	if ($strict &&(length($this) > 1)&&($this =~ /^\\/)) {
	    local($tmp) = 'do_cmd_'.$';
	    if ((defined &$tmp)||($this =~ /^\\(math|text)/)) {
		$_ = $this .' '. $_;
		$this = &missing_braces();
	    }
	}
    } unless (
        (s/$next_pair_pr_rx/$this = $2;''/eo)
        ||(s/$next_pair_rx/$this = $2;''/eo));
    s/^$comment_mark\d+//o; $this =~ s/^\s*//o;
    if ($this =~ /^(\&|;)$/) { s/^([a-zA-Z]+;(#\w+;)?)/$this.=$1;''/eo; } 
    elsif ($this eq '') { s/^\s*([&;][a-zA-Z]+;)/$this =$1;''/eo; }
    $this;
}

# This extracts sup/sub-scripts that follow immediately.
# It alters $_ in the caller.
# ...this is meant for code to be passed to LaTeX
sub get_supsub {
    local($supsub,$supb,$which,$getit) = ('','','');
    $supsub = "\\limits" if (s/^[\s%]*(\\limits|\&limits\;)//);
    while (s/^[\s%]*(\^|_|\'|\\prime|\\begin(($O|$OP)\d+($C|$CP))(Sb|Sp)\2)/$supb=$1;''/eo ) {
	$which .= $supb;
	if ($supb =~ /\^|\_/) {
	    $getit = &get_next_token(1);
	    $supsub .= join('', $supb,"\{",$getit,"\}")
	        unless ($getit eq '');
	} elsif ($5) {
	    $supsub .= $1; $which .= (($5 =~ /b/) ? '_' : '^');
	    local($multisub_type) = $5;
	    s/\\end(($O|$OP)\d+($C|$CP))$multisub_type\1/$supsub .= $`.$&;''/em;
	} else { $supsub .= "\{^\\prime\}" }
    }
    # include dummy sup/sub-scripts to enhance the vertical spacing
    # when not a nested sup/subscript
    do {
	$supsub .= "_{}" unless ($which =~ /\_|\\prime|\'/);
	$supsub .= "^{}" unless ($which =~ /\^|\'|\\prime/ );
    } unless (($slevel)||(!$which));
    $supsub =~ s/^\\limits$//;
    $supsub;
}


# These regular expressions help decide the type of a math-entity,
# so that extra white space may be inserted, as desirable or necessary.

#$binary_ops_rx = "(pm|mp|times|plus|minus|div|ast|star|circ|dot|triangle\\w|cap|cup|vee|wedge|bullet|diamond\$|wr\$|oslash|amalg|dagger|lhd|rhd)";

$binary_ops_rx = "(times|plus|minus|div|circ|dot|cap|cup|vee|wedge|wr\$|amalg|lhd|rhd)";

$binary_rels_rx = "(eq|prec|succ|\^ll\$|\^gg\$|subset|supset|\^in\$|\^ni\$|dash|sim|approx|cong|asymp|prop|models|perp|\^mid\$|parallel|bowtie|Join|smile|frown)";

$arrow_rels_rx = "(arrow|harpoon|mapsto|leadsto)";

     

&ignore_commands( <<_IGNORED_CMDS_);
allowbreak
mathord
mathbin
mathrel
mathop
mathopen
mathclose
mathpunct
mathalpha
mathrm
mathbf
mathtt
mathit
mathbb
mathcal
cal
mathsf
smash
_IGNORED_CMDS_

    # Commands which need to be passed, ALONG WITH THEIR ARGUMENTS, to TeX.

&process_commands_inline_in_tex( <<_LATEX_CMDS_);
#mathbb # {}
#mathcal # {}
#mathsf # {}
_LATEX_CMDS_


1;









