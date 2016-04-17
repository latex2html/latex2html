# $Id: frame.pl,v 1.12 2001/04/13 22:30:25 RRM Exp $
# frame.pl - Ross Moore (ross@mpce.mq.edu.au) 30.11.98
# 
# developed for the W3C HTML 4.0 Frameset DTD, 
#    $FRAME_DOCTYPE = '-//W3C//DTD HTML 4.0 Frameset';
#    $PUBLIC_REF = 'http://www.w3.org/TR/REC-html40/frameset.dtd';
#
# extending work done earlier, as:
#
# frames.perl - Martin Wilck (martin@tropos.de) 22.5.96
# 
# Extension to the LaTeX2HTML program by Nikos Drakos
#
# Enable LaTeX2HTML to build pages using frames
# (HTML extension for browsers that understand frames)
# 
# Change Log:
# jcl = Jens Lippmann <lippmann@rgb.informatik.tu-darmstadt.de>
# mwk = Martin Wilck
# rrm = Ross Moore <ross@maths.mq.edu.au>
#
# $Log: frame.pl,v $
# Revision 1.12  2001/04/13 22:30:25  RRM
#  --  wrong color on Index page; thanks Ingo de Boer, for the report
#
# Revision 1.11  2000/09/01 09:43:38  RRM
#  --  include an easier call to &make_frame_help for the Help frame.
#  --  changed default of 'TEXT' to 'MAIN' for \framecolor and \frameoptions
#
# Revision 1.10  1999/11/03 10:14:21  RRM
#  --  changed "Refresh" button to be "Expand", as more indicative
#      of the action performed
#
# Revision 1.9  1999/09/16 08:43:27  RRM
#  --  fixed incorrect use of  undef
#  	thanks to  Jarkko Hietaniemi  for reporting those errors.
#
# Revision 1.8  1999/09/09 00:30:59  MRO
#
#
# -- removed all *_ where possible
#
# Revision 1.7  1999/07/10 12:39:06  RRM
#  --  fixed the target frame for links from the mini-toc.
#  --  removed redundant definition of  &add_frame_toc
#
# Revision 1.6  1999/06/03 03:45:57  RRM
#  --  changed email address: ross@maths.mq.edu.au
#  --  set $NO_FRAME_HELP when there are no special views needed.
#
# Revision 1.5  1999/04/09 18:19:36  JCL
# changed my e-Mail address
#
# Revision 1.4  1999/03/26 11:34:14  RRM
#  --  updated to recover the missing 'Next' buttons
#
# Revision 1.3  1999/03/03 10:51:40  RRM
#  --  use variables  $MAIN_VMARGIN and $MAIN_HMARGIN for the values of
#     attributes MARGINHEIGHT and MARGINWIDTH of the main <FRAME> tag.
#  --  when $NOFRAMES is set, prevent the navigation buttons from appearing
#     in more than one frame.    Thanks Uli, for noticing this.
#     Also stop <HEAD> and <LINK> tags being repeated.
#
# Revision 1.2  1999/02/24 11:02:36  RRM
#  --  include a margin with the main body frame
#  --  define a style name 'TOC' for easy application of styles in the
#       contents frame
#  --  get correct target for links to images within the contents frame
#
# Revision 1.1  1998/12/02 10:26:35  RRM
#      new extension:  frame.pl  by  RRM
#
#      replaces the  frames.perl  package
#  --  implements frames, via the  W3C's DTD:  "HTML 4.0 Frameset"
#  --  makes minimal use of the Netscape <FRAME border=...> attribute
#  --  rebinds many subroutines from latex2html and other modules
#      uses an extra indirection, to minimize recoding
#


# Different frames are used for the navigation panel buttons,
#    the main text field and the footnotes (if any).
# 
# The package redefines the following subroutines of LaTeX2HTML:
#     - process_footnote
#     - post_process
#     - make_footnotes
#     - make_file
#     - make_head_and_body
#
# This file should be put in your LATEX2HTMLVERSIONS directory.
#
# The package will be loaded if the following perl code:
###############################################################################
# if ($FRAMES) {
#     foreach $dir (split(/:/,$LATEX2HTMLVERSIONS)) { 
# 	print $dir;
# 	if (-f ($_ = "$dir/frame.pl")) {
# 	    print "Loading $_...\n";
# 	    require ($_);
# 	};
#     } ;
# };
###############################################################################
# is inserted into the latex2html script (uncommented, of course)
#    (I insert it directly before the call to &driver)
# and $FRAMES is set to 1 in one of your configuration files.

package main;

$html_frame_version = 3.0 ;
$FRAME_DOCTYPE = '-//W3C//DTD HTML 4.0 Frameset'
    unless ($FRAME_DOCTYPE);

if ($HTML_VERSION >= 4.0) {
#    $FRAME_DOCTYPE = '-//W3C//DTD HTML 4.0 Frameset';
#    $PUBLIC_REF = 'http://www.w3.org/TR/REC-html40/frameset.dtd';
    $frame_implementation = "W3C";
    $html_frame_version = 4.0 ;
} else {
    $frame_implementation = "Netscape"
	unless ($frame_implementation);
}
if ($NO_BORDER) { $NO_BORDER = '' }
else {
    $NO_BORDER = (($HTML_STRICT || !$NETSCAPE_HTML) ? '' : ' BORDER=0')
}
$HELP_BORDER = ' BORDER=0' unless (defined $HELP_BORDER);
$FHELP_SIZE = 20 unless $FHELP_SIZE;

$NO_ROBOTS = "\n<META NAME=\"Robots\" CONTENT=\"nofollow\">"
	unless (defined $NO_ROBOTS);

$REFRESH_BUTTON = '<SUP>Expand</SUP>' unless $REFRESH_BUTTON;
	
$BACKGROUND_DIR = "http://home.netscape.com/assist/net_sites/bg/";
$BACKGROUND_IMAGE = "stucco/yellow_stucco.gif";

@Netscape_colorset = ("main",'1',"alink",'1',"link",'2',"vlink",'3',"bgcolor",'4');
@Netscape_colorset_star = ("main",'4',"alink",'4',"link",'3',"vlink",'2',"bgcolor",'1');
@Netscape_colorset_star_star = ("main",'4',"alink",'1',"link",'4',"vlink",'3',"bgcolor",'2');

###############################################################################
# PACKAGE OPTIONS - set these in one of your init files !
###############################################################################
# Set $NOFRAMES=1 if you want a <noframes>...</noframes> section to be
#   inserted in your HTML documents, making the contents accessible
#   also for browsers that can't handle frames.
# If $NOFRAMES is not set, these  browsers will only find a short message
#   informing the user that he should use another browser.
$NOFRAMES = 0 unless defined ($NOFRAMES);
#$NOFRAMES = 1;

# The height of the top frame containing the navigation buttons
$NAVIGATION_HEIGHT = 36 unless $NAVIGATION_HEIGHT;

# The height of the bottom frame containing footnotes (if there are any
#    on the current page)
$FOOTNOTE_HEIGHT = 60 unless $FOOTNOTE_HEIGHT;

$TOC_WIDTH = 150 unless $TOC_WIDTH;
$IDX_WIDTH = 200 unless $IDX_WIDTH;

# These are optional widths
#$CONTENTS_TABLE_WIDTH = 300 unless $CONTENTS_TABLE_WIDTH;
#$INDEX_TABLE_WIDTH = 350 unless $INDEX_TABLE_WIDTH;

# protect special characters in user-supplied code
if ($CONTENTS_BANNER =~ /[%~\$]/) {
    $CONTENTS_BANNER =~ s/\%/;SPMpct;/g;
    $CONTENTS_BANNER =~ s/~/;SPMtilde;/g;
    $CONTENTS_BANNER =~ s/\$/;SPMdollar;/g;
}
if ($CONTENTS_FOOTER =~ /[%~\$]/) {
    $CONTENTS_FOOTER =~ s/\%/;SPMpct;/g;
    $CONTENTS_FOOTER =~ s/~/;SPMtilde;/g;
    $CONTENTS_FOOTER =~ s/\$/;SPMdollar;/g;
}
if ($INDEX_BANNER =~ /[%~\$]/) {
    $INDEX_BANNER =~ s/\%/;SPMpct;/g;
    $INDEX_BANNER =~ s/~/;SPMtilde;/g;
    $INDEX_BANNER =~ s/\$/;SPMdollar;/g;
}
if ($INDEX_FOOTER =~ /[%~\$]/) {
    $INDEX_FOOTER =~ s/\%/;SPMpct;/g;
    $INDEX_FOOTER =~ s/~/;SPMtilde;/g;
    $INDEX_FOOTER =~ s/\$/;SPMdollar;/g;
}

# Additional feature: Choose colors and other options for the different 
#   frames. The layout strings will be inserted into the <BODY ...> declaration
#   of the HTML files. 
# WARNING: The default colors set here may not be what you expect or like!
#
# Main Body window
$MAIN_VMARGIN = 3 unless (defined $MAIN_VMARGIN);
$MAIN_HMARGIN = 5 unless (defined $MAIN_HMARGIN);

$MAIN_COLOR = "bgcolor=\"#ffffff\" text=\"#000000\" link=\"#9944EE\" vlink=\"#0000ff\" alink=\"#00ff00\""
	unless $MAIN_COLOR;
#
## Main window (seems to have no effect in Netscape)
#if (!$NOFRAMES) { $MAIN_COLOR = "bgcolor=\"#000000\" text=\"#ffffff\"" unless $MAIN_COLOR;}
#else { $MAIN_COLOR = "bgcolor=\"#ffffff\" text=\"#000000\"" unless $MAIN_COLOR; }
#
# Navigation window
$NAVIG_COLOR = "bgcolor=\"#ffeee0\" text=\"#000000\" link=\"#9944EE\" vlink=\"#FF0000\" alink=\"#00ff00\""
	unless $NAVIG_COLOR;
#
# Footnote window
$FOOT_COLOR = "bgcolor=\"#eeeee0\" text=\"#000000\" link=\"#9944EE\" vlink=\"#0000ff\" alink=\"#00ff00\""
	unless $FOOT_COLOR;

# Table-of-Contents window	# D0F000
$TOC_COLOR = "bgcolor=\"#8080C0\" text=\"#ffeee0\" link=\"#eeeee0\" vlink=\"#eeeee0\" alink=\"#00ff00\""
	unless $TOC_COLOR;

# Index window, same as Text window
$IDX_COLOR = $MAIN_COLOR;


# extra help-frame, above the navigation panel, unless $NO_FRAME_HELP
if ($NO_FRAME_HELP) { $FRAME_HELP = $FHELP_FILE = '' }
else { $FHELP_FILE = "fhelp".$EXTN unless ($FHELP_FILE) }

sub make_frame_help {
    print "\n *** making frame-help file $NO_FRAME_HELP ...";
    if (!($idxfile || $tocfile)||$NO_FRAME_HELP) {
	print " ... cancelled ***\n";
	$help_file_done = 1;
	$NO_FRAME_HELP = 1;
	return();
    }
    $FRAME_HELP = join('', "Click "
    	, ($tocfile ? "<STRONG>Contents</STRONG>" : '') 
    	, (($idxfile && $tocfile) ? " or " : '')
    	, ($idxfile ? "<STRONG>Index</STRONG>" : '')
         , " for extra navigation, hidden by <STRONG>Expand</STRONG>."
         ) unless ($FRAME_HELP);
    if (!(-f $FHELP_FILE)) {
	open(FHELP, ">$FHELP_FILE");
	local($fhelp_string) = join("\n"
	    , '<HTML>', '<HEAD>', '<TITLE>'.$fhelp_title.'</TITLE>'
	    , '</HEAD>', '<BODY '.$NAVIG_COLOR.'>'
	    , '<DIV ALIGN="RIGHT"><SMALL><SMALL>'.$FRAME_HELP.'</SMALL></SMALL>'
	    , '</DIV></BODY>', '</HTML>', ''
	    );
	&lowercase_tags($fhelp_string) if $LOWER_CASE_TAGS;
	print FHELP $fhelp_string;
	undef $fhelp_string;
	close FHELP;
	print " ... done: $FHELP_FILE ***\n";
    }
    $help_file_done = 1;
}



sub replace_frame_markers {
    # Modifies $_
    local($frame,$frame_data)=("none","none");
    s/$frame_mark<#(.*)#><#(.*)#>/&set_frame_data("$1","$2")/geo;
    @_[0];
}

sub set_frame_data {
    local($frame,$frame_data) = @_;
    $frame_data =~ s/,$//o; $frame_data =~ s/,/ /g;
    ${$frame} = "$frame_data";
    '';    
}


# Implement some use-macros.
# The background can be set only by  \frameoptions
# Colors can be set by  \framecolor or \frameoptions

sub do_cmd_frameoptions {
    local($_) = @_;
    local($frame_data,$bkgrnd_str)=('','');
    local ($frame,$dum)=&get_next_optional_argument;
    if (!($dum)) {$frame = "MAIN";}
    $frame_data = &missing_braces() unless (
	(s/$next_pair_pr_rx/$frame_data = $2;''/eo)
	||(s/$next_pair_rx/$frame_data = $2;''/eo)); 
    local($rest) = $_;
    $frame_data =~ s/background[\s\t]*\=[\s\t]*([\w\W]*)/
	if (!($1)) { "background=$BACKGROUND_DIR$BACKGROUND_IMAGE"}
	else { "background=${BACKGROUND_DIR}$1" }/eo;
    if (!($frame_data)) 
	{ print STDERR "\nno frame options, $frame unchanged\n"; return $_;}
    join('',&apply_frame_options(1,$frame,$frame_data),$rest);
}

sub do_cmd_framecolor {
    local($_) = @_;
    local($frame,$frame_data,$frame_test);
    $frame = &missing_braces() unless (
	(s/$next_pair_pr_rx/$frame = $2;''/eo)
	||(s/$next_pair_rx/$frame = $2;''/eo)); 
    if (!$frame) 
	{ print STDERR "\nno FRAME specified\n"; return $_;}
    eval { $frame_test = ${$frame."_COLOR"} };
    if (!$frame_test)
	{ print STDERR "\nthere is no frame $frame\n"; 
	    (s/$next_pair_pr_rx//o)||(s/$next_pair_rx//o);
	    return $_;
	}
    $frame_data =  &missing_braces() unless (
	(s/$next_pair_pr_rx/$frame_data = $2;''/eo)
	||(s/$next_pair_rx/$frame_data = $2;''/eo));
    local($rest) = $_;
    if (!$frame_data) 
	{ print STDERR "\nno frame options, $frame unchanged\n"; return $_;}
    join('',&apply_frame_options(0,$frame,$frame_data),$rest);
}


# These are user-macros for imposing complete colorsets.

sub do_cmd_frameColorSet {
    &check_frame_colorset(0,$frame_implementation,$_[0]);
}

sub do_cmd_frameColorSetstar {
    local($_)=@_;
    if (s/^\*//o) {
	&check_frame_colorset(2,$frame_implementation,$');
    } else {
	&check_frame_colorset(1,$frame_implementation,$_[0]);
    }
}

sub do_cmd_frameColorSetstarstar {
    &check_frame_colorset(2,$frame_implementation,$_[0]);
}

sub check_frame_colorset {
    local($reverse, $which, $_) = @_;
    local($frame_data,$frame_test);
    local($frame,$dum)=&get_next_optional_argument;
    if (!($dum)) {$frame = 'MAIN';}
    $frame_data =  &missing_braces() unless (
	(s/$next_pair_pr_rx/$frame_data = $2;''/eo)
	||(s/$next_pair_rx/$frame_data = $2;''/eo));
    local($rest) = $';
    eval { $frame_test = ${$frame."_COLOR"} };
    if (!($frame_test))
	{ print STDERR "\nthere is no frame $frame\n"; return($rest);}
    if (!($frame_data)) 
	{ print STDERR "\nno colorset specified, $frame unchanged\n"; return($rest);}
    local($colorset);
    if ($reverse == 0) {$colorset="${which}_colorset"}
    elsif ($reverse == 1) {$colorset="${which}_colorset_star"}
    elsif ($reverse == 2) {$colorset="${which}_colorset_star_star"}
    else {$colorset="${which}_colorset"}
    if (!(defined  @$colorset))
	{ print STDERR "\nframes for $which are not supported\n"; return($rest);}	
    local($frame_tmp)=$frame_data;
    local($key, @values);
    local($num) = $frame_tmp =~ s/,/,/g;
    if (!($num > 0)) {
	$framedata =~ s/^[\s\t\n]*//o; $framedata =~ s/[\s\t\n]*$//o; 
	local($cnt) = true;
	$frame_str = '';
	foreach $key (@$colorset) {
	    if ($cnt) { $frame_str .= "$key="; }
	    else {$frame_str .= "$frame_data$key".","}
	    $cnt = !($cnt);
	}
	$frame_str =~ s/,$//o;
    } else {
	@values = split (',',$frame_tmp);
    }
    join('',&apply_frame_options(0,$frame,$frame_str),$rest);
}


sub apply_frame_options {
    local($replace,$frame,$frame_data) = @_ ;
    local($frame_tmp,$option_str, $option) = ('','','');
    local(@previous, @options, @settings, @keys, @done);
    local(%options);
    if (!($frame_mark)) { &initialise_frames() };
    $frame = $frame."_COLOR";
    $frame_tmp = $frame."_TMP";
    # if  $replace=0, impose just the new values,
    # else use existing settings, but replacing with the new values
    if ($replace) {
	$option_str = $${frame_tmp};
	if (!($option_str)) { 
	    $option_str = $$frame; 
	    $option_str =~ s/[\s\t\n]*$//o;
	    @previous = split(' ',$option_str);
   	} else {
	    $option_str =~ s/[\s\t\n]*$//o;
	    @previous = split(' ',$option_str);
   	}
	# recover the existing settings; store in @options hash
	foreach $option (@previous) {
	    $option =~ s/^[\s\t\n]*//o; $option =~ s/[\s\t\n]*$//o;
	    $_ = $option; s/[\s\t\n]*\=[\s\t\n]*//o;
	    if ($&) { $options{$`}=$'; }
	}
	@options = sort keysort @options;
    }
    # process the new values; storing directly into $option_str
    @settings = split(',',$frame_data);
    foreach $option (@settings) {
	$option =~ s/^[\s\t\n]*//o; $option =~ s/[\s\t\n]*$//o;
	$option =~ s/[\s\t\n]*\=[\s\t\n]*//o;
	if ($&) { 
	    if ($` eq "background") {
		$options{$`}="\"$'\"";
	    }
	    elsif (defined &get_named_color) {
		$options{$`}= "\"\#".&get_named_color($')."\"";
	    } else {
		$options{$`}="\"$'\"";
	    }
	} else {print STDERR "\nno value specifed for $frame option: $option\n";}
    };
    # recover the new values from the @options hash
    @keys = keys %options;  # @keys = sort keysort @keys;
    $option_str = '';
    foreach $option (@keys) { 
	$option_str .= "$option\=@options{$option} ";
    }
    # reassign to the  $<frame>_COLOR_TMP  variable
    if ($STARTFRAMES) { 
	${$frame_tmp} = $option_str;
    } else { 
	${$frame} = $option_str ;
    }
# Uncomment next line, for a diagnostic check:
#  print STDERR "\n$frame : $option_str\n";
    "$frame_mark<#$frame#><#$option_str#>";
}



sub apply_framebody_options {
    local($frame,$which,$value) = @_;
    local($body,$option,%previous);
    $frame = "${frame}_COLOR";
    $body = $$frame;
    study $body;
    $body =~ s/^\s*//o; $body =~ s/\s*$//o;
    $body =~ s/\s*\=\s*/\=/g; $body =~ s/\s+/ /g; 
    @previous = split(' ',$body); 
    $body = '';
    foreach $option (@previous) {
	$option =~ s/\=/\=/o;
	if (lc($`) eq $which) { $body .= " $which=\#$value" }
	else { $body .= " $`=$'" }
    }
    $$frame = $body;
}

# These override definitions in color.perl

sub apply_frame_body_options{
    local($which,$value)=@_;
    if ($which eq "background") { $which="bgcolor" };
    &apply_framebody_options("MAIN",$which,$value);
}

sub set_frame_section_color {
    if ($next_section_color) {
	&apply_framebody_options("MAIN","text","$next_section_color"); 
    }
    if ($next_section_bkgnd_color) {
	&apply_body_options("MAIN","bgcolor","$next_section_bkgnd_color");
    }
}

# frame-navigation string constants
$frame_main_suffix = '_mn' unless $frame_main_suffix;
$frame_body_suffix = '_ct' unless $frame_body_suffix;
$frame_idx_suffix = '_id' unless $frame_idx_suffix;
$frame_head_suffix = '_hd' unless $frame_head_suffix;
$frame_toc_suffix = '_tf' unless $frame_toc_suffix;
$frame_top_name = '_top';
$frame_main_name = 'main' unless $frame_main_name;
$frame_body_name = 'contents' unless $frame_body_name;
$frame_foot_name = 'footer' unless $frame_foot_name;
$frame_toc_name = 'toc' unless $frame_toc_name;
$frame_idx_name = 'index' unless $frame_idx_name;

$FRAME_TOP = ' TARGET="'.$frame_top_name.'"';
$EXTN = $frame_main_suffix.$EXTN;

$indexframe_mark = '<index_frame_mark>';

# Define the subroutine &frame_navigation_panel in your configuration files
#   if you don't like this definition (puts all the buttons, but only the
#   buttons, in the navigation frame).

if (! defined &frame_navigation_panel) {
    sub frame_navigation_panel {
	"$NEXT $UP $PREVIOUS $CONTENTS $INDEX $CUSTOM_BUTTONS";};};

# HINT: You may want to comment out the buttons line ("$NEXT $UP ...")
#   in the definitions of &top_navigation_panel and &bot_navigation_panel
#   in your latex2html.config file if you use this package in order to
#   avoid the buttons showing up in the text window as well. If you do that,
#   the textual links will still be there. Alternatively, you can just set 
#   $NO_NAVIGATION; in that case, no textual links will be there, but the
#   navigation window will remain.

# Here comes the main routine of the package. It is invoked by the (changed)
#    subroutine post_process. It takes over the file handling that that 
#    routine usually performed. Note that the implementation of frames takes
#    place just before the final versions of the files are written, so that
#    everything else LaTeX2html does will be preserved.

sub make_frame_header {
# Arguments: Title of the page, filename, and the whole contents of the file
    local ($title,$file,$contents) = @_;
# Get the contents of the navigation frame
#   (customizable subroutine &frame_navigation_panel !).
    local ($navig) = &frame_navigation_panel;
# This is the same as usual. Note that the navigation panels defined by
#   $top_navigation and $bot_navigation go into the text frame,
#   not into the navigation frame (see HINT above)!
    local ($top_navigation) = &top_navigation_panel unless $NO_NAVIGATION;
    local ($bot_navigation) = &bot_navigation_panel unless $NO_NAVIGATION;
# Check if there is a reference to $footfile in the text (usually, a footnote
#   reference).
# Besides, insert a "target="footer" tag into these references in order to
#   make them point to the footnote window.
    local ($has_footref) = $contents =~ s/target="footer"/$&/iog;
#    if (($has_footref)&&(!$NO_FOOTNODE)) {
    if (!$NO_FOOTNODE) {
	local($footheight) = ($has_footref ? $FOOTNOTE_HEIGHT : '15pt');
	# If there are footnote refs: 3 frames
	$frameset 
	    = "<FRAMESET ROWS=\"$NAVIGATION_HEIGHT,*,$footheight\""
		. $NO_BORDER . '>';
	# The footnote frame is called "footer"; its contents come from $footfile.
	$footframe = 
	    "<FRAME SRC=\"$footfile\" NAME=\"footer\" SCROLLING=\"auto\">"
    } else {
	# Otherwise: no footnote frame required -> only 2 frames.
	$frameset = "<FRAMESET ROWS=\"$NAVIGATION_HEIGHT,*\""
		. $NO_BORDER . '>';
	$footframe = "";
    }

#
# Construct filenames from main/help name "NAME.html": 
#   Text page: "NAME_ct.html",
#   Navigation page: "NAME_hd.html".
#   Index frame page: "NAME_id.html".
#   Main page: "NAME_mn.html".
#   Help frame page: "NAME.html".
#   Contents frame page: "NAME_tf.html".
    local ($navigfile,$mainfile,$mainfile,$contfile,$indexfile,$toc_framefile,$frame_def);
    ($navigfile = $file) =~ s/($frame_main_suffix)?\.htm(l?)$/$frame_head_suffix.htm$2/;
    ($contfile = $file) =~ s/($frame_main_suffix)?\.htm(l?)$/$frame_body_suffix.htm$2/;
    ($indexfile = $file) =~ s/($frame_main_suffix)?\.htm(l?)$/$frame_idx_suffix.htm$2/;
#    ($mainfile = $file) =~ s/($frame_main_suffix)?\.htm(l?)$/.htm$2/;
    ($mainfile = $file) =~ s/($frame_main_suffix)?\.htm(l?)$/.htm$2/;
    ($toc_framefile = $file) =~ s/($frame_main_suffix)?\.htm(l?)$/$frame_toc_suffix.htm$2/;
# This is more or less obsolete
#   (normally these titles will never be displayed).
    local ($navigtitle)="Header of $title";
    local ($conttitle)="Contents of $title";

    local($idxfile) = $idxfile;
#   $idxfile =~ s/\Q$EXTN\E/$frame_body_suffix$&/ if ($idxfile);
    $idxfile =~ s/($frame_main_suffix)?(\.html?)$/$frame_body_suffix$2/ if ($idxfile);
    local($tocfile) = $tocfile;
#   $tocfile =~ s/\Q$EXTN\E/$frame_body_suffix$&/ if ($tocfile);
    $tocfile =~ s/($frame_main_suffix)?(\.html?)$/$frame_body_suffix$2/ if ($tocfile);
#
# Try to open the four files
    open (OUTFILE, ">$file") || die "Cannot open file $file $!";
    open (NAVIG,">$navigfile") || die "Cannot open file $navigfile $!";
    open (CONT,">$contfile") || die "Cannot open file $contfile $!";
    open (ENTRY,">$mainfile") || die "Cannot open file $mainfile $!";
#
    local($main_frames) = join("\n",
	, "<FRAME SRC=\"$navigfile\" SCROLLING=\"no\""
	    . " FRAMEBORDER=0 MARGINHEIGHT=0 MARGINWIDTH=0>",
	, "<FRAME SRC=\"$contfile\" NAME=\"contents\" SCROLLING=\"auto\""
	    . " FRAMEBORDER=1 MARGINHEIGHT=$MAIN_VMARGIN MARGINWIDTH=$MAIN_HMARGIN>"
	);
    &make_frame_help() unless $help_file_done;
    local($help_frames) = join('', "\n"
	, '<FRAMESET ROWS="'.($NO_FRAME_HELP ? '100%' : $FHELP_SIZE).',*"'
		. "$HELP_BORDER" .'>'
	, ($NO_FRAME_HELP ? '' : "\n<FRAME SRC=\"$FHELP_FILE\" SCROLLING=\"no\""
	    ."\n FRAMEBORDER=0 MARGINHEIGHT=0 MARGINWIDTH=0>")
	, "\n<FRAME SRC=\"$file\" NAME=\"$frame_main_name\" SCROLLING=\"no\""
	    ." FRAMEBORDER=0 MARGINHEIGHT=0 MARGINWIDTH=0>\n"
	);
    local($refresh_link);
    $refresh_link = join('', '<SMALL><A HREF="', $mainfile, '"'
		, $FRAME_TOP . '>', $REFRESH_BUTTON, '</A></SMALL>')
		unless $NO_FRAME_HELP ;
    $helpframe_def = $help_frames.'<NOFRAMES>';

# Construct the "<framedef>...</framedef>" section for the top file.
    $frame_def=join ("\n", $frameset, $main_frames, $footframe, '<NOFRAMES>');
    $_ = $contents;
    &replace_frame_markers;
    $contents = $_;
# If $NOFRAMES is set, insert the whole text in the "<noframes>...</noframes>"
#   section.
    local($noframe_contents, $noframe_flag);
    if ($NOFRAMES) {
	$noframes_flag = 1;
	local ($flag) = (($BOTTOM_NAVIGATION || &auto_navigation) &&
	     $bot_navigation);
	if ($flag) {
	    $noframe_contents = join ("\n",
		&make_head_and_body($title,$MAIN_COLOR,$frame_def)
		, $top_navigation, $contents , $bot_navigation)
	} else {
	    $noframe_contents = join ("\n",
		&make_head_and_body($title,$MAIN_COLOR,$frame_def)
		, $top_navigation, $contents )
	};
	$noframe_contents =~ /\s*<BODY[^>]*>/s;
	$noframe_contents = $';
    }
    local($no_frames) = ($NOFRAMES 
	? $noframe_contents
	: '<P>Sorry, this requires a browser that supports frames!<BR>'."\n"
		.'Try <A HREF="'.$contfile.'">'.$contfile.'</A> instead.</P>' );
    undef $noframe_contents; undef $noframes_flag;
#
# Make the text page first. Note that &make_head_and_body has been altered
#   such that it accounts for the layout string; the last argument 
#   (definitions that go between head and body) is empty.

    local($after_contents) = "\n</BODY>\n</HTML>\n";
    if ($contfile eq $idxfile) {
	$_ = &make_head_and_body($conttitle,$IDX_COLOR," ");
    } elsif ($contfile eq $tocfile) {
	$_ = &make_head_and_body($conttitle,$TOC_COLOR," ");
    } else {
	$_ = &make_head_and_body($conttitle,$MAIN_COLOR," ");
	$after_contents = &make_address;
    }
#    $_ = join ("\n", $_, $top_navigation, $contents);
    $_ = join ("\n", $_, $contents);
##    local ($flag) = (($BOTTOM_NAVIGATION || &auto_navigation) &&
##	     $bot_navigation);
## ... and bottom navigation panel. --- no need for this  RRM.
##    $_ = join ("\n", $_, $bot_navigation) if $flag;
# Do the usual post-processing. 
    &replace_markers;
    &post_post_process if (defined &post_post_process);
    $_ = join ("\n", $_, "<HR>", $after_contents);
    &lowercase_tags($_) if $LOWER_CASE_TAGS;
    print CONT $_;
    close CONT;
#
# Now go on with the navigation file.
    $navig =~ s/(TARGET=")$frame_top_name("><tex2html_(next|up|prev))(\w+)/$1$frame_main_name$2$4/g;
    $_ = &make_head_and_body($navigtitle,$NAVIG_COLOR," ");
    &reduce_frame_header($_);
    if ($refresh_link) {
	$_ = join ("\n", $_
		, '<TABLE WIDTH="100%">', '<TR><TD>'.$navig
		, '</TD><TD ALIGN="RIGHT">'
		, $refresh_link , '</TD></TR>'
		, '</TABLE>' , "</BODY>\n</HTML>\n" );
    } else {
	$_ .= "\n".$navig."</BODY>\n</HTML>\n";
    }
    &replace_markers;
    &post_post_process if (defined &post_post_process);
    &lowercase_tags($_) if $LOWER_CASE_TAGS;
    print NAVIG $_;
    close NAVIG;
#
# Next, the main frame-set.
#  $frame_def goes between head and body 
#   (third argument of &make_head_and_body).
    $_ = join ("\n", &make_head_and_body($title,$MAIN_COLOR,$frame_def)
	, $no_frames);
    &reduce_frame_header($_);
    # adjust the DOCTYPE of the Frameset page
    local($savedRS) = $/; $/ = '';
	$_ =~ s/\Q$DOCTYPE\E/$FRAME_DOCTYPE/;
    $/ = $savedRS;
    &replace_markers;
    &post_post_process if (defined &post_post_process);
    $_ = join ("\n", $_, "<HR>", &make_noframe_address);
    &lowercase_tags($_) if $LOWER_CASE_TAGS;
    print OUTFILE $_;
    close OUTFILE;
    
# Now make the ENTRY frame file.
    &make_frame_help() unless $help_file_done;
    local ($flag) = (($BOTTOM_NAVIGATION || &auto_navigation) &&
	     $bot_navigation);
    $_ = join ("\n",
	, &make_head_and_body($title,$NAVIG_COLOR, $helpframe_def)
	, $top_navigation, $no_frames);
    &reduce_frame_header($_);
    # adjust the DOCTYPE of the Frameset page
    local($savedRS) = $/; $/ = '';
        $_ =~ s/\Q$DOCTYPE\E/$FRAME_DOCTYPE/;
    $/ = $savedRS;
    &replace_markers;
    &post_post_process if (defined &post_post_process);
    $_ = join ("\n", $_, "<HR>", &make_noframe_address);
    &lowercase_tags($_) if $LOWER_CASE_TAGS;
    print ENTRY $_;
    close ENTRY;

# Now go on with the index-frame file.
    local ($index_frameset, $indexframe);
    if ($idxfile) {
	open (INDX,">$indexfile") || die "Cannot open file $indexfile $!";
	$index_frameset = "<FRAMESET COLS=\"*,$IDX_WIDTH\""
		. (($STRICT_HTML || 
		($INDEX_TABLE_WIDTH && $INDEX_TABLE_WIDTH > $IDX_WIDTH))
		 ? '' : $NO_BORDER ) . '>';
	$indexframe = join("\n",''
		, "<FRAME SRC=\"$file\" NAME=\"$frame_main_name\" SCROLLING=\"no\">"
		, "<FRAME SRC=\"$idxfile\" NAME=\"$frame_idx_name\" SCROLLING=\"auto\">"
		, '<NOFRAMES>'
		);

	$_ = &make_head_and_body($indexname, $IDX_COLOR, $index_frameset . $indexframe);
	&reduce_frame_header($_);
	# adjust the DOCTYPE of the Frameset page
	local($savedRS) = $/; $/ = '';
	    $_ =~ s/\Q$DOCTYPE\E/$FRAME_DOCTYPE/;
	$/ = $savedRS;
	$_ = join ("\n", $_ ,$no_frames, "</BODY>\n</NOFRAMES>\n</FRAMESET>\n</HTML>\n");
	&replace_markers;
	&post_post_process if (defined &post_post_process);
	&lowercase_tags($_) if $LOWER_CASE_TAGS;
	print INDX $_;
	close INDX;
    }
# Now go on with the toc-frame file.
    local ($toc_frameset, $tocframe);
    if ($tocfile) {
	open (TOC,">$toc_framefile") || die "Cannot open file $toc_framefile $!";
	$toc_frameset = "<FRAMESET COLS=\"$TOC_WIDTH,*\""
		. (($STRICT_HTML || 
		($CONTENTS_TABLE_WIDTH && $CONTENTS_TABLE_WIDTH > $TOC_WIDTH))
		 ? '' : $NO_BORDER ) . '>';
	$tocframe = join("\n", ''
		, "<FRAME SRC=\"$tocfile\" NAME=\"$frame_toc_name\" SCROLLING=\"auto\">"
		, "<FRAME SRC=\"$file\" NAME=\"$frame_main_name\" SCROLLING=\"no\">"
		, '<NOFRAMES>'
		);

	$_ = &make_head_and_body($indexname, $MAIN_COLOR, $toc_frameset . $tocframe);
	&reduce_frame_header($_);
	# adjust the DOCTYPE of the Frameset page
	local($savedRS) = $/; $/ = '';
	    $_ =~ s/\Q$DOCTYPE\E/$FRAME_DOCTYPE/;
	$/ = $savedRS;
	$_ = join ("\n", $_ ,$no_frames, "</BODY>\n</NOFRAMES>\n</FRAMESET>\n</HTML>\n");
	&replace_markers;
	&post_post_process if (defined &post_post_process);
	&lowercase_tags($_) if $LOWER_CASE_TAGS;
	print TOC $_;
	close TOC;
    }
}

sub reduce_frame_header {
    # MRO: Use $_[0] instead of: local(*header) = @_;
    $_[0] =~ s/<(META NAME|LINK)[^>]*>\s*//g;
    $_[0] =~ s/$more_links_mark/$NO_ROBOTS\n$LATEX2HTML_META/g;
    local($savedRS)=$/; $/ = '';
    $_[0] =~ s/\n{2;}/\n/sg;
    $_[0] =~ s/\s$//s;
    $_[0] =~ s!\s*(\n</HEAD>\n)\s*!$1!s;
    $/ = $savedRS;
}

sub make_noframe_address {
    local ($addr) = join("\n", &make_real_address(@_)
	, '</NOFRAMES></FRAMESET>', '</HTML>', '' );
    &lowercase_tags($addr) if $LOWER_CASE_TAGS;
    $addr;
}
    
# Altered: &make_href
sub make_frame_href {
    local($link, $text) = @_;
    local($target) = $target;
    $href_name++;
    $text =~ s/<A .*><\/A>//go;
    if ($text eq $link) { $text =~ s/~/&#126;/g; }
    $link =~ s/~/&#126;/g;
    # catch \url or \htmlurl
    $link =~ s/\\(html)?url\s*(($O|$OP)\d+($C|$CP))([^<]*)\2/$5/;
    $link =~ s:(<TT>)?<A [^>]*>([^<]*)</A>(</TT>)?(([^<]*)|$):$2$4:;
    $text = &simplify($text);
    if ($target eq $frame_body_name) {
	$link =~ s/_..(\.html?)(\#[^#]*)?$/$frame_body_suffix$1$2/;
#    } elsif (!$target ||($target =~ /^notarget$/)) {
    } elsif ($target =~ /^$frame_main_name$/) {
	$link =~ s/_..(\.html?)(\#[^#]+)$/$frame_main_suffix$1$2/;
    }

    # show links to images within the 'contents' frame
    if (($link =~ /\.(gif|jpe?g|png)$/i)&&(!$target)) {
	$target = $frame_body_name;
    }

    if ($target) {
	if ($target eq "notarget") {
	    "<A NAME=\"tex2html$href_name\" HREF=\"$link\">$text</A>";
	} else {
	    # use smaller text on the Contents page
	    $text = join('','<SMALL>',$text,'</SMALL>') if ($target =~ /^$frame_main_name$/);
	    "<A NAME=\"tex2html$href_name\" HREF=\"$link\" TARGET=\"$target\">$text</A>";
	}
    } elsif (((defined $base_file)&&($link =~ /^\Q$base_file\E/))
	|| ($CURRENT_FILE && ($link =~ /^\Q$CURRENT_FILE\E/))) {
	#child-links to the same HTML page
	$link =~ s/_..(\.html?)(\#[^#]*)?$/$frame_body_suffix$1$2/;
	"<A NAME=\"tex2html$href_name\" HREF=\"$link\">$text</A>";
    } else {
	"<A NAME=\"tex2html$href_name\" HREF=\"$link\"$FRAME_TOP>$text</A>";
    }
}

# Altered: &make_href_noexpand
sub make_frame_href_noexpand {
    local($link, $name, $text) = @_;
    do {$name = "tex2html". $href_name++} unless $name;
    $text =~ s/<A .*><\/A>//go;
    #$link =~ s/&#126;/$percent_mark . "7E"/geo;
    if ($text eq $link) { $text =~ s/~/&#126;/g; }
    $link =~ s/~/&#126;/g;
    # catch \url or \htmlurl
    $link =~ s/\\(html)?url\s*(($O|$OP)\d+($C|$CP))([^<]*)\2/$5/;
    $link =~ s:(<TT>)?<A [^>]*>([^<]*)</A>(</TT>)?(([^<]*)|$):$2$4:;
    if ($target) {
	if ($target eq "notarget") {
	    "<A NAME=\"tex2html$href_name\" HREF=\"$link\">$text</A>";
	} else {
	    "<A NAME=\"tex2html$href_name\" HREF=\"$link\" TARGET=\"$target\">$text</A>";
	}
    } else {
	"<A NAME=\"tex2html$href_name\" HREF=\"$link\"$FRAME_TOP>$text</A>";
    }
}

# Altered: &make_named_href
sub make_frame_named_href {
    local($name, $link, $text) = @_;
    local($namestr) = '';
    if ($name) { $namestr = " NAME=\"$name\"\n"; }
    $text =~ s/<A .*><\/A>//go;
    $text = &simplify($text);
    if ($text eq $link) { $text =~ s/~/&#126;/g; }
    $link =~ s/~/&#126;/g;
    # catch \url or \htmlurl
    $link =~ s/\\(html)?url\s*(($O|$OP)\d+($C|$CP))([^<]*)\2/$5/;
    $link =~ s:(<TT>)?<A [^>]*>([^<]*)</A>(</TT>)?(([^<]*)|$):$2$4:;
    if ($target eq $frame_body_name) {
	$link =~ s/_..(\.html?)(\#[^#]*)?$/$frame_body_suffix$1$2/;
    } elsif ($target =~ /^$frame_main_name$/) {
	$link =~ s/_..(\.html?)(\#[^#]+)$/$frame_main_suffix$1$2/;
    }
    if ($target) {
	if ($target eq "notarget") {
	    "<A$namestr HREF=\"$link\">$text</A>";
	} else {
	    "<A$namestr HREF=\"$link\" TARGET=\"$target\">$text</A>";
	}
    } else {
	"<A$namestr HREF=\"$link\"$FRAME_TOP>$text</A>";
    }
}

# Altered: &make_half_href
sub make_frame_half_href {
    local($link) = $_[0];
    $href_name++;
    if ($target) {
	if ($target eq "notarget") {
	    "<A NAME=\"tex2html$name\" HREF=\"$link\">";
	} else {
	    "<A NAME=\"tex2html$name\" HREF=\"$link\" TARGET=\"$target\">";
	}
    } else {
	"<A NAME=\"tex2html$name\" HREF=\"$link\"$FRAME_TOP>";
    }
}

# should use footnote frame, but allow alternative if $NO_FOOTNODE is high enough
$NO_FOOTNODE = '' unless ($NO_FOOTNODE > 1);
# Altered: &do_cmd_footnote		# RRM
sub do_frame_footnote {
    local($target) = ($NO_FOOTNODE ? $frame_body_name : $frame_foot_name);
    &do_real_cmd_footnote(@_) }
sub do_frame_footnotemark {
    local($target) = ($NO_FOOTNODE ? $frame_body_name : $frame_foot_name);
    &do_real_cmd_footnotemark(@_) }
sub do_frame_thanks {
    local($target) = ($NO_FOOTNODE ? $frame_body_name : $frame_foot_name);
    &do_real_cmd_footnote(@_) }


## Index adaptations
$INDEX_STYLES = "STRONG,SMALL";
# Altered: &make_index_entry	# RRM
sub make_frame_index_entry {
    local($target) = $frame_main_name;
    &make_real_index_entry(@_);
}
# Altered: &do_cmd_index	# RRM
sub do_frame_index {
    local($target) = $frame_body_name;
    local($CURRENT_FILE) = $CURRENT_FILE;
    $CURRENT_FILE =~ s/(\Q$frame_main_suffix\E)(\.html?)$/$frame_body_suffix$2/;
    &do_real_index(@_);
}
# Altered: &make_preindex	# RRM
sub make_frame_preindex {
    local($target) = $frame_body_name;
    &make_real_preindex
}

## Bibliography adaptations
# Altered: &do_cmd_bibitem	# RRM
sub do_frame_bibitem {
    # Modifies $filename
    local($filename) = $CURRENT_FILE;
    $filename =~ s/$frame_main_suffix(\.html?)$/$frame_body_suffix$1/;
    &do_real_bibitem($filename,@_);
}
# Altered: &do_cmd_harvarditem	# RRM
sub do_frame_harvarditem {
    # Modifies $filename 
    local($filename) = $CURRENT_FILE;
    $filename =~ s/$frame_main_suffix(\.html?)$/$frame_body_suffix$1/;
    &do_real_harvarditem($filename,@_);
}
# Altered: &do_cmd_bibitem	# RRM
sub do_frame_bibliography {
    # Modifies $filename
    local($filename) = $CURRENT_FILE;
    $filename =~ s/$frame_main_suffix(\.html?)$/$frame_body_suffix$1/;
    &do_real_bibliography($filename,@_);
}

# Altered: &anchor_label	# RRM
sub anchor_frame_label {
    # Modifies $filename 
    local($label,$filename,$context) = @_;
    $filename =~ s/$frame_main_suffix(\.html?)$/$frame_body_suffix$1/;
    &real_anchor_label($label,$filename,$context);
}

# Altered: &replace_cross_ref_marks
sub replace_frame_cross_ref_marks {
    # Modifies $_
    local($label,$id,$ref_label,$ref_mark,$after,$name,$target);
    local($invis) = "<tex2html_anchor_invisible_mark></A>";
#    s/$cross_ref_mark#([^#]+)#([^>]+)>$cross_ref_mark/
    s/$cross_ref_mark#([^#]+)#([^>]+)>$cross_ref_mark<\/A>(\s*<A( NAME=\"\d+)\">$invis)?/
	do {($label,$id) = ($1,$2); $name = $4;
	    if ($ref_label = $ref_files{$label}) {	   
		$ref_label =~ s!$frame_main_suffix(\.html?)$!$frame_body_suffix$1!o;
		$target = '';
	    } else {
		$ref_label = $external_labels{$label};
		$target = $FRAME_TOP;
	    }
	    print "\nXLINK<: $label : $id :$name " if ($VERBOSITY > 3);
	    $ref_mark = &get_ref_mark($label,$id);
	    &extend_ref if ($name); $name = '';
	    print "\nXLINK: $label : $ref_label : $ref_mark " if ($VERBOSITY > 3);
	    '"' . "$ref_label#$label\"".$target.'>' . $ref_mark . '<\/A>'
	}/geo;

    # This is for pagerefs which cannot have symbolic labels ??? 
#    s/$cross_ref_mark#(\w+)#\w+>/
    s/$cross_ref_mark#([^#]+)#[^>]+>/
	do {$label = $1;
	    if ($ref_label = $ref_files{$label}) {	   
		$ref_label =~ s!$frame_main_suffix(\.html?)$!$frame_body_suffix$1!o;
		$target = '';
	    } else {
		$ref_label = $external_labels{$label};
		$target = $FRAME_TOP;
	    }
	    print "\nXLINKP: $label : $ref_label" if ($VERBOSITY > 3);
	    '"' . "$ref_files{$label}#$label\"".$target.'>'
	}/geo;
}


# Altered: &replace_external_ref_marks	# RRM
sub replace_frame_external_ref_marks {
    # Modifies $_
    local($label, $link);
    s/$external_ref_mark#([^#]+)#([^>]+)>$external_ref_mark/
	do {($label,$id) = ($1,$2); 
	    $link = $external_labels{$label};
	    print "\nLINK: $label : $link" if ($VERBOSITY > 3);
	    '"'. "$link#$label\"".$FRAME_TOP.">\n"
	       . &get_ref_mark("userdefined$label",$id)
	}
    /geo;
}


# Altered: &post_process. 
# The main routine that handles section links etc.
sub frame_post_process {
    # Put hyperlinks between sections, add HTML headers and addresses,
    # do cross references and citations.
    # Uses the %section_info array created in sub translate.
    # Binds the global variables
    # $PREVIOUS, $PREVIOUS_TITLE
    # $NEXT, $NEXT_TITLE
    # $UP, $UP_TITLE
    # $CONTENTS
    # $INDEX
    # $NEXT_GROUP, $NEXT_GROUP_TITLE
    # $PREVIOUS_GROUP, $PREVIOUS_GROUP_TITLE
    # Converting to and from lists and strings is very inefficient.
    # Maybe proper lists of lists should be used (or wait for Perl5?)
    # JKR:  Now using top_navigation and bot_navigation instead of navigation
    local($_, $key, $depth, $file, $title, $header, @link, @old_link,
	  $top_navigation, $bot_navigation, @keys,
	  @tmp_keys, $flag, $child_links, $body, $more_links);

    $CURRENT_FILE = '';
    @tmp_keys = @keys = sort numerically keys %section_info;
    print "\nDoing section links ...";
    &adjust_segment_links if ($SEGMENT || $SEGMENTED);
    while (@tmp_keys) {
        $key = shift @tmp_keys;
	next if ($MULTIPLE_FILES &&!($key =~ /^$THIS_FILE/));
	print ".";
	$more_links = "";
	($depth, $file, $title) = split($delim,$section_info{$key});
	print STDOUT "\n$key $file $title" if ($VERBOSITY > 3);
	$PREVIOUS = $PREVIOUS_TITLE = $NEXT = $NEXT_TITLE = $UP = $UP_TITLE
	    = $CONTENTS = $CONTENTS_TITLE = $INDEX = $INDEX_TITLE
	    = $NEXT_GROUP = $NEXT_GROUP_TITLE
	    = $PREVIOUS_GROUP = $PREVIOUS_GROUP_TITLE
	    = $_ = $top_navigation = $bot_navigation = undef;
	@link =  split(' ',$key);
	($PREVIOUS, $PREVIOUS_TITLE) =
	    &add_link($previous_page_visible_mark,$file,@old_link);
	@old_link = @link;

	unless ($done{$file}) {
	    $link[$depth]++;
	    ($NEXT_GROUP, $NEXT_GROUP_TITLE)
		= &add_link($next_visible_mark, $file, @link);
	    &add_link_tag('next', $file, @link);
	    	    
	    $link[$depth]--;$link[$depth]--;
	    if ($MULTIPLE_FILES && !$depth ) {
	    } else {
		($PREVIOUS_GROUP, $PREVIOUS_GROUP_TITLE) =
		    &add_link($previous_visible_mark, $file,@link);
		&add_link_tag('previous', $file,@link);
	    }
	   
	    $link[$depth] = 0;
	    ($UP, $UP_TITLE) = 
		&add_link($up_visible_mark, $file, @link);
	    &add_link_tag('up', $file, @link);
	    
	    if ($CONTENTS_IN_NAVIGATION && $tocfile) {
		($CONTENTS, $CONTENTS_LINK) = 
		    &add_special_link($contents_visible_mark, $tocfile, $file);
		&add_link_tag($frame_body_name, $file, $delim.$tocfile);
	    }

	    if ($INDEX_IN_NAVIGATION && $idxfile) {
		($INDEX, $INDEX_LINK) = 
		    &add_special_link($index_visible_mark, $idxfile, $file);
		&add_link_tag('index', $file, $delim.$idxfile,);
	    }

	    @link = split(' ',$tmp_keys[0]);
	    # the required `next' link may be several sub-sections along
	    local($nextdepth,$nextfile,$nextkey)=($depth,$file,$key);
	    $nextkey = shift @tmp_keys;
	    ($nextdepth, $nextfile, $nexttitle,$nextbody) = split($delim,$section_info{$nextkey});
	    if (($nextdepth<$MAX_SPLIT_DEPTH)&&(!($nextbody=~/external/)))  {
		($NEXT, $NEXT_TITLE) =
		    &add_link($next_page_visible_mark, $file, @link);
		&add_link_tag('next', $file, @link);
	    } else {
		($NEXT, $NEXT_TITLE) = ('','');
		$nextfile = $file;
	    }

#	    if (($NEXT =~ /next_page_inactive_visible_mark/)&&(@tmp_keys)) {
	    if ((!$NEXT || $NEXT =~ /next_page_inactive_visible_mark/)&&(@tmp_keys)) {
		# the required `next' link may be several sub-sections along
		while ((@tmp_keys)&&(($MAX_SPLIT_DEPTH < $nextdepth+1)||($nextfile eq $file))) {
		    $nextkey = shift @tmp_keys;
		    ($nextdepth, $nextfile,$nexttitle,$nextbody) = split($delim,$section_info{$nextkey});
		    if ($nextbody =~ /external/) {
			$nextfile = $file;
			next;
		    };
		    print ",";
		    print STDOUT "\n$nextkey" if ($VERBOSITY > 3);
		}
		@link = split(' ',$nextkey);
		if (($nextkey)&&($nextdepth<$MAX_SPLIT_DEPTH)) {
		    ($NEXT, $NEXT_TITLE) =
			&add_link($next_page_visible_mark, $file, @link);
		    &add_link_tag('next', $file, @link);
		} else {
		    ($NEXT, $NEXT_TITLE) = ($NEXT_GROUP, $NEXT_GROUP_TITLE);
		    $NEXT =~ s/next_page_(inactive_)?visible_mark/next_page_$1visible_mark/;
		    ($PREVIOUS, $PREVIOUS_TITLE) = ($PREVIOUS_GROUP, $PREVIOUS_GROUP_TITLE);
		    $PREVIOUS =~ s/previous_(inactive_)?visible_mark/previous_page_$1visible_mark/;
		}
	    }
	    unshift (@tmp_keys,$nextkey) if ($nextkey);

	    local($this_file) = $file;
	    if ($MULTIPLE_FILES && $ROOTED) {
		if ($this_file =~ /\Q$dd\E([^$dd$dd]+)$/) { $this_file = $1 }
	    }

	    rename($this_file, "TMP.$this_file");
#	    open(INPUT, "<TMP.$this_file") || die "Cannot open file TMP.$this_file $!";
	    &slurp_input("TMP.$this_file");
#	    open(OUTFILE, ">$this_file") || die "Cannot open file $this_file $!";

	    if (($INDEX) && ($SHORT_INDEX) && ($SEGMENT eq 1)) { 
		&make_index_segment($title,$file); }

	    local($child_star,$child_links);
	    if (/$childlinks_on_mark\#(\d)\#/) { $child_star = $1 }
	    $child_links = &add_child_links('',$file, $depth, $child_star,$key, @keys)
		unless (/$childlinks_null_mark\#(\d)\#/);
	    if (($child_links)&&(!/$childlinks_mark/)&&($MAX_SPLIT_DEPTH > 1)) {
		if ($depth < $MAX_SPLIT_DEPTH -1) {
		    $_ = join('', $header, $_, &child_line(), $childlinks_mark, "\#0\#" );
		} else {
		    $_ = join('', $header, "\n$childlinks_mark\#0\#", &upper_child_line(), $_ );
		}
	    } else {
		$_ = join('', $header, $_ );
	    }

# File operations are carried out by &make_frame_header.
	    &make_frame_header ($title,$file,$_);
	    $done{$file}++;
	}
    }
    &post_process_footnotes if ($footfile);
}

sub adjust_segment_links {
    $EXTERNAL_UP_LINK = &adjust_segment_link($EXTERNAL_UP_LINK) if ($EXTERNAL_UP_LINK);
    $EXTERNAL_PREV_LINK = &adjust_segment_link($EXTERNAL_PREV_LINK) if ($EXTERNAL_PREV_LINK);
    $EXTERNAL_DOWN_LINK = &adjust_segment_link($EXTERNAL_DOWN_LINK) if ($EXTERNAL_DOWN_LINK);
}

sub adjust_segment_link {
    local($orig) = @_;
    local($link) = $orig;
    $link =~ s/(\Q$frame_main_suffix\E)?(\.html?)$/$frame_main_suffix$2/;
    if (-f $link) { return $link } else { return $orig }
}

# Altered: &make_footnotes.
# The only change is the call to &make_file.
sub make_frame_footnotes {
    # Uses $footnotes defined in translate and set in do_cmd_footnote
    # Also uses $footfile
    local($_) = "<DL>$footnotes<\/DL>\n";
    print "\nDoing footnotes ...";
    &replace_frame_markers;
    &replace_markers;
    if ($footfile) {
	&make_file($footfile, "Footnotes", $FOOT_COLOR); # Modifies $_;
	$_ = ""
    }
    $_;
}

# Altered: &make_file.
# It now takes a third argument specifying the layout (colors etc.)
sub make_frame_file {
    # Uses and modifies $_ defined in the caller
    local($filename, $title, $layout) = @_;
    $_ = join('', &make_head_and_body($title,$layout," "), $_
	, (($filename =~ /^\Q$footfile\E$/) ? '' : &make_address )
	, (($filename =~ /^\Q$footfile\E$/) ? "\n</BODY>\n</HTML>\n" : '')
	);
    &text_cleanup;
    open(FILE,">$filename") || print "Cannot open $filename $!\n";
    print FILE $_;
    close(FILE);
}

sub add_frame_special_link {
    local($icon, $file, $current_file) = @_;    
    local($text);
    if ($icon eq $index_visible_mark) {
	$text = $idx_title;
#	$current_file =~ s/$EXTN$/$frame_idx_suffix$&/;
	$current_file =~ s/($frame_main_suffix)?(\.html?)$/$frame_idx_suffix$2/;
	local($target) = $frame_top_name;
	("\n" . &make_href($current_file, $icon) 
    	    , ($text ? " ". &make_href($current_file, $text) : undef) )
    } elsif ($icon eq $contents_visible_mark) {
	$text = $toc_title;
#	$current_file =~ s/$EXTN$/$frame_toc_suffix$&/;
	$current_file =~ s/($frame_main_suffix)?(\.html?)$/$frame_toc_suffix$2/;
	local($target) = $frame_top_name;
	("\n" . &make_href($current_file, $icon) 
    	    , ($text ? " ". &make_href($current_file, $text) : undef) )
    } else {
	&add_real_special_link(@_)
    }
}

sub add_frame_child_links {
    local($target) = $target;
    local($split_depth) = $FALSE_SPLIT_DEPTH||$MAX_SPLIT_DEPTH;
    $target = ($depth < $split_depth-1 ? $frame_main_name : $frame_body_name)
	unless ($doing_toc);
    &add_real_child_links(@_);
}

# Place navigation lists within fixed-width <TABLE>s,
#  ... only when an appropriate width has been provided.
# Use this to prevent wrapping of moderately long titles; scroll instead

sub add_idx_hook {
    if ($INDEX_TABLE_WIDTH) {
	s!$idx_mark!
	    join(''
		, ($INDEX_BANNER ? $INDEX_BANNER."\n" : '')
		, '<TABLE WIDTH=',$INDEX_TABLE_WIDTH , '>'
		, "\n<TR><TD>$idx_mark</TD></TR>"
		, "\n</TABLE>\n"
		, ($INDEX_FOOTER ?  $INDEX_FOOTER."\n" : '')
		)
	!eo;
    }
    # call the real &add_idx indirectly, to catch overrides
    eval "&add_idx";
}

sub add_frame_toc {
    local($target) = $frame_main_name;
    local($use_description_list) = 1;
    local($doing_toc) = 1;
    if ($CONTENTS_TABLE_WIDTH) {
	# put into a <TABLE> of fixed size
	s!$toc_mark!
	    join('','<TABLE WIDTH=',$CONTENTS_TABLE_WIDTH,'>'
		, "\n<TR><TD>$toc_mark</TD></TR>"
		, "\n</TABLE>\n" )
	!eo;
    }
    # call the real &add_toc
    &add_real_toc;
}

sub do_frame_tableofcontents {
    local($toc_style) = 'TOC' if ($USING_STYLES);
    join("\n", $CONTENTS_BANNER , &do_real_tableofcontents(@_), $CONTENTS_FOOTER );
}


# Modified  &replace_general_markers
sub replace_frame_general_markers {
    local($target) = $frame_body_name;

    if (defined &replace_infopage_hook) {&replace_infopage_hook if (/$info_page_mark/);}
    else { &replace_infopage if (/$info_page_mark/); }

    $target = $frame_body_name;
    if (defined &add_idx_hook) {&add_idx_hook if (/$idx_mark/);}
    else {&add_idx if (/$idx_mark/);}

    if ($segment_figure_captions) {
#	s/$lof_mark/<UL>$segment_figure_captions<\/UL>/o
#   } else { s/$lof_mark/<UL>$figure_captions<\/UL>/o }
	s/$lof_mark/$segment_figure_captions/o
    } else { s/$lof_mark/$figure_captions/o }
    if ($segment_table_captions) {
#	s/$lot_mark/<UL>$segment_table_captions<\/UL>/o
#   } else { s/$lot_mark/<UL>$table_captions<\/UL>/o }
	s/$lot_mark/$segment_table_captions/o
    } else { s/$lot_mark/$table_captions/o }
    &replace_morelinks();
    if (defined &replace_citations_hook) {&replace_citations_hook if /$bbl_mark/;}
    else {&replace_bbl_marks if /$bbl_mark/;}

    $target = $frame_main_name;
    if (defined &add_toc_hook) {&add_toc_hook if (/$toc_mark/);}
    else {&add_toc if (/$toc_mark/);}
    if (defined &add_childs_hook) {&add_childs_hook if (/$childlinks_on_mark/);}
    else {&add_childlinks if (/$childlinks_on_mark/);}
    &remove_child_marks;

    $target = $frame_body_name;
    if (defined &replace_cross_references_hook) {&replace_cross_references_hook;}
    else {&replace_cross_ref_marks if /$cross_ref_mark||$cross_ref_visible_mark/;}

    $target = 'notarget';
    if (defined &replace_external_references_hook) {&replace_external_references_hook;}
    else {&replace_external_ref_marks if /$external_ref_mark/;}

    $target = $frame_body_name;
    if (defined &replace_cite_references_hook) {&replace_cite_references_hook;}
    else { &replace_cite_marks if /$cite_mark/; }

    if (defined &replace_user_references) {
 	&replace_user_references if /$user_ref_mark/; }
}

# Settings requested in the preamble take effect immediately;
# for those in the text a frame_marker is inserted, followed
# by the frame_data, which must be applied later.
# To control this, the value of $STARTFRAMES must be changed 
# when the preamble ends.

sub initialise_frames {
    print "\n *** initialising Netscape frames ***"
	if ($frame_implementation =~ /Netscape/);
    $frame_mark = '<tex2html_frame_mark>';
    &do_require_package(color);
    do {	# bind existing subroutines to the `frame' versions
	sub do_cmd_bibitem { &do_frame_bibitem(@_); }
	sub do_cmd_bibliography { &do_frame_bibliography(@_); }
	sub do_cmd_harvarditem { &do_frame_harvarditem(@_); }
	sub do_cmd_thanks { &do_frame_thanks(@_); }
	sub do_cmd_index { &do_frame_index(@_); }
	sub make_preindex { &make_frame_preindex; }
	sub do_cmd_footnote { &do_frame_footnote(@_); }
	sub do_cmd_footnotemark { &do_frame_footnotemark(@_); }
	sub do_cmd_tableofcontents { &do_frame_tableofcontents(@_); }
	sub add_toc { &add_frame_toc; }
	sub add_child_links { &add_frame_child_links(@_); }
#	sub process_footnote { &process_frame_footnote(@_); }
#	sub make_footnotes { &make_frame_footnotes(@_); }
# 	sub make_file { &make_frame_file(@_); }
 	sub anchor_label { &anchor_frame_label(@_); }
 	sub make_index_entry { &make_frame_index_entry(@_); }
 	sub add_special_link { &add_frame_special_link(@_); }
	sub make_half_href { &make_frame_half_href(@_); }
 	sub make_named_href { &make_frame_named_href(@_); }
 	sub make_href { &make_frame_href(@_); }
 	sub make_href_noexpand { &make_frame_href_noexpand(@_); }

	sub replace_general_markers { &replace_frame_general_markers(@_); }
	sub replace_cross_ref_marks { &replace_frame_cross_ref_marks(@_); }
	sub replace_external_ref_marks { &replace_frame_external_ref_marks(@_); }
	sub post_process { &frame_post_process(@_); }
 	sub apply_body_options { &apply_frame_body_options(@_); }
 	sub set_section_color { &set_frame_section_color(@_); }
	${AtBeginDocument_hook} .= "\$STARTFRAMES = 1;";
    }
}

if ($HTML_VERSION lt "$html_frame_version" ) { do { 
    print STDERR "\n*** frames are not supported with HTML version: $HTML_VERSION ***\n";
    &ignore_commands( <<_IGNORED_CMDS_);
frameoptions # [] # {}
framecolor # {} # {}
frameColorSet # [] # {}
frameColorSetstar # [] # {}
frameColorSetstarstar # [] # {}
_IGNORED_CMDS_
}} else { &initialise_frames(); }

1;  # This must be the last line.

