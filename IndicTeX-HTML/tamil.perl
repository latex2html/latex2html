# $Id: tamil.perl,v 1.1 1998/01/22 04:33:24 RRM Exp $
# TAMIL.PERL by Ross Moore <ross@mpce.mq.edu.au> 10-1-98
# Mathematics Department, Macquarie University, Sydney, Australia.
#
# Style for LaTeX2HTML v98.1 to construct images of Tamil script
# using the University of Washington  wntml10  font,
# and EITHER
#
#      1.  Jeroen Hellingman's  preprocessor: patc
# OR
#      2.  University of Washington  preprocessors: 
#		 tamilize  and  tmilize
#
# ... based on the parts of the  tamilmax.tex  macros
# and their adaptation  tmlmacs.tex  by Jeroen Hellingman
#
# OR
#      3.  Indica pre-processor, and sinhala fonts:  sinha, sinhb, sinhc
#          by Yannis Haralambous <Yannis.Haralambous@univ-lille1.fr>
#
#          and the  sinhala.sty  package for LaTeX-2e,
#          by Dominik Wujastyk <D.Wujastyk@ucl.ac.uk>
#
#          extended for Prasad Dharmasena's <pkd@isr.umd.edu>
#          `samanala'  transliteration scheme
#          by Vasantha Saparamadu <vsaparam@ocs.mq.edu.au>
#
#
# These resources are *not* included with this package.
# Obtain them from CTAN:  http//ctan.tug.org/ctan
#
# ===================================================================
# This package requires the corresponding LaTeX package:  tamil.sty 
# and  indica.sty  and  indica.perl  for use with Indica pre-processor.
#
# With LaTeX2HTML the options on the \usepackage line specify which
# preprocessor and transcription mode to use.
#
# Usage:
#
#  \usepackage[tamilize]{tamil}   %|  uses Univ. of Washington preprocessor
#  \usepackage[tmilize]{tamil}    %|    tamilize  or  tmilize , resp.
#                                 %|  images load macros:  tamilmax.tex
#
#  \usepackage[tamil]{tamil}      %|  uses Jeroen Hellingman's preprocessor
#  \usepackage[wntml]{tamil}      %|    patc -p <option>.pat 
#  \usepackage[adami]{tamil}      %|  macros:  tmlmacs.tex  mmtrmacs.tex
#
#  \usepackage[preprocess]{tamil} %|  same as  \usepackage[tamil]{tamil}
#  \usepackage{tamil}             %|  same as  \usepackage[tamil]{tamil}
#
#
# for the Indica pre-processor:
#
#  \usepackage[indica]{tamil}     %|  uses #ALIAS TAMIL T
#  \usepackage[tam]{tamil}        %|  uses #ALIAS TAMIL TAM
#  \usepackage[7bit]{tamil}       %|  Velthuis' Hindi/Sanskri transcription
#  \usepackage[csx]{tamil}        %|  8-bit Sanskrit extension of ISO 646
#  \usepackage[latex]{tamil}      %|  standardized LaTeX transcription form
#  \usepackage[unicode]{tamil}    %|  ISO 10646-1 + Sinhalese extension
#  \usepackage[samanala]{tamil}   %|  Prasad Dharmasena's transliteration
#
# ===================================================================
# Warning 1.
#
#  This package works BOTH with source *before* preprocessing
#  and also *after* having preprocessed.
#  The latter may create more smaller images of individual syllabes,
#  whereas the former tends to create larger images of whole lines,
#  paragraphs, sections, etc.
# ===================================================================
# Warning 2.
#
#  To use the  patc  preprocessor, set the variable $PRE_FILTERS
#  to the directory where the preprocessor's  .pat  files are found.
#  This is best done in  latex2html.config .
# ===================================================================
#
# Change Log:
# ===========
# $Log: tamil.perl,v $
# Revision 1.1  1998/01/22 04:33:24  RRM
# 	LaTeX2HTML interfaces to packages and pre-processors for including
# 	traditional Indic scripts (as images) in HTML documents
#
# 	see the .perl files for documentation on usage
# 	see the corresponding .sty file for the LaTeX-2e interface
#
#

package tamil;

# Put tamil equivalents here for headings/dates/ etc when
# latex2html starts supporting them ...

sub main'tamil_translation {
    @_[0];
}

package main;


###  configuration variables  ###
# these may be set in .latex2html-init files

# command-name for the  tamilize  pre-processors
$TAMILIZE = 'tamilize' unless ($TAMILIZE);
$TMILIZE = 'tmilize' unless ($TMILIZE);

# command-name for the  patc  pre-processor
$PATC = 'patc' unless ($PATC);


####  IMPORTANT: this variable *must* be set correctly ####
# directory for the  .pat  filter tables
$PRE_FILTERS = '.' unless ($PRE_FILTERS);



# max characters in an inline string

# in transliteration
$tml_inline = 200 unless ($tml_inline);

# after pre-processing:
$tamil_inline = 500 unless ($tamil_inline);



# preprocessor: tamil
sub do_tamil_preprocess { &pre_process_tamil('') }
sub do_tamil_wntml { &pre_process_tamil('wntml') }
sub do_tamil_adami { &pre_process_tamil('adami') }
sub do_tamil_tamil { &pre_process_tamil('tamil') }
sub do_tamil_tamilize { &pre_process_tmilize() }
sub do_tamil_tamilize { &pre_process_tamilize() }


# preprocessor: indica
sub do_tamil_indica { &check_indica_loaded(); &do_indica_tamil() }
sub do_tamil_tam { &check_indica_loaded(); &do_indica_tam() }

# input modes
sub do_tamil_7bit { &check_indica_loaded(); &do_indica_7bit() }
sub do_tamil_csx { &check_indica_loaded(); &do_indica_csx() }
sub do_tamil_latex { &check_indica_loaded(); &do_indica_latex() }
sub do_tamil_unicode { &check_indica_loaded(); &do_indica_unicode() }
sub do_tamil_samanala { &check_indica_loaded(); &do_indica_samanala() }


sub check_indica_loaded {
    return if ($INDICA_MODE);

    # load Indica for #TAMIL
    &do_require_package('indica');
    if (defined &do_indica_tamil) { &do_indica_tamil() }
    else { die "\n indica.perl was not loaded, sorry" }
    #
    # override Indica variables here
    #
    #  $INDICA = 'indica';
    #  $INDICA_MODE = 'sevenbit';
}


sub pre_process_tamil {
    local($pattern) = @_; $pattern = 'tamil' unless ($pattern);
    $preprocessor_cmds .= 
	"$PATC -p $PRE_FILTERS$dd$pattern.pat ${PREFIX}images.pre ${PREFIX}images.tex\n";
    $preprocessor_cmds .= 
	"$PATC -p $PRE_FILTERS${dd}tamil.pat ${PREFIX}images.pre ${PREFIX}images.tex\n"
		unless ($pattern =~ /tamil/);
    if ($pattern =~ /wntml/) {
	%other_environments = ( %other_environments
		, '~:~' , 'tamilize' )
    } elsif ($pattern =~ /adami/) {
	%other_environments = ( %other_environments
		, '<tamil>:</tamil>', 'tamil'  )
    } else {
	%other_environments = ( %other_environments
		, '<tamil>:</tamil>' , 'tamil' )
    }
    $PREPROCESS_IMAGES = 1;
}

sub pre_process_tamilize {
    $PREPROCESS_IMAGES = 1;
    $preprocessor_cmds .= 
	"$TAMILIZE ${PREFIX}images.pre ${PREFIX}images.tex\n";
    %other_environments = ( %other_environments
		, '~:~' , 'tamilize' );
}

sub pre_process_tmilize {
    $PREPROCESS_IMAGES = 1;
    $preprocessor_cmds .= 
	"$TMILIZE ${PREFIX}images.pre ${PREFIX}images.tex\n";
    %other_environments = ( %other_environments
		, '~:~' , 'tamilize' );
}


sub do_env_pre_tamil {
    local($_) = @_;

    if (length($_) < $tml_inline ) {
	$_ = &process_undefined_environment('tex2html_tml_inline'
	    , ++$global{'max_id'}, "<tamil>\n$_\n</tamil>");
    } else { $_ = &process_in_latex("<tamil>\n$_\n</tamil>") }

    if ($USING_STYLES) {
	$env_style{'TAM'} = " " unless ($env_style{'TAM'});
	join('','<SPAN CLASS="TAM">', $_, '</SPAN>');
    } else { $_ }
}
$begin_preprocessor{'mmtr'} = '<tamil>';
$end_preprocessor{'mmtr'} = '</tamil>';


sub do_env_pre_tamilize {
    local($_) = @_;

    if (length($_) < $tml_inline ) {
	$_ = &process_undefined_environment('tex2html_tmlz_inline'
	    , ++$global{'max_id'}, "\{\~$_\~\}");
    } else { $_ = &process_in_latex("\{\~$_\~\}") }

    if ($USING_STYLES) {
	$env_style{'TAM'} = " " unless ($env_style{'TAM'});
	join('','<SPAN CLASS="TAM">', $_, '</SPAN>');
    } else { $_ }
}
$begin_preprocessor{'tamilize'} = "\{\~";
$end_preprocessor{'tamilize'} = "\~\}";


sub do_env_pre_tamiltr { 
    local($_) = @_;
    $_ = &translate_environments($_);
    &translate_commands($_);
}
$begin_preprocessor{'tamiltr'} = '';
$end_preprocessor{'tamiltr'} = '';



&process_commands_in_tex (<<_RAW_ARG_CMDS_);
begintamil # <<\\endtamil>>
starttamil # <<\\endtamil>>
btam # <<\\etam>>
_RAW_ARG_CMDS_

# need this, else an image can result from inaction
&ignore_commands (<<_IGNORE_CMDS_);
pre_tamiltr
_IGNORE_CMDS_


$MMCURRM = 'rm';

$image_switch_rx .= "|(begin|start)tamil|btam";


sub do_env_tamil {
    local($_) = @_; &process_tamil_text('tmlfont', $tamil_inline, $_)};

#RRM: These aren't needed yet.
#
#sub do_cmd_begintamil { local($_) = @_;
#   if ($_ =~ /\\endtamil/ ) { local($this) = $`; $_ = $'; }
#   $this = &process_tamil_text('tmlfont', $tamil_inline, $this);
#   join('', $this, $_); }

#sub do_cmd_btam { local($_) = @_;
#   if ($_ =~ /\\etam/ ) { local($this) = $`; $_ = $'; }
#   $this = &process_tamil_text('tmlfont', $tamil_inline, $this);
#   join('', $this, $_); }


sub process_tamil_text {
    local($tmlfont,$brlength,$tmltxt) = @_;
    #add a bit of space if the last character is an accent
    $tmltxt =~ s/hbox(($O|$OP)\d+($C|$CP))\1\s*$/hbox$1\\,$1/;
    $tmltxt =~ s/(mmV(($O|$OP)\d+($C|$CP))(.*)\2)\s*$/$1\\kern.2em/;
    $tmltxt = "\\begintamil\{\\$tmlfont $tmltxt\}\\endtamil";

    if (length($tmltxt) < $brlength ) {
	$global{'max_id'}++;
	$tmltxt = &process_undefined_environment('tex2html_tml_inline'
	    ,$global{'max_id'}, $tmltxt);
    } else { $tmltxt = &process_in_latex($tmltxt) }

    if ($USING_STYLES) {
	$env_style{'TML'} = " " unless ($env_style{'TML'});
	join('','<SPAN CLASS="TML">', $tmltxt, '</SPAN>');
    } else { $tmltxt }
}

sub do_cmd_C {
    local($_) = @_; local($char);
    $char = &missing_braces unless (
	(s/$next_pair_pr_rx/$char=$2;''/e)
	||(s/$next_pair_rx/$char=$2;''/e));
    join('',&process_tamil_text('tmlfont',$tamil_inline,"\\char$char"), $_);
}


# some stuff from  Malayalam-TeX

sub do_cmd_mmtr { 
    local($_)= @_;
    local($ACCENT_IMAGES) = "mmtr";
    $_ =~ s/^\s*//os;
    &translate_commands($_)
};

sub do_cmd_lii { &process_mm_accent('lii') .@_[0] }
sub do_cmd_rii { &process_mm_accent('rii') .@_[0] }
sub do_cmd_Lii { &process_mm_accent('Lii') .@_[0] }
sub do_cmd_Rii { &process_mm_accent('Rii') .@_[0] }
sub do_cmd_LII { &process_mm_accent('Lii') .@_[0] }
sub do_cmd_RII { &process_mm_accent('Rii') .@_[0] }

sub process_mm_accent{
    local($which) = @_;
    local($afterkern); $afterkern = '\\kern.15em' if ($which =~ /l/i);
    &process_undefined_environment("tex2html_accent_inline",
	, ++$global{'max_id'} , "\{\\mmtr\\$which$afterkern\}"); }


sub do_cmd_mmcurrm {
    local($_) = @_[0];
    foreach $cmd (split(/\\/,$MMCURRM)) {
	$tmp = "do_cmd_$cmd";
	if (defined &$tmp) { eval("\$_ = &$tmp(\$_)") }
	else { 
	    $_ = &declared_env($cmd,$_);
	}
    }
    $_;
}
sub do_cmd_RMF { &do_cmd_mmcurrm(@_) }


1;				# Not really necessary...



