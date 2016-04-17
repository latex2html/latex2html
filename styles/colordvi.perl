# colordvi.perl  by Ross Moore <ross@mpce.mq.edu.au>  07-01-96
#
# Extension to LaTeX2HTML V 96.1 to support colordvi.sty
# which defines color-names for the `Crayola' colors, available
# to dvips.
#
# Change Log:
# ===========
# RRM: 26 July 1996
#  -	implemented commands \textRed, \textPlum, etc.
#	mainly for use with LaTeX-2.09 ;
#  -	implemented \background, \textColor
#  	to depend on similar routines in  color.perl.
#  

package main;

sub initialise_crayola {
    &do_require_package("color");
    &do_require_packageoption("color_dvips");
    $GLOBALCOLOR="Black";
    $GLOBALMODEL="";
}

sub do_cmd_background {
    &do_cmd_pagecolor;
}

sub do_cmd_textColor {
    local($_)=@_;
    local($data,$rest);
    &missing_braces unless (
	(s/$next_pair_pr_rx/$data=$2;''/eo)
	||(s/$next_pair_rx/$data=$2;''/eo)); 
    $rest = $_;
    local($cnt) = $data =~ s/,/,/g;
    if (!($cnt== 3)) {
	$data =~ s/^\s+//o;
	$data =~ s/\s+$//o;
	$data =~ s/\s+/,/g;
    }
    $GLOBALMODEL="[cmyk]";
    $GLOBALCOLOR="$data";
    &do_cmd_color("[cmyk]<\#0\#>$data<\#0\#>$rest");
}

sub do_cmd_Color {
    local($_)=@_;
    local($data,$rest);
    &missing_braces unless (
	(s/$next_pair_pr_rx/$data=$2;''/eo)
	||(s/$next_pair_rx/$data=$2;''/eo)); 
    $rest = $_;
    local($cnt) = $data =~ s/,/,/g;
    if (!($cnt== 3)) {
	$data =~ s/^\s+//o;
	$data =~ s/\s+$//o;
	$data =~ s/\s+/,/g;
    }
    &do_cmd_textcolor("[cmyk]<\#0\#>$data<\#0\#>$rest");
}

sub do_cmd_subdef {
    local($_) = @_;
    my $model, $data;
    &missing_braces unless (
	(s/$next_pair_pr_rx/$data=$2;''/eo)
	||(s/$next_pair_rx/$data=$2;''/eo)); 
    $data =~ s/^\s+|\s+$//go;
    $data =~ s/^(\w+)\s+/$model=$1/eo;
    if ($model) { 
	$data = $';
 	$data =~ s/\s+/,/g;
	$GLOBALMODEL="[$model]";
	$GLOBALCOLOR=$data;
    } else {
	$GLOBALMODEL="";
	$GLOBALCOLOR=$data;
    }
    &do_cmd_color("$GLOBALMODEL<\#0\#>$GLOBALCOLOR<\#0\#>");
    $_;
}

sub do_cmd_globalColor {
    local($_) = @_;
    &do_cmd_textcolor("$GLOBALMODEL<\#0\#>$GLOBALCOLOR<\#0\#>$_");
}

sub do_cmd_newColor {
    local($_) = @_;
    local($name);
    s/\s*(\w+)\s*/$name=$1/eo;
    $rest = $';
    eval "sub do_cmd_text$name {"
	. "\$GLOBALMODEL=\"\";"
	. "\$GLOBALCOLOR=\"$name\";"
	. "\&do_named_text_color('$name',\$_[0]);"
	. "}";
    print "\n$@" if ($@);
    &process_commands_wrap_deferred("text$name \n");

    eval "sub do_cmd_$name {"
	. "\&do_named_local_color('$name',\$_[0]);"
	. "}";
    print "\n$@" if ($@);
    &process_commands_wrap_deferred("$name \# \{\}\n");

    $rest;
}

sub do_named_local_color {
    local($name,$_) = @_;
    &do_cmd_textcolor("<\#0\#>$name<\#0\#>$_");    
}

sub do_named_text_color {
    local($name,$_) = @_;
#    local($tex2html_deferred) = 1;
    &do_cmd_color("<\#0\#>$name<\#0\#>".$_);  
}


&initialise_crayola();

&do_cmd_newColor("GreenYellow ");
&do_cmd_newColor("Yellow ");
&do_cmd_newColor("Goldenrod ");
&do_cmd_newColor("Dandelion ");
&do_cmd_newColor("Apricot ");
&do_cmd_newColor("Peach ");
&do_cmd_newColor("Melon ");
&do_cmd_newColor("YellowOrange ");
&do_cmd_newColor("Orange ");
&do_cmd_newColor("BurntOrange ");
&do_cmd_newColor("Bittersweet ");
&do_cmd_newColor("RedOrange ");
&do_cmd_newColor("Mahogany ");
&do_cmd_newColor("Maroon ");
&do_cmd_newColor("BrickRed ");
&do_cmd_newColor("Red ");
&do_cmd_newColor("OrangeRed ");
&do_cmd_newColor("RubineRed ");
&do_cmd_newColor("WildStrawberry ");
&do_cmd_newColor("Salmon ");
&do_cmd_newColor("CarnationPink ");
&do_cmd_newColor("Magenta ");
&do_cmd_newColor("VioletRed ");
&do_cmd_newColor("Rhodamine ");
&do_cmd_newColor("Mulberry ");
&do_cmd_newColor("RedViolet ");
&do_cmd_newColor("Fuchsia ");
&do_cmd_newColor("Lavender ");
&do_cmd_newColor("Thistle ");
&do_cmd_newColor("Orchid ");
&do_cmd_newColor("DarkOrchid ");
&do_cmd_newColor("Purple ");
&do_cmd_newColor("Plum ");
&do_cmd_newColor("Violet ");
&do_cmd_newColor("RoyalPurple ");
&do_cmd_newColor("BlueViolet ");
&do_cmd_newColor("Periwinkle ");
&do_cmd_newColor("CadetBlue ");
&do_cmd_newColor("CornflowerBlue ");
&do_cmd_newColor("MidnightBlue ");
&do_cmd_newColor("NavyBlue ");
&do_cmd_newColor("RoyalBlue ");
&do_cmd_newColor("Blue ");
&do_cmd_newColor("Cerulean ");
&do_cmd_newColor("Cyan ");
&do_cmd_newColor("ProcessBlue ");
&do_cmd_newColor("SkyBlue ");
&do_cmd_newColor("Turquoise ");
&do_cmd_newColor("TealBlue ");
&do_cmd_newColor("Aquamarine ");
&do_cmd_newColor("BlueGreen ");
&do_cmd_newColor("Emerald ");
&do_cmd_newColor("JungleGreen ");
&do_cmd_newColor("SeaGreen ");
&do_cmd_newColor("Green ");
&do_cmd_newColor("ForestGreen ");
&do_cmd_newColor("PineGreen ");
&do_cmd_newColor("LimeGreen ");
&do_cmd_newColor("YellowGreen ");
&do_cmd_newColor("SpringGreen ");
&do_cmd_newColor("OliveGreen ");
&do_cmd_newColor("RawSienna ");
&do_cmd_newColor("Sepia ");
&do_cmd_newColor("Brown ");
&do_cmd_newColor("Tan ");
&do_cmd_newColor("Gray ");
&do_cmd_newColor("Black ");
&do_cmd_newColor("White ");


# wrap general color specifications, ...

&process_commands_wrap_deferred ( <<_DEFERRED_CMDS_);
textColor # {}
globalColor # {}
background # {}
subdef # {}
Color # {} # {}
_DEFERRED_CMDS_


&ignore_commands( <<_IGNORED_CMDS_);
_IGNORED_CMDS_

1;	# Must be last line
