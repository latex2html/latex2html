# graphicx.perl
#    by Bruce Miller <bruce.miller@nist.gov>
# Support of the graphicx.sty standard LaTeX2e package
#    with `extended argument format'
# See graphics-support.perl
# ====================================================================== 
do_require_package('graphics-support');

# Package Options
sub do_graphicx_dvips {}
sub do_graphicx_draft {}
sub do_graphicx_final {}
sub do_graphicx_hiresbb {}
sub do_graphicx_hiderotate { 
  map($GRAPHICS_OPTHIDE{$_}=1, @GRAPHICS_ROTATEOPTS); }
sub do_graphicx_hidescale  { 
  map($GRAPHICS_OPTHIDE{$_}=1, @GRAPHICS_SCALEEOPTS); }

# ====================================================================== 
sub do_cmd_includegraphics {
  local($_)=@_;
  my $opt=x_next_optarg();
  my $op2=x_next_optarg();
  my $file = x_next_arg();
  my $file_from_subdir = find_from_subdir($file);
  if($op2){			# 2 optional args? Use `standard' arg format
    $opt = "bb=$opt,$op2"; $opt =~ s/,/ /g; }
  do_includegraphics($file,$opt,
		    "\\includegraphics".($opt && "[$opt]")."\{$file_from_subdir\}"); }

sub do_cmd_includegraphicsstar {
  local($_)=@_;
  my $opt=x_next_optarg();
  my $op2=x_next_optarg();
  my $file = x_next_arg();
  my $file_from_subdir = find_from_subdir($file);
  if($op2){			# 2 optional args? Use `standard' arg format
    $opt = "bb=$opt,$op2"; $opt =~ s/,/ /g; }
  $opt .= ", " if $opt;
  $opt .= "clip";
  do_includegraphics($file,"$opt",
		    "\\includegraphics".($opt && "[$opt]")."\{$file_from_subdir\}"); }

# ====================================================================== 
1;

