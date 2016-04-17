# Seminar.perl
# Keith Refson
# November 97
#
#  This version does not handle notes properly.
#  Text inside the slide and slide* environments is passed through
#  and processed into HTML.  Anything inside an explicit note environment
#  is ignored.  Notes *outside* a slide/slide* environment get mixed
#  up with the main text.
#

# Suppress option-warning messages:
 
sub do_seminar_portrait{}
sub do_seminar_a4{}

#
# New environments
# Text inside the slide and slide* environments is passed through
# and processed into HTML.  Anything inside a note environment
# 
sub do_env_slide {
    local($_) = @_;
    local($optional1,$dummy)=&get_next_optional_argument;
    local($failed, $labels, $comment, $halign) = ('','','','CENTER');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
    
    if ($failed) {
        $_ = &process_undefined_environment("slide", $br_id, $saved);
        $_ = (($comment.$labels)? "$comment$labels\n":''). $_;
    } else {
	$_ = &translate_environments($_);
	$_ = &translate_commands($_);
    }
    $halign = " ALIGN=\"$halign\"" if $halign;
    if ($border||($attribs)) {
        $_ = join('',"<BR>\n<DIV$halign>\n"
            , &make_table( $border, $attribs, '', '', '', $_ )
            , "</DIV>\n<BR CLEAR=\"ALL\">");
    } elsif ($HTML_VERSION > 2.2) {
        $_ = join('',"<BR><P></P>\n<DIV$halign>",$_
            ,"</DIV><BR CLEAR=\"ALL\">\n<P></P>");
    } else {
        $_ = join('',"<BR><P></P><P>\n",$_,"\n</P><P></P>");
    }
}

sub do_env_slidestar {
    &do_env_slide(@_);
}

sub do_env_note {
  "";
}
#
#  Putting "slide*" into the ignored commands list causes a failure - 
#  so do it by hand. *sigh*. "slide" is already in there....

++$ignore{'slide*'};

#
#  Slidesmag changes the magstep causes overlarge images since we 
#  pay no attention to it in the html file.  Reset it to zero
#  so images come out correct size.
#
${AtBeginDocument_hook} .= "&add_to_preamble(\'xxx\',\'\\slidesmag\{0\}\');";

#
# Redefine the \newslide command to do sectioning.  This splits the
# document as one might hope.  Declare our own global counter for slides.
#
%section_commands = ('newslide', 1, %section_commands);

sub do_cmd_newslide {
    local($after) = @_;
 
    $section_number = "0" if ($section_number eq "");
    $section_number++;
    #JKR: Don't prepend whitespace
    $TITLE =  " Slide $section_number" if $section_number;
 
    join('', &make_section_heading(" ", "H4" , ""), $after);
}

&ignore_commands( <<_IGNORED_CMDS_);
printlandscape
slideframe # {}
newslideframe # {}
slidewidth
slideheight
slidesmag # {}
landscapeonly
portraitonly
centerslidesfalse
centerslidestrue
raggedslides # []
extraslideheight # {}
setslidelength # {} # {}
addtoslidelength # {} # {}
ptsize # {}
onlyslides # {}
notslides # {}
articlemag # {}
slidestyle # {}
slidepagestyle # {}
onlynotestoo
_IGNORED_CMDS_

1;
