# CHANGEBAR.PERL by Nikos Drakos <nikos@cbl.leeds.ac.uk> 4-AUG-94
# Computer Based Learning Unit, University of Leeds.
#
# Extension to LaTeX2HTML to translate commands defined in 
# the changebar.sty file (c) 1990 by David B. Johnson 
# (dbj@titan.rice.edu). It also supports some commands from
# changebars.sty by Michael Fine and 
# Johannes Braams <J.L.Braams@research.ptt.nl>
#
#
# Modifications:
#
# nd = Nikos Drakos <nikos@cbl.leeds.ac.uk>
# hs = Herb Swan    <dprhws@edp.Arco.com>
# mg = Michel Goossens <goossens@cern.ch>
# rm = Ross Moore <ross@mpce.mq.edu.au>
#
# nd  4-AUG-94 - Created
# hs 20-DEC-95 - Removed arguments from chgbarwidth and chgbarsep
# mg 14-Jan-96 - added more commands for Braams's changebar package
# rm 10-Apr-96 - added version-control, using  \cbversion{..}

package main; 

sub do_cmd_chgbarbegin { &do_cmd_cbstart(@_) }
sub do_cmd_chgbarend { &do_cmd_cbend(@_) }

#  Recognise options to \usepackage{changebar} .

sub do_changebar_dvips {}
sub do_changebar_leftbars  { $cb_align = "left" if ($HTML_VERSION > 2.0);  }
sub do_changebar_rightbars { $cb_align = "right" if ($HTML_VERSION > 2.0); }



&ignore_commands(<<_IGNORED_CMDS_);
chgbarwidth
chgbarsep
driver
changebarwidth
changebarsep
changebargrey
deletebarwidth
outerbars
nochangebars
cb_at_barpoint # {} # {} # {}
_IGNORED_CMDS_



$cb_version = '';	# RRM  string for version control, initially empty.
$cb_align = '';		# RRM  alignment, empty for HTML 2.0 .

# style for displaying the version identifier string
$cbstyle = (($HTML_VERSION eq "2.0")? "I" : "SUP");

# regular expression for detecting \cbversion
$cbversion_rx = "\\\\cbversion<<\\d+>>[^<]+<<\\d+>>";

# regular expression for detecting nested changebars ending together
$cbend_rx = "(_change_\\w+_visible_mark>(<$cbstyle>[^<]*</$cbstyle>))?\\s*<BR>(<<\\d+>>)";


# RRM
# This routine is currently redundant, as the environments get processed
# before individual commands. However this may change with V97-NG.
#
sub do_cmd_cbversion{
    local($_) = @_;
    $cb_version = &missing_braces 
	unless ((s/$next_pair_rx[\s%]*/$cb_version=$2;''/eo)
	||(s/$next_pair_pr_rx[\s%]*/$cb_version=$2;''/eo));
    $_;
}


sub do_cmd_cbstart{
    local($cb_string)='';
    $cb_string = join('',"<$cbstyle>",$cbversion,"</$cbstyle>") if ($cb_version);
    join ('', &put_cb_icon('begin',2, $cb_string), @_[0]);
}

sub do_cmd_cbend{
    local($cb_string)='';
    $cb_string = join('',"<$cbstyle> ",$cbversion,"</$cbstyle>") if ($cb_version);
    join ('', &put_cb_icon('end',2, $cb_string), @_[0]);
}

sub do_cmd_cbdelete{
    local($cb_string)='';
    $cb_string = join('',"<$cbstyle>",$cbversion,"</$cbstyle>") if ($cb_version);
    join ('', &put_cb_icon('delete',2, $cb_string), @_[0]);
}

sub put_cb_icon{
    local($icon, $break, $string) = @_;
    local($cb_icon, $alignstr);
    local($brs) = (($break) ? "<BR>" : "" );
    local($bre) = "\n<BR>"; #(($break) ? "\n<BR>" : "");
    if ($cb_align =~ /r/) { $alignstr = "_right" } #unless ($icon =~ /del/); };
    eval "\$cb_icon = \$change_" . $icon . "$alignstr" . "_visible_mark";
    $cb_string = join('',"<$cbstyle>",$cbversion,"</$cbstyle>") if ($cb_version);
    if ($cb_align =~ /l/)    { "$brs$cb_icon$string$bre" }
    elsif ($cb_align =~ /r/) { "$brs$string$cb_icon$bre" }
    else { "$brs$cb_icon$string$bre" }
}

# RRM
# Look for a \cbversion{..} command as first thing in the environment.
# If found, use its argument for  $cb_version .
# RRM: no longer necessary, since \cbversion is now `wrap-deferred'.

sub do_env_changebar {
    &set_chgbar_preamble;
    local($_) = @_;
    local($next,$pat,$endcb) = ('','',2);
    local($endstr) = "<tex2html_change_end_visible_mark><$cbstyle>";
    local($keep) = $_;
    local($this_version) = $cb_version;

#    ($next,$pat) = &get_next_tex_cmd;
#    if ($next eq "cbversion") { 
#	s/$next_pair_rx/$cb_version=$2;''/eo; $keep = '';
#    } else { $_ = $keep }

    $_ = &translate_environments($_);

    # multiple ends of change-bars have icons on the same line.
    local($saveRS) = $/; undef $/;
    s/(($endstr[^<]*<\/$cbstyle>)\s*<BR>(<<\d+>>($cbversion_rx)?)?\s*$)/
	if ($`) {$1} else { $endcb = 0; $2.$3 }/egm;
    s/($cbend_rx\s*$)/ if ($`) { $1 } else { $endcb = 0; $2.$4 }/egm;
    $/ = $saveRS;


    if ($this_version) {
	join('', &put_cb_icon('begin',2, "<$cbstyle>$this_version</$cbstyle>")
	    , $_ , &put_cb_icon('end',$endcb, "<$cbstyle> $this_version</$cbstyle>"));
    } else {
	join('', &put_cb_icon('begin',2,""), $_ , &put_cb_icon('end',$endcb,""));
    }
}

$raw_arg_cmds{changebar} = 1;  # environment handles when to expand sub-environments

sub set_chgbar_preamble {
    $preamble .= "\\def\\cb\@barpoint#1#2#3{}\n"
    unless $preamble =~ /cb\@barpoint/;
}

&process_commands_wrap_deferred (<<_RAW_ARG_DEFERRED_CMDS_);
cbversion # {}
_RAW_ARG_DEFERRED_CMDS_


1;				# This must be the last line






