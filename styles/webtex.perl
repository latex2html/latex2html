##
## File: webtex.perl   by  Ross Moore <ross@mpce.mq.edu.au>
##
#################################################################
##
##  work done at the Geometry Center, University of Minnesota
##  commenced during a visit to:
##
##  The National Science Foundation,
##  Science and Technology Research Center for the
##  Computation and Visualization of Geometric Structures
##  funded by  NSF/DMS89-20161
##
#################################################################

package main;
#

# configuration variable defaults

$WEBEQ_OLD = 1 unless $WEBEQ_OLD;	# default until new version is available
$WEBEQ_MML_ONLY = '' unless $WEBEQ_MML_ONLY;
$WEBEQ_APP_ONLY = '' unless $WEBEQ_APP_ONLY;
$WEBEQ_IMG_ONLY = '' unless $WEBEQ_IMG_ONLY;
$WEBEQ_APPMML = 1  unless ($WEBEQ_APPMML);
$WEBEQ_NOIMG  = '' unless ($WEBEQ_NOIMG);


# Package options

sub do_webtex_old { $WEBEQ_OLD = 1; }
sub do_webtex_new { $WEBEQ_OLD = ''; }

sub do_webtex_mmlonly { $WEBEQ_MML_ONLY = 1;
	$WEBEQ_IMG_ONLY = $WEBEQ_APP_ONLY = ''; }
sub do_webtex_apponly { $WEBEQ_APP_ONLY = 1;
	$WEBEQ_MML_ONLY = $WEBEQ_IMG_ONLY = ''; }
sub do_webtex_imgonly { $WEBEQ_IMG_ONLY = 1;
	$WEBEQ_MML_ONLY = $WEBEQ_APP_ONLY = ''; }
sub do_webtex_mmlapp { $WEBEQ_APPMML = 0; $WEBEQ_IMG_ONLY = ''; }
sub do_webtex_appmml { $WEBEQ_APPMML = 1; $WEBEQ_IMG_ONLY = ''; }
sub do_webtex_noimg  { $WEBEQ_NOIMG  = 1; $WEBEQ_IMG_ONLY = ''; }


sub do_webtex_white { $WEBEQ_BKG = 'ffffff'; }

sub do_webtex_text { $WEBEQ_MIME = ' TYPE="text/mathml"'; }
sub do_webtex_application { $WEBEQ_MIME = ' TYPE="application/mathml"'; }

## Mathematics environments


#
# Inline math,  $...$
#
sub do_env_tex2html_wrap_inline {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment) = ("inline",'','');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border, $web_failed, $alt_math);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
    s/(^\s*(\$|\\\()\s*|\s*(\$|\\\))\s*$)//g; # remove the \$ signs or \(..\)

    ($labels, $comment, $alt_math) = &process_math_env($math_mode,$_);
    $comment =~ s/^\n//; # remove the leading \n
    ($web_failed, $_) = &convert_to_webtex('inline',$saved,$alt_math);
    if ($failed) {
	$_ = join ('', $labels, $comment 
            , &process_undefined_environment("tex2html_wrap_inline", $id, $saved));
    } else { $_ = join('', $labels, $comment, $_); }
    if ($border||($attribs)) { 
        &make_table( $border, $attribs, '', '', '', $_ ) 
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
    local($halign) = $math_class unless $FLUSH_EQN;
    local($sbig,$ebig,$web_failed);
    ($sbig,$ebig) = ('<BIG>','</BIG>')
	if (($DISP_SCALE_FACTOR)&&($DISP_SCALE_FACTOR >= 1.2 ));

    ($labels, $comment, $alt_math) = &process_math_env($math_mode,$_);
    ($web_failed, $_) = &convert_to_webtex('display',$saved,$alt_math);

    if ($failed) {
	$_ = &process_undefined_environment("displaymath", $id, $saved);
	s/^[ \t]*\n?/\n/; s/\n?[ \t]*$/\n/; 
	$_ = (($comment.$labels)? "$comment$labels\n":''). $_;
    } else {
	s/^[ \t]*\n?/\n/; s/\n?[ \t]*$/\n/;
	$_ = (($comment.$labels)? "$comment$labels\n":'').$sbig.$_.$ebig;
    }
    if ($border||($attribs)) {
	join('',"<BR>\n<DIV$math_class>\n"
            , &make_table( $border, $attribs, '', '', '', $_ )
	    , "</DIV>\n<BR CLEAR=\"ALL\">");
    } else { 
        join('',"<BR><P></P>\n<DIV$math_class>",$_
            ,"</DIV><BR CLEAR=\"ALL\">\n<P></P>");
    }
}


sub convert_to_webtex {
    local($mode,$orig,$no_applet) = @_;

    print "\nWebTeX:$mode:". ($WEBEQ_NOIMG ? 'no' : 'with')
	. ' images' . ($WEBEQ_IMG_ONLY ? ' only' : '') . "\n$_\n"
	    if ($VERBOSITY > 1);
    if($WEBEQ_IMG_ONLY) { return (1,$no_applet) };

    local($savedRS, $failed, $env_id, $_) = ($/,'','',$orig);
    $/='';
    if ($mode =~ /inline/) {
	if (/^\s*\\\(/) { $failed = 1 }
	else {
	    $_ = &revert_to_raw_tex($_);
	    $_ =~ s/^\s*\$?/\$/sm;
	    $_ =~ s/\$?$/\$/sm;
	    $env_id .= $WEBEQ_INL if $USING_STYLES;
	}
    } elsif ($mode =~ /display/) {
	if (/^\s*\$\$/) { $failed = 1 }
	else {
	    $_ = &revert_to_raw_tex($_);
	    $_ =~ s/^\s*(\\\[|\$\$)?/\\\[/sm;
	    $_ =~ s/(\$\$|\\\])?\s*$/\\\]/sm;
	    $env_id .= $WEBEQ_DIS if $USING_STYLES;
	}
    } else {
	print " *** Unknown WebTeX mode, no applet ***";
	$/ = $savedRS;
	return (0,$no_applet)
    }
    $/ = $savedRS;
    return (0,$no_applet) if $failed;

    ($failed,$_) = &check_only_webtex($_);
    return (0,$no_applet) if $failed;

    local($webeq_abbrev);
    SWITCH: {
	if ($WEBEQ_IMG_ONLY) { $webeq_abbrev = ''; last SWITCH; };
	if ($WEBEQ_MML_ONLY) { $webeq_abbrev = 'MML'; last SWITCH; };
	if ($WEBEQ_APP_ONLY) { $webeq_abbrev = 'APP'; last SWITCH; };
	if ($WEBEQ_APPMML) { $webeq_abbrev = 'APPMML'; last SWITCH; }
	else { $webeq_abbrev = 'MMLAPP'; last SWITCH; }
    };
    $webeq_abbrev .= (($WEBEQ_NOIMG || $WEBEQ_MML_ONLY) ? ':' : 'IMG:' );

    local($uucontents) = &encode(&addto_encoding('webeq'.$mode.$webeq_abbrev,$_));
#    local($cached) = $WEBEQ_CACHE{$uucontents};
    local($cached) = $cached_env_image{$uucontents};
    if ($cached) {
	$_ = $cached;
    } else {
	$verbatim{++$global{'verbatim_counter'}} = $_;
	local($verb_math) = join("",$verbatim_mark
		, 'verbatim',$global{'verbatim_counter'},'#');

	# don't bother making an image, use LaTeX2HTML's one
	$WEBEQ_IMG = $WEBEQ_NONE;

	++$WEBEQ_CTR;
	local($WEBEQ_CMD);
	local($WEBEQ_PRE) = "wbq${WEBEQ_CTR}"
		. (($WEBEQ_OLD &&(!$WEBEQ_IMG eq $WEBEQ_NONE))? 'a':'');
	local($wbq_src) = $WEBEQ_PRE.'.src';
	local($out_app) = $WEBEQ_PRE.'.app';
	local($out_tag) = $WEBEQ_PRE.'.tag';
	local($out_jpg) = $WEBEQ_PRE.'1.jpg';
	local($out_png) = $WEBEQ_PRE.'1.png';
	local($out_mml) = $WEBEQ_PRE.'.mml';
	local($out_err) = $WEBEQ_PRE.'.err';
	local($mml_tag, $app_tag, $ewebeq) = ('','','</NOEMBED>');

#	local($WEBEQ_IMG) = (($IMAGE_TYPE =~ /png/) ? $WEBEQ_PNG : $WEBEQ_JPG);
#	local($out_img) = (($IMAGE_TYPE =~ /png/) ? $out_png : $out_jpg);


	open (SRC , ">$wbq_src");
	print SRC $_;
	close SRC;

	local($eapplet) = '</applet>';
	local($snoembed) = "<NOEMBED>\n";
	local($enoembed) = '</NOEMBED>';
	local($width,$height,$align);

    if (!$WEBEQ_APP_ONLY) {
	$WEBEQ_CMD = $WEBEQ.$WEBEQ_OPTS.$WEBEQ_MML.$WEBEQ_PARSER.$WEBEQ_IMG
	   ." -errors $out_err -o $out_mml $wbq_src\n";
	print "\n$WEBEQ_CMD" if $DEBUG;
	if (system $WEBEQ_CMD) {
	    &webeq_failed($out_mml); $out_mml = '';
	} else {
	    ($width,$height,$align) = 
		&cleanup_mml_attribs($out_mml,$mode,$no_applet);
	    $mml_tag = join('', '<EMBED SRC="', $out_mml, '"'
			, $WEBEQ_MIME , "\n "
			, ($height ? " HEIGHT=\"$height\"" : '')
			, ($width ? " WIDTH=\"$width\"" : '')
			, ' ALIGN="'.($align ? $align : 'MIDDLE').'"'
			, ">\n</EMBED>\n");
	}
	print "\nMATHML:\n$mml_tag\n" if ($DEBUG ||($VERBOSITY>1));
    };


    if (!$WEBEQ_MML_ONLY) {
	$WEBEQ_CMD = $WEBEQ.$WEBEQ_OPTS.$WEBEQ_APP.$WEBEQ_IMG.$WEBEQ_PARSER
	    ." -imgtype none -errors $out_err -o $out_tag $wbq_src\n";
	print "\n$WEBEQ_CMD" if $DEBUG;
	if (system $WEBEQ_CMD) {
	    $_ = $no_applet;
	    &webeq_failed($out_tag); $out_tag = '';
	} else {
	    open(TAG, "<$out_tag");
	    $app_tag = join('',<TAG>);
	    close(TAG);
	    # replace webeq fall-back image by LaTeX2HTML's own, or none at all
#	    $app_tag =~ s/<img[^>]*>/($WEBEQ_NOIMG ? '' : $no_applet)/e;
#	    $app_tag =~ s|(\n?</applet>)\s*|($WEBEQ_NOIMG ? '' : $no_applet).$1|e;
	    if ($mode =~ /display/) {
		# remove initial space, line-ends and HTML tags
		$app_tag =~ s/^\s*(<P><CENTER>)?//s;
		$app_tag =~ s|(</CENTER><P>)?\s*$||s;
	    }

	    # cleanup blank lines
	    $app_tag =~ s/\n[ \t]*\n/\n/sg;

	    local($code);
	    $app_tag =~ s/(<param[^"\n]*name=eq value=")([^"]*)(">)/
		$code = $2;
		$code =~ s|[<>"&]|'&'.$html_special_entities{$&}.';'|eg;
		$verbatim{++$global{'verbatim_counter'}} = $code;
		join("", $1, $verbatim_mark
		    , 'rawhtml', $global{'verbatim_counter'},'#',$3)/e;
	}
    }

    SWITCH: {
	if ($WEBEQ_MML_ONLY) {
	    return (0,$no_applet) unless $mml_tag;
	    $_ = $mml_tag . $snoembed . $enoembed;
	    last SWITCH }

	if ($WEBEQ_APP_ONLY) {
	    return (0,$no_applet) unless $app_tag;
	    $_ = $app_tag;
	    last SWITCH }

	if ($WEBEQ_APPMML) {
	    $_ = $app_tag;
	    $_ =~ s/(\Q$eapplet\E)\s*$/$mml_tag$snoembed$enoembed$1/;
	    last SWITCH;
	} else {
	    $_ = join('', $mml_tag
		, $snoembed, $app_tag , $enoembed );
	    last SWITCH;
	}
    }

	if (($WEBEQ_IMG eq $WEBEQ_NONE)&&(!$WEBEQ_NOIMG)) {
	    # insert the fall-back material
	    $_ =~ s/((\s*($eapplet|$enoembed))+)\s*$/$no_applet$1/;
	} elsif ($WEBEQ_NOIMG) {
	    $_ =~ s/$snoembed\s*$enoembed//g;
	} 

	if ($HTML_VERSION >= 4.0) {
	    # use <OBJECT> tag, not the deprecated <APPLET> tag
	    $_ =~ s/^\s*<(APPLET|EMBED)/<OBJECT$env_id/igs;
#	    $_ =~ s/<(APPLET|EMBED)/<OBJECT$env_id/igs;
	    $_ =~ s/<\/(APPLET|(NO)?EMBED)>\s*$/<\/OBJECT>/igs;
	    $_ =~ s/<\/(OBJECT|EMBED)>\s*<NOEMBED>//g;
	    $_ =~ s/ SRC=/ DATA=/gi;
	    $_ =~ s/ NAME=/ ID=/gi;
	    $_ =~ s/ PLUGINURL=/ CLASSID=/gi;
	    $_ =~ s/ PLUGINSPAGE=/ CODEBASE=/gi;
	    print "\nOBJECT:$_\n" if ($DEBUG||($VERBOSITY > 1));
	}


#	$WEBEQ_CACHE{$uucontents} = $_;
	$cached_env_image{$uucontents} = $_ unless $WEBEQ_IMG_ONLY;
    
    } # end of  if($cached) { ... } else {

    ($failed,$_);
}

# check that the only macro-names are those known to WebTeX
sub check_only_webtex {
    local($webtex) = @_;
#    $webtex =~ s/\'/\\prime /g;		# coerce ' --> \prime
    (0,$webtex);
}

sub webeq_failed {
    local($err_str) = "\n*** WebEQ failed to make image @_[0] ***";
    print $err_str."\n" if ($DEBUG || ($VERBOSITY > 1));
    &write_warnings($err_str);
}

# early versions of  webeq  started with <P><CENTER> tags and their ends
# remove these, if they exist.
sub cleanup_mml_attribs {
    local($mml_file,$mode,$_) = @_;
    local($width,$height,$align);
    open (MML, "<$mml_file");
    local($mml_code) = join('',<MML>);
    close MML;

    local($savedRS) = $/; $/='';
    $mml_code =~ s/^\s*<P><CENTER>\n?//s;
    $mml_code =~ s/\s*<applet code="[^"]*" width=(\d+) height=(\d+) align=(\w+)>\s*/
	$width=$1;$height=$2;$align=$3;''/e;
    $mml_code =~ s/<param[^>\n]*>?\n//g;
    $mml_code =~ s|(\n\">\s*</applet>\s*)?\s*</CENTER><P>\s*||s;
    $mml_code =~ s|\n\">\s*</applet>\s*||s;
    $mml_code =~ s/\&($WEBEQ_mml_name_rx);/$WEBEQ_mml_name{$1}/eg;
    $mml_code =~ s/\&($WEBEQ_mml_punct_rx);/$WEBEQ_mml_punct{$1}/eg;
    # catch superscripted primes --- put them into the preceding tag
    $mml_code =~ s|<(msup>)\s*<([^>]*>)([^<>]*)</\2\s*<mo>\&prime;</mo>\s*</\1|<$2$3\'</$2|sg;
    open (MML, ">$mml_file");
    print MML $mml_code;
    close MML;

    if ($mode =~/display/) {
	# webweq has already used a scaling for \displaystyle
	if ($width) { $width *= $WEBEQ_TCX_REL_SCALE; $width = int($width + 0.5) }
	if ($height) { $height *= $WEBEQ_TCX_REL_SCALE; $height = int($height + 0.5) }
    } elsif ($no_applet) {
	local($find_width,$find_height,$val) = ($width,$height);
	&replace_image_marks;
	if (s/(WIDTH|HEIGHT)\s*=\s*"?(\d+)"?/$val=$2;
		if ($1 eq 'WIDTH') { $find_width = $val if ($val > $find_width) }
		else { $find_height = $val if ($val > $find_height) };''/esg ) {
	    if (/ALIGN="MIDDLE"/) { $height *= 2; }
	    else { $height *= $WEBEQ_TCX_INL_SCALE; }
	    $width *= $WEBEQ_TCX_INL_SCALE;
	    if ($find_width > $width) { $width = $find_width };
	    if ($find_height > $height) { $height = $find_height };
	} else {
	    print "\nNo HEIGHT/WIDTH info within: $_ ***";
	    if ($width) { $width *= $WEBEQ_TCX_INL_SCALE }
	    if ($height) { $height *= $WEBEQ_TCX_INL_SCALE }
	}
    } else {
	# tech-explorer uses a scaling of roughly 1.5
	if ($width) { $width *= $WEBEQ_TCX_INL_SCALE }
	if ($height) { $height *= $WEBEQ_TCX_INL_SCALE }
    }
    $width = 10 + int($width + 0.5) if $width;
    $height = 5 + int($height + 0.5) if $height;
    ($width,$height,$align);
}

# Fix entity-name errors in webeq output
%WEBEQ_mml_name = (
	 'in'	, '&isin;'			# 
	, 'setminus' , "\\"			# &setminus;
	, 'mapsto' , '&nbsp;- > '		# &setminus;
	, 'times' , '&nbsp;x '			# &times;
	, 'rightarrow' , '&nbsp;-- > '		# &rarrow;
	, 'longrightarrow' , '&nbsp;--- > '	# &rrarrow;
	);
$WEBEQ_mml_name_rx = join('|', keys %WEBEQ_mml_name);


%WEBEQ_mml_punct = (
	 ','	, ' '		# '&thinsp;'
#	 '.'	, '&dot;'	# dot accent
	, ':'	, '&nbsp;'	# '&medsp;'
	, ';'	, ' &nbsp;'	# '&thicksp;'
	, '!'	, '&negsp;'
	, '~'	, '&nbsp;'
#	, '`'	, '`'		# acute accent
#	, '''	, '''		# grave -- accent;
#	, '"'	, '"'		# umlaut -- accent;
	, '@'	, '@'
	, '#'	, '#'
	, '$'	, '$'
	, '%'	, '%'
#	, '^'	, '^'		# caret -- accent;
	, '&'	, '&amp;'
	, '*'	, '&star;'
	, '('	, ''
	, ')'	, ''
	, '-'	, ''
	, '_'	, '_'
	, '+'	, ''
	, '='	, ''
	, '='	, ''
	, '['	, '['
	, ']'	, ']'
	, '|'	, '||'		# &Vert;  or  &Verbar;
	, '<'	, '&langle;'
	, '>'	, '&rangle;'
	, '{'	, '{'		# &lbrace; 
	, '}'	, '}'		# &rbrace; 
	);
$WEBEQ_mml_punct_rx = "\\W";


$WEBEQ_CLASSES = $ENV{'CLASSPATH'};
print " *** no JAVA classes*** \n
 please set the CLASSPATH variable\n" unless $WEBEQ_CLASSES;

$WEBEQ_CTR = '';
$WEBEQ = 'java webeq.wizard.clwizard ';
$WEBEQ_OPTS = ' -colorspace colors -quality excellent -linewrap true -allow_selection true ';
$WEBEQ_PARSER = ' -parser WebTeX -delims WebTeX ';
$WEBEQ_PMML = ' -parser MathML -delims MathML ';
$WEBEQ_APP = ' -outtype Applets';
$WEBEQ_IMG = ' -outtype Images_Only';
#$WEBEQ_MML = ' -outtype MathML_Only';
$WEBEQ_MML = ' -outtype MathML_Applets';
$WEBEQ_JPG = ' -imgtype jpeg';
$WEBEQ_PNG = ' -imgtype png';
$WEBEQ_NONE = ' -imgtype none';
$WEBEQ_ERR = ' -errors ';
$WEBEQ_OUT = ' -o ';
#$WEBEQ_MIME = ' TYPE="application/mathml"';
$WEBEQ_MIME = ' TYPE="text/mathml"';
$WEBEQ_JAVA = ' TYPE="application/java"';
$WEBEQ_INL = ' CLASS="INLINE"';
$WEBEQ_DIS = ' CLASS="DISPLAY"';
$WEBEQ_BKG = ' color=#ffffff';
$WEBEQ_TCX_REL_SCALE = 1.2;
$WEBEQ_TCX_INL_SCALE = 1.6;

%WEBEQ_CACHE = ();

&ignore_commands( <<_IGNORED_CMDS_);
_IGNORED_CMDS_


&process_commands_wrap_deferred (<<_RAW_ARG_DEFERRED_CMDS_);
_RAW_ARG_DEFERRED_CMDS_

1;

