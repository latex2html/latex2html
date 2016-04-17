# xy.perl by Ross Moore <ross@mpce.mq.edu.au>  3-18-96
#
# Extension to LaTeX2HTML supply support for the Xy-pic
# suite of macros for typesetting diagrams and graphics 
# within TeX and LaTeX. 
#
# Change Log:
# ===========

package main;
#
#  Make the xy environment be translated as
#  generating an image.
#

sub do_env_xy {
    local($border,$attribs);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    $contents = &process_undefined_environment($env, $id,$contents);
    if ((($border)||($attribs))&&($HTML_VERSION > 2.1 )) { 
	$contents = &make_table( $border, $attribs, '', '', '', $contents ) }
    else { $contents }
}

sub do_env_diagram { &do_env_xy(@_); }
sub do_env_diagramnocompile { &do_env_xy(@_); }


#  Suppress the possible options to   \usepackage[....]{xy}

sub do_xy_all {
}
sub do_xy_arrow {
}
sub do_xy_arc {
}
sub do_xy_cmtip {
}
sub do_xy_color {
}
sub do_xy_crayon {
}
sub do_xy_curve {
}
sub do_xy_dummy {
}
sub do_xy_frame {
}
sub do_xy_graph {
}
sub do_xy_idioms {
}
sub do_xy_import {
}
sub do_xy_knot {
}
sub do_xy_line {
}
sub do_xy_matrix {
}
sub do_xy_poly {
}
sub do_xy_recat {
}
sub do_xy_rotate {
}
sub do_xy_tile {
}
sub do_xy_tips {
}
sub do_xy_v2 {
}
sub do_xy_web {
}
sub do_xy_2cell {
}

sub do_xy_ps {
}
sub do_xy_tpic {
}


#  ...including the device drivers:

sub do_xy_dvips {
}
sub do_xy_xdvi {
}
sub do_xy_textures {
}
sub do_xy_16textures {
}
sub do_xy_cmactex {
}
sub do_xy_17oztex {
}
sub do_xy_oztex {
}
sub do_xy_emtex {
}
sub do_xy_dvidrv {
}
sub do_xy_dvitops {
}


&ignore_commands( <<_IGNORED_CMDS_);
arraycolsep # &ignore_numeric_argument
xyoption # {}
xyrequire # {}
xywithoption # {} # {}
xyeverywithoption # {} # {}
xyeveryrequest # {} # {}
dumpPSdict # {}
_IGNORED_CMDS_


&process_commands_inline_in_tex (<<_RAW_ARG_CMDS_);
xy # <<\\endxy>>
xystar # <<\\endxy>>
xygraph # {}
xypolygon # {}
xymatrix # {}
xymatrixcompile # {}
xymatrixnocompile # {}
diagram # <<\\enddiagram>>
diagramcompileto # <<\\enddiagram>>
_RAW_ARG_CMDS_


&process_commands_nowrap_in_tex (<<_RAW_ARG_NOWRAP_CMDS_);
CompileMatrices # []
NoCompileMatrices
CompilePrefix # {}
CompileAllDiagrams # {}
NoCompileAllDiagrams
ReCompileAllDiagrams
LaTeXdiagrams
LoadAllPatterns # {}
LoadPattern # {} # {}
AliasPattern # {} # {} # {}
UsePatternFile # {}
newxypattern # {} # {}
MultipleDrivers
UseSingleDriver
xyReloadDrivers
xyShowDrivers
NoisyDiagrams
SloppyCurves
splinetolerance # {} 
UseResizing
NoResizing
NoRules
UseRules
OnlyOutlines
UseComputerModernTips
NoComputerModernTips
UseCrayolaColors
UsePSheader # {}
xyPSdefaultdict
UsePScolor
NoPScolor
UsePSframes
NoPSframes
UsePSlines
NoPSlines
UsePSrotate
NoPSrotate
UsePStiles
NoPStiles
UsePSspecials # {}
NoPSspecials
UseDVIPSspecials
UseTexturesPSspecials
UseTexturesSpecials
UsePostScriptSpecials
UseOzTeXspecials
UseDVITOPSspecials
UseEMspecials
NoEMspecials
maxTPICpoints # {}
UseTPICspecials
NoTPICspecials
UseTPICframes
NoTPICframes
UseAllTwocells
UseTwocells
UseHalfTwocells
UseCompositeMaps
arrowobject # {}
curveobject # {}
lowercurveobject # {}
uppercurveobject # {}
modmapobject # {}
twocellhead # {}
twocelltail # {}
definemorphism # {} # {} # {} # {}
everyentry # {}
everyxy # {}
entrymodifiers # {}
newdir # {} # {}
newxycolor # {} # [] # {}
newgraphescape # {} # [] # {}
knotholesize # {}
knotstyle # {}
knotstyles # {}
knotSTYLE # {}
knottips # {}
labelmargin # {}
turnradius # {}
objectmargin # <<>> {}
objectwidth # <<>> {}
objectheight # <<>> {}
#objectstyle # <<>> {}
spreaddiagramcolumns # {}
spreaddiagramrows # {}
xymatrixrowsep # {}
xymatrixcolsep # {}
_RAW_ARG_NOWRAP_CMDS_


#&process_commands_in_tex (<<_RAW_ARG_CMDS_);
#xymatrix # {}
#xymatrixcompile # {}
#xymatrixnocompile # {}
#xygraph # {}
#xypolygon # {}
#_RAW_ARG_CMDS_

#$XY_DONT_INCLUDE = join(':',xy,xypic,xyv2);
$DONT_INCLUDE = join(':',$DONT_INCLUDE,xy,xypic,xyv2);

1;                              # This must be the last line




