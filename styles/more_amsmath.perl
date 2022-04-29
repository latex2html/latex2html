# more_amsmath.perl
# by Ross Moore <ross@mpce.mq.edu.au>  1-19-98
#
# Extension to LaTeX2HTML to load further features from 
# the AMS packages, using advanced parsing
# This package requires the `math' extension to be loaded
# e.g. via switches:
#
#	-no_math -html_version 3.2,math
# OR    -no_math -html_version 4.0,math
#
# This extension is loaded automatically from  amstex.perl
# when the \usepackage{amstex}  or \usepackage{amsmath}
# commands are used. 
#
# Change Log:
# ===========

package main;
#

if ($HTML_VERSION < 3) {
    print "\n*** advanced features of the AMS math packages require HTML 3.2 or later ***\n";
    return(1);
}

$display_env_rx = join('|', $display_env_rx 
	,'gather','multline','align','split');

sub do_htmlmath_array {
    local($colspec) = @_;
    if (defined &do_env_array) {
	join('', $comment, "<P class=\"CENTER\">$sbig"
	    , $labels, "\n<MATH CLASS=\"EQNARRAY\">"
	    , &do_env_array("$O$max_id${C}$colspec$O$max_id$C$_")
	    , "</MATH>\n$ebig</P>" )
    } else {
	join('', $comment, '<P class="CENTER">', $labels,
	    , &process_undefined_environment($env, $id , $_),'</P>')
    }
}


sub set_math_size {
    local($mode) = @_;
    local($ssize,$esize);
    ($ssize,$esize) = ("<BIG>","</BIG>")
	if (!($mode =~ /inline/)&&($DISP_SCALE_FACTOR)
	    &&($DISP_SCALE_FACTOR >= 1.2 ));
    if ($USING_STYLES) {
	$ssize .= '<SPAN CLASS="MATH">';
	$esize = '</SPAN>'.$esize;
    }  
    ($ssize,$esize)
}

sub set_math_valign {
    local($numbering) = @_;
    "";
}

sub get_eqn_number {
    local($outer_num, $scan) = @_;
    # an explicit \tag overrides \notag , \nonumber or *-variant
    local($labels,$tag);
    ($scan,$labels) = &extract_labels($scan); # extract labels
    if ($scan =~ s/\\tag(\*|star\b)?\s*(($O|$OP)\d+($C|$CP))(.*)\2//) {
	local($star) = $1; $tag = $5;
	$tag = &translate_environments($tag) if ($tag =~ /\\begin/);
	$tag = &translate_commands($tag) if ($tag =~ /\\/);
	$tag = (($star)? $tag : $EQNO_START.$tag.$EQNO_END );
    } elsif (($outer_num)&&(!($scan)||!($scan =~ s/\\no(tag|number)//))
	&&(!($scan =~ /^\s*\\begin(<(<|#)\d+(>|#)>)($outer_math_rx)\b/))
    ){ 
	$global{'eqn_number'}++ ;
	if ($subequation_level) {
	    local($sub_tag) =  &get_counter_value('equation');
	    $tag = join('', $EQNO_START
		, $eqno_prefix
		, &falph($sub_tag)
		, $EQNO_END);
	} else {
	    $tag = join('', $EQNO_START
		, &simplify(&translate_commands('\theequation'))
		, $EQNO_END);
	}
    } else { $tag = ';SPMnbsp;;SPMnbsp;;SPMnbsp;' }
    $scan =~ s/($comment_mark\d+) /$1\n/g;
    if ($labels) {
	$labels =~ s/$anchor_mark/$tag/o;
	($labels , $scan);
    } else { ($tag , $scan) }
}

$outer_math_rx = "(fl|x|xx)?align(at)?|multline|gather|(sub)?equation";

sub get_mult_eqn_number {
    local($num_rows,$valign, $scan) = @_;
    local($align,$tag);
    $align = " VALIGN=\"$valign\"" if $valign;
    ($tag,$scan) = &get_eqn_number(1,$scan);
    $tag = join('', $align, " ROWSPAN=$num_rows", $etag , $tag);
    ($tag , $scan);
}

sub start_math_display {
    join(''
#	, (($border||($attribs)||!($outer_math))? '': "<P></P>")
	, ((($doimage)||!($outer_math))? '': "\n<DIV$math_class>")
	, (($labels)? $labels : '') , $comment
	, @_ );
}

sub end_math_display {
    join('', @_ , ((($doimage)||!($outer_math))? '' : 
	"</DIV>\n" ));
}

sub embed_display {
    # cancel <BIG> tags when alignment inside subequations
    return( join('', $ebig, @_[0], $sbig) )
	 if ($outer_math && $subequation_level > 1);
    # just return contents when alignment inside equation/multline
    return(@_[0]) if $outer_math;

    # at the outermost level
    if (($border)||($attribs)) {
	join('',"<DIV$math_class>\n"
	    , &make_table( $border, $attribs, '', '', '', @_ )
	    , "\n");
    } else { join('', "<P></P>", @_ , "<P></P>") }
}

$smdiv_rx = "<(BR|DIV)";
$spdisplay = (($HTML_VERSION > 3.1)? "<DIV ":"<P "). "class=\"CENTER\">";
$epdisplay = (($HTML_VERSION > 3.1)? "</DIV>\n":'')."";
$mdisp_width = "";#" style=\"width:100%\"";
$smarray = "<TABLE";
$smarrayB = " ";	# padding:0; by default
$emarray = "\n</TABLE>";
$smrow = "\n<TR"; # must be followed by alignment or ">"
$emrow = "</TR>";
$emtag = ">";
$smncell = "\n<TD ";
$smcell = "\n<TD";
$emcell = "</TD>";
$mcalign = " style=\"text-align:center;\">";
$mlalign = " style=\"text-align:left;\">";
$mralign = " style=\"text-align:right;\">";
$mvalign = " ";	#  class equation specifies style=\"vertical-align:baseline;\"
$slcell = $smncell."class=\"LEFT\">";
$srcell = $smncell."class=\"RIGHT\">";
$smlcell = $smncell.$mlalign;
$smccell = $smncell.$mcalign;
$smrcell = $smncell.$mralign;
$mnocell = "\n<TD>";
$mspace = "\&nbsp;";
$mdlim = $html_specials{'&'};

$lseqno = "$eqno_class style=\"text-align:left;\">\n";
$rseqno = "$eqno_class style=\"text-align:right\">\n";
$lsfill = " class=\"lfill\">";
$rsfill = " class=\"rfill\">";


# do these indirectly, so that they only over-ride the existing
# ones when the right combination of packages is present.

eval "sub do_env_equation { \&process_env_equation(1,\@_); }";
eval "sub do_env_equationstar { \&process_env_equation(0,\@_); }";

sub do_env_subequations {
    local($contents) = @_[0];
    local($prev_eqn_number) = $global{'eqn_number'}++;
    local($eqno_prefix) = &translate_commands('\theequation');
    $eqno_prefix =~ s/\s+$//;
    ++$subequation_level;
    local($outer_math) = 'subequations' unless $outer_math;
    $global{'eqn_number'} = 0;
    $contents = &process_env_equation(1, $contents);
    --$subequation_level;
    $global{'eqn_number'} = ++$prev_eqn_number;
    $contents;
}

sub process_env_equation {
    local($numbered, $_) = @_;
    local($math_mode, $failed, $labels, $comment, $doimage) = ("equation",'','','','');
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = &revert_array_envs($_);
    local($falign) = 'CENTER';
    local($sbig,$ebig)= &set_math_size($math_mode);
    $failed = 1 if ($NO_SIMPLE_MATH); # simplifies the next call
    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    $failed = 0;

    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($outer_math) = $env unless ($outer_math);

    if ($USING_STYLES) {
	$env_id =~ s/(CLASS=\")(\w+)/$1$outer_math/;
	$env_style{$outer_math} = "" unless ($env_style{$outer_math});
	$env_id = ' CLASS="'.$outer_math.'"' unless $env_id;
    }

    if ($failed) {
	local($this_env) = $outer_math;
	if (!($this_env =~ s/(star|\*)$/\*/)) { $global{'eqn_number'}++ };
	$_ = &process_undefined_environment($this_env, $id, $saved);
	$falign = (($EQN_TAGS =~ /L/)? 'LEFT' : 'RIGHT') if $numbered;
	local($fsdisplay,$fedisplay) = ($spdisplay,$epdisplay);
	if (!($fsdisplay =~ s/(ALIGN\s*=\s*\")[^\"]*\"/$1$falign\"/)) {
	    $fsdisplay .= "<DIV$env_id class=\"$falign\">";
	    $fedisplay = '</DIV>'.$epdisplay;
	}
	$_ = join('', $fsdisplay, $labels, $comment, $_, $fedisplay);

    } elsif ($NO_SIMPLE_MATH) {
#    if ($NO_SIMPLE_MATH) {
	$failed = 0;
	s/$htmlimage_rx/$doimage = $&;''/eo ; # force an image
	s/$htmlimage_pr_rx/$doimage .= $&;''/eo ; # force an image
	local($valign) = &set_math_valign();
	local($sarray, $srow, $scell, $calign, $ecell, $erow, $earray);

#	local($env_id) = $env_id;
#	if ($USING_STYLES) {
#	    $env_id =~ s/(CLASS=\")(\w+)/$1$outer_math/;
#	    $env_style{$env} = "" unless ($env_style{$env});
#	}

	($sarray, $erow, $earray, $sempty, $calign) = ( 
	    $smarray.$env_id.$smarrayB.($numbered?$mdisp_width:'').">"
	    , $emrow , $emarray, $emcell.$mnocell, $mcalign );
	$env_id = '';

	local($return) = &start_math_display ( $sarray );

	local($eqno, $inner_numbered);
	($eqno, $_) = &get_eqn_number($numbered,$_);
	local($valign) = &set_math_valign($eqno);

	$_ = &protect_array_envs($_);
	if ($_ =~ /\s*\\begin\s*$O\d+$C\s*align/) {
	    # no equation numbering --- handled by the inner-alignment
	    $inner_numbered = 1;
	    ($srow, $scell, $ecell) = (
		$smrow.$valign.$emtag, $smncell , $emcell);
	    $return .= $srow . $scell;	    
	} elsif ($EQN_TAGS =~ /L/) {
	    # equation number on left
	    ($srow, $scell, $ecell) = (
#		$smrow.$valign.$emtag.$smcell.$mcalign, $smncell , $emcell);
		$smrow.$valign.$emtag.$smcell.$lseqno, $smncell , $emcell);
	    $return .= $srow . $eqno . $ecell . $scell;
	} else {
	    # equation number on right
	    ($srow, $scell, $ecell) = (
		$smrow.$valign.$emtag , $smncell , $emcell);
	    $return .= $srow . $scell ;
	}

	if (s/\\shove(righ|lef)t//) {
	    local($whichway) = $1;
	    $return .= (($1 =~/lef/)? $mlalign : $mralign );
	    if (($doimage)||($failed)) {
		$_ = &process_math_in_latex("indisplay",'',''
		    , $doimage.$_ ) unless ($_ eq '');
	    } else { 
		$_ = &make_math('display','','',$_) unless ($_ eq '')
	    }
	    if (!($_ eq '')) {
	        $return .= join(''
		    , (($whichway =~ /lef/)? $mspace.$mspace : '')
		    , ((/^$smarray/)? $_ : $sbig.$_.$ebig )
		    , (($whichway =~ /lef/)? '' : $mspace.$mspace )
		    , $ecell , $erow);
	    } else { $return .= join('', $mspace , $ecell, $erow); } 
	} else {
	    $thismath = $_;
	    $thismath =~ s/(^\s*|\s*$)//gm;
	    if (($doimage)||($failed)) {
	        $thismath = &process_math_in_latex("indisplay",'',''
		    , $doimage.$thismath ) unless ($thismath eq '' );
	    } else {
		if ($thismath =~ /$subAMS_array_env_rx/) {
		    $outer_math =~ s/(equation)(star)?$/$1star/;
		    $thismath = &make_math($outer_math,'','', $thismath);
		} else {
		    $thismath = &make_math('display','','', $thismath)
			unless ( $thismath eq '' );
		}
	    }
	    if ($thismath ne '') {
	        $return .= join('', $calign
		    , (($thismath =~ /^$smarray/)? $thismath
			: $sbig . $thismath . $ebig )
		    , $ecell);
	    } else {
		$return .= join('', $sempty, "\&nbsp;", $ecell);
	    }
	}
#	$return .= $smncell.$mcalign.$eqno.$ecell
	$return .= $smncell.$rseqno.$eqno.$ecell
	    unless (($EQN_TAGS =~ /L/)||$inner_numbered); # eqn-num on right
	$return .= $erow;

        $_ = &end_math_display($return , $earray );
    } else {
        $_ = &do_htmlmath_array('c');
    }

    undef $outer_math unless ($subequation_level);
    &embed_display($_);
}


### Multiline formulas


sub do_env_multline {
    &process_env_multline(1,@_);
}
sub do_env_multlinestar {
    &process_env_multline(0,@_);
}

sub process_env_multline {
    local($numbered, $_) = @_;
    local($math_mode, $failed, $labels, $comment, $doimage) = ("equation",'','','','');
    local($attribs, $border);
    local($outer_math) = $env unless ($outer_math);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
    local($sbig,$ebig)= &set_math_size($math_mode);
    $failed = 1 if ($NO_SIMPLE_MATH); # simplifies the next call
    ($labels, $comment, $_) = &process_math_env($math_mode,$_);

    local($falign) = 'CENTER';
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/) unless ($outer_math); # force an image
    local($outer_math) = $env unless ($outer_math);

    if ($failed) {
	$latex_body .= join('', "\n\\setcounter{equation}{"
			    , $global{'eqn_number'} , "}\n");
	$_ .= "%EQNO:".$global{'eqn_number'}."\n";
	$global{'eqn_number'}++;
	$_ = &process_undefined_environment(
		'multline'.(($numbered) ? '':"*"), $id, $saved);
	$falign = (($EQN_TAGS =~ /L/)? 'LEFT' : 'RIGHT') if $numbered;
	local($fsdisplay,$fedisplay) = ($spdisplay,$epdisplay);
	if (!($fsdisplay =~ s/(ALIGN\s*=\s*\")[^\"]*\"/$1$falign\"/)) {
	    $fsdisplay .= "<DIV class=\"$falign\">";
	    $fedisplay = '</DIV>'.$epdisplay;
	}
	$_ = join('', $fsdisplay, $labels, $comment, $_, $fedisplay);

    } elsif ($NO_SIMPLE_MATH) {
	$failed = 0;
	s/$htmlimage_rx/$doimage = $&;''/eo ; # force an image
	s/$htmlimage_pr_rx/$doimage .= $&;''/eo ; # force an image
	local($valign) = &set_math_valign();
	local($sarray, $srow, $scell, $calign, $ecell, $erow, $earray);

	local($env_id) = $env_id;
	if ($USING_STYLES) {
	    $env_id = ' CLASS="equation"';
	}
	($sarray, $erow, $earray, $sempty, $calign) = ( 
	    $smarray.$env_id.$smarrayB.($numbered?$mdisp_width:'').">"
	    , $emrow , $emarray, $emcell.$mnocell, $mlalign );
	$env_id = '';

	local($return) = &start_math_display ( $sarray );

	local($eqno);
	($eqno, $_) = &get_eqn_number($numbered,$_);
	local($valign) = &set_math_valign($eqno);

	$_ = &protect_array_envs($_);

	if ($EQN_TAGS =~ /L/) {
	    # equation number on left
	    ($srow, $scell, $ecell) = (
#		$smrow.$valign.$emtag.$smcell.$mcalign , $smncell , $emcell);
		$smrow.$valign.$emtag.$smcell.$lseqno , $smncell , $emcell);
	    $return .= $srow . $eqno . $ecell . $scell;
	} else { # equation number on right
	    ($srow, $scell, $ecell) = (
		$smrow.$valign.$emtag , $smncell, $emcell);
	    $return .= $srow . $scell ;
	}

	local(@rows,$thismath);
	s/\\\\[ \t]*(\*|\[[^\]]*])/\\\\/g; # remove forced line-heights
	@rows = split(/\\\\/);
	$#rows-- if ( $rows[$#rows] =~ /^\s*$/ );
	local($row_cnt);
	foreach (@rows) { # displaymath
	    if ($row_cnt) {
		$eqno = '' if ($EQN_TAGS =~ /L/);
		$calign = $mcalign;
		$calign = $mralign if ($row_cnt == $#rows );
		$return .= $erow . $srow . $scell ;
	    }
	    $row_cnt++;

	    if (s/\\shove(righ|lef)t//) {
		local($whichway) = $1;
		$return .= (($1 =~/lef/)? $mlalign : $mralign );
		if (($doimage)||($failed)) {
		    $_ = &process_math_in_latex("indisplay",'',''
		        , $doimage.$_ ) unless ($_ eq '');
		} else { 
		    $_ = &make_math('display','','',$_) unless ($_ eq '')
		}
		if (!($_ eq '')) {
		    $return .= join(''
			, (($whichway =~ /lef/)? $mspace.$mspace : '')
			, ((/^$smarray/)? $_ : $sbig.$_.$ebig )
			, (($whichway =~ /lef/)? '' : $mspace.$mspace )
			, $ecell , $erow);
		} else { $return .= join('', $mspace , $ecell , $erow); } 
		next;
	    }

	    # columns to be set using \displaystyle
	    $thismath = $_; 
	    $thismath =~ s/(^\s*|\s*$)//gm;
	    if (($doimage)||($failed)) {
	        $thismath = &process_math_in_latex("indisplay",'',''
		    , $doimage.$thismath ) unless ($thismath eq '' );
	    } else {
	        $thismath = &make_math('displaymath','',''
		    , $thismath) unless ( $thismath eq '' );
	    }
	    if ($thismath ne '') {
	        $return .= join('', $calign
		    , (($row_cnt == 1)? $mspace.$mspace : '')
		    , (($thismath=~/^$smarray/)? $thismath
			    : $sbig.$thismath.$ebig )
		    , (($row_cnt == 1+$#rows )?  $mspace.$mspace : '')
		    , $ecell);
	    } else { 
		$return .= join('', $sempty, "\&nbsp;", $ecell);
	    }
	}

#	$return .= $smncell.$mcalign.$eqno.$ecell
	$return .= $smncell.$rseqno.$eqno.$ecell
		unless ($EQN_TAGS =~ /L/); # eqn-num on right
	$return .= $erow;

	$_ = &end_math_display($return , $earray );
    } else {
	$_ = &do_htmlmath_array('c');
    }
    undef $outer_math unless ($subequation_level);
    &embed_display($_);
}


sub process_intertext {
    local($eq_nums, $_) = @_;
    local($text,$post);
    s/\\intertext//o; $_ = $';
    local($pre) = $`; $pre =~ s/(^\s*|\s*$)//go;
    local($span) = (/$mdlim/) + $eq_nums + 1;
    $text = &missing_braces unless (
	(s/$next_pair_pr_rx/$text = $2;''/e)
	||(s/$next_pair_rx/$text = $2;''/e));
    $post = $_; $post =~ s/(^\s*|\s*$)//go;
    $text = &translate_commands(&translate_environments($text))
	if ($text =~ /\\/);
    $text = join('', $smrow, $emtag
	, (($span > 1) ? $smcell." COLSPAN=$span".$mlalign : $smlcell)
	, "<BR>", $text, "<P><BR>", $emcell, $emrow);
    ($text, $pre . $post );
}

sub do_env_align {
    local($_) = @_;
    local($math_mode, $attribs, $border) = ("equation",'','');
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    $_ = &process_env_align(1,"align",'','',$_);
    &embed_display($_);
}

sub do_env_alignstar {
    local($_) = @_;
    local($math_mode, $attribs, $border) = ("equation",'','');
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    $_ = &process_env_align(0,"align*",'','',$_);
    &embed_display($_);
}

sub do_env_alignat {
    local($_) = @_;
    local($aligns);
    $aligns = &missing_braces unless (
	(s/$next_pair_pr_rx/$aligns = $2;''/e)
	||(s/$next_pair_rx/$aligns = $2;''/e ));
    local($math_mode, $attribs, $border) = ("equation",'','');
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    $_ = &process_env_align(1,"alignat",$aligns,'',$_);
    &embed_display($_);
}

sub do_env_alignatstar {
    local($_) = @_;
    local($aligns);
    $aligns = &missing_braces unless (
	(s/$next_pair_pr_rx/$aligns = $2;''/e)
	||(s/$next_pair_rx/$aligns = $2;''/e ));
    local($math_mode, $attribs, $border) = ("equation",'','');
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    $_ = &process_env_align(0,"alignat*",$aligns,'',$_);
    &embed_display($_);
}

sub do_env_xalignat {
    local($_) = @_;
    local($aligns);
    $aligns = &missing_braces unless (
	(s/$next_pair_pr_rx/$aligns = $2;''/e)
	||(s/$next_pair_rx/$aligns = $2;''/e ));
    local($math_mode, $attribs, $border) = ("equation",'','');
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    $_ = &process_env_align(1,"xalignat",$aligns,'',$_);
    &embed_display($_);
}

sub do_env_xalignatstar {
    local($_) = @_;
    local($aligns);
    $aligns = &missing_braces unless (
	(s/$next_pair_pr_rx/$aligns = $2;''/e)
	||(s/$next_pair_rx/$aligns = $2;''/e ));
    local($math_mode, $attribs, $border) = ("equation",'','');
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    $_ = &process_env_align(0,"xalignat*",$aligns,'',$_);
    &embed_display($_);
}

sub do_env_xxalignat {
    local($_) = @_;
    local($aligns);
    $aligns = &missing_braces unless (
	(s/$next_pair_pr_rx/$aligns = $2;''/e)
	||(s/$next_pair_rx/$aligns = $2;''/e ));
    local($math_mode, $attribs, $border) = ("equation",'','');
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    $_ = &process_env_align(1,"xxalignat",$aligns,'',$_);
    &embed_display($_);
}

sub do_env_xxalignatstar {
    local($_) = @_;
    local($aligns);
    $aligns = &missing_braces unless (
	(s/$next_pair_pr_rx/$aligns = $2;''/e)
	||(s/$next_pair_rx/$aligns = $2;''/e ));
    local($math_mode, $attribs, $border) = ("equation",'','');
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    $_ = &process_env_align(0,"xxalignat*",$aligns,'',$_);
    &embed_display($_);
}

sub do_env_flalign {
    local($_) = @_;
    local($math_mode, $attribs, $border) = ("equation",'','');
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    $_ = &process_env_align(1,"flalign",'','',$_);
    &embed_display($_);
}

sub do_env_flalignstar {
    local($_) = @_;
    local($math_mode, $attribs, $border) = ("equation",'','');
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    $_ = &process_env_align(0,"flalign*",'','',$_);
    &embed_display($_);
}

sub do_env_gather {
    local($_) = @_;
    local($math_mode, $attribs, $border) = ("equation",'','');
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    $_ = &process_env_align(1,"gather",'','c',$_);
    &embed_display($_);
}

sub do_env_gatherstar {
    local($_) = @_;
    local($math_mode, $attribs, $border) = ("equation",'','');
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    $_ = &process_env_align(0,"gather*",'','c',$_);
    &embed_display($_);
}

sub process_env_align{
    # parameters 
    #   $numbered :  0 = *-version, no implicit equation-numbering
    #   $outer-math : outer-most environment
    #   $num_aligns : expected number of alignment pairs per row
    #   $align_spec : alignment of rows without any `&'s
    #   $_  :   the row/column data
    #
    # if $num_aligns is empty, count the number of cells delimiters (`&`) 
    # per row --- align columns alternating right-/left-
    # 
    # use the $align_spec only when there is just a single column
    # 
    local($numbered, $outer_math, $num_aligns, $align_spec, $_) = @_;
    local($failed, $labels, $comment, $def_align) = ('','','','');
    local($saved)= $_;
    local($falign)= 'CENTER';
    $saved = join('',"\\begin\{$env\}$num_aligns"
		, $_, "\\end\{$env\}\n") if ($outer_math);
    $num_aligns = 2*$num_aligns - 1 if ($num_aligns);
    if ($align_spec =~ /(l|r)/) {
	$def_align = (($1 eq 'l')? $smlcell : $smrcell ) }
    elsif ($align_spec eq 'c') { $def_align = $smccell }
#    elsif (!$num_aligns) { $def_align = $smlcell }
    elsif (!$num_aligns) { $def_align = $smccell }

    local($sbig,$ebig)= &set_math_size($math_mode);
    $failed = 1 if ($NO_SIMPLE_MATH); # simplifies the next call
    ($labels, $comment, $_) = &process_math_env($math_mode,$_)
	unless ($outer_math);

    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    if ($failed) {
	local($this_env) = ($outer_math ? $outer_math : $env );
	if ($saved =~ s/^\s*\\begin((($O|$OP)\d+($C|$CP|))|\{)\Q$this_env\E(\2|\})//){
	    $saved =~ s/\\end((($O|$OP)\d+($C|$CP))|\{)\Q$this_env\E(\2|\})\s*$//s;
	}
	$_ = &process_undefined_environment($this_env,$id,$saved);

	$falign = (($EQN_TAGS =~ /L/)? 'LEFT' : 'RIGHT') if $numbered;
	local($fsdisplay,$fedisplay) = ($spdisplay,$epdisplay);
	if (!($fsdisplay =~ s/(ALIGN\s*=\s*\")[^\"]*\"/$1$falign\"/)) {
	    $fsdisplay .= "<DIV class=\"$falign\">";
	    $fedisplay = '</DIV>'.$epdisplay;
	}
	$_ = join('', $fsdisplay, $labels, $comment, $_, $fedisplay);

    } elsif ($NO_SIMPLE_MATH) {
	$failed = 0;  
	s/$htmlimage_rx/$doimage = $&;''/eo ; # force images of parts
	s/$htmlimage_pr_rx/$doimage .= $&;''/eo ; # force an image

	local($env_id) = $env_id;
	if ($USING_STYLES) {
	    $env_id = ' CLASS="equation"';
	}
	local($sarray, $erow, $earray, $sempty, $calign) = (
	    $smarray.$env_id.$smarrayB.($numbered?$mdisp_width:'').">", $emrow
	    , $emarray, $mnocell.$mspace, $mcalign );
	$env_id = '';

	local($valign, $scell, $eqno) = ($mvalign,'','');
	local($srow, $ecell) = (
	    $smrow.$valign.$emtag , $emcell
	    );

	local($return) = &start_math_display ( $sarray );

	# revert all protection, before protecting alignment in sub-envs
	$_ = &revert_array_envs($_);
	$_ = &protect_array_envs($_);

	# leftmost and rightmost columns expand to fill available space,
	# so that the main group of columns is centered.
	# one of the two contains the equation numbers.
	($srow, $scell, $ecell) = ( $smrow.$valign.$emtag.$smcell
				    , $smncell , $emcell);

	local($xcols) = '0';

	local(@rows, @cols, $eqno, $thismath);
	s/\\\\[ \t]*(\*|\[[^\]]*])/\\\\/g; # remove forced line-heights
	@rows = split(/\\\\/);
	$#rows-- if ( $rows[$#rows] =~ /^\s*$/ );
	foreach (@rows) { # displaymath
	    next if (/^\s*$/); # ignore last row, if empty

	    if (/\\intertext/) {
		local($extra_row);
		#der -- David Rourke
		#there is an equation-number cell, even if empty
		#($extra_row,$_) = &process_intertext($numbered,$_);
		($extra_row,$_) = &process_intertext(1,$_);
		$return .= $extra_row;
	    }
	    ($eqno, $_) = &get_eqn_number($numbered,$_);
	    $valign = &set_math_valign($eqno);

	    if ($EQN_TAGS =~ /L/) {
#		$return .= $srow.$mcalign.$eqno.$ecell
		$return .= $srow.$lsfill.$eqno.$ecell
	    } else { $return .= $srow.$lsfill.$ecell }

	    local($scell) = $srcell; # so 1st cell is right-aligned...

	    local($xcols) = $num_aligns - (/$mdlim/g);
	    if ($num_aligns) {
		while ($xcols > 0) { $_ .= $mdlim; $xcols--; }
		if ($xcols < 0) {
		    local($orig_code) = &revert_to_raw_tex($_);
		    &write_warnings("\ntoo many cols in alignment:\n\t$orig_code");
		    print "\ntoo many columns in alignment:\n$orig_code\n";
		}
	    # ... unless there is no explicit alignment
	    } elsif ($xcols == 0) { $scell = $def_align }

	    if (s/\\shove(righ|lef)t//) {
		local($whichway) = $1;
		$return .= (($1 =~/lef/)? $slcell : $srcell );
		if (($doimage)||($failed)) {
		    $_ = &process_math_in_latex("indisplay",'',''
			, $doimage.$_ ) unless ($_ eq '');
		} else {
		    $_ = &revert_array_envs($_);
		    $_ = &make_math('display','','',$_) unless ($_ eq '')
		}
		if (!($_ eq '')) {
		    $return .= join(''
			, (($whichway =~ /lef/)? $mspace.$mspace : '')
			, ((/^$smarray/)? $_ : $sbig.$_.$ebig )
			, (($whichway =~ /lef/)? '' : $mspace.$mspace )
			, $ecell);
		} else { $return .= join('', $mspace , $ecell); }

#		$return .= $smncell.$mcalign.$eqno.$ecell
		$return .= $smncell.$rfill;
		$return .= $eqno
		    unless ($EQN_TAGS =~ /L/); # eqn-num on right
		$return .= $ecell.$erow;
		next;
	    }

	    # columns to be set using \displaystyle
	    @cols = split(/$mdlim/o);
	    local($col_cnt);
	    foreach (@cols) { # set in displaymath
		# alternating right/left aligned
		$scell =  (($scell eq $slcell)? $srcell : $slcell) if ($col_cnt);
		$thismath = $_; $col_cnt++;
		$thismath =~ s/(^\s*|\s*$)//gm;
		if (($doimage)||($failed)) {
		    $thismath = &process_math_in_latex("indisplay",'',''
	 		, $doimage.$thismath ) unless ($thismath eq '' );
		} elsif ($thismath ne '') {
		    $thismath = &revert_array_envs($thismath);
		    $thismath = &make_math('display','','',$thismath);
		}
		if ($thismath ne '') {
		    $return .= join('', $scell
                        , (($thismath=~/^$smarray/)? $thismath
			    : $sbig.$thismath.$ebig )
			, $ecell);
		} else { $return .= $sempty.$ecell; }
	    }

#	    $return .= $smncell.$mcalign.$eqno.$ecell
	    $return .= $smncell.$rsfill;
	    $return .= $eqno
		unless ($EQN_TAGS =~ /L/); # eqn-num on right
	    $return .= $ecell.$erow;
	}
	$_ = &end_math_display($return , $earray );
    } else {
	$_ = &do_htmlmath_array('');
    }
    $_;
}

sub do_env_aligned {
    local($_) = @_;
    local($saved) = join(''
	, "\\begin\{aligned\}"
	, &revert_array_envs($_)
	, "\\end\{aligned\}\n"
	);
    local($inner_math) = 'aligned';
    &process_undefined_environment(
	'displaymath' , ++$global{'max_id'}, $saved);
}
sub do_env_alignedat {
    local($_) = @_;
    $_ = &revert_array_envs($_);
    local($saved) = join(''
	, "\\begin\{alignedat\}"
	, &revert_array_envs($_)
	, "\\end\{alignedat\}\n"
	);
    local($inner_math) = 'alignedat';
    &process_undefined_environment(
	'displaymath' , ++$global{'max_id'}, $saved);
}
sub do_env_gathered {
    local($_) = @_;
    $_ = &revert_array_envs($_);
    local($saved) = join(''
	, "\\begin\{gathered\}\n"
	, &revert_array_envs($_)
	, "\\end\{gathered\}\n"
	);
    local($inner_math) = 'gathered';
    &process_undefined_environment(
	'displaymath' , ++$global{'max_id'}, $saved);
}
sub do_env_cases {
    local($_) = @_;
    $_ = &revert_array_envs($_);
    local($saved) = join(''
	,"\\begin\{cases\}\n"
	, &revert_array_envs($_)
	, "\\end\{cases\}\n"
	);
    local($inner_math) = 'cases';
    &process_undefined_environment(
	'displaymath' , ++$global{'max_id'}, $saved);
}

sub do_env_split {
    local($_) = @_;
    local($failed, $labels, $comment, $doimage) = ('','');
    local($saved) = join('',"\\begin\{split\}\n", $_, "\\end\{split\}\n");
    local($sbig,$ebig)= &set_math_size($math_mode);
    $failed = 1 if ($NO_SIMPLE_MATH); # simplifies the next call

    local($falign) = 'CENTER';
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/) unless ($outer_math); # force an image
    local($outer_math) = $env unless ($outer_math);

    if ($failed) {
	$_ = &process_undefined_environment(
		$outer_math.(($numbered) ? '':"*"), $id, $saved);
	$falign = (($EQN_TAGS =~ /L/)? 'LEFT' : 'RIGHT') if $numbered;
	local($fsdisplay,$fedisplay) = ($spdisplay,$epdisplay);
	if (!($fsdisplay =~ s/(ALIGN\s*=\s*\")[^\"]*\"/$1$falign\"/)) {
	    $fsdisplay .= "<DIV class=\"$falign\">";
	    $fedisplay = '</DIV>'.$epdisplay;
	}
	$_ = join('', $fsdisplay, $labels, $comment, $_, $fedisplay);

    } elsif ($NO_SIMPLE_MATH) {
	$failed = 0;
	local($outer_math) = 0; #  not an "outer" environment

	s/$htmlimage_rx/$doimage = $&;''/eo ; # forces images of cells
	s/$htmlimage_pr_rx/$doimage .= $&;''/eo ; # force an image
	local($valign) = &set_math_valign();
	local($sarray, $srow, $scell, $calign, $ecell, $erow, $earray);

	local($env_id) = $env_id;
	if ($USING_STYLES) {
	    $env_style{$env} = "" unless ($env_style{$env});
	}
	($sarray, $erow, $earray, $sempty, $calign) = ( 
	    $smarray.$env_id.$smarrayB.$emtag.">", $emrow 
	    , $emarray, $mnocell.$mspace, $mcalign );
	$env_id = '';

	($srow, $scell, $ecell, $slcell, $srcell) = (
	    $smrow.$valign.$emtag , $smncell, $emcell
	    , $smcell.$mralign, $smncell.$mlalign );

	local($return) = &start_math_display ( $sarray );

	$_ = &protect_array_envs($_);

	local(@rows,$eqno,$thismath);
	s/\\\\[ \t]*(\*|\[[^\]]*])/\\\\/g; # remove forced line-heights
	@rows = split(/\\\\/);
	$#rows-- if ( $rows[$#rows] =~ /^\s*$/ );
	foreach (@rows) { # displaymath
	    next if (/^\s*$/); # ignore last row, if empty

	    if (s/\\shove(righ|lef)t//) {
		local($whichway) = $1;
	        $return .= (($1 =~/lef/)? $mlalign : $mralign );
		if (($doimage)||($failed)) {
		    $_ = &process_math_in_latex("indisplay",'',''
		        , $doimage.$_ ) unless ($_ eq '');
		} else { 
		    $_ = &make_math('display','','',$_) unless ($_ eq '')
		}
		if (!($_ eq '')) {
		    $return .= join(''
			, (($whichway =~ /lef/)? $mspace.$mspace : '')
			, ((/^$smarray/)? $_ : $sbig.$_.$ebig )
			, (($whichway =~ /lef/)? '' : $mspace.$mspace )
			, $ecell , $erow);
		} else { $return .= join('', $mspace , $ecell, $erow); } 
		next;
	    } else {
		$return .= $srow;
	    }

	    # columns to be set using \displaystyle
	    @cols = split(/$mdlim/o);
	    # left column, set using \displaystyle
	    $thismath = shift(@cols); 
	    $thismath =~ s/(^\s*|\s*$)//gm;
	    if (($doimage)||($failed)) {
	        $thismath = &process_math_in_latex("indisplay",'',''
		    , $doimage.$thismath ) unless ($thismath eq '' );
	    } else {
	        $thismath = &make_math('display','',''
		    , $thismath) unless ( $thismath eq '' );
	    }
	    if (!($thismath eq '')) {
	        $return .= join('', $slcell
                        , (($thismath=~/^$smarray/)? $thismath
			    : $sbig.$thismath.$ebig )
			, $ecell);
	    } else { $return .= $sempty.$ecell; }

	    # right column, set using \displaystyle
	    $thismath = shift(@cols);
	    $thismath =~ s/(^\s*|\s*$)//gm;
	    if (($doimage)||($failed)) {
		$thismath = &process_math_in_latex("indisplay",'',''
		    , $doimage.$thismath ) unless ($thismath eq '' );
	    } else {
		$thismath = &make_math('display','',''
		    , $thismath) unless ( $thismath eq '' );
	    }
	    if (!($thismath eq '')) {
		$return .= join('', $srcell
		    , (($thismath=~/^$smarray/)? $thismath
			: $sbig.$thismath.$ebig )
		    , $ecell);
	    } else { $return .= $sempty . $ecell}

	    $return .= $erow;
	}
	$_ = &end_math_display($return , $earray );
    } else {
	$_ = &do_htmlmath_array('rl');
    }
    $_;
}

1;                              # This must be the last line












