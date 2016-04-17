### File: techexpl.pl
### Version 0.1, June 15, 1999
### Written by Ross Moore <ross@maths.mq.edu.au>
###
### support for IBM TechExplorer browser plug-in
###

$TE_pluginName = "IBM-TechExplorer";
$TE_pluginPage = "http://www.software.ibm.com/network/techexplorer/";
$TEdone = 0;

sub do_env_TEinline {
    local($_) = @_;
    my ($TEcode, $L2Hcontents, $mtype);
    $mtype = &get_next_optional_argument;
    $mtype = &check_TE_mime_types($mtype);
    $TEcode = $L2Hcontents = $_;
    $L2Hcontents = &translate_environments($L2Hcontents);
    $L2Hcontents = &translate_commands($L2Hcontents);
    return ($L2Hcontents) unless ($mtype);
    $L2Hcontents =~ s/(^\s+|\s+$)//gs;
    $TEcode = &revert_to_raw_tex($TEcode);
    $TEcode =~ s/(\\|")/\\$1/gm;
    ++$TEdone;

    my $width = &TE_estimate_window_size('',$mtype,$L2Hcontents);

    if ($HTML_VERSION < 4.0) {
	join('', '<EMBED type="', $mtype, "\"\n $WIDTH\n"
		, ($TEdone>1? '':"\n  NAME=\"$TE_pluginName\"")
		, ($TEdone>1? '':"\n  PLUGINSPAGE=\"$TE_pluginPage\"")
		, ">\n<NOEMBED>\n"
		, $L2Hcontents
		, "\n</NOEMBED></EMBED>\n" );
    } else {
        join('', '<OBJECT type="', $mtype, "\"\n $WIDTH\n"
		, ($TEdone>1? '':"\n  CODEBASE=\"$TE_pluginPage\"")
		, ">\n<PARAM value=\"$TEcode\">\n"
		, $L2Hcontents
		, "\n</OBJECT>\n" );
    }
}

sub do_env_TEinfile {
    local($_) = @_;
    my ($TEcode, $L2Hcontents, $mtype, $TEfile);
    $mtype = &get_next_optional_argument;
    $TEcode = $L2Hcontents = $_;

    $mtype = join('',' TYPE="',&check_TE_mime_types($mtype));
    $L2Hcontents = &translate_environments($L2Hcontents);
    $L2Hcontents = &translate_commands($L2Hcontents);
    return ($L2Hcontents) unless ($mtype);
    $L2Hcontents =~ s/(^\s+|\s+$)//gs;

    if ($envID) {
	$TEfile = $envID;
	$TEfile =~ s/infile//;
	$TEfile .= '.tex';
	open TEout, ">$TEfile" or return ($L2Hcontents);
    } else { return ($L2Hcontents) }

    $TEcode = &revert_to_raw_tex($TEcode);
    print TEout $TEcode;
    close TEout;
    ++$TEdone;

    my($stag,$etag,$noembed,$height,$param);
    my $mtag = "\"\n ";
    if ($HTML_VERSION < 4.0) {
	$stag = "\n<EMBED";
	$noembed = ">\n<NOEMBED>\n";
	$etag = "</NOEMBED></EMBED>\n";
	$mtype.= '" SRC="';
	$mtag = join(''
	    , "\"\n  NAME=\"$TE_pluginName\""
	    , "\n  PLUGINSPAGE=\"$TE_pluginPage"
	    , $mtag ) unless ($TEdone > 1);
    } else {
	$stag = "\n<OBJECT";
	$noembed = ">\n";
	$etag = "\n</OBJECT>\n";
	$mtype.= '" DATA="';
	$mtag = join(''
	    , "\"\n  ID=\"$TE_pluginName\""
	    , "\n  CODEBASE=\"$TE_pluginPage"
	    , $mtag ) unless ($TEdone > 1);
    }
    my $width = ' WIDTH="100%" HEIGHT="';

#    if ($HTML_VERSION < 4.0) {
#        join('', '<EMBED type="', $mtype, "\" src=\"$TEfile\"\n"
#		, ($TEdone>1? '':"\n  NAME=\"$TE_pluginName\"")
#		, ($TEdone>1? '':"\n  PLUGINSPAGE=\"$TE_pluginPage\"")
#		, ">\n<NOEMBED>\n"
#		, $L2Hcontents
#		, "\n</NOEMBED></EMBED>\n" );
#    } else {
#        join('', '<OBJECT type="', $mtype, "\" src=\"$TEfile\"\n"
#		, ">\n<PARAM value=\"$TEcode\">\n"
#		, $L2Hcontents
#		, "\n</OBJECT>\n" );
#    }
    my ($TE_undefined,$TE_invalid,$TE_lines) = &TE_check_file_contents($TEfile);
    if (!$TE_invalid) {
	print "\nwrote TE file: $TEfile\n";
	# very rough estimate of the height
	$height = join('', 20*$TE_lines,'"');
	join('', $stag, $mtype, $TEfile, $mtag, $width, $height
 	   , $noembed, $L2Hcontents, $etag)
    } else {
	--$TEdone;
	&write_warnings("Did not include TE file-link to: $TEfile");
	$L2Hcontents
    }
}


sub check_TE_mime_types {
    local($mtype) = @_;
    if ($mtype =~ /^mml$/i) {
	&write_warnings("MathML (.mml) is not yet supported");
	"";
    } elsif ($mtype =~ /^t[ec]x$/i) {
	"application/x-latex";
    } elsif ($mtype) {
	&write_warnings(
	  "MIME type '$mtype' is not supported by IBM TechExplorer");
	"";
    } else { 
	"application/x-latex";
    }
}

sub TE_estimate_window_size {
    local ($isfile, $type, $data);
    if ($isfile) {
	' WIDTH="100%" HEIGHT="24"';
    } else {
	my $lines = $data =~ /\n/sg;
	join('', ' WIDTH="100%"', ' HEIGHT="',$lines x 20,'"');
    }
}

sub TE_replace_file_marks {
    my($ifile,$contents,$stag,$etag,$noembed,$height,$param,$pre,$post);
    print "\nLooking for TechExplorer \\include  files ... ";

    my $mtype = join('',' TYPE="',&check_TE_mime_types('tex'));
    my $mtag = "\"\n ";
    if ($HTML_VERSION < 4.0) {
	$stag = "\n<EMBED";
	$noembed = ">\n<NOEMBED>\n";
	$etag = "</NOEMBED></EMBED>\n";
	$mtype.= '" SRC="';
	$mtag = join(''
	    , "\"\n  NAME=\"$TE_pluginName\""
	    , "\n  PLUGINSPAGE=\"$TE_pluginPage"
	    , $mtag ) unless ($TEdone > 1);
    } else {
	$stag = "\n<OBJECT";
	$noembed = ">\n";
	$etag = "\n</OBJECT>\n";
	$mtype.= '" DATA="';
	$mtag = join(''
	    , "\"\n  ID=\"$TE_pluginName\""
	    , "\n  CODEBASE=\"$TE_pluginPage"
	    , $mtag ) unless ($TEdone > 1);
    }
    my $width = ' WIDTH="100%" HEIGHT="';
    my ($TE_invalid,$TE_lines);

    s/(<(DIV|SPAN)[^>]*>\n)?$file_mark\#(.*)\#\n(.*)(<(DIV|SPAN)[^>]*>\n)?$endfile_mark\#\3\#(\n<\/(DIV|SPAN)>)?\n/
	$ifile=$3;$contents=$1.$4.$7; $post=$5; ++$TEdone;
	$contents =~ s!(<(DIV|SPAN)[^>]*>\n?)$!$post=$1.$post;''!esi;
	# only put the TE url on the first occurrence
	$mtag = "\"\n " if ($TEdone > 1);
	#
	# file name is relative to source directory: $orig_cwd
	# but we need it relative to  $DESTDIR
	# (assumed to be the same, or a child)
	#
	do {
	    if (!($ifile =~ s!^(\.$dd)!\.$1!)) {
		$ifile = &fulltexpath($ifile) }
	} unless ($DESTDIR eq $orig_cwd);

	if (-f $ifile) {
	    my ($TE_undefined,$TE_invalid,$TE_lines) = &TE_check_file_contents($ifile);
	    if (!$TE_invalid) {
		print "\nTE included file: $ifile\n" if ($VERBOSITY > 1);
		# very rough estimate of the height
		$height = join('', 20*$TE_lines,'"');
		join('', $stag, $mtype, $ifile, $mtag, $width, $height
	 	   , $noembed, $param, $contents, $etag, $post)
	    } else {
		&write_warnings("Did not include TE file-link to: $ifile");
		$contents.$post
	    }
	} else {
	    ($TE_invalid,$TE_lines) = ('',0);
	    &write_warnings("Could not find TE \\include file: $ifile");
	    $contents.$post
	}
    /esg;    
}

#
# check the TeX code within the file, for control-sequences
# that TechExplorer does not implement.
#
sub TE_check_file_contents {
    local ($ifile) = @_;
    open(TEINC, "<$ifile");
    my($macrosOK,$macrosNUM,$numlines,$invalid) = (0,0,0,0);
    my $TE_special_macros_rx = join('|',@TE_special_macros);
    my $TE_defined_accents_rx = join('|',@TE_defined_accents);
    my $TE_defined_spec_chars_rx = join('|',@TE_defined_spec_chars);
    my $TE_defined_symbols_rx = join('|',@TE_defined_symbols);
    my $TE_font_macros_rx = join('|',@TE_font_macros);
    my $TE_defined_macros_rx = join('|',@TE_defined_macros);
    my $TE_ignored_macros_rx = join('|',@TE_ignored_macros);
    my $TE_ignored_parameters_rx = join('|',@TE_ignored_parameters);
    my $TE_defined_environments_rx = join('|',@TE_defined_environments);
    my $TE_newcommands_rx = join('|',@TE_newcommands) if (@TE_newcommands);

    my($cmd, $tech_check) = ('',0);
    while (<TEINC>) {
	# count lines containing decent source text
	++$numlines unless /(^(\%|$|\\begin|\\iftechexplorer|\\(fi|item)$)|\\altLink)/;
	s/$TE_invalid_rx/++$invalid;''/egs;

	# discard after \iftechexplorer....\else  ...up to the...  \fi
	if (/\\iftechexplorer\b/) {++$tech_check};
        if ($tech_check) {
	    if (/\\else\b/) {
		++$tech_check; $_=$`;
		if ($' =~ /\\fi\b/) { $_ .= $'; $tech_check = 0 }
	    } elsif ($tech_check > 1) {
		if (/\\fi\b/) { $_ = $'; $tech_check = 0 }
	    }
	}
	# collect any new command/environment definitions
	s/\\g?def(ine)?\s*\\([a-zA-Z]+)\b/
	    push @TE_newcommands, $2;
	    $TE_newcommands_rx .= '|'.$2;''/eg;
	s/\\((re)?new|provide)command\s*\{\s*\\([a-zA-Z]+)\s*\}/
	    push @TE_newcommands, $3;
	    $TE_newcommands_rx .= '|'.$3;''/eg;
	s/\\((re)?new|provide)environment\s*\{\s*\\([a-zA-Z]+)\s*\}/
	    push @TE_defined_environments, $3;
	    $TE_defined_environments_rx .= '|'.$3;''/eg;

	# check all the control-sequences for TE-compatibility
	#
	s/(^|\G|[^\\])\\((begin|end)\{([^\}]+)\}|("\w|[\W\d]|[a-zA-Z]+\*?))/$cmd = $4||$5;
	    if ($4) {
		do { &write_warnings("TE cannot process environment \{$cmd\}");
		     ++$macrosNUM;
		    } unless ($cmd =~ m!^($TE_defined_environments_rx)$!);
	    } else {
		do { &write_warnings("TE cannot process command \\$cmd");
		     ++$macrosNUM;
		    } unless 
		($cmd =~ m!^($TE_special_macros_rx|$TE_defined_symbols_rx)$!)
		||((@TE_newcommands)&& $cmd =~ m!^($TE_newcommands_rx)$!)
	        ||($cmd =~ m!^($TE_defined_accents_rx|$TE_defined_spec_chars_rx)$!)
	        ||($cmd =~ m!^($TE_font_macros_rx|$TE_defined_macros_rx)$!)
		||($cmd =~ m!^($TE_ignored_macros_rx|$TE_ignored_parameters_rx)$!)
	        ||($cmd =~ m!^(begin|end)($TE_defined_environments_rx)$!)
	    };''
	/egs;
    }
    close TEINC;
    &write_warnings("file $ifile contains $macrosNUM TE-invalid macro usages")
	if ($macrosNUM);
    ($macrosNUM,$invalid,$numlines);
}

$TE_invalid_rx = "\\begin\s*\{TE_in(line|file)\}";

# users should set this, for commands in any files \input without checking
@TE_newcommands = () unless (@TE_newcommands);

@TE_special_macros = (
	 'aboveTopic','altLink','appLink','audioLink'
	,'backgroundcolor','backgroundimage','backgroundsound','bibfile','buttonBox'
	,'define','dialogBox','docLink','evalLink'
	,'globalnewcommand','globalnewenvironment','gradientBox'
	,'iftechexplorer'
	,'includeaudio','includevideo','inputbox','inputboxLink','inputonce'
	,'labelLink','nextTopic','newmenu','nocaret'
	,'popupLink','previousTopic','ProvidesFeature','RequiresFeature'
	,'techexplorerLinkColor','TrueTypeTextFont','usemenu'
	,'videoLink','windowTitle','yesNoLink'
	);

@TE_defined_accents = ('"A','"a','"E','"e','"I','"i','"O','"o','"U','"u');

@TE_defined_spec_chars = (
	'\!','\$','\&','\>','\,','\/','\:',';','\{'.'\}','\[','\]','\(','\)'
	,'\^','_','\\\\','\|','\@','\-',' ','\%'
	);

@TE_defined_symbols = (
	 'AA','aa','AE','ae','aleph','alpha','amalg','angel','angle','approx','ast','asymp'
	,'backprime','backslash','Bbbk','because','beta','beth','between'
	,'bigcap','bigcirc','bigcup','bigodot','bigoplus','bigotimes','bigsqcup','bigstar'
	,'bigtriangledown','bigtriangleup','biguplus','bigvee','bigwedge','blacksquare'
	,'blacktriangle','blacktriangledown','blacktriangleleft','blacktriangleright'
	,'bot','bowtie','Box','box','boxdot','boxminus','boxplus','boxtimes'
	,'bullet','Bumpeq','bumpeq'
	,'Cap','cap','cdot','cents','chi','circ','circeq'
	,'circlearrowleft','circlearrowright','circledast','circledcirc','circleddash'
	,'clubsuit','compliment','cong','coprod','copyright','Cup','cup'
	,'curlyeqprec','curlyeqsucc','curvearrowleft','curvearrowright'
	,'dag','dagger','daleth','dashv','ddag','ddagger','Delta','delta'
	,'diagdown','diagup','Diamond','diamond','diamondsuit','digamma','div'
	,'doteq','doteqdot','dots'
	,'Downarrow','downarrow','downarrows','downharpoonleft','downharpoonright'
	,'ell','emptyset','epsilon','eqcirc','eqslantless','equiv','eta','eth','exists'
	,'fallingdotseq','Finv','flat','forall','frown'
	,'Game','Gamma','gamma','ge','geq','geqq','geqslant','geqslant','gg','ggg'
	,'gimel','gnapprox','gneq','gneqq','gnsim'
	,'gt','gtreqless','gtreqqless','gtrless','gtrsim','gvertneqq'
	,'hbar','heartsuit','hookleftarrow','hookrightarrow','hslash'
	,'i','Im','imath','in','infty','int','intercal','iota'
	,'j','jmath','Join'
	,'kappa'
	,'Lambda','lambda','land','langle','lceil','le','leadsto'
	,'Leftarrow','leftarrow','leftharpoondown','leftharpoonup','leftleftarrows'
	,'Leftrightarrow','leftrightarrow','leftrightarrows','leftrightharpoons'
	,'leftrightsquigarrow'
	,'leq','leqq','leqslant','lessaprox','lesseqgtr','lesseqqgtr','lessgrt','lesssim'
	,'lfloor','lhd','ll','llcorner','lll','lnapprox','lneq','lneqq','lnsim'
	,'Longleftarrow','longleftarrow','Longleftrightarrow','longleftrightarrow'
	,'longmapsto','Longrightarrow','longrightarrow','looparrowleft','looparrowright'
	,'lor','lozenge','lq','lrcorner','Lsh','lt','ltimes','lvertneqq'
	,'mapsto','measuredangle','mho','mid','models','mp','mu','multimap'
	,'nabla','natural','ncong','ne','nearrow','neg','neq','nexists','ngeq','ngeqq'
	,'ngtr','ni','nLeftarrow','nleftarrow','nLeftrightarrow','nleftrightarrow'
	,'nleq','nleqq','nleqslant','nless','nmid','nparallel','nprec','npreceq'
	,'nqeqslant','nRightarrow','nrightarrow','nshortmid'
	,'nshortparallel','nsim','nsubseteq','nsubseteqq','nsucc','nsucceq','nsupseteq'
	,'nsupseteqq','ntriangleleft','ntriangleright'
	,'nu','nVDash','nVdash','nvDash','nvdash','nwarrow'
	,'O','o','odot','OE','oe','oint','Omega','omega','ominus','oplus','oslash','otimes'
	,'P','parallel','partial','perp','Phi','phi','Pi','pi','pitchfork','pm','pounds'
	,'prec','precapprox','preccurlyeq','preceq','precnapprox','precnsim','precsim'
	,'prime','prod','propto','Psi','psi'
	,'rangle','rceil','Re','registered','rfloor','rhd','rho'
	,'Rightarrow','rightarrow','rightharpoondown','rightharpoonup','rightleftarrows'
	,'rightleftharpoons','rightrightarrows','risingdotseq','rq','Rsh','rtimes'
	,'S','searrow','setminus','sharp','shortmid','shortparallel','Sigma','sigma'
	,'sim','simeq','slash','smile','spadesuit','sphericalangle','sqcap','sqcup'
	,'sqsubset','sqsubset','sqsubseteq','sqsupset','sqsupset','sqsupseteq','square'
	,'ss','star','subset','subseteq','subsetneqq'
	,'succ','succapprox','succapprox','succcurlyeq','succeq','succnapprox','succnsim'
	,'succsim','sum','supset','supseteq','supsetneq','supsetneqq','surd','swarrow'
	,'tau','therefore','Theta','theta','thickapprox','thicksim'
	,'THORN','Thorn','thorn','times','to','top','trademark'
	,'triangle','triangledown','triangleleft','trianglelefteq','triangleq'
	,'triangleright','trianglerighteq','twoheadleftarrow','twoheadrightarrow'
	,'ulcorner','unlhd','unrhd','Uparrow','uparrow','Updownarrow','updownarrow'
	,'upharpoonleft','\upharpoonright','uplus','Upsilon','upsilon','urcorner'
	,'varepsilon','varkappa','varnothing','varphi','varpi','varrho','varsigma'
	,'varsubsetneq','varsubsetneq','varsubsetneqq','varsupsetneq','varsupsetneqq'
	,'vartheta','vartriangle','vartriangleleft','vartriangleright'
	,'Vdash','vDash','vdash','vee','Vert','vert','Vvdash'
	,'wedge','wp','wr','Xi','xi','zeta'
);

@TE_font_macros = ('bf','cal','displaystyle','em','emph','footnotesize','Huge','huge'
	,'it','LARGE','Large','large','mathbb','mathbf','mathcal','mathit','mathsf'
	,'mathtt','mit','normalsize','rm','sc','scriptscriptsize','scriptscriptstyle'
	,'scriptsize','scriptstyle','sf','sl','small'
	,'textbf','textit','textrm','textsf','textsl','textstyle','texttt','tiny','tt'
	);

@TE_defined_macros = (
	 'acute','addtocounter','Alph','alph','arabic','arccos','arcsin','arctan'
	,'arg','atop','author'
	,'begingroup','bf','bgroup','bibitem','big','bigl','bigm','bigr','Bigl','Big'
	,'Bigm','Bigr','bigg','biggl','biggm','biggr','Bigg','Biggl','Biggm','Biggr'
	,'bigskip','Bmatrix','bmatrix','bmod','bold','boxed','break'
	,'caption','cases','cdots','centering','centerline','cfrac','chapter','choose'
	,'cite','colon','color','colorbox','cos','cosh','cot','coth','csc','csch'
	,'date','ddot','ddots','ddotsb','ddotsc','ddotsi','ddotsm','def','deg','det'
	,'dfrac','dim','displaylines','displaystyle','dot'
	,'egroup','em','emph','endgroup','enskip','enspace','ensuredisplaymath'
	,'ensuremath','eqno','erf','errmessage','exp'
	,'fbox','fcolorbox','fil','fill','filll','fnsymbol','footnotesize','frac','framebox'
	,'gcd','gdef','global','grave'
	,'H','hat','hbox','hfil','hfill','hfilll','hline','hom','hphantom','hrule'
	,'hsize','hskip','hspace','hspace*','hss','Huge','huge'
	,'idotsint','iff','ifmmode','iint','iiint','iiiint','impliedby','implies'
	,'includegraphics','include','index','inf','input','it','item'
	,'joinrel'
	,'kern','ker'
	,'label','LARGE','Large','large','LaTeX','lbrace','lbrack','lcm','ldots'
	,'left','leftline','leqno','lg','lim','liminf','limsup','llap','ln','log'
	,'lower','lowercase','lVert','lvert'
	,'makebox','maketitle','mathbb','mathbf','mathbin','mathcal','mathchoice'
	,'mathclose','mathit','mathop','mathopen','mathord','mathrel','mathsf','mathstrut'
	,'mathtt','matrix','max','mbox','medbreak','medspace','medskip','min','mit'
	,'negmedspace','negthinspace','newcommand','newcounter','newenvironment'
	,'newline','normalsize','not','notin','null'
	,'operatorname','over','overbrace','overbracket','overline','overrightarrow'
	,'overset'
	,'pagecolor','par','paragraph','parbox','part','phantom','pmatrix','pmod','pod'
	,'Pr','prime','providecommand'
	,'qed','qedsymbol','qquad','quad'
	,'raggedleft','raggedright','raise','raisebox','rbrace','rbrack','refstepcounter'
	,'relax','renewcommand','renewenvironment','right','rightline','rlap'
	,'rm','root','Roman','roman','rule','rVert','rvert'
	,'sb','sc','scriptscriptsize','scriptscriptstyle','scriptsize','scriptstyle'
	,'shadowbox','sec','sech','section','setstyle','sf','sin','sinh','sl'
	,'small','smallskip','smallmatrix','smash','sp','space','sqrt','stackrel'
	,'stepcounter','strut','subparagraph','subsection','subsubsection','sup'
	,'tan','tanh','TeX','text','textbf','textcolor','textit','textrm','textsf','textsl'
	,'textstyle','texttt','tfrac','thanks','thebibliography','thechapter','theenumi'
	,'theenumii','theenumiii','theenumiv','theequation','thefigure','thefootnote'
	,'thempfootnote','thepage','theparagraph','thepart','thesection'
	,'thesubparagraph','thesubsection','thesubsubsection','thetable'
	,'thickspace','thinspace','tilde','tiny','title','today','tt'
	,'underbar','underbrace','underbracket','underline','underset','uppercase'
	,'value','vbox','vdots','verb','Vmatrix','vmatrix','vphantom','vrule'
	,'vskip','vss','vtop'
	,'widehat','widetilde'
	,'zag','zig'
	);

@TE_ignored_macros = (
	 'addcontentsline','addtocontents','addtolength','allowbreak','and'
	,'bibliographystyle','boldmath','break','brokenpenalty','bye'
	,'cleardoublepage','clearpage','cline','clubpenalty'
	,'DeclareMathOperator','definecolor','displaywidowpenalty'
	,'documentclass','documentstyle'
	,'eject','else','end'
	,'fi','floatingpenalty','font','fontencoding','fontfamily','fontseries'
	,'fontshape','fontsize','footnotemark','frenchspacing','fussy'
	,'goodbreak'
	,'hline','hyphenation'
	,'indent','interlinepenalty'
	,'let','limits','linebreak','long','looseness'
	,'markboth','markright','multicolumn'
	,'newblock','newif','newlength','newpage','newtheorem'
	,'noalign','nobreak','nocite','nocorr','nofrenchspacing','noindent','nolimits'
	,'nolinebreak','nomargins','nonumber','nopagebreak','nopagenumbers','null'
	,'pagebreak','pagenumbering','pagestyle','postdisplaypenalty','predisplaypenalty'
	,'protect','putat'
	,'raggedbottom','relax','rgb'
	,'selectfont','setlength','settodepth','settoheight','settowidth'
	,'singlespace','sloppy','special'
	,'techexplorerfalse','techexplorertrue','thispagestyle','typeout'
	,'unboldmath','usefont','usepackage'
	,'widowpenalty'
	);

@TE_ignored_parameters = (
	 'abovedisplayshortskip','abovedisplayskip','arraycolsep','arrayrulewidth'
	,'baselineskip','baselinestretch','belowdisplayshortskip','belowdisplayskip'
	,'bibindent'
	,'columnsep','columnseprule'
	,'dblfloatsep','dbltextfloatsep','doublerulesep'
	,'emergencystretch','epsfxsize','evensidemargin'
	,'fboxrule','fboxsep','floatsep','footnotesep','footskip'
	,'hangafter','hangindent','headheight','headsep','hoffset','hsize'
	,'intextsep'
	,'jot'
	,'leftskip','linewidth','magnification'
	,'magstep','marginparpush','marginparsep','marginparwidth','mathindent'
	,'oddsidemargin'
	,'pageheight','pagewidth','parindent','parskip'
	,'rightskip'
	,'tabbingsep','tabcolsep','textfloatsep','textheight','textwidth','topmargin'
	,'topskip','voffset','vsize'
	);

@TE_defined_environments = (
	 'align','align*','abstract','array'
	,'Bmatrix','bmatrix'
	,'center'
	,'description','dirlist','displaymath','document'
	,'enumerate','eqnarray','eqnarray*','equation'
	,'figure','flushleft','flushright'
	,'gather','gather*'
	,'Huge','huge'
	,'itemize'
	,'LARGE','Large','large'
	,'math','matrix','minipage'
	,'normalsize'
	,'pmatrix'
	,'quotation','quote'
	,'slide','small','smallmatrix'
	,'tabbing','table','tabular','tiny','titlepage'
	,'verbatim','Vmatrix','vmatrix'
	);


#
# replace the  &remove_file_marks  hook with  &TE_replace_file_marks
# for \include files, not in the document preamble
#
sub replace_file_marks {
    if ($PREAMBLE) { &remove_file_marks }
    else { &TE_replace_file_marks }
}

1;


