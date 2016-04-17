# $Id: indica.perl,v 1.4 1999/03/13 00:26:54 RRM Exp $
# INDICA.PERL by Ross Moore <ross@mpce.mq.edu.au> 14-1-98
# Mathematics Department, Macquarie University, Sydney, Australia.
#
# Style for LaTeX2HTML v98.1 to construct images of traditional
#  Indic scripts, using:
#
#  Indica pre-processor and sinhala fonts:  sinha, sinhb, sinhc
#    by Yannis Haralambous <Yannis.Haralambous@univ-lille1.fr>
#
#  sinhala.sty  package for LaTeX-2e
#    by Dominik Wujastyk <D.Wujastyk@ucl.ac.uk>
#
#  extended for Prasad Dharmasena's <pkd@isr.umd.edu>
#  `samanala'  transliteration scheme
#    by Vasantha Saparamadu <vsaparam@ocs.mq.edu.au>
#
# These resources are *not* included with this package.
# Obtain them from CTAN:  http//ctan.tug.org/ctan
#
# ===================================================================
# This package requires the corresponding LaTeX package:  indica.sty .
#
# With LaTeX2HTML the options on the \usepackage line specify which
# preprocessor and transcription mode to use.
#
# Usage:
#
#  \usepackage{indica}            %|  for text already pre-processed
#  \usepackage[indica]{indica}    %|  for all supported languages
#  \usepackage[preprocess]{indica}%|  same as  [indica]
#
#  options affecting Input-forms
#
#  \usepackage[7bit]{indica}    %|  Velthuis' Hindi/Sanskri transcription
#  \usepackage[csx]{indica}     %|  8-bit Sanskrit extension of ISO 646
#  \usepackage[latex]{indica}   %|  standardized LaTeX transcription form
#  \usepackage[unicode]{indica} %|  ISO 10646-1 + Sinhalese extension
#  \usepackage[samanala]{indica}%|  Prasad Dharmasena's transliteration
#
#  options specifyinging languages:
#
#  \usepackage[ben]{indica} %|  Bengali
#  \usepackage[guj]{indica} %|  Gujarati
#  \usepackage[gur]{indica} %|  Gurmukhi
#  \usepackage[hin]{indica} %|  Hindi
#  \usepackage[kan]{indica} %|  Kannada
#  \usepackage[mal]{indica} %|  Malayalam
#  \usepackage[ori]{indica} %|  Oriya
#  \usepackage[san]{indica} %|  Sanskrit
#  \usepackage[sin]{indica} %|  Sinhala, Sinhalese
#  \usepackage[tam]{indica} %|  Tamil
#  \usepackage[tel]{indica} %|  Telugu
#  \usepackage[tib]{indica} %|  Tibetan
#
#  LaTeX2HTML: create aliases to 3-letter abbreviations;
#  e.g.   #ALIAS SANSKRIT SAN
#
#
#  \usepackage[bengali]{indica}   %|  Bengali
#  \usepackage[gujarati]{indica}  %|  Gujarati
#  \usepackage[gurmukhi]{indica}  %|  Gurmukhi
#  \usepackage[hindi]{indica}     %|  Hindi
#  \usepackage[kannada]{indica}   %|  Kannada
#  \usepackage[malayalam]{indica} %|  Malayalam
#  \usepackage[oriya]{indica}     %|  Oriya
#  \usepackage[sanskrit]{indica}  %|  Sanskrit
#  \usepackage[sinhala]{indica}   %|  Sinhala, Sinhalese
#  \usepackage[sinhalese]{indica} %|  Sinhala, Sinhalese
#  \usepackage[tamil]{indica}     %|  Tamil
#  \usepackage[telugu]{indica}    %|  Telugu
#  \usepackage[tibetan]{indica}   %|  Tibetan
#
#  LaTeX2HTML: create aliases to 1-letter abbreviations;
#  e.g.   #ALIAS SANSKRIT S
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
# $Log: indica.perl,v $
# Revision 1.4  1999/03/13 00:26:54  RRM
#  --  implement <SPAN> and <DIV> tags for HTML4.0
#  --  include LANG=  attribute with HTM4.0
#  --  use \vbox with paragraphs
#
# Revision 1.3  1998/08/18 12:59:56  RRM
#  --  allow for extra space after particular characters
#  --  include the \diatop macro within images.tex in a better way
#
# Revision 1.2  1998/02/03 05:28:47  RRM
#  --  changed file-names: gujrathi --> gujarati
#
# Revision 1.1  1998/01/22 04:33:20  RRM
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

# command-name for the Indica pre-processor
#$INDICA = 'Indica' unless $INDICA;
$INDICA = 'indica' unless $INDICA;

# mode
$INDICA_MODE = 'sevenbit' unless ($INDICA_MODE);

# pre-processor directives for header
$indica_default = "\#SEVENBIT\n\#ALIAS NIL N\n" unless ($indica_default);

# max characters in an inline string
$indica_inline = 200 unless ($indica_inline);
$indica_csx = 100 unless ($indica_inline);
$indica_latex = 300 unless ($indica_latex);
$indica_unicode = 800 unless ($indica_unicode);

# matches directives to revert to normal (La)TeX
$indica_normal_rx = '\#(N(IL)?)' unless ($indica_normal_rx);


# list of recognised pre-processor directives
# (other than language switches)
$indica_commands_rx = '(SEVENBIT|CSX|LATEX|UNICODE|SAMANALA|ALIAS)'
	unless ($indica_commands_rx);



# preprocessor: indica
sub do_indica_preprocess { &alias_indica('','') }
sub do_indica_indica { &alias_indica('','') }

# input modes
sub do_indica_7bit { &alias_indica('SEVENBIT','') }
sub do_indica_csx { &alias_indica('CSX','') }
sub do_indica_latex { &alias_indica('LATEX','') }
sub do_indica_unicode { &alias_indica('UNICODE','') }
sub do_indica_samanala { &alias_indica('SAMANALA','') }

# language short aliases
sub do_indica_bengali { &alias_indica('BENGALI','B') }
sub do_indica_gujarati { &alias_indica('GUJARATI','G') }
sub do_indica_gurmukhi { &alias_indica('GURMUKHI','G') }
sub do_indica_hindi { &alias_indica('HINDI','H') }
sub do_indica_kannada { &alias_indica('KANNADA','K') }
sub do_indica_malayalam { &alias_indica('MALAYALAM','M') }
sub do_indica_oriya { &alias_indica('ORIYA','O') }
sub do_indica_sanskrit { &alias_indica('SANSKRIT','S') }
sub do_indica_sinhala { &alias_indica('SINHALA','S') }
sub do_indica_sinhalese { &alias_indica('SINHALESE','S') }
sub do_indica_tamil { &alias_indica('TAMIL','T') }
sub do_indica_telugu { &alias_indica('TELUGU','T') }
sub do_indica_tibetan { &alias_indica('TIBETAN','T') }

# language medium aliases
sub do_indica_ben { &alias_indica('BENGALI','BEN') }
sub do_indica_guj { &alias_indica('GUJARATI','GUJ') }
sub do_indica_gur { &alias_indica('GURMUKHI','GUR') }
sub do_indica_hin { &alias_indica('HINDI','HIN') }
sub do_indica_kan { &alias_indica('KANNADA','KAN') }
sub do_indica_mal { &alias_indica('MALAYALAM','MAL') }
sub do_indica_ori { &alias_indica('ORIYA','ORI') }
sub do_indica_san { &alias_indica('SANSKRIT','SAN') }
sub do_indica_sin { &alias_indica('SINHALA','SIN') }
sub do_indica_tam { &alias_indica('TAMIL','TAM') }
sub do_indica_tel { &alias_indica('TELUGU','TEL') }
sub do_indica_tib { &alias_indica('TIBETAN','TIB') }



sub alias_indica {
    local($mode,$alias) = @_;
    $prelatex .= $indica_default unless $indica_loaded;
    if ($alias) { 
	$prelatex .= join(' ','#ALIAS', $mode, "$alias\n")
    } elsif ($mode && $mode =~ /^$indica_commands_rx$/) {
	$prelatex .= "\#$mode\n";
	$INDICA_MODE = $mode unless ($mode =~ /SAMANALA/);
	if ($mode =~ /UNICODE/ )  { $indica_inline = 500; }
	elsif ($mode =~ /LATEX/ ) { $indica_inline = 300; }
    }
    &pre_process_indica($alias);
}

sub pre_process_indica {
    local($pattern) = @_;
    $preprocessor_cmds .= 
	"$INDICA <${PREFIX}images.pre >${PREFIX}images.tex\n"
	    unless $indica_loaded;
    &indica_environments() unless $indica_loaded;

    %other_environments = ( %other_environments
		, "\#$pattern:\#", 'indica[]'
	) if ($pattern);
    $indica_loaded = 1;
    $PREPROCESS_IMAGES = 1;
}

sub indica_environments {
    %other_environments = ( %other_environments
		, "\#BENGALI:\#", 'indica[]'
		, "\#GUJARATHI:\#", 'indica[]'
		, "\#GURMUKHI:\#", 'indica[]'
		, "\#HINDI:\#", 'indica[]'
		, "\#KANNADA:\#", 'indica[]'
		, "\#MALAYALAM:\#", 'indica[]'
		, "\#ORIYA:\#", 'indica[]'
		, "\#SANSKRIT:\#", 'indica[]'
		, "\#SINHALA:\#", 'indica[]'
		, "\#SINHALESE:\#", 'indica[]'
		, "\#TAMIL:\#", 'indica[]'
		, "\#TELUGU:\#", 'indica[]'
		, "\#TIBETAN:\#", 'indica[]'
		, "\#SEVENBIT:", 'nowrap'
		, "\#CSX:", 'nowrap'
		, "\#LATEX:", 'nowrap'
		, "\#UNICODE:", 'nowrap'
		, "\#SAMANALA:", 'nowrap'
		, "\#ALIAS:", 'nowrap'
    );
}

%ISO_indic = (
	  'BENGALI'	, 'bn'
	, 'GUJARATHI'	, 'gu'
	, 'GURMUKHI'	, 'pa'
	, 'HINDI'	, 'hi'
	, 'KANNADA'	, 'kn'
	, 'MALAYALAM'	, 'ml'
	, 'ORIYA'	, 'or'
	, 'SANSKRIT'	, 'sa'
	, 'SINHALA'	, 'si'
	, 'SINHALESE'	, 'si'
	, 'TAMIL'	, 'ta'
	, 'TELUGU'	, 'te'
	, 'TIBETAN'	, 'bo'
);

sub do_env_pre_indica {
    local($_) = @_;
    local($inline_length) = $indica_inline;
    local($indic) = &get_next_optional_argument;

    if ($INDICA_MODE =~ /UNICODE/ )  { $inline_length = $indica_unicode; }
    elsif ($INDICA_MODE =~ /CSX/ ) { $inline_length = $indica_csx; }
    elsif ($INDICA_MODE =~ /LATEX/ ) { $inline_length = $indica_latex; }
    else { $inline_length = $indica_inline; }

    local($par_start, $par_end, $ilang) = ('<P', "</P>\n", '');
    $ilang = join('', ' LANG="', $ISO_indic{$indic}, '"');
    if (/\\par/) {
	local(@paragraphs, @indic_processed, $this_par);
	if ($USING_STYLES) {
	    $indic =~ s/^([A-Z]{3})\w*$/$1/;
	    $env_style{$indic} = " " unless ($env_style{$indic});
	    $par_start .=  "$ilang CLASS=\"$indic\">";
	} else { $par_start .= '>' }

	@paragraphs = (split(/$par_rx/, $_));
	while (@paragraphs) {
	    $this_par = shift @paragraphs;
	    foreach (1..6) { shift @paragraphs; }
	    next unless ($this_par);
	    $this_par =~ s/\s$//;
	    if (($HTML_VERSION >= 4)&&(defined &process_object_in_latex)) {
		$_ = &process_object_in_latex(
			"\#$indic\n" , $this_par , "\n\#NIL\n" );
		push(@indic_processed , $par_start , $_ , $par_end);
	    } else {
		$_ = &process_in_latex("\\vbox{\#$indic\n$this_par\n\#NIL }\n");
		push(@indic_processed
		    , &make_comment( 'INDICA '.$indic, $this_par)
		    , $par_start , $_ , $par_end);
	    }
	}
	join('', @indic_processed );
    } else  {
	local($comment);
	if (length($_) < $inline_length ) {
	    if (($HTML_VERSION >= 4)&&(defined &process_object_in_latex)) {
		$_ = &process_object_in_latex("\#$indic ", $_ , "\#NIL\n");
	    } else {
		$_ = &process_undefined_environment('tex2html_ind_inline'
		    , ++$global{'max_id'}, "\#$indic$_\#NIL\n");
	    }
	} elsif (($HTML_VERSION >= 4)&&(defined &process_object_in_latex)) {
	    $_ = &process_object_in_latex("\#$indic\n", $_ , "\n\#NIL\n");
	} else { 
	    $comment = join('', &make_comment( 'INDICA '.$indic, $_),"\n");
	    $_ = &process_in_latex("\#$indic\n$_\n\#NIL\n")
	}
	if ($USING_STYLES) {
	    $indic =~ s/^([A-Z]{3})\w*$/$1/;
	    $env_style{$indic} = " " unless ($env_style{$indic});
	    join('', $comment, "<SPAN$ilang CLASS=\"$indic\">", $_, '</SPAN>');
	} else { $comment . $_ }
    }
}


# for source already pre-processed

# $ACCENT_IMAGES .= 'rm'; # make images of unusual (not ISO-Latin1) accents

$SNHCURRM = 'rm';
$SNH_SIZE = '';
$image_switch_rx .= "|SH[abc]";

sub do_cmd_SHa { &process_indica_output('SHa', $font_size{'SHa'}, $snh_inline, @_[0]) }
sub do_cmd_SHb { &process_indica_output('SHb', $font_size{'SHb'}, $snh_inline, @_[0]) }
sub do_cmd_SHc { &process_indica_output('SHc', $font_size{'SHc'}, $snh_inline, @_[0]) }

sub process_indica_output {
    local($snhfont, $snh_size, $brlength, $snhtxt) = @_;

    local($afterspace) = '\\kern.05em';
    if ($snhfont =~ /SHa/) {
        $afterspace = '\\kern.1em' if ($snhtxt =~ /char7$/);
    }
    
    # size defaults to $LATEX_FONT_SIZE
    $snhtxt = "\{\\$snhfont$snhtxt$afterspace\}\%".
    		($snh_size ? $snh_size : $LATEX_FONT_SIZE)."\%";

    if (length($snhtxt) < $brlength ) {
	$global{'max_id'}++;
	$snhtxt = &process_undefined_environment('tex2html_snh_inline'
	    ,$global{'max_id'}, $snhtxt);
    } else { $snhtxt = &process_in_latex($snhtxt) }

    if ($USING_STYLES) {
	$env_style{'INDIC'} = " " unless ($env_style{'INDIC'});
	join('','<SPAN CLASS="INDIC">', $snhtxt, '</SPAN>');
    } else { $snhtxt }
}


sub do_cmd_snhcurrm {
    local($_) = @_[0];
    foreach $cmd (split(/\\/,$SNHCURRM)) {
	$tmp = "do_cmd_$cmd";
	if (defined &$tmp) { eval("\$_ = &$tmp(\$_)") }
	else { 
	    $_ = &declared_env($cmd,$_);
	}
    }
    $_;
}

#explicitly include Thiele's  \diatop  into preamble of images.tex

local($diatop) = "\n\\def\\diatop[#1|#2]{%\n"
 . "{\\setbox1=\\hbox{{#1{}}}\\setbox2=\\hbox{{#2{}}}%\n"
 . " \\dimen0=\\ifdim\\wd1>\\wd2\\wd1\\else\\wd2\\fi%\n"
 . " \\dimen1=\\ht2\\advance\\dimen1by-1ex%\n"
 . " \\setbox1=\\hbox to1\\dimen0{\\hss#1\\hss}%\n"
 . " \\hbox{\\rlap{\\raise1\\dimen1\\box1}%\n"
 . " \\hbox to1\\dimen0{\\hss#2\\hss}}}}%\n"
 ."%e.g. of use: \\diatop[\\'|{\\=o}] gives o macron acute\n\n";

$LaTeXmacros .= $diatop; undef $diatop;

&process_commands_in_tex (<<_RAW_ARG_CMDS_);
diatop # []
_RAW_ARG_CMDS_



1;				# Not really necessary...



