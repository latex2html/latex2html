# -*- perl -*-
#
# $Id: alltt.perl,v 1.20 1999/11/25 10:20:25 RRM Exp $
#
# alltt.perl by Herbert Swan <dprhws.edp.Arco.com>  12-22-95
#
# Extension to LaTeX2HTML V 96.1 to supply support for the
# "alltt" standard LaTeX2e package.
#
# revised for v99.1  by  Ross Moore <ross@maths.mq.edu.au>
#
# Change Log:
# ===========
# $Log: alltt.perl,v $
# Revision 1.20  1999/11/25 10:20:25  RRM
#  --  protect " characters from becoming active; e.g. with german, etc.
#  	thanks to Peter Junglas for reporting the bug
#
# Revision 1.19  1999/10/22 00:35:44  RRM
#  --  undef is a scalar operator --- thanks Achim.Haertel
#
# Revision 1.18  1999/09/14 22:02:02  MRO
#
# -- numerous cleanups, no new features
#
# Revision 1.17  1999/06/06 14:25:01  MRO
#
#
# -- many cleanups wrt. to TeXlive
# -- changed $* to /m as far as possible. $* is deprecated in perl5, all
#    occurrences should be removed.
#
# Revision 1.16  1999/06/03 05:00:54  RRM
#  --  extensive revision, to support styles, with correct nesting of tags
#  --  retain space after macro-names
#  --  support $USING_STYLES for stylesheets
#

package main;

# allow users to declare their own alltt-like environments
if ($alltt_rx) {
    $alltt_rx = 'alltt'."|$alltt_rx";
    $alltt_rx =~ s/\|{2,}/\|/g; $alltt_rx =~ s/\|$//g;
} else {
    $alltt_rx = 'alltt'
}

sub preprocess_alltt {
    local ($before, $after, $alltt, $alltt_env);
    local ($alltt_begin) = "<alltt_begin>";
    local ($alltt_end) = "<alltt_end>";
    local($saveRS) = $/; undef $/;
    while (/\\begin\s*{($alltt_rx)}([ \t]*\n)?/m) {
	$alltt_env = $1;
	$alltt = "";
	($before, $after) = ($`, $');
	if ($after =~ /\\end\s*{($alltt_rx)}/sm) {
	    ($alltt, $after) = ($`, $');
	    local(@check) = split("\n",$before);
	    local($lastline) = pop @check unless ($before =~ s/\n$//sm);
	    $alltt = &alltt_helper($alltt)	 # shield special chars
		unless ($lastline =~ /(^|[^\\])(\\\\)*%.*$/m);  # unless commented out
	    undef @check; undef $lastline;
	}
	$_ = join('', $before, "\n", $alltt_begin, "{$alltt_env}\n"
		, $alltt, $alltt_end, "{$alltt_env}", $after);
    }
    $/ = $saveRS;
    s/$alltt_begin\{([^\}]*)\}/\\begin{$1}/gosm;
    s/$alltt_end\{([^\}]*)\}/\\end{$1}/gosm;
}

sub alltt_helper {
    local ($_) = @_;
    local($br_id) = ++$global{'max_id'};
    s/^/\\relax$O$br_id$C$O$br_id$C /s; # Preserve leading & trailing white space
    s/\t/ /g;		# Remove tabs
    # preserve space after macro names
    s/(\\\w+) /$br_id=++$global{'max_id'};$1."$O$br_id$C$O$br_id$C "/eg;
    s/\\?\$/;SPMdollar;/g;
    s/\\?%/;SPMpct;/g;
    # protect " from being used as an active character with some languages
    s/((^|[^\\])(\\\\)*)(\"|\;SPMquot\;)/$1\&#34;/gm;
    s/~/;SPMtilde;/g;
    s/\n/\n<BR>/g;	# preserve end-of-lines --- cannot have <P>s
    join('', $_, "\\relax ");
}

#RRM, 29-4-99:
#   The {alltt} environment is always aligned-left
#   but it may inherit color & other styles from surrounding environments.

sub do_env_alltt {
    local ($_) = @_;
    local($closures,$reopens,$alltt_start,$alltt_end,@open_block_tags);

    if ($HTML_VERSION > 3.0) {
        if ($USING_STYLES) {
            $env_id .= ' CLASS="alltt"' unless ($env_id =~/CLASS=/);
            $env_style{'alltt'} = " " unless ($env_style{'alltt'});
        }
	$alltt_start = "\n<DIV$env_id ALIGN=\"LEFT\">\n";
	$alltt_end = "\n</DIV>\n";
	$env_id = '';
    } else {
	$alltt_start = "<P ALIGN=\"LEFT\">";
	$alltt_end = "</P>";
    }


    # get the tag-strings for all open tags
    local(@keep_open_tags) = @$open_tags_R;
    ($closures,$reopens) = &preserve_open_tags() if (@$open_tags_R);

    # get the tags for text-level tags only
    $open_tags_R = [ @keep_open_tags ];
    local($local_closures, $local_reopens);
    ($local_closures, $local_reopens,@open_block_tags) = &preserve_open_block_tags
	if (@$open_tags_R);

    $open_tags_R = [ @open_block_tags ];

    do {
	local($open_tags_R) = [ @open_block_tags ];
	local(@save_open_tags) = ();

	local($cnt) = ++$global{'max_id'};
	$_ = join('',"$O$cnt$C\\tt$O", ++$global{'max_id'}, $C
		, $_ , $O, $global{'max_id'}, "$C$O$cnt$C");

	$_ = &translate_environments($_);
	$_ = &translate_commands($_) if (/\\/);

	# preserve space-runs, using &nbsp;
	while (s/(\S) ( +)/$1$2;SPMnbsp;/g){};
	s/(<BR>) /$1;SPMnbsp;/g;

#RRM: using <PRE> tags doesn't allow images, etc.
#    $_ = &revert_to_raw_tex($_);
#    &mark_string; # ???
#    s/\\([{}])/$1/g; # ???
#    s/<\/?\w+>//g; # no nested tags allowed
#    join('', $closures,"<PRE$env_id>$_</PRE>", $reopens);
#    s/<P>//g;
#    join('', $closures,"<PRE$env_id>", $_, &balance_tags(), '</PRE>', $reopens);

	$_ = join('', $closures, $alltt_start , $local_reopens
		, $_
		, &balance_tags() #, $local_closures
		, $alltt_end, $reopens);
	undef $open_tags_R; undef @save_open_tags;
    };

    $open_tags_R = [ @keep_open_tags ];
    $_;
}

1;	# Must be last line





