# $Id: chemstr.perl,v 1.1 1998/08/24 09:48:46 RRM Exp $
#
#  chemstr.perl   by Ross Moore <ross@mpce.mq.edu.au>
#
# This file is part of the LaTeX2HTML support for the XyM-TeX package
# for TeX and LaTeX by Shinsaku Fujita
#
# Change Log
# ==========
# $Log chemstr.perl,v $
#

package main;

$XyMname = (($HTML_VERSION >= 3.0)? 'X<SUP><BIG>Y</BIG></SUP>M' : 'XyM');

sub do_cmd_XyMTeX { join ('', $XyMname, $TeXname, @_[0]) }
sub do_cmd_XyM { $XyMname . @_[0] }
sub do_cmd_UPSILON {
    local($br_idA) = ++$global{'max_id'};
    local($br_idB) = ++$global{'max_id'};
    join(''
	, &translate_commands(&translate_environments(
	    "\\begin$O$br_idA${C}math$O$br_idA$C\\Upsilon\\end$O$br_idB${C}math$O$br_idB$C"))
	, @_[0]) }

# These commands should not occur by themselves inline.
# They should be inside other commands/environments which
# specify the \begin{picture}....

&ignore_commands( <<_IGNORED_CMDS_);
rmoiety # {}
lmoiety # {}
putlatom # {} # {} # {}
putratom # {} # {} # {}
putlratom # {} # {} # {}
Putlratom # {} # {} # {}
setsixringv # {} # {} # {} # {} # {}
setdecaringv # {} # {} # {} # {} # {}
setfusedbond # {} # {} # {} # {} # {}
setatombond # {} # {} # {}
setsixringh # {} # {} # {} # {} # {}
_IGNORED_CMDS_


#
# Each command is treated as generating a separate inlined image.
# Perhaps these cannot occur inline ?

&process_commands_in_tex ( <<_INLINE_CMDS_);
#rmoiety # {}
#lmoiety # {}
_INLINE_CMDS_

#  origpttrue  is used essentially only within the preamble, for all images,
# or immediately after a group opening { 
# In the latter case, treat it as an image-request for the whole grouping

sub do_cmd_origpttrue  { &process_cmd_origpt ('true',  @_[0]) }
sub do_cmd_origptfalse { &process_cmd_origpt ('false', @_[0]) }

sub process_cmd_origpt {
    local($bool,$whats_next) = @_; $whats_next =~ s/^\s*//;
    if (($whats_next) && !$PREAMBLE ) {
	if ($env =~ /group/) {
	    &do_env_tex2html_wrap("\\origpt$bool ". $whats_next);
	} else {
	    $latex_body .= "\n\n\\origpt$bool\n\n";
	    $whats_next;
	}
    } else {
	$whats_next;
    }
}

$image_switch_rx .= '|origpttrue';


&process_commands_nowrap_in_tex ( <<_NOWRAP_CMDS_);
#origpttrue
#origptfalse
_NOWRAP_CMDS_

1;

