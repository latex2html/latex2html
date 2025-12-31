# -*- perl -*-
#
# $Id: color.perl,v 1.24 2001/02/17 22:42:06 RRM Exp $
# color.perl by Michel Goossens <goossens@cern.ch>  01-14-96
#
# Extension to LaTeX2HTML V 96.2 to support color.sty
# which is part of standard LaTeX2e graphics bundle.
#
# Revisions by Ross Moore <ross@mpce.mq.edu.au>
#  1.  implementing named colors
#  2.  read color specifications from files
#  3.  for compatibility with the option-loading mechanism V96.2 
#  4.  \pagecolor and \color implemented, using $BODYTEXT 
#
#
# Change Log:
# ===========
# $Log: color.perl,v $
# Revision 1.24  2001/02/17 22:42:06  RRM
#  --  defined RGB, CMYK, GRAY color models
#      these are the same as rgb, cmyk, gray but using integer coords
#      in the range 0 --> 255 with each component.
#      Note that not all LaTeX drivers support all of these models.
#
# Revision 1.23  1999/10/12 13:15:39  RRM
#  --  handle all color-changing commands via declarations
#
# Revision 1.22  1999/09/16 09:57:01  RRM
#  --  fixed error merging the previous changes
#
# Revision 1.21  1999/09/16 09:30:41  RRM
#  --  fixed errors in  do_cmd_fcolorbox
#  	thanks to John McNaught for reporting the errors
#
# Revision 1.20  1999/09/14 22:02:02  MRO
#
# -- numerous cleanups, no new features
#
# Revision 1.19  1999/06/10 23:00:20  MRO
#
#
# -- fixed an artifact in the *ball icons
# -- cleanups
# -- option documentation added
# -- fixed bug in color perl (determining path to rgb/crayola)
#
# Revision 1.18  1999/06/04 07:36:28  RRM
#  --  &read_rgb_colors  and  &read_cmyk_colors  failed with a full path
#  	via the new scheme for $RGBCOLORFILE  and  $CRAYOLAFILE
#      Now the filename argument may include the complete path, or just
#      	the name of a file on a path in $LATEX2HTMLSTYLES
#
# Revision 1.17  1999/03/12 06:30:58  RRM
#  --  made \DefineNamedColor more robust,
#  	it now works sequentially in the preamble
#
# Revision 1.16  1999/03/03 10:34:17  RRM
#  --  fixed error in  &find_color  that lost all but the 1st component
#  	in rgb  and cmyk color-spaces.
#
# Revision 1.15  1998/06/26 07:16:37  RRM
#  --  simplified reading of crayola.txt fro CMYK colors
#
# Revision 1.14  1998/05/19 11:35:43  latex2html
#  --  \textcolor inside math needs to pass $color_env back outside.
#
# Revision 1.13  1998/05/15 12:46:40  latex2html
#  --  color is used with more environments, so need $color_env to be
#     a local variable
#
# Revision 1.12  1998/04/28 13:13:23  latex2html
#  --  fixed \color and \textcolor so that the tags nest correctly when
#      used in a non-trivial way
#  --  sets $color_env variable, so that color can be included with the
#      code used for images; hence colored math expressions work correctly
#
# Revision 1.11  1997/12/08 12:45:17  RRM
#  --  updated the color macros for style-sheets
#
# Revision 1.10  1997/11/05 10:35:29  RRM
#  --  added "..." around color attribute values
#
# Revision 1.9  1997/06/06 12:02:44  RRM
#  -  Changed some VERBOSITY levels
#  -  added some error-detection to  finding the requested color
#  -  made  \color and  \pagecolor to be of `deferred' type
#
# Revision 1.8  1997/05/19 13:39:21  RRM
#     Recognises color Names, as well as names (note capitalization).
#
# Revision 1.7  1997/05/11 03:56:21  RRM
#      ... and don't forget the "s around attribute values.
#
# Revision 1.6  1997/05/11 03:46:30  RRM
#      Oops, default segment-pagecolor was #111111, now is #FFFFFF (White).
#
# Revision 1.5  1997/05/09 12:10:51  RRM
#     Added some $VERBOSITY tracing, and cosmetic changes to messages.
#
# Revision 1.4  1997/01/03 12:17:24  L2HADMIN
# changes by RRM
#
# Revision 1.3  1996/12/25 03:03:19  JCL
# must ignore also \segmentcolor{} if colors not available
#
# Revision 1.2  1996/12/20 03:59:05  JCL
# changed reserved COLOR_HTML_VERSION to HTML_VERSION for use with 3.2
#
#
# JCL: 16 Sept 1996
#  -    introduced $PREAMBLE
#  -    introduced $COLOR_HTML to explicitly use colors,
#       and $COLOR_HTML_VERSION for future usage.
#
# RRM: 28 June 1996
#  -	added support for named colors, using
#		1. rgb, cmyk, gray  models
#		2. the 8 standard primaries and secondaries
#		3. color names and values read from  rgb.txt
#  -	implemented  \definecolor
#
# RRM: 1 July 1996
#  -	extend color-name search to include all lower-case;
#  -	recognise 6-letter Hex-strings (3 nibbles) as color-names.
#  -	when reading rgb.txt values can be integers or decimals.
#  -	read_rgb_colors  now has filename parameter (e.g. `rgb.txt').
#  -	read read_cmyk_colors  implemented similarly.
#
# RRM: 12 July 1996
#  -	recognises LaTeX's package options;
#  -	implements loading of Crayola colors, via the dvips option;
#
# RRM: 26 July 1996
#  -	\pagecolor and \color implemented, to modify $BODYTEXT;
#  -	added $RGBCOLORFILE variable for main source of named colors;
#

package main;

$html_color_version = "3.2";
$RGBCOLORFILE = "rgb.txt" unless ($RGBCOLORFILE);
$CRAYOLAFILE = "crayola.txt" unless ($CRAYOLAFILE);
$BKGSTRING = "bgcolor";

sub read_rgb_colors {
    local($base_file) = @_;
    local($file) = $base_file;
    local($r,$g,$b,$name,$dir);
    foreach $dir (split(/$envkey/,$LATEX2HTMLSTYLES)) {
    	$file = "$dir$dd$base_file"
          unless (L2hos->is_absolute_path($base_file));
          # unless ($base_file =~/^\Q$dd\E/);
	if (-f $file) {
            if (open(COLORFILE,"<$file")) {
		print STDOUT "\n(reading colors from $file" if $DEBUG;
		while (<COLORFILE>) {
	s/^\s*(\d+)\s+(\d+)\s+(\d+)\s+(\w+(\s\w+)*)\s*/
	    ($r,$g,$b,$name)=($1,$2,$3,$4);
	    $named_color{$name} = &encode_rgbcolor($r,$g,$b);
	    print STDOUT "\n$name = $named_color{$name}" if ($VERBOSITY > 5);
		/e;
		}
		close(COLORFILE);
		print STDOUT ")\n" if $DEBUG;
		last
	    } else { 
		print STDERR "$file could not be opened:$dir\n";
	    }
	}
    }
    $_[0];
}

sub read_cmyk_colors {
    local($base_file) = @_;
    local($file) = $base_file;
    local($c,$m,$y,$k,$name,$dir,@colors);
    local($num_rx) = "(\\d|\\d\\.\\d*)";
    foreach $dir (split(/$envkey/,$LATEX2HTMLSTYLES)) {
    	$file = "$dir$dd$base_file"
          unless (L2hos->is_absolute_path($base_file));
          # unless ($base_file =~/^\Q$dd\E/);
	if (-f $file) {
	    if (open(COLORFILE,"<$file")) {
		print STDOUT "\n(reading colors from $file";
		@colors = (<COLORFILE>);
		foreach (@colors) {
		    next if (/^\s*$/);
#  s/^\s*(\w+)\s+(\d|\d\.\d*)\s+(\d|\d\.\d*)\s+(\d|\d\.\d*)\s+(\d|\d\.\d*)\s*$/
		    s/^\s*(\w+)\s+$num_rx\s+$num_rx\s+$num_rx\s+$num_rx\s*$/
			($name,$c,$m,$y,$k)=($1,$2,$3,$4,$5);
			if ($named_color{$name}) {
			    print STDOUT "***$name = \#$named_color{$name}\n"
		   		if ($VERBOSITY > 3);
			}
			$named_color{$name} = &get_cmyk_color($c,$m,$y,$k);
			print STDOUT "$name = \#$named_color{$name}\n"
			    if ($VERBOSITY > 3);
		    /oe;
		}
		close(COLORFILE); undef @colors;
		print STDOUT ")\n";
		last;
	    } else { 
		print STDERR "$file could not be opened:$dir\n";
	    }
	} 
    }
    $_[0];
}

sub encode_rgbcolor {
    local($r,$g,$b) = @_;
    if (($r =~ s/\./\./o)) {
	&get_rgb_color($r,$g,$b);
    } else {
	local($str)=sprintf("%2x%2x%2x",$r,$g,$b);
	$str =~ s/\s/0/g;
	$str;
#	($r,$g,$b) = map(unpack("H2",pack("S",$_)),($r,$g,$b));
#	"$r$g$b";
    }
}

# colour names are case-sensitive.
# However, if the exact name is not found, 
# then a lowercase version is tried.
# Only if this also fails is the default `black' used.
#
# Hex-strings: #<3 nibbles>  are recognised and return 
# just the nibbles. These can be of either case. 

sub get_named_color {
    local($name) = @_;
    $name =~ s/^[\s\t\n]*//o; $name =~ s/[\s\t\n]*$//o;
    if ($name =~ s/^\#//o ) {
	if (length($name)==6) {
	    $name =~ tr/A-Z/a-z/;
	    return ($name);
	}
    }
    if ($named_color{$name}) { $named_color{$name} }
    elsif ($named_color{$name."1"}) { $named_color{$name."1"} }
    else {
	local($lcname) = $name;
	$lcname =~ tr/A-Z/a-z/;
	print "no color for $name, trying $lcname";
	if ($named_color{$lcname}) { $named_color{$lcname} }
	elsif ($named_color{$lcname."1"}) { $named_color{$lcname."1"} }
	else { 
	    print STDERR "\nunknown color $name, using ";
	    ""; }
    }
}

sub get_rgb_color {
    local($r,$g,$b) = @_;
    if (!("$g$b")) {($r,$g,$b) = split(',',$r)};
    ($r,$g,$b) = (int(255*$r+.5),int(255*$g+.5),int(255*$b+.5));
    local($str)=sprintf("%2x%2x%2x",$r,$g,$b);
    $str=~s/\s/0/g;
    $str;
#    ($r,$g,$b) = map(unpack("H2",pack("S",$_)), ($r,$g,$b));
#    "$r$g$b";
}

sub get_RGB_color {
    local($r,$g,$b) = @_;
    if (!("$g$b")) {($r,$g,$b) = split(',',$r)};
    ($r,$g,$b) = (int($r+.5),int($g+.5),int($b+.5));
    local($str)=sprintf("%2x%2x%2x",$r,$g,$b);
    $str=~s/\s/0/g;
    $str;
}

sub get_cmyk_color {
    local($c,$m,$y,$k) = @_;
    if (!("$m$y$k")) {($c,$m,$y,$k) = split(',',$c)};
    local($r,$g,$b);
#    ($r,$g,$b) = map( 1-$_-$k, ($c,$m,$y));
    ($r,$g,$b) = (1-$c-$k,1-$m-$k,1-$y-$k);
#    ($r,$g,$b) = map( abs($_)/2+$_/2, ($r,$g,$b));
    $r = 0 unless ($r > 0);
    $g = 0 unless ($g > 0);
    $b = 0 unless ($b > 0);
    &get_rgb_color($r,$g,$b);
}

sub get_CMYK_color {
    local($c,$m,$y,$k) = @_;
    if (!("$m$y$k")) {($c,$m,$y,$k) = split(',',$c)};
    local($r,$g,$b);
    ($r,$g,$b) = (1-$c/255-$k/255,1-$m/255-$k/255,1-$y/255-$k/255);
    $r = 0 unless ($r > 0);
    $g = 0 unless ($g > 0);
    $b = 0 unless ($b > 0);
    &get_rgb_color($r,$g,$b);
}

sub get_gray_color {
    local($gray) = @_;
    $gray = int(255*$gray+.5);
    local($str)=sprintf("%2x%2x%2x",$gray,$gray,$gray);
    $str=~s/\s/0/g;
    $str;
#    $gray = unpack("H2",pack("S",$gray));
#    "$gray$gray$gray";
}

sub get_GRAY_color {
    local($gray) = @_;
    $gray = int($gray+.5);
    local($str)=sprintf("%2x%2x%2x",$gray,$gray,$gray);
    $str=~s/\s/0/g;
    $str;
}

sub do_cmd_DefineNamedColor {
    local($_) = @_;
    local($model,$name,$rest);
    $model = &missing_braces unless (
	(s/$next_pair_pr_rx/$model =$2;''/eo)
	||(s/$next_pair_rx/$model =$2;''/eo));
    $rest = $_;
#    local($get_string) = "get_${model}_color";
#    if (defined  &$get_string) {
#	$_ = &do_cmd_definecolor($rest);
#    } else {
#	print "\n*** Defining new Color Model \"$model\" ***\n";
#	&do_DefineColorModel($model);
#	s/$next_pair_pr_rx//o; $name =$2;
#	$_ = &do_cmd_definecolor($rest);
#	${${model}_color}{$name} = $_;
#    }
#    $_ = &do_cmd_definecolor($rest);
#    
    $_ = &do_cmd_definecolor($rest);
    $_;
}

sub do_cmd_definecolor {
    local($_) = @_;
    local($name,$model,$hex)=('','','');
    local(@data,$data, $get_string);
    $name = &missing_braces unless (
	(s/$next_pair_pr_rx/$name =$2;''/eo)
	||(s/$next_pair_rx/$name =$2;''/eo)); 
    $name =~ s/^\s*//g; $name =~ s/\s*$//g;
    $model = &missing_braces unless (
	(s/$next_pair_pr_rx/$model =$2;''/eo)
	||(s/$next_pair_rx/$model =$2;''/eo));
    $model =~ s/^\s*//g; $model =~ s/\s*$//g;
    $data = &missing_braces unless (
	(s/$next_pair_pr_rx/$data =$2;''/eo)
	||(s/$next_pair_rx/$data =$2;''/eo));
    @data = split(/\s*,\s*|\s+/,$data);
    $get_string = "get_${model}_color";
    if (defined  &$get_string) {
	$hex = &$get_string(@data) ;
	if ($hex) {
	    if ($named_color{$name}) {
		print STDERR "\nredefining existing color: $name = \#$hex\n";
	    } else {
		print STDERR "new color: ($name) = \#$hex\n";
	    }
	    $named_color{$name} = "$hex";
	} else { print "\nfailed to make color: $name\n"; }
    } else { 
	print STDERR "\n$model is not a known color model\n";
    }
    $_;
}

sub initialise_colors {
    print STDERR "\n *** initialising colors ***\n";
    $named_color{'black'} = "000000";
    $named_color{'Black'} = "000000";
    $named_color{'gray'} = "808080";
    $named_color{'Gray'} = "808080";
    $named_color{'white'} = "ffffff";
    $named_color{'White'} = "ffffff";
    $named_color{'red'} = "ff0000";
    $named_color{'Red'} = "ff0000";
    $named_color{'green'} = "008000";
    $named_color{'Green'} = "008000";
    $named_color{'blue'} = "0000ff";
    $named_color{'Blue'} = "0000ff";
    $named_color{'yellow'} = "ffff00";
    $named_color{'Yellow'} = "ffff00";
    $named_color{'cyan'} = "00ffff";
    $named_color{'aqua'} = "00ffff";
    $named_color{'Aqua'} = "00ffff";
    $named_color{'magenta'} = "ff00ff";
    $named_color{'fuchsia'} = "ff00ff";
    $named_color{'Fuchsia'} = "ff00ff";
    $named_color{'lime'} = "00ff00";
    $named_color{'Lime'} = "00ff00";
    $named_color{'maroon'} = "800000";
    $named_color{'Maroon'} = "800000";
    $named_color{'navy'} = "000080";
    $named_color{'Navy'} = "000080";
    $named_color{'olive'} = "808000";
    $named_color{'Olive'} = "808000";
    $named_color{'purple'} = "800080";
    $named_color{'Purple'} = "800080";
    $named_color{'silver'} = "c0c0c0";
    $named_color{'Silver'} = "c0c0c0";
    $named_color{'teal'} = "008080";
    $named_color{'Teal'} = "008080";
    &read_rgb_colors($RGBCOLORFILE);
    ${AtBeginDocument_hook} .= "\&set_section_color; ";
}

# \textcolor is for a `local' color-change to specified text

sub do_cmd_textcolor {
    local($color,$_,$color_cmd) = &find_color;
    if (!($color)) {
	$color= "000000";  # default = black
	print STDERR "\ntext color = black\n";
    }

    if ($inside_math) {
	# allow math-parsing to use this $color_env
	$color_env = $color_cmd;
    } else {
	# environments will be parsed with this $color_env
	local($color_env) = $color_cmd;
    }
    push (@$open_tags_R, $color_cmd);
    $_ = &styled_text_chunk("FONT COLOR=\"\#$color\""
	, 'hue', 'font', 'color', "\#$color", '', $_);
    pop (@$open_tags_R); $_;
}

# \pagecolor is for a `global' color-change to the background;
#  see Lamport (2nd ed), bottom of p168.

sub do_cmd_pagecolor {
    local($color,$rest) = &find_color;
    if (!($color)) {
	$color= "ffffff";  # default = white
	print STDERR "\npage color = white\n";}
    &apply_body_options($BKGSTRING,"$color");
    $rest;
}

# colorboxes use the `blink' effect; only one color can be used.

sub do_cmd_colorbox {
    local($color,$_,$color_cmd) = &find_color;
    local($color_env) = $color_cmd;
    push (@$open_tags_R, $color_cmd);
    $_= &styled_text_chunk("BLINK><FONT COLOR=\"\#$color\""
	, 'cbox', 'background', 'color', "\#$color", '', $_);
    s/\/BLINK/\/FONT><\/BLINK/ unless ($USING_STYLES);
    pop (@$open_tags_R);
    $_;
}

sub do_cmd_fcolorbox {
    local($_) = @_;
    my $fcolor, $bcolor, $color_cmd;
    if ($USING_STYLES) { 
	($fcolor, $_, $color_cmd) = &find_color($_);
	($bcolor, $_, $color_cmd) = &find_color($_);
#	push (@$open_tags_R, $color_cmd);  # not needed
	&multi_styled_text_chunk('','fcol',"border,background"
		,",color","solid thin \#$fcolor,\#$bcolor",$_);
#	pop (@$open_tags_R);  # not needed 
    } else {
	(s/$next_pair_pr_rx//o||s/$next_pair_rx//o);
	&do_cmd_colorbox($_);
    }
}


# the result of a \color command depends upon where it is issued:
#   1.  in the preamble: change the global text-color,
#	and save the color for later (sub)sections;
#   2.  bracketed, within preamble -- ignore it;
#   3.  top-level, within the body: treat as a local color change,
#	and save the color for later (sub)sections;
#   4.  bracketed, within the body: treat as a local color change.
#
#RRM:  3 and 4 are not implemented properly yet
#

sub do_cmd_color {
    local($color,$rest,$color_cmd) = &find_color;
    if (!($color)) {
	$color= "000000";  # default = black
	print STDERR "black\n";
    }
    $color_env = $color_cmd;
    if ($tex2html_deferred) {
	$color_cmd = 'color'. $color_cmd unless ($color_cmd =~ /^color/);
	$color_cmd =~ s/\,/ /g;
	$declarations{$color_cmd} = "<FONT COLOR=\"\#$color\"></FONT>"
	    unless ($declarations{$color_cmd});
    }
    if (($PREAMBLE)&&($NESTING_LEVEL == 0)) { 
	&apply_body_options("text","$color");
	$next_section_color = $color;
	$rest;
    } elsif ($PREAMBLE) { 
	$rest;
    } elsif ($NESTING_LEVEL == 0) { 
	push ( @$open_tags_R, $color_cmd );
	$next_section_color = $color;
	join('',"\n<FONT COLOR=\"\#$color\">", $rest )
#	    , ($tex2html_deferred ? '' : "\n</FONT>" ));
    } else {
	push ( @$open_tags_R, $color_cmd );
	join('',"\n<FONT COLOR=\"\#$color\">",$rest )
#	    , (($tex2html_deferred||!$rest) ? '' : "\n</FONT>" ));
    }
}

# use any global color from the previous section
# as the bodytext color for new (sub)sections.
# This is called for each section, from  &translate .

$next_section_color = '';
$next_section_bkgnd_color = '';

sub set_section_color {
    if ($next_section_color) {
	&apply_body_options("text","$next_section_color"); }
    if ($next_section_bkgnd_color) {
	&apply_body_options($BKGSTRING,"$next_section_bkgnd_color"); }
}

sub do_cmd_normalcolor {
    local($_) = @_;
    if ($next_section_color) {
	local($color,$_,$color_cmd) = &find_color($next_section_color);
	if ($color) {
	    local($color_env) = $color_cmd;
	    push (@$open_tags_R, $color_cmd);
	    $_ = &styled_text_chunk("FONT COLOR=\"\#$color\""
		    ,'hue','font','color',"\#$color",'', $_ );
	    pop (@$open_tags_R);
	}
    }
    $_;
}

# \segmentcolor and \segmentpagecolor may be read
# from the .ptr file for a segment, giving global colors.

sub do_cmd_segmentcolor {
    local($color,$_) = &get_model_color(@_);
    if (!($color)) {
	$color= "000000";  # default = black
	print STDERR "black\n";}
    $next_section_color = $color;
    &set_section_color;
    $_;
}

sub do_cmd_segmentpagecolor {
    local($color,$_) = &get_model_color(@_);
    if (!($color)) {
	$color= "FFFFFF";  # default = white
	print STDERR "\nsegment page color = white\n";}
    $next_section_bkgnd_color = $color;
    &set_section_color;
    $_;
}

sub get_model_color {
    local($_) = @_;
    local($color,$model,$rest);
    s/$next_pair_pr_rx//o; $color =$2;
    $color =~ s/(\w+)\s+/$model=$1/eo;
    $color =~ s/^\s*//g;
    if ($model) { 
	$model = "[$model]";
	$color = $';
	$color =~ s/\s+/,/g;	
    }
    $rest = $_;
    local($color,$_) = &find_color("$model<\#0\#>$color<\#0\#>") if ($color);
    ($color,$rest);
}

sub find_color {
    local($_) = @_;
    local($rest,$get_string,$color,$color_cmd,@color);
    local ($model,$dum)=&get_next_optional_argument;
    if (!($dum)) {$model = 'named'}
    else { $color_cmd = &revert_to_raw_tex($dum); $dum = '' }
    $model = "named" unless ($model);
    $get_string = "get_${model}_color";
    $color = &missing_braces
	unless ((s/$next_pair_pr_rx/$color=$2;$dum=$&;''/eo)
	        ||(s/$next_pair_rx/$color=$2;$dum=$&;''/eo));
    $rest =$_;
    $color_cmd .= &revert_to_raw_tex($dum);

    if (!(defined &$get_string)) {
	print "\nno routine for $get_string, trying named color: $color\n";
	$get_string = "get_named_color";
    }
    if ($model =~ /named/) { @color = ($color) }
    else { @color = split(/\s+|,\s*/, $color) }
    $color = &$get_string(@color);
    $color_cmd = 'color'. $color_cmd;
    $declarations{$color_cmd} = "<FONT COLOR=\"\#$color\"></FONT>"
	unless ($declarations{$color_cmd});
    ($color, $rest, $color_cmd );
}

sub apply_body_options{
    local($which,$value)=@_;
    local($body) = $BODYTEXT;
    local($option,$test,%previous);
    $body =~ s/^\s*//o; $body =~ s/\s*$//o;
    $body =~ s/\s*\=\s*/\=/g; $body =~ s/\s+/ /g; 
    @previous = split(' ',$body); $body = '';
    local($found) = 0;
    foreach $option (@previous) {
	$option =~ s/\=/\=/o;
	$test = $`;
	$test =~ tr/A-Z/a-z/;
	if ($test eq $which) { 
	    $body .= " $which=\"\#$value\"";
	    $found = 1;
	} else { $body .= " $`=$'" }
    }
    $body .= " $which=\"\#$value\"" unless ($found);
    $BODYTEXT = $body;
}


# implement usable options from LaTeX

sub do_color_dvips {
    if (!$styles_loaded{color_dvips}) {
	&read_cmyk_colors($CRAYOLAFILE);
	$styles_loaded{color_dvips} = 1;
    }
}

sub do_color_xdvi {
    &do_color_dvips();
    &do_color_monochrome();
}

sub do_color_dvipsnames {
    &do_color_dvips();
}


# cancel redundant options from LaTeX

sub do_color_monochrome {
}

sub do_color_usenames {
}
sub do_color_dvipsnonames {
}
sub do_color_dvgt {
}
sub do_color_dvi2ps {
}
sub do_color_dvialw {
}
sub do_color_dvilaser {
}
sub do_color_dvipsone {
}
sub do_color_dviwindo {
}
sub do_color_dvitops {
}
sub do_color_emtex {
}
sub do_color_dviwin {
}
sub do_color_oztex {
}
sub do_color_psprint {
}
sub do_color_pubps {
}
sub do_color_textures {
}
sub do_color_pctexps {
}
sub do_color_pctexwin {
}
sub do_color_pctexhp {
}
sub do_color_ln {
}

#	Some declarations

&process_commands_nowrap_in_tex ( <<_IGNORED_CMDS_);
#color # [] # {}
pagecolor # [] # {}
_IGNORED_CMDS_

&process_commands_wrap_deferred ( <<_DEFERRED_CMDS_);
color # [] # {}
textcolor # [] # {} # {}
DefineNamedColor # {} # {} # {} # {}
_DEFERRED_CMDS_

# Get rid of color specifications, but keep contents,
# when the html version is inappropriate.

if (($HTML_VERSION lt "$html_color_version") && !($NETSCAPE_HTML)) { do { 
    print STDERR "\n*** color is not supported with HTML version: $HTML_VERSION ***\n";
    undef &set_section_color;
    &ignore_commands( <<_IGNORED_CMDS_);
color # [] # {}
textcolor # [] # {}
pagecolor # [] # {}
colorbox # [] # {}
fcolorbox # [] # {} # [] # {}
_IGNORED_CMDS_
}} else { &initialise_colors(); }

1;	# Must be last line
