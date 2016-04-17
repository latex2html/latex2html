
$MAX_SPLIT_DEPTH = 5;
$PAPERSIZE = 'a4';

#  xymspec  environment
# centered image of its contents, including origin-markers
# use  tex2html_wrap  since cannot rely on the bounding-box
# --- XyMTeX {picture}s often place material outside the \hbox
#
sub do_env_xymspec {
    local($_) = @_;
    local($br_idA,$br_idB) = (++$global{'max_id'},++$global{'max_id'});
    local($contents) = join(''
    	, "\\medskip\\begin$O$br_idA${C}tex2html_wrap$O$br_idA$C"
    	, '\origpttrue ', $_
    	, "\\end$O$br_idB${C}tex2html_wrap$O$br_idB$C\\medskip " );
    &declared_env('center',$contents)
}

# sub Upsilon { &process_math_in_latex('text','','','\XyM') }
# sub UPSILON { &process_math_in_latex('','display','','\Upsilon') }

sub do_cmd_XyMTeX { join ('', &do_xym_XyM(), $TeXname, @_[0]) }
# sub do_xym_XyM { &process_math_in_latex('text','',''
#	,'\mbox{\vrule width0pt height 2.5ex\XyM}') }
sub do_xym_XyM {
    local($style);
    local($tags) = join(',',@open_tags);
    if ($tags =~ /LARGE|[Ll]arge/)   { $style .= "\\$&" }
    if ($tags =~ /bf/i ) { $style .= "\\bfseries" }
    elsif ($making_name||$making_title) { $style = '\bfseries' }
    local($adjust) = '';#\lower 2pt ' unless ($style);
    &process_math_in_latex('','',''
	,$adjust.'\hbox{'.$style.'\vrule width0pt depth0pt height 1.75ex \XyM}') }


1;
