# $Id: devnagri.perl,v 1.5 2001/06/11 00:59:03 RRM Exp $
# DEVNAGRI.PERL by Ross Moore <ross@mpce.mq.edu.au> 10-1-98
# Mathematics Department, Macquarie University, Sydney, Australia.
#
# Style for LaTeX2HTML v2K.1 to construct images of Devanagari script
# using:
#
#  `devnag'  pre-processor and  dvng  fonts
#       by Frans J. Velthuis' <velthuis@rc.rug.nl>
#
#   and the  dev.sty  LaTeX-2e interface 
#       by Dominik Wujastyk <D.Wujastyk@ucl.ac.uk>
#
#   retaining support for the old  dev2e.sty  LaTeX-2e interface 
#       by Dominik Wujastyk <D.Wujastyk@ucl.ac.uk>
#
#  Furthermore it can be used with the transcription scheme
#  devised by Jeroen Hellingman, for his  `patc' preprocessor
#  requiring macro files:  dnmacs.tex  and  dntrmacs.tex
#
#
# These resources are *not* included with this package.
# Obtain them from CTAN:  http//ctan.tug.org/ctan
#
# ===================================================================
# This package requires the corresponding LaTeX package:  devnagri.sty .
#
# With LaTeX2HTML the options on the \usepackage line specify which
# preprocessor and transcription mode to use.
#
# Usage:
#
#  \usepackage[devnag]{devnagri}     %|  Velthuis' pre-processor only
#  \usepackage[hindi]{devnagri}      %|    
#  \usepackage[marathi]{devnagri}    %|  
#  \usepackage[nepali]{devnagri}     %|  
#  \usepackage[sanskrit]{devnagri}   %|  
#
#  \usepackage{devnagri}             %|  source already pre-processed
#  \usepackage[preprocess]{devnagri} %|  same as  \usepackage[patc]{devnagri}
#
#  \usepackage[dev209]{devnagri}       %|  old LaTeX-209 version
#  \usepackage[olddevnag]{devnagri}    %|  old LaTeX-209 version
#  \usepackage[old,...]{devnagri}      %|  uses LaTeX-209 version with others
#
#  \usepackage[patc]{devnagri}         %|  also uses Jeroen Hellingman's 
#  \usepackage[patc,hindi]{devnagri}   %|    patc -p <option>.pat
#  \usepackage[patc,marathi]{devnagri} %|  with language options, and macros:
#  \usepackage[patc,nepali]{devnagri}  %|   dnmacs.tex  dntrmacs.tex
#  \usepackage[patc,sanskrit]{devnagri}%|  
#
# ===================================================================
# Warning 1.
#
#  This package works BOTH with source *before* pre-processing
#  and also *after* having pre-processed.
#  The latter may create more smaller images of individual syllabes,
#  whereas the former tends to create larger images of whole lines,
#  paragraphs, sections, etc.
# ===================================================================
# Warning 2.
#
#  To use the  patc  pre-processor, set the variable $PRE_FILTERS
#  to the directory where the pre-processor's  .pat  files are found.
#  This is best done in  latex2html.config .
# ===================================================================
#
# Change Log:
# ===========
# $Log: devnagri.perl,v $
# Revision 1.5  2001/06/11 00:59:03  RRM
#  --  differentiate between \newline and \\
#       \\ causes </P><P> to split paragraphs
#       \newline causes <BR> assuming that an outer environment supplies
#        the correct paragraph-level tagging.
#  --  environments {verse}, {quote}, and {center} are recognised as being
#      at paragraph-level. Currently no special HTML tags are used for these.
#      That should be addressed with further development.
#
# Revision 1.4  2001/05/22 13:31:32  RRM
#  --  leave $DN2 undefined by default. It's only needed for german
#      extensions by Klaus-J. Wolf  <yanestra@t-online.de>
#
# Revision 1.3  2001/05/21 10:23:53  RRM
#  --  update to support the version 2.0  revision of  devnag  and  dn2
#
# Revision 1.2  1998/02/03 05:35:03  RRM
#  --  dev2e.sty was written by Wujastyk, not Fairbairns
#
#

package devnagri;

# Put devnagri equivalents here for headings/dates/ etc when
# latex2html starts supporting them ...

sub main'devnagri_translation {
    @_[0];
}

package main;

###  configuration variables  ###
# these may be set in .latex2html-init files

# command-name for the  devnag  and  dn2  pre-processors
$DEVNAG = 'devnag' unless ($DEVNAG);
#$DN2 = 'dn2' unless ($DN2); # uncomment this for the  dn2  german extension

# command-name for the  patc  pre-processor
$PATC = 'patc' unless ($PATC);

####  IMPORTANT: move/rename  system command
####  (un-)comment the following lines to get this right:
$RENAME = 'mv';	# Unix
#$RENAME = 'rename'; # DOS


####  IMPORTANT: this variable *must* be set correctly ####
# directory for the  .pat  filter tables
$PRE_FILTERS = '.' unless ($PRE_FILTERS);


# max characters in an inline string
# patc:
$dn_inline = 150 unless ($dn_inline);

# devnag:
$devnag_inline = 150 unless ($devnag_inline);



# pre-processor: devnag
sub do_devnagri_devnag { &pre_process_devnag('') }
sub do_devnagri_old { $DVNG_OLD=1; }
sub do_devnagri_dev209 { &do_devnagri_old; &pre_process_devnag('') }
sub do_devnagri_olddevnag { &do_devnagri_209(); }

# preprocessor: patc
sub do_devnagri_preprocess { &pre_process_devnagri('') }
sub do_devnagri_patc { &pre_process_devnagri('') }
sub do_devnagri_hindi { &pre_process_devnagri('hindi') }
sub do_devnagri_marathi { &pre_process_devnagri('marathi') }
sub do_devnagri_nepali { &pre_process_devnagri('nepali') }
sub do_devnagri_sanskrit { &pre_process_devnagri('sanskrit') }


# pre-processor directives: pass these to images.pre
#
%other_environments = ( %other_environments
	, '@hindi:', 'nowrap'
	, '@sanskrit:', 'nowrap'
	, '@dollars:', 'nowrap'
	, '@nodollars:', 'nowrap'
	, '@dolmode0:', 'nowrap'
	, '@dolmode1:', 'nowrap'
	, '@dolmode2:', 'nowrap'
	, '@dolmode3:', 'nowrap'
	, '@hyphen:', 'nowrap'
	, '@nohyphen:', 'nowrap'
	, '@lig:', 'nowrap'
	, '@nolig:', 'nowrap'
	, '@tabs:', 'nowrap'
	, '@notabs:', 'nowrap'
	, '@vconjuncts:', 'nowrap'
);

sub pre_process_devnagri {
    local($pattern) = @_; $pattern = 'dng'; # unless ($pattern);
    if ($DVNG_OLD) {
      $preprocessor_cmds .= 
	"$PATC -p $PRE_FILTERS$dd$pattern.pat ${PREFIX}images.pre ${PREFIX}images.tex\n";
      $preprocessor_cmds .= 
	"$DEVNAG  ${PREFIX}images.pre ${PREFIX}images.tex\n"
		unless ($pattern =~ /devnagri/);
    } else {
      $preprocessor_cmds .= 
    	"$RENAME ${PREFIX}images.pre ${PREFIX}images.dn; ";
    	if ($DN2) {
    	    $preprocessor_cmds .=
		"$DEVNAG  ${PREFIX}images.dn ${PREFIX}imagesdn2; "
		. "$DN2  ${PREFIX}imagesdn2.tex ${PREFIX}images.tex\n";
	} else {
    	    $preprocessor_cmds .=
		"$DEVNAG  ${PREFIX}images.dn ${PREFIX}images.tex\n";
	}
    }

    %other_environments = ( %other_environments
		, "\$\$:\$\$", 'tr_devnagri'
		, "\$:\$", 'devnagri'
	) if ($prelatex =~ /^\@dollars/m );
#	) unless ($prelatex =~ /\@dollar/ );

    %other_environments = ( %other_environments
		, '<hindi>:</hindi>', 'devnagri'
		, '<marathi>:</marathi>', 'devnagri'
		, '<nepali>:</nepali>', 'devnagri'
		, '<sanskrit>:</sanskrit>', 'devnagri'
		, '<hindi.transcription>:</hindi>', 'tr_devnagri'
		, '<marathi.transcription>:</marathi>', 'tr_devnagri'
		, '<nepali.transcription>:</nepali>', 'tr_devnagri'
		, '<sanskrit.transcription>:</sanskrit>', 'tr_devnagri'
        );
    $PREPROCESS_IMAGES = 1;
}

sub pre_process_devnag {
    $PREPROCESS_IMAGES = 1;
    if ($DVNG_OLD) {
      $preprocessor_cmds .= 
	"$DEVNAG  ${PREFIX}images.pre ${PREFIX}images.tex\n"
	    unless ($preprocessor_cmds =~ /devnag/);
    } elsif(!($preprocessor_cmds =~ /devnag/)) {
      $preprocessor_cmds .= 
    	"$RENAME ${PREFIX}images.pre ${PREFIX}images.dn; ";
    	if ($DN2) {
    	    $preprocessor_cmds .=
		"$DEVNAG  ${PREFIX}images.dn ${PREFIX}imagesdn2; "
		. "$DN2  ${PREFIX}imagesdn2.tex ${PREFIX}images.tex\n";
	} else {
    	    $preprocessor_cmds .=
		"$DEVNAG  ${PREFIX}images.dn ${PREFIX}images.tex\n";
	}
    }
	%other_environments = ( %other_environments
		, "\$\$:\$\$", 'tr_devnag'
		, "\$:\$", 'devnag'
	) if ($prelatex =~ /\@dollar/ );
}

$verse_rx = "\\\\(?:begin|end)\\s*\\{\\s*(?:verse|quote|center)\\s*\\}\\s*";

sub do_env_pre_devnagri {
    local($_) = @_; 
    $_ = &revert_to_raw_tex($_);

    #if (/\\par\b/m) {
    if ($devn =~ /\\par\b|$verse_rx/s) {
	local(@paragraphs, @dn_processed, $this_par);
	local($par_start, $par_end) = ('<P', "</P>\n");
	$par_start .= (($USING_STYLE)? " CLASS=\"DEV\"":''). '>';
	#@paragraphs = (split(/\\par\b/, $_ ));
	@paragraphs = (split(/\\par\b|($verse_rx)/, $_ ));
	while (@paragraphs) {
	    $this_par = shift @paragraphs;
	    if ($this_par =~ /$verse_rx/) {
		$this_par .= shift @paragraphs;
		$this_par .= shift @paragraphs;
	    }
	    $this_par =~ s/\s$//;
	    if ($this_par =~ /^\s*$/) {
	        push(@dn_processed, "\n<P></P>\n");
	    } else {
	        $_ = &process_in_latex("<hindi>$this_par</hindi>");
	        push(@dn_processed
		    , &make_comment('DEVANAGARI', $this_par)
		    , $par_start , $_ , $par_end);
	    }
	}
	join('', @dn_processed );
    } else {
	local($comment);
	if (length($_) < $devnag_inline) {
	    $_ = &process_undefined_environment('tex2html_dng_inline'
	    , ++$global{'max_id'}, "<hindi>$_</hindi>");
	} else { 
	    $comment = join('', &make_comment('DEVANAGARI', $_),"\n");
	    $_ = &process_in_latex("<hindi>\n$_\n</hindi>")
	}
	if ($USING_STYLES) {
	    $env_style{'DEV'} = " " unless ($env_style{'DEV'});
	    join('', $comment, '<SPAN CLASS="DEV">', $_, '</SPAN>');
	} else { $comment . $_ }
    }
}
$begin_preprocessor{'devnagri'} = '<hindi>';
$end_preprocessor{'devnagri'} = '</hindi>';


sub do_env_pre_devnag {
    local($_) = @_; 
    $_ = &revert_to_raw_tex($_);

    #if (/\\par\b/m) {
    if ($devn =~ /\\par\b|$verse_rx/s) {
	local(@paragraphs, @dn_processed, $this_par);
	local($par_start, $par_end) = ('<P', "</P>\n");
	$par_start .= (($USING_STYLE)? " CLASS=\"DEV\"":''). '>';
	#@paragraphs = (split(/\\par\b/, $_ ));
	@paragraphs = (split(/\\par\b|($verse_rx)/, $_ ));
	while (@paragraphs) {
	    $this_par = shift @paragraphs;
	    if ($this_par =~ /$verse_rx/) {
		$this_par .= shift @paragraphs;
		$this_par .= shift @paragraphs;
	    }
	    $this_par =~ s/\s$//;
	    if ($this_par =~ /^\s*$/) {
	        push(@dn_processed, "\n<P></P>\n");
	    } else {
	        $_ = &process_in_latex("\\parbox\{\\textwidth\}\{$this_par\}");
	        push(@dn_processed
		    , &make_comment('DEVANAGARI', $this_par)
		    , $par_start , $_ , $par_end);
	    }
	}
	join('', @dn_processed );
    } else  {
	local($comment);
	if ((length($_) < $devnag_inline)||($_=~/\\\\/)) {
	    $_ = &process_undefined_environment('tex2html_dng_inline'
	    , ++$global{'max_id'}, "\{$_\}");
	} elsif ($_=~/\\\\|\|/s) { 
	    $devn = &process_undefined_environment('tex2html_dn_inpar'
	    , ++$global{'max_id'}, '\vbox{\let\\\\\\newline'."\n".$devn.'}');
	} else { 
	    $comment = join('', &make_comment('DEVANAGARI', $_),"\n");
	    $_ = &process_in_latex("\{$_\}")
	}
	if ($USING_STYLES) {
	    $env_style{'DEV'} = " " unless ($env_style{'DEV'});
	    join('', $comment, '<SPAN CLASS="DEV">', $_, '</SPAN>');
	} else { $comment . $_ }
    }
}
$begin_preprocessor{'devnag'} = "\{";
$end_preprocessor{'devnag'} = "\}";


sub do_env_pre_tr_devnagri { 
    local($_) = @_;
    open(DNTR,">dntr.tmp") || print "\n *** cannot open dntr.tmp ***" ;
    print DNTR "\$\$", &revert_to_raw_tex($_), "\$\$";
    close DNTR;
    &syswait("patc -p $PRE_FILTERS${dd}dng.pat dntr.tmp dntr.tmp1");
    &slurp_input_and_partition_and_pre_process('dntr.tmp1');
    unlink ('dntr.tmp', 'dntr.tmp1') unless $DEBUG;

    $_ = &translate_environments($_);
    $_ = &translate_commands($_);

    if ($USING_STYLES) {
        $env_style{'DEVRM'} = " " unless ($env_style{'DEVRM'});
        join('','<SPAN CLASS="DEVRM">', $_, '</SPAN>');
    } else { $_ }
}
$begin_preprocessor{'tr_devnag'} = '<hindi.transcription>';
$end_preprocessor{'tr_devnag'} = '</hindi>';


$image_switch_rx .= "|dn|(eight|nine|ten|eleven|twelve|fourteen|seventeen)dev";

$DNCURMF = '';
$DNCURRM = '';

sub do_cmd_dn { &process_dn('dn', @_ ) }

sub process_dn {
    local($dnsize, $_) = @_;
    if (($dnsize eq 'dn')&&($DNCURMF)) { $dnsize = "$DNCURRM\\dn" }
    local($devn) = &revert_to_raw_tex($_);
    my $is_dev_inline = '';

    if ($devn =~ /\\par\b|$verse_rx|\\(newline)/m) {
	$is_dev_inline = $1;
	local(@paragraphs, @dn_processed, $this_par);
	local($par_start, $par_end) = ('<P', "</P>\n");
	$par_start .= (($USING_STYLE)? " CLASS=\"DEV\"":''). '>';
	@paragraphs = (split(/\\par\b|($verse_rx)|\\newline\s*/, $devn ));
	while (@paragraphs) {
	    $this_par = shift @paragraphs;
	    if ($this_par =~ /$verse_rx/) {
		$this_par .= shift @paragraphs;
		$this_par .= shift @paragraphs;
		$is_dev_inline = 0;
	    } elsif ($this_par =~ /\\newline/) {
		# this should not happen;
		# It's not correct, as the first chunk gets <P> tags anyway
		push(@dn_processed, "<BR>\n");
		$this_par = shift @paragraphs;
	        $devn = &process_in_latex(
	        	"\\parbox\{\\textwidth\}\{\\$dnsize $this_par\}");
	        push(@dn_processed
		    , &make_comment('DEVANAGARI', $this_par)
		    , $devn);
		next;
	    }
	    $this_par =~ s/\s$//;
	    if ($this_par =~ /^\s*(\{\s*\})?$/) {
		if ($is_dev_inline) {
		    push(@dn_processed, "<BR>\n");
		} else {
	            push(@dn_processed, "\n<P></P>\n");
		}
	    } elsif ($is_dev_inline) {
		# assume text is inline, within some outer environment
	        $devn = &process_in_latex(
	        	"\\parbox\{\\textwidth\}\{\\$dnsize $this_par\}");
	        push(@dn_processed, $devn);
	    } else {
	        $devn = &process_in_latex(
	        	"\\parbox\{\\textwidth\}\{\\$dnsize $this_par\}");
	        push(@dn_processed
		    , &make_comment('DEVANAGARI', $this_par)
		    , $par_start , $devn , $par_end);
	    }
	}
	join('', @dn_processed );
    } else  {
	local($devn) = join('',"\{\\$dnsize\\, ", $devn, "}\\,");
	local($comment);
	if (length($devn) < $dn_inline) {
#print "\nprocess_dn_inline:\n$_\n";
	    $devn = &process_undefined_environment('tex2html_dn_inline'
	    , ++$global{'max_id'}, $devn);
	} elsif ($_=~/\\\\|\|/s) { 
#print "\nprocess_dn_inpar:\n$_\n";
	    $devn = &process_undefined_environment('tex2html_dn_inpar'
	    , ++$global{'max_id'}, '\vbox{\let\\\\\\newline'."\n".$devn.'}');
	} else { 
#print "\nprocess_dn latex:\n$_\n";
	    $comment = join('', &make_comment('DEVANAGARI',$devn),"\n");
	    $devn = &process_in_latex("\{$devn\}")
	}
	if ($USING_STYLES) {
	    $env_style{'DEV'} = " " unless ($env_style{'DEV'});
	    join('', $comment, '<SPAN CLASS="DEV">', $devn, '</SPAN>');
	} else { $comment . $devn }
    }
}

sub do_cmd_dnx { &do_cmd_dn(@_) }
sub do_cmd_eightdev { &process_dn('eightdev', @_) }
sub do_cmd_ninedev { &process_dn('ninedev', @_) }
sub do_cmd_tendev { &process_dn('tendev', @_) }
sub do_cmd_elevendev { &process_dn('elevendev', @_) }
sub do_cmd_twelvedev { &process_dn('twelvedev', @_) }
sub do_cmd_fourteendev { &process_dn('fourteendev', @_) }
sub do_cmd_seventeendev { &process_dn('seventeendev', @_) }

# these support size changes in Jeroen Hellingman's 
# Devanagari extension to his Malayalam-TeX
sub do_cmd_dnsmall { &set_dncurrm('smalldn', 'smallcr'); @_[0] }
sub do_cmd_dnnine { &set_dncurrm('ninedn', 'ninecr'); @_[0] }
sub do_cmd_dnnormal { &set_dncurrm('dvng', 'rm'); @_[0] }
sub do_cmd_dnhalf { &set_dncurrm('halfdn', 'halfcr'); @_[0] }
sub do_cmd_dnbig { &set_dncurrm('bigdn', 'bigcr'); @_[0] }
sub do_cmd_dnlarge { &set_dncurrm('largedn', 'largecr'); @_[0] }
sub do_cmd_dnhuge { &set_dncurrm('hugedn', 'hugecr'); @_[0] }

sub set_dncurrm { ($DNCURMF, $DNCURRM) = @_ }

sub do_cmd_dntr {
    local($_)= @_;
    local($ACCENT_IMAGES) = "dntr";
    $_ =~ s/^\s*//os;
    &translate_commands($_)
};

sub do_cmd_lii { &process_dn_accent('lii') .@_[0] }
sub do_cmd_rii { &process_dn_accent('rii') .@_[0] }
sub do_cmd_Lii { &process_dn_accent('Lii') .@_[0] }
sub do_cmd_Rii { &process_dn_accent('Rii') .@_[0] }
sub do_cmd_LII { &process_dn_accent('Lii') .@_[0] }
sub do_cmd_RII { &process_dn_accent('Rii') .@_[0] }
sub do_cmd_kh { &process_dn_accent('kh') .@_[0] }
sub do_cmd_Kh { &process_dn_accent('Kh') .@_[0] }
sub do_cmd_KH { &process_dn_accent('KH') .@_[0] }
sub do_cmd_g { &process_dn_accent('g') .@_[0] }
sub do_cmd_G { &process_dn_accent('G') .@_[0] }
sub do_cmd_ltwig { 
    local($_) = @_;
    local($next);
    $next = &missing_braces unless (
        (s/$next_pair_pr_rx/$next=$2;''/e)
        ||(s/$next_pair_rx/$next=$2;''/e));
    join('', &process_dn_accent("ltwig\{$next\}"), $_)
}

sub process_dn_accent{
    local($which) = @_;
    local($afterkern); $afterkern = '\\kern.15em' if ($which =~ /[lh]/i);
    &process_undefined_environment("tex2html_accent_inline",
        , ++$global{'max_id'} , "\{\\dntr\\$which$afterkern\}"); }



sub do_cmd_rn { 
    return(@_) unless $DNNUM;
    local($num, $rsize, $_) = ('', $DNCURRM, @_);
    $rsize = "\\".$rsize if ($rsize);
    $num = &missing_braces unless (
	(s/$next_pair_pr_rx/$num=$2;''/e)
	||(s/$next_pair_rx/$num=$2;''/e));
    join('', &process_in_latex("$rsize{\\dn $num}"), $_ );
}

sub do_cmd_rsize {
    print "\n *** error: \\rsize should not occur explicitly\n"; @_[0]}


&process_commands_nowrap_in_tex (<<_RAW_ARG_NOWRAP_CMDS_);
dnnum # \$DNNUM = 1
cmnum # \$DNNUM = 0
dnnormal
dnsmall
dnnine
dnhalf
dnbig
dnlarge
dnhuge
_RAW_ARG_NOWRAP_CMDS_


1;				# Not really necessary...



