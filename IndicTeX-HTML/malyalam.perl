# $Id: malyalam.perl,v 1.1 1998/01/22 04:33:22 RRM Exp $
# MALYALAM.PERL by Ross Moore <ross@mpce.mq.edu.au> 23-12-97
# Mathematics Department, Macquarie University, Sydney, Australia.
#
# Style for LaTeX2HTML v98.1 to construct images of Malayalam script
#
# using  EITHER
#
#    1.  patc  and  mm  pre-processors
#        Malayalam fonts:
#        and the  mmmacs.tex  and  mmtrmacs.tex   macros
#        by Jeroen Hellingman
#
# OR
#
#    2.  Indica pre-processor, and sinhala fonts:  sinha, sinhb, sinhc
#        by Yannis Haralambous <Yannis.Haralambous@univ-lille1.fr>
#
#        and the  sinhala.sty  package for LaTeX-2e,
#        by Dominik Wujastyk <D.Wujastyk@ucl.ac.uk>
#
#        extended for Prasad Dharmasena's <pkd@isr.umd.edu>
#        `samanala'  transliteration scheme
#        by Vasantha Saparamadu <vsaparam@ocs.mq.edu.au>
#
#
# These resources are *not* included with this package.
# Obtain them from CTAN:  http//ctan.tug.org/ctan
#
# ===================================================================
# This package requires the corresponding LaTeX package: .sty .
#
# With LaTeX2HTML the options on the \usepackage line specify which
# preprocessor and transcription mode to use.
#
# Usage:
#
#  \usepackage{malyalam}          %|  for text already pre-processed
#  \usepackage[mm]{malyalam}      %|  for Malayalam (reformed) script 
#  \usepackage[ml]{malyalam}      %|  for traditional script
#  \usepackage[mlr]{malyalam}     %|  for reformed script
#  \usepackage[mtr]{malyalam}     %|  transcription only
#  \usepackage[patc]{malyalam}    %|  transcription only
#  \usepackage[preprocess]{malyalam}%| same as  [mm]
#
#
# for the Indica pre-processor:
#
#  \usepackage[indica]{malyalam}  %|  uses #ALIAS MALAYALAM M
#  \usepackage[mal]{malyalam}     %|  uses #ALIAS MALAYALAM MAL
#  \usepackage[7bit]{malyalam}    %|  Velthuis' Hindi/Sanskri transcription
#  \usepackage[csx]{malyalam}     %|  8-bit Sanskrit extension of ISO 646
#  \usepackage[latex]{malyalam}   %|  standardized LaTeX transcription form
#  \usepackage[unicode]{malyalam} %|  ISO 10646-1 + Sinhalese extension
#  \usepackage[samanala]{malyalam}%|  Prasad Dharmasena's transliteration
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
# $Log: malyalam.perl,v $
# Revision 1.1  1998/01/22 04:33:22  RRM
# 	LaTeX2HTML interfaces to packages and pre-processors for including
# 	traditional Indic scripts (as images) in HTML documents
#
# 	see the .perl files for documentation on usage
# 	see the corresponding .sty file for the LaTeX-2e interface
#
#

package malayalam;

# Put malayalam equivalents here for headings/dates/ etc when
# latex2html start supporting them ...

sub main'malayalam_translation {
    @_[0];
}

package main;


###  configuration variables  ###
# these may be set in .latex2html-init files

# command-name for the  patc  pre-processor
$PATC = 'patc' unless ($PATC);


####  IMPORTANT: this variable *must* be set correctly ####
# directory for the  .pat  filter tables
$PRE_FILTERS = '.' unless ($PRE_FILTERS);


# command-name for the  mm  pre-processor
$MM = 'mm' unless ($MM);

####  IMPORTANT: this variable *must* be set correctly ####
# directory for the  mm's  filter tables
$MMDIR = $ENV{'MMDIR'}  unless $MMDIR;
# try the same as for  patc 
$MMDIR = $PRE_FILTERS unless $MMDIR;



# max characters in an inline string

# in transliteration
$mm_inline = 150 unless ($mm_inline);

# phonetics:
$mmph_inline = 150 unless ($mmph_inline);

# after pre-processing:
$malyalam_inline = 500 unless ($malyalam_inline);



# preprocessor: malayalam
sub do_malyalam_preprocess { &pre_process_mlr('') }
sub do_malyalam_mm { &pre_process_mlr('') }
sub do_malyalam_ml { &pre_process_ml ('') }
sub do_malyalam_mlr{ &pre_process_mlr('') }
sub do_malyalam_ack{ &pre_process_ack('') }
sub do_malyalam_mmtr{ &pre_process_mmtr('') }
sub do_malyalam_patc{ &pre_process_mmtr('') }


# preprocessor: indica
sub do_malyalam_indica { &check_indica_loaded(); &do_indica_malayalam() }
sub do_malyalam_mal { &check_indica_loaded(); &do_indica_mal() }

# input modes
sub do_malyalam_7bit { &check_indica_loaded(); &do_indica_7bit() }
sub do_malyalam_csx { &check_indica_loaded(); &do_indica_csx() }
sub do_malyalam_latex { &check_indica_loaded(); &do_indica_latex() }
sub do_malyalam_unicode { &check_indica_loaded(); &do_indica_unicode() }
sub do_malyalam_samanala { &check_indica_loaded(); &do_indica_samanala() }


sub check_indica_loaded {
    return if ($INDICA_MODE);

    # load Indica for #MALAYALAM
    &do_require_package('indica');
    if (defined &do_indica_malayalam) { &do_indica_malayalam() }
    else { die "\n indica.perl was not loaded, sorry" }
    #
    # override Indica variables here
    #
    #  $INDICA = 'indica';
    #  $INDICA_MODE = 'sevenbit';
}


sub pre_process_ml {
    $preprocessor_cmds .=
        "mm -s $MMDIR${dd}mm.scr -t $MMDIR${dd}mm.trs ${PREFIX}images.pre ${PREFIX}images.tex\n";
    &mm_other_environments();
    %other_environments = ( %other_environments
                , "\$:\$", 'mmtrad'
                , '<malayalam>:</malayalam>' , 'mmtrad' );
}

sub pre_process_mlr {
    $preprocessor_cmds .=
        "$MM -s $MMDIR${dd}mmr.scr -t $MMDIR${dd}mmr.trs ${PREFIX}images.pre ${PREFIX}images.tex\n";
    &mm_other_environments();
    %other_environments = ( %other_environments
                , "\$:\$", 'mmreform'
                , '<malayalam>:</malayalam>', 'mmreform' );
}

sub pre_process_ack {
    $preprocessor_cmds .=
        "$PATC -p $MMDIR${dd}ack.pat ${PREFIX}images.pre ${PREFIX}images.tex\n";
    $preprocessor_cmds .=
        "$MM -s $MMDIR${dd}mmr.scr -t $MMDIR${dd}mmr.trs ${PREFIX}images.pre ${PREFIX}images.tex\n";
    &mm_other_environments();
}

sub pre_process_mmtr {
#   $preprocessor_cmds .=
#       "$PATC -p $MMDIR${dd}mm.pat ${PREFIX}images.pre ${PREFIX}images.tex\n";
    $PREPROCESS_IMAGES = 1;
    %other_environments = ( %other_environments
                , "\$\$:\$\$" , 'mmtr'
	) unless ($other_environments{"\$\$:\$\$"});
}

sub mm_other_environments {
    $PREPROCESS_IMAGES = 1;
    %other_environments = ( %other_environments
                , "\$\$:\$\$", 'mmtr'
	) unless ($other_environments{"\$\$:\$\$"});
    %other_environments = ( %other_environments
                , '<ml>:</ml>', 'mmtrad'
                , '<mlr>:</mlr>', 'mmreform'
                , "\\math:\\math", 'math'
                , "\\Math:\\Math", 'Math'
	) unless ($other_environments{'mmtrad'});
}

sub do_cmd_dollar { "\$".@_[0] }


sub do_env_pre_mmtr {
    local($_) = @_;
    open(MMTR,">mmtr.tmp") || print "\n *** cannot open mmtr.tmp ***" ;
    print MMTR "\$\$", &revert_to_raw_tex($_), "\$\$";
    close MMTR;
    &syswait("$PATC -p $MMDIR${dd}mm.pat mmtr.tmp mmtr.tmp1");
    &slurp_input_and_partition_and_pre_process('mmtr.tmp1');
    unlink ('mmtr.tmp', 'mmtr.tmp1') unless $DEBUG;

    $_ = &translate_environments($_);
    $_ = &translate_commands($_);

    if ($USING_STYLES) {
        $env_style{'MALRM'} = " " unless ($env_style{'MALRM'});
        join('','<SPAN CLASS="MALRM">', $_, '</SPAN>');
    } else { $_ }
}
$begin_preprocessor{'mmtr'} = '';
$end_preprocessor{'mmtr'} = '';


sub do_env_pre_mmtrad {
    local($_) = @_;

    if (length($_) < $mm_inline ) {
        $_ = &process_undefined_environment('tex2html_mm_inline'
            , ++$global{'max_id'}, "<ml>$_</ml>");
    } else { $_ = &process_in_latex("<ml>\n$_\n</ml>") }

    if ($USING_STYLES) {
        $env_style{'MAL'} = " " unless ($env_style{'MAL'});
        join('','<SPAN CLASS="MAL">', $_, '</SPAN>');
    } else { $_ }
}
$begin_preprocessor{'mmtrad'} = '<ml>';
$end_preprocessor{'mmtrad'} = '</ml>';


sub do_env_pre_mmreform {
    local($_) = @_;

    if (length($_) < $mm_inline ) {
        $_ = &process_undefined_environment('tex2html_mm_inline'
            , ++$global{'max_id'}, "<mlr>$_</mlr>");
    } else { $_ = &process_in_latex("<mlr>\n$_\n</mlr>") }

    if ($USING_STYLES) {
        $env_style{'MAL'} = " " unless ($env_style{'MAL'});
        join('','<SPAN CLASS="MAL">', $_, '</SPAN>');
    } else { $_ }
}
$begin_preprocessor{'mmreform'} = '<mlr>';
$end_preprocessor{'mmreform'} = '</mlr>';


sub do_env_pre_math { &do_env_math(@_) }
sub do_env_pre_Math { &do_env_displaymath(@_) }

$begin_preprocessor{'math'} = '\(';
$end_preprocessor{'math'} = '\)';
$begin_preprocessor{'Math'} = '\[';
$end_preprocessor{'Math'} = '\]';


$MMCURMF = 'mmr';
$MMCURRM = 'rm';

$image_switch_rx .= "|mm(ph)?";
$env_switch_rx .= "|(six|eight|twelve|seventeen)?mm(r|b|sl|c(b|sl)?)";


sub do_cmd_mm {
    local($_) = @_; &process_malayalam_text('mm', $malyalam_inline, $_)};

sub do_cmd_mmph {&process_malayalam_text('mmph', $mmph_inline, @_)};


sub process_malayalam_text {
    local($mmfont,$brlength,$mmtxt) = @_;
    #add a bit of space if the last character is an accent
    $mmtxt =~ s/hbox(($O|$OP)\d+($C|$CP))\1\s*$/hbox$1\\,\\,$1/;
    $mmtxt =~ s/(mmV(($O|$OP)\d+($C|$CP))(.*)\2)\s*$/$1\\kern.2em/;
    local($mmtxt) = &revert_to_raw_tex($_);

#    $mmtxt = "\\${MMCURMF}\{\\$mmfont $mmtxt\}";

    if ($mmtxt =~ /\\par\b/m) {
	local(@paragraphs, @mm_processed, $this_par);
	local($par_start, $par_end) = ('<P', "</P>\n");
	$par_start .= (($USING_STYLE)? " CLASS=\"MAL\"":''). '>';
	@paragraphs = (split(/\\par\b/, $mmtxt ));
	while (@paragraphs) {
	    $this_par = shift @paragraphs;
	    $this_par =~ s/\s$//;
	    if ($this_par =~ /^\s*$/) {
	        push(@mm_processed, "\n<P></P>\n");
	    } else {
	        $mmtxt = &process_in_latex(
			"\{${MMCURMF}\{\\$mmsize $this_par\}\}" );
	        push(@mm_processed
		    , &make_comment('MALAYALAM', $this_par)
		    , $par_start , $mmtxt , $par_end);
	    }
	}
	join('', @mm_processed );
    } else  {
	local($maltxt) = join(''
		,"\{\\${MMCURMF\\,}\{\\$mmsize ",$mmtxt,"\}\\,\}");
	local($comment);
	if (length($mmtxt) < $brlength ) {
	    $mmtxt = &process_undefined_environment('tex2html_mm_inline'
	    , ++$global{'max_id'}, $maltxt);
	} else { 
	    $comment = join('', &make_comment('MALAYALAM',$mmtxt),"\n");
	    $mmtxt = &process_in_latex($maltxt)
	}
	if ($USING_STYLES) {
	    $env_style{'MAL'} = " " unless ($env_style{'MAL'});
	    join('', $comment, '<SPAN CLASS="MAL">', $mmtxt, '</SPAN>');
	} else { $comment . $mmtxt }
    }
}

sub do_cmd_D {
    local($_) = @_; local($char);
    $char = &missing_braces unless (
	(s/$next_pair_pr_rx/$char=$2;''/e)
	||(s/$next_pair_rx/$char=$2;''/e));
    join('',&process_malayalam_text('mm',$malyalam_inline,"\\char$char"), $_);
}
sub do_cmd_dotcircle{&process_malayalam_text('mm',$malyalam_inline,"\\char0")}
sub do_cmd_ornstar{&process_malayalam_text('mm',$malyalam_inline,"\\char255")}


sub do_cmd_mmtr { 
    local($_)= @_;
    local($ACCENT_IMAGES) = "$MMCURMF,mmtr";
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
	, ++$global{'max_id'} , "\\${MMCURMF}\{\\mmtr\\$which$afterkern\}"); }


sub process_malayalam_digit {
    &process_malayalam_text('mm',$malyalam_inline,"\\\<".@_[0]."\>");}

sub do_cmd_mmzero {
    return ( join('',&do_cmd_RMF("0"), @_[0])) unless $MMNUM;
    join('',&process_malayalam_digit('102'), @_[0]) }
sub do_cmd_mmone {
    return ( join('',&do_cmd_RMF("1"), @_[0])) unless $MMNUM;
    join('',&process_malayalam_digit('103'), @_[0]) }
sub do_cmd_mmtwo {
    return ( join('',&do_cmd_RMF("2"), @_[0])) unless $MMNUM;
    join('',&process_malayalam_digit('104'), @_[0]) }
sub do_cmd_mmthree {
    return ( join('',&do_cmd_RMF("3"), @_[0])) unless $MMNUM;
    join('',&process_malayalam_digit('105'), @_[0]) }
sub do_cmd_mmfour {
    return ( join('',&do_cmd_RMF("4"), @_[0])) unless $MMNUM;
    join('',&process_malayalam_digit('106'), @_[0]) }
sub do_cmd_mmfive {
    return ( join('',&do_cmd_RMF("5"), @_[0])) unless $MMNUM;
    join('',&process_malayalam_digit('107'), @_[0]) }
sub do_cmd_mmsix {
    return ( join('',&do_cmd_RMF("6"), @_[0])) unless $MMNUM;
    join('',&process_malayalam_digit('108'), @_[0]) }
sub do_cmd_mmseven {
    return ( join('',&do_cmd_RMF("7"), @_[0])) unless $MMNUM;
    join('',&process_malayalam_digit('109'), @_[0]) }
sub do_cmd_mmeight {
    return ( join('',&do_cmd_RMF("8"), @_[0])) unless $MMNUM;
    join('',&process_malayalam_digit('110'), @_[0]) }
sub do_cmd_mmnine {
    return ( join('',&do_cmd_RMF("9"), @_[0])) unless $MMNUM;
    join('',&process_malayalam_digit('111'), @_[0]) }

sub do_cmd_sixmmr { &set_mmcurrm('scriptsize',@_[0]) }
sub do_cmd_eightmmr { &set_mmcurrm('small',@_[0]) }
sub do_cmd_mmr { &set_mmcurrm('normalsize',@_[0]) }
sub do_cmd_mmb { &set_mmcurrm('bfseries',@_[0]) }
sub do_cmd_mmsl { &set_mmcurrm('itshape',@_[0]) }
sub do_cmd_mmc { &set_mmcurrm('normalsize',@_[0]) }
sub do_cmd_mmcb { &set_mmcurrm('bfseries',@_[0]) }
sub do_cmd_mmcsl { &set_mmcurrm('itshape',@_[0]) }
sub do_cmd_twelvemmr { &set_mmcurrm('large',@_[0]) }
sub do_cmd_twelvemmb { &set_mmcurrm('large bfseries',@_[0]) }
sub do_cmd_twelvemmsl { &set_mmcurrm('large itshape',@_[0]) }
sub do_cmd_twelvemmc { &set_mmcurrm('large',@_[0]) }
sub do_cmd_twelvemmcb { &set_mmcurrm('large bfseries',@_[0]) }
sub do_cmd_twelvemmcsl { &set_mmcurrm('large itshape',@_[0]) }
sub do_cmd_seventeenmmr { &set_mmcurrm('LARGE',@_[0]) }
sub do_cmd_seventeenmmb { &set_mmcurrm('LARGE bfseries',@_[0]) }
sub do_cmd_seventeenmmc { &set_mmcurrm('LARGE',@_[0]) }
sub do_cmd_seventeenmmcb { &set_mmcurrm('LARGE bfseries',@_[0]) }

sub set_mmcurrm {
    local($saveMMCURRM, $saveMMCURMF) = ($MMCURRM, $MMCURMF);
    $MMCURRM = @_[0]; $MMCURRM =~ s/ /\\/g;
    $MMCURMF = $cmd;
    $latex_body .= "\\$MMCURMF ";
    local($mm_id) = ++$global{'max_id'};
    local($revert) = "\\HTMLset$OP$mm_id${CP}".'MMCURRM'."$OP$mm_id$CP";
    $mm_id = ++$global{'max_id'};
    $revert .= "$OP$mm_id$CP$saveMMCURRM$OP$mm_id$CP";
    $mm_id = ++$global{'max_id'};
    $revert .= "\\HTMLset$OP$mm_id$CP".'MMCURMF'."$OP$mm_id$CP";
    $mm_id = ++$global{'max_id'};
    $revert .= "$OP$mm_id$CP$saveMMCURMF$OP$mm_id$CP";
    @_[1] . $revert;
}
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

&process_commands_nowrap_in_tex (<<_RAW_ARG_NOWRAP_CMDS_);
mmfigures # \$MMNUM = 1
rmfigures # \$MMNUM = 0
_RAW_ARG_NOWRAP_CMDS_

&process_commands_wrap_deferred (<<_WRAP_CMDS_);
#mmcurrm
_WRAP_CMDS_

1;				# Not really necessary...



