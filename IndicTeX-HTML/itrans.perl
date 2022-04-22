# $Id: itrans.perl,v 1.4 1999/03/13 00:22:58 RRM Exp $
# ITRANS.PERL by Ross Moore <ross@mpce.mq.edu.au> 8-4-98
# Mathematics Department, Macquarie University, Sydney, Australia.
#
# Style for LaTeX2HTML v98.1 to construct images of traditional
#  Indic scripts, using:
#
#  ITRANS pre-processor and fonts: by Avinash Chopde
#
#
# The ITRANS system is *not* included with this package.
# Obtain if from:  http://www.aczone.com/itrans.html
#
# ===================================================================
# This package requires the corresponding LaTeX package:  itrans.sty .
#
# With LaTeX2HTML the options on the \usepackage line specify which
# preprocessor and transcription output mode to use.
#
# Usage:
#
#  \usepackage{itrans}            %|  for text already pre-processed
#
#  options affecting Input-forms
#
#  \usepackage[itrans]{itrans}    %|  itrans 7-bit transliteration
#  \usepackage[preprocess]{itrans}%|  same as  [itrans]
#  \usepackage[7bit]{itrans}      %|  same as  [itrans]
#  \usepackage[csx]{itrans}       %|  8-bit Sanskrit extension of ISO 646
#  \usepackage[8bit]{itrans}      %|  same as  [csx]
#
#  options affecting Output-forms
#
#  \usepackage[html7]{itrans}     %|  use <FONT> tags with 7-bit entities  
#  \usepackage[html8]{itrans}     %|  use <FONT> tags with 8-bit codes
#  \usepackage[postscript]{itrans}%|  --- not implemented
#
#  options specifying languages:
#
#  \usepackage[ind]{itrans} %|  Indian
#
#  \usepackage[ben]{itrans} %|  Bengali
#  \usepackage[dev]{itrans} %|  Devanagari
#  \usepackage[guj]{itrans} %|  Gujarati
#  \usepackage[gur]{itrans} %|  Gurmukhi
#  \usepackage[hin]{itrans} %|  Hindi
#  \usepackage[kan]{itrans} %|  Kannada
#  \usepackage[mar]{itrans} %|  Marathi
#  \usepackage[ori]{itrans} %|  Oriya
#  \usepackage[pun]{itrans} %|  Punjabi
#  \usepackage[rom]{itrans} %|  Romanisation
#  \usepackage[san]{itrans} %|  Sanskrit
#  \usepackage[tam]{itrans} %|  Tamil
#  \usepackage[tel]{itrans} %|  Telugu
#
#
#  \usepackage[bengali]{itrans}    %|  Bengali
#  \usepackage[devanagarii]{itrans}%|  Devanagari
#  \usepackage[gujarati]{itrans}   %|  Gujarati
#  \usepackage[gurmukhi]{itrans}   %|  Gurmukhi
#  \usepackage[hindi]{itrans}      %|  Hindi
#  \usepackage[kannada]{itrans}    %|  Kannada
#  \usepackage[marathi]{itrans}    %|  Marathi
#  \usepackage[oriya]{itrans}      %|  Oriya
#  \usepackage[punjabi]{itrans}    %|  Punjabi 
#  \usepackage[roman]{itrans}      %|  Romanisation
#  \usepackage[sanskrit]{itrans}   %|  Sanskrit
#  \usepackage[tamil]{itrans}      %|  Tamil
#  \usepackage[telugu]{itrans}     %|  Telugu
#
#
# ===================================================================
# Warning
#
#  This package works BOTH with source *before* pre-processing
#  and also *after* having pre-processed.
#  The latter may create more smaller images of individual syllabes,
#  whereas the former tends to create larger images of whole lines,
#  paragraphs, sections, etc.
# ===================================================================
#
# Change Log:
# ===========
# $Log: itrans.perl,v $
# Revision 1.4  1999/03/13 00:22:58  RRM
#  --  implement <SPAN> and <DIV> tags for HTML4.0
#  --  include LANG=  attribute with HTM4.0
#  --  use \vbox with paragraphs
#  --  fine-tuning for certain letters to prevent cropping-bar problems
#
# Revision 1.3  1998/06/19 12:28:48  RRM
#  --  recognise #endfont
#  --  indic environment may finish as inline, not all paragraphs
#  --  removed unneeded variable and code
#  --  ensure unwanted gaps don't appear at the start of environments
#
# Revision 1.2  1998/06/18 12:30:50  RRM
#  --  support for Gurmukhi/Punjabi, as in itrans 5.2
#  --  use struts for fine-tuning of images, avoids cropping problems
#  --  add some TeX macros to images.tex
#  --  recognise but ignore \obeylines  and  \obeyspaces
#  --  Avinash Chopde has a new Web address
#
# Revision 1.1  1998/04/29 09:12:09  latex2html
# 	support for the ITRANS pre-processor, by Avinash Chopde
#
#      note that ITRANS itself is not supplied;
#      this must be obtained and installed separately.
#
#      various changes were required in the latex2html script
#      to meet the special requirements of ITRANS
#
# Revision 1.1  1998/04/08 04:33:20  RRM
# 	LaTeX2HTML interfaces to packages and pre-processors for including
# 	traditional Indic scripts (as images) in HTML documents
#
# 	see the .perl files for documentation on usage
# 	see the corresponding .sty file for the LaTeX-2e interface
#
#

package main;

###  configuration variables  ###
# these may be set in .latex2html-init files

#..however this *must* be set in the environment:
$ITRANSPATH = $ENV{'ITRANSPATH'} = join(':'
	, '/usr/local/share/itrans/itrans-5.1/lib'
	, '/usr/local/share/itrans/itrans-5.1/lib/fonts'
	, '/usr/local/share/texmf/fonts/tfm/itrans'
	) unless $ENV{'ITRANSPATH'};

# command-name for the ITRANS pre-processor
$ITRANS = 'itrans -v ' unless $ITRANS;


# input mode
$ITRANS_MODE = 'TeX' unless ($ITRANS_MODE);

# input mode
$ITRANS_OUTMODE = 'TeX' unless ($ITRANS_OUTMODE);

# pre-processor directives for header
$itrans_default = "\#output=TeX\n" unless ($itrans_default);

# max characters in an inline string
$itrans_inline = 200 unless ($itrans_inline);
$itrans_csx = 100 unless ($itrans_csx);
$itrans_latex = 300 unless ($itrans_latex);

# matches languages supported by ITRANS
@itrans_languages = (
		  'indian'
		, 'bengali'
		, 'devanagari'
		, 'gujarati'
		, 'gurmukhi'
		, 'hindi'
		, 'kannada'
		, 'marathi'
		, 'oriya'
		, 'roman'
		, 'sanskrit'
		, 'tamil'
		, 'telugu'
		);
$itrans_languages_rx = "\#(".join('|',@itrans_languages).")\\b";
$itrans_ifm_rx  = "\#(".join('|',@itrans_languages).")ifm\\s*\=(.*)\.ifm\\s*\\n";
$itrans_font_rx = "\#(".join('|',@itrans_languages).")font\\s*\=\\s*\\(.*)\\s*\\n";
$itrans_output_rx = "\#output\\s*\=\\s*(TeX|HTML_7|HTML_8|PostScript)\\s*\\n";
$itrans_endfont_rx = "\#endfont\\s*\=\\s*(\.*)\\s*\\n";

# matches directives to revert to normal (La)TeX
$itrans_normal_rx = "\#end${itrans_languages_rx}\\b" unless ($itrans_normal_rx);


# list of recognised pre-processor directives
# (other than language switches)
$itrans_commands_rx = '(usecsx|nousecsx|useshortmarkers)'
	unless ($itrans_commands_rx);



# preprocessor: ITRANS
sub do_itrans_preprocess { &alias_itrans('','') }
sub do_itrans_itrans { &alias_itrans('','') }

# input modes
sub do_itrans_7bit { &alias_itrans('SEVENBIT','') }
sub do_itrans_8bit { &alias_itrans('SEVENBIT','') }
sub do_itrans_csx   { $ITRANS_MODE = 'CSX'; }
sub do_itrans_html7 { $ITRANS_OUTMODE = 'HTML_7'; }
sub do_itrans_html8 { $ITRANS_OUTMODE = 'HTML_8'; }

# language short aliases
sub do_itrans_bengali { &alias_itrans('BENGALI','B') }
sub do_itrans_devanagari { &alias_itrans('DEVANAGARI','D') }
sub do_itrans_gujarati { &alias_itrans('GUJARATI','G') }
sub do_itrans_gurmukhi { &alias_itrans('GURMUKHI','G') }
sub do_itrans_hindi { &alias_itrans('HINDI','H') }
sub do_itrans_indian { &alias_itrans('INDIAN','I') }
sub do_itrans_kannada { &alias_itrans('KANNADA','K') }
sub do_itrans_marathi { &alias_itrans('MARATHI','M') }
sub do_itrans_oriya { &alias_itrans('ORIYA','O') }
sub do_itrans_punjabi { &alias_itrans('GURMUKHI','P') }
sub do_itrans_roman { &alias_itrans('ROMAN','R') }
sub do_itrans_sanskrit { &alias_itrans('SANSKRIT','S') }
sub do_itrans_tamil { &alias_itrans('TAMIL','T') }
sub do_itrans_telugu { &alias_itrans('TELUGU','T') }

# language medium aliases
sub do_itrans_ben { &alias_itrans('BENGALI','BEN') }
sub do_itrans_dev { &alias_itrans('DEVANAGARI','DEV') }
sub do_itrans_guj { &alias_itrans('GUJARATI','GUJ') }
sub do_itrans_gur { &alias_itrans('GURMUKHI','GUR') }
sub do_itrans_hin { &alias_itrans('HINDI','HIN') }
sub do_itrans_ind { &alias_itrans('INDIAN','IND') }
sub do_itrans_kan { &alias_itrans('KANNADA','KAN') }
sub do_itrans_mar { &alias_itrans('MARATHI','MAR') }
sub do_itrans_ori { &alias_itrans('ORIYA','ORI') }
sub do_itrans_pun { &alias_itrans('GURMUKHI','PUN') }
sub do_itrans_rom { &alias_itrans('ROMAN','ROM') }
sub do_itrans_san { &alias_itrans('SANSKRIT','SAN') }
sub do_itrans_tam { &alias_itrans('TAMIL','TAM') }
sub do_itrans_tel { &alias_itrans('TELUGU','TEL') }



sub alias_itrans {
    local($mode,$alias) = @_;
    $prelatex .= "$itrans_default\n" unless $itrans_loaded;
    if ($alias) { 
    } elsif ($mode && $mode =~ /^$itrans_commands_rx$/) {
	$prelatex .= "\#$mode\n";
	$ITRANS_MODE = $mode;
# may need to adjust the  $itrans_inline  here
    }
    &pre_process_itrans($alias);
}

sub pre_process_itrans {
    local($pattern) = @_;
    $preprocessor_cmds .= 
	"$ITRANS -i ${PREFIX}images.pre -o ${PREFIX}images.tex\n"
	    unless $itrans_loaded;
    &itrans_environments() unless $itrans_loaded;

    %other_environments = ( %other_environments
		, "\#$pattern:\#end$pattern", 'itrans'
	) if ($pattern);

    $itrans_loaded = 1;
    $PREPROCESS_IMAGES = 1;
}

sub itrans_environments {
    %other_environments = ( %other_environments
		, "\#bengali:\#endbengali", 'itrans'
		, "\#devanagari:\#enddevanagari", 'itrans'
		, "\#gujarati:\#endgujarati", 'itrans'
		, "\#gurmukhi:\#endgurmukhi", 'itrans'
		, "\#hindi:\#endhindi", 'itrans'
		, "\#indian:\#endindian", 'itrans'
		, "\#kannada:\#endkannada", 'itrans'
		, "\#marathi:\#endmarathi", 'itrans'
		, "\#oriya:\#endoriya", 'itrans'
		, "\#roman:\#endroman", 'itrans'
		, "\#sanskrit:\#endsanskrit", 'itrans'
		, "\#tamil:\#endtamil", 'itrans'
		, "\#telugu:\#endtelugu", 'itrans'
		, "\#\#:\#\#", 'itrans'
		, "\#bengaliifm:\n", 'nowrap'
		, "\#bengalifont:\n", 'nowrap'
		, "\#devanagariifm:\n", 'nowrap'
		, "\#devanagarifont:\n", 'nowrap'
		, "\#gujaratiifm:\n", 'nowrap'
		, "\#gujaratifont:\n", 'nowrap'
		, "\#gurmukhifm:\n", 'nowrap'
		, "\#gurmukhifont:\n", 'nowrap'
		, "\#hindiifm:\n", 'nowrap'
		, "\#hindifont:\n", 'nowrap'
		, "\#indianifm:\n", 'nowrap'
		, "\#indianfont:\n", 'nowrap'
		, "\#kannadaifm:\n", 'nowrap'
		, "\#kannadafont:\n", 'nowrap'
		, "\#marathiifm:\n", 'nowrap'
		, "\#marathifont:\n", 'nowrap'
		, "\#oriyaifm:\n", 'nowrap'
		, "\#oriyafont:\n", 'nowrap'
		, "\#romanifm:\n", 'nowrap'
		, "\#romanfont:\n", 'nowrap'
		, "\#sanskritifm:\n", 'nowrap'
		, "\#sanskritfont:\n", 'nowrap'
		, "\#tamilifm:\n", 'nowrap'
		, "\#tamilfont:\n", 'nowrap'
		, "\#teluguifm:\n", 'nowrap'
		, "\#telugufont:\n", 'nowrap'
		, "\#endwordvowel:\n", 'nowrap'
		, "\#input:\n", 'nowrap'
		, "\#useshortmarkers:", 'nowrap'
		, "\#ignoreshortmarkers:", 'nowrap'
		, "\#usecsx:", 'nowrap'
		, "\#ignorecsx:", 'nowrap'
		, "\#endfont:", 'nowrap'
    );
}

%ISO_indic = (
	  'gujarati'	, 'gu'
	, 'gurmukhi'	, 'pu'
	, 'punjabi'	, 'pu'
	, 'hindi'	, 'hi'
	, 'kannada'	, 'kn'
	, 'marathi'	, 'mr'
	, 'oriya'	, 'or'
	, 'roman'	, 'sa'
	, 'sanskrit'	, 'sa'
	, 'tamil'	, 'ta'
	, 'telugu'	, 'te'
	, %ISO_indic
);

# interface for inclusion of fonts...
# ...either using <FONT FACE=...> or by style-sheet

$itrans_html_rx = "(bengali|gujarati|sanskrit|roman)";
$itrans_html_ifm_rx = "(itxbeng|itxguj|xdvng|romancsx)";

sub itrans_html {
    local($indic,$itext) = @_;
    local($ifont) = $itrans_info{$indic.'ifm'};
    $ifont =~ s/\.ifm\s*$//;

    local($_) = join("\n", "\#output=$ITRANS_OUTMODE"
		, "\#${indic}ifm=".$itrans_info{$indic.'ifm'}
		, "\#$indic", $itext , "\#end$indic\n" );
    open(ITRANS, ">itrans.itx");
    binmode ITRANS;;
    print ITRANS "$_";
    close(ITRANS);
    &syswait("$ITRANS <itrans.itx >itrans.htm");
    open(ITRANS, "<itrans.htm"); binmode ITRANS; $itext = '';
    while (<ITRANS>) {
	next if (/^(\%|$)/);
	$itext .= $_ 
    }
    close(ITRANS);
    $itext =~ s/\\\\/<BR>/g;
    if ($USING_STYLES) {
	$env_style{'SPAN.'.$ifont} = "font-family: $ifont"
	   unless ($env_style{'SPAN.'.$ifont});
    }
    join( "\n"
	, ($USING_STYLES ? "<SPAN CLASS=\"$ifont\">"
	    : "<FONT FACE=\"$ifont\">" )
	, $itext
	, ($USING_STYLES ? "</SPAN>" : "</FONT>" )
	);
}


# processing environments, by paragraphs

sub do_env_pre_itrans {
    local($_) = @_;
    local($inline_length) = $itrans_inline;
    local($indic) = &get_next_optional_argument;
    local($itext,$indic_info) = ('',$itrans_info{$indic.'ifm'});

    if ($ITRANS_MODE =~ /CSX/ ) { $inline_length = $itrans_csx; }
    else { $inline_length = $itrans_inline; }

    local($strut);
    local($par_start, $par_end, $ilang) = ('<P', "</P>\n", '');
    if ($USING_STYLES) {
	$ilang = join('', ' LANG="', $ISO_indic{$indic}, '"');
    }
    if (/\\par/) {
	local(@paragraphs, @indic_processed, $this_par);
	local($par_alt_start, $par_alt_end) = ($par_start, '');
	if ($USING_STYLES) {
	    $indic =~ s/^([A-Z]{3})\w*$/$1/;
	    $env_style{'P.'.$indic} = " " unless ($env_style{'P.'.$indic});
	    $env_style{'SPAN.'.$indic} = " " unless ($env_style{'SPAN.'.$indic});
	    $par_start .=  $ilang." CLASS=\"$indic\">";
	    $par_alt_start =  "<SPAN$ilang CLASS=\"$indic\">";
	    $par_alt_end =  "</SPAN>";
	} else {
	    $par_start .= '>';
	    $par_alt_start .= '>';
	}

	@paragraphs = (split(/$par_rx/, $_));
	local($saved_par);
	while (@paragraphs) {
	    $this_par = shift @paragraphs;
	    foreach (1..6) { shift @paragraphs; }
	    next unless ($this_par);
	    $strut = '';
	    if (($ITRANS_OUTMODE =~ /HTML/)&&($indic =~ /$itrans_html_rx/)
		&&($indic_info =~ /$itrans_html_ifm_rx/)) {
		local($PREAMBLE) = 1;
		$this_par = &revert_to_raw_tex($this_par);
		$_ = &itrans_html($indic,$this_par);
	    } else {
		if ($this_par =~ /^\\/) {
		    #catch 'paragraphs' that are just TeX macros
		    local($savedRS) = $/; $/ = '';
		    if ($this_par =~ /^(\s*\\\w+)+$/sm ) {
			# save them for the next paragraph
			$saved_par .= $this_par."\n\n";
			$/ = $savedRS; next;
		    }
		    $/ = $savedRS;
		}
		if ($saved_par) {
		    #include any saved macros
		    $this_par = $saved_par . $this_par; 
		    $saved_par = '';
		}

		if (($indic =~ /^($gur_font_rx)/i)
			||($indic_info =~/$gur_font_rx/i)) {
		    $this_par = &tuneup_gurmukhi($this_par);
		} elsif ($indic_info =~ /dvng/) {		
		    $this_par = &tuneup_devnag($this_par);
		} elsif (($indic =~ /^($dvnc_font_rx)/i)
			||($indic_info =~/$dvnc_font_rx/i)) {
		    $this_par = &tuneup_devnac($this_par);
		}

		next if ($this_par =~ /^\s*$/s);
	    }
	    if (($#paragraphs >= 0)||($this_par =~ /\\\\|\n+$/)
		    ||(length($this_par) > $inline_length )) {
		$this_par =~ s/^\s*|\s*$//sg;
		if (($HTML_VERSION >= 4)&&(defined &process_object_in_latex)) {
		    $_ = &process_object_in_latex(
			"\\vbox{\#$indic$strut\n", $this_par, "\n\#end$indic}"
			);
		    push(@indic_processed, $par_start , $_ , $par_end);
		} else {
		    $_ = &process_in_latex(
			"\\vbox{\#$indic$strut\n$this_par\n\#end$indic}");
		    push(@indic_processed
			, &make_comment( 'ITRANS: '.$indic, $this_par)
			, $par_start , $_ , $par_end);
		}
	    } else {
		$this_par =~ s/^\s*|\s*$//g;
		if (($HTML_VERSION >= 4)&&(defined &process_object_in_latex)) {
		    $_ = &process_object_in_latex(
			"\#$indic ", $this_par, "$strut\#end$indic\n"
			);
		    push(@indic_processed, $par_alt_start , $_ , $par_alt_end);
		} else {
		    $_ = &process_undefined_environment(
			'tex2html_ind_inline'
			, ++$global{'max_id'}
			, "\#$indic $this_par$strut\#end$indic\n");
		    push(@indic_processed
			, &make_comment( 'ITRANS: '.$indic, $this_par)
			, $par_alt_start , $_ , $par_alt_end);
		}
	    }
	}
	join('', @indic_processed );

    } elsif (($ITRANS_OUTMODE =~ /HTML/)&&($indic =~ /$itrans_html_rx/)
	 &&($indic_info =~ /$itrans_html_ifm_rx/))  {
	local($PREAMBLE) = 1; # as if processing the preamble
	local($itext) = &revert_to_raw_tex($_);
	$itext =~ s/^\s*|\s*$//g;
	join ('' , &make_comment('ITRANS: '.$indic, $itext)
		, &itrans_html($indic,$itext) );
    } else  {
	local($comment);

	if (($indic =~ /^($gur_font_rx)/i)
		||($indic_info =~/$gur_font_rx/i)) {
	    $_ = &tuneup_gurmukhi($_);
	} elsif ($indic_info =~ /dvng/) {
	    $_ = &tuneup_devnag($_);
	} elsif (($indic =~ /^($dvnc_font_rx)/i)
		||($indic_info =~/$dvnc_font_rx/i)) {
	    $_ = &tuneup_devnac($_);
	}

	if (length($_) < $inline_length ) {
	    # preserve empty {}s 
	    s/(($O|$OP)\d+($C|$CP))\1/\{\}/g;
	    if (($HTML_VERSION >= 4)&&(defined &process_object_in_latex)) {
		$_ = &process_object_in_latex(
		    "\#$indic ", $_ , "$strut\#end$indic}"
		    ) unless ($_ =~ /^\s*$/s);
	    } else {
		$_ = &process_undefined_environment('tex2html_ind_inline'
		    , ++$global{'max_id'}, "\#$indic $_$strut\#end$indic\n")
		    unless ($_ =~ /^\s*$/s);
	    }
	} elsif (($HTML_VERSION >= 4)&&(defined &process_object_in_latex)) { 
	    $_ =~ s/^\s*|\s*$//g;
	    $_ = &process_object_in_latex(
		"\\vbox{\#$indic$strut\n" , $_, "\n\#end$indic}"
		) unless ($_ =~ /^\s*$/s);
	} else { 
	    $_ =~ s/^\s*|\s*$//g;
	    $comment = join('', &make_comment( 'ITRANS: '.$indic, $_),"\n");
	    $_ = &process_in_latex("\\vbox{\#$indic$strut\n$_\n\#end$indic}")
		unless ($_ =~ /^\s*$/s);
	}
	if ($USING_STYLES) {
	    $indic =~ s/^([A-Z]{3})\w*$/$1/;
	    $env_style{$indic} = " " unless ($env_style{$indic});
	    join('', $comment, "<SPAN$ilang CLASS=\"$indic\">", $_, '</SPAN>');
	} else { $comment . $_ }
    }
}

$beng_font_rx = 'BEN';
$devnag_font_rx = 'DEV';
$dvnc_font_rx = 'HIN|MAR|SAN';
$guj_font_rx = 'GUJ';
$gur_font_rx = 'GUR|PUN';
$kan_font_rx = 'KAN';
$tel_font_rx = 'TEL';
$tamil_font_rx = 'TAM';
$utopia_font_rx = 'ROM';

sub tuneup_gurmukhi {
    local($_) = @_;
    #catch characters that draw outside their boxes
    s/^\s*((nn|mm)a)/\\ $1/;
    s/(r(a|u))$/$1\\,/;
    s|(\\)?(\w+)$|$1?$1.$2:$2."\\/"|e;
    $_;
}

sub tuneup_dvnc {
    local($_) = @_;
    #catch characters that draw outside their boxes
#    s/^\s*((nn|mm)a)/\\ $1/;
    s/(hu|u|ii|aas?|ar|th|tr|ai?|e|\.\w|M|m)$/$1\\,/;
    s|(\\)?(\w+)$|$1?$1.$2:$2."\\/"|e;
    $_;
}

sub tuneup_devnac {
    local($_) = @_;
    $strut = '\istrut' if (/a\.|ii|[MI]/);
    &tuneup_dvnc($_);
}

sub tuneup_devnag {
    local($_) = @_;
    #catch characters that draw outside their boxes
    s/(\^i|^\s*[io]$)$/$1\\,/;
    s/^\s*(\.([\Wr]|$))/\\ $1/;
    s/^\s*(d(e|vr))/\\,$1/;
#    $strut_needed = (/a\.|ii|[MI]/ ? 1 : '');
    $strut = '\dvgstrut' if (/a\.|ii|[MI]/);
    &tuneup_dvnc($_);
}

sub do_cmd_usecsx { $ITRANS_MODE = 'CSX'; @_[0]}
sub do_cmd_nousecsx { $ITRANS_MODE = ''; @_[0]}


# for source already pre-processed

# make images of unusual (not ISO-Latin1) accents
$ACCENT_IMAGES = 'textrm' unless $ACCENT_IMAGES;

$ENGLFONT = 'bfseries' unless $ENGLEFONT;
$DVN_SIZE = '';
$image_switch_rx .= "|(frans|post|use|normal|large|Large|LARGE|huge|Huge)dvng|devn(font|mode)|englfont";

sub do_cmd_devnfont { &do_cmd_normaldevn(@_) }
sub do_cmd_devnmode { &do_cmd_devnfont(@_) }
sub do_cmd_franstrue { $ENGLFONT = 'rmfamily'; }
sub do_cmd_fransfalse { $ENGLFONT = 'bfseries'; }

sub do_cmd_fransdvng { 
    local($ENGLFONT) = 'rmfamily';
    &process_itrans_output('fransdvng',$font_size{'fransdvng'},$itrans_inline, @_[0]) }
sub do_cmd_postdvng {
    local($ENGLFONT) = 'bfseries';
    &process_itrans_output('postdvng',$font_size{'postdvng'},$itrans_inline, @_[0]) }
sub do_cmd_usedvng {
    &process_itrans_output('usedvng',$font_size{'usedvng'},$itrans_inline, @_[0]) }
sub do_cmd_normaldvng {
    local($ENGLEFONT) = $ENGLEFONT; $ENGLFONT .= "\\normalsize";
    &process_itrans_output('normaldvng',$font_size{'normaldvng'},$itrans_inline, @_[0]) }
sub do_cmd_largedvng {
    local($ENGLEFONT) = $ENGLEFONT; $ENGLFONT .= "\\large";
    &process_itrans_output('largedvng',$font_size{'largedvng'},$itrans_inline, @_[0]) }
sub do_cmd_Largedvng {
    local($ENGLEFONT) = $ENGLEFONT; $ENGLFONT .= "\\Large";
    &process_itrans_output('Largedvng',$font_size{'Largedvng'},$itrans_inline, @_[0]) }
sub do_cmd_LARGEdvng {
    local($ENGLEFONT) = $ENGLEFONT; $ENGLFONT .= "\\LARGE";
    &process_itrans_output('LARGEdvng',$font_size{'LARGEdvng'},$itrans_inline, @_[0]) }
sub do_cmd_hugedvng {
    local($ENGLEFONT) = $ENGLEFONT; $ENGLFONT .= "\\huge";
    &process_itrans_output('hugedvng',$font_size{'hugedvng'},$itrans_inline, @_[0]) }
sub do_cmd_Hugedvng {
    local($ENGLEFONT) = $ENGLEFONT; $ENGLFONT .= "\\Huge";
    &process_itrans_output('Hugedvng',$font_size{'Hugedvng'},$itrans_inline, @_[0]) }

$font_size{'normaldvng'} = "10pt";
$font_size{'largedvng'} = " scaled \\magstephalf ";
$font_size{'Largedvng'} = " scaled \\magstep1 ";
$font_size{'LARGEdvng'} = " scaled \\magstep2 ";
$font_size{'hugedvng'} = " scaled \\magstep3 ";
$font_size{'Hugedvng'} = " scaled \\magstep4 ";


sub process_itrans_output {
    local($dvnfont, $dvn_size, $brlength, $dvntxt) = @_;
    $brlength = $itrans_inline unless $brlength;

    # size defaults to $LATEX_FONT_SIZE
    # it can be set separately for each font-call, if desired
    # via:  $font_size{'...'} = <size>
    $dvntxt = "\{\\$dvnfont$dvntxt\}\%".($dvn_size ? $dvn_size : $LATEX_FONT_SIZE)."\%";

    if (length($dvntxt) < $brlength ) {
	$global{'max_id'}++;
	$dvntxt = &process_undefined_environment('tex2html_dvn_inline'
	    ,$global{'max_id'}, $dvntxt);
    } else { $dvntxt = &process_in_latex($dvntxt) }

    if ($USING_STYLES) {
	$env_style{'INDIC'} = " " unless ($env_style{'INDIC'});
	join('','<SPAN CLASS="INDIC">', $dvntxt, '</SPAN>');
    } else { $dvntxt }
}


sub do_cmd_englfont {
    local($_) = @_[0];
    foreach $cmd (split(/\\/,$ENGLFONT)) {
	$tmp = "do_cmd_$cmd";
	if (defined &$tmp) { eval("\$_ = &$tmp(\$_)") }
	else { 
	    $_ = &declared_env($cmd,$_);
	}
    }
    $_;
}

# \itrans_info is inserted artificially to read the
# directives of the form:  #hindiifm=....  #hindifont=...
sub do_cmd_ITRANSinfo {
    local($_) = @_;
    local($ilang,$iinfo);
    $ilang = &missing_braces unless (
	(s/$next_pair_pr_rx/$ilang=$2;''/e)
	||(s/$next_pair_rx/$ilang=$2;''/e));
    $iinfo = &missing_braces unless (
	(s/$next_pair_pr_rx/$iinfo=$2;''/e)
	||(s/$next_pair_rx/$iinfo=$2;''/e));

    $itrans_info{$ilang} = $iinfo;
    $latex .= "\n\#$ilang=$iinfo\n";
    '';
}

#$itrans_tex_mod = 
#    "\n \\def\\sBs#1#2{{\\setbox\\zErOdEpTh=\\hbox{%"
#    ."\n  \\raise#1em\\hbox{#2}}\\dp\\zErOdEpTh=0pt\\box\\zErOdEpTh}}"
$itrans_tex_mod = 
    "\n \\def\\dvgstrut{\\vrule height6ex width0pt}\n"
    ."\n \\def\\istrut{\\vrule height1.1ex width0pt}\n";


# TeX commands from  idevn.tex  and  itrnstlg.tex

&ignore_commands (<<_IGNORED_CMDS_);
portraitpage
landscapepage
obeyspaceslines
obeyspaces
obeylines
_IGNORED_CMDS_

&process_commands_wrap_deferred (<<_DEFERRED_CMDS_);
specialsforfrans
_DEFERRED_CMDS_

&process_commands_in_tex (<<_RAW_ARG_CMDS_);
sBs # {} # {}
_RAW_ARG_CMDS_



1;				# Not really necessary...



