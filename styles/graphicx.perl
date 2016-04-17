# graphics.perl
#    by Bruce Miller <bruce.miller@nist.gov>
# Support of the graphics.sty standard LaTeX2e package
#    with `standard argument format'
# See graphics-support.perl
# ====================================================================== 
do_require_package('graphics-support');

# Package Options
sub do_graphics_dvips {}
sub do_graphics_draft {} # What'd be the point?
sub do_graphics_final {}
sub do_graphics_hiresbb {}
sub do_graphics_hiderotate { 
  map($GRAPHICS_OPTHIDE{$_}=1, @GRAPHICS_ROTATEOPTS); }
sub do_graphics_hidescale  { 
  map($GRAPHICS_OPTHIDE{$_}=1, @GRAPHICS_SCALEEOPTS); }

# ====================================================================== 
sub do_cmd_includegraphics {
  local($_)=@_;
  my $opt=x_next_optarg();   $opt =~ s/,/ /;
  my $op2=x_next_optarg();   $op2 =~ s/,/ /;
  my $file = x_next_arg();
  do_includegraphics($file,
     ($op2 ? "bb=$opt $op2" : ($opt ? "bb=0 0 $opt" : '')),
     "\\includegraphics".($opt && "[$opt]").($op2 && "[$op2]")."\{$file\}"); }

sub do_cmd_includegraphicsstar {
  local($_)=@_;
  my $opt=x_next_optarg();  $opt =~ s/,/ /;
  my $op2=x_next_optarg();  $op2 =~ s/,/ /;
  my $file = x_next_arg();
  do_includegraphics($file,
     ($op2 ? "bb=$opt $op2, clip" : ($opt ? "bb=0 0 $opt, clip" : "clip")),
     "\\includegraphics*".($opt && "[$opt]").($op2 && "[$op2]")."\{$file\}"); }

# ====================================================================== 
1;

