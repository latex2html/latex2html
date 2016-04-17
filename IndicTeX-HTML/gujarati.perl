# $Id: gujarati.perl,v 1.1 1998/02/03 05:26:55 RRM Exp $
# GUJRATHI.PERL by Ross Moore <ross@mpce.mq.edu.au> 17-1-98
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
# This package requires the corresponding LaTeX package:  gujarati.sty .
# It also requiress:  indica.perl  and   indica.sty .
#
# With LaTeX2HTML the options on the \usepackage line specify 
# preprocessor commands to use with Indica.
#
# Usage:
#
#  \usepackage{gujarati}            %|  pre-process source using Indica
#  \usepackage[indica]{gujarati}    %|  with  #ALIAS GUJARATI G
#  \usepackage[preprocess]{gujarati}%|  and   #ALIAS NIL N
#
#  \usepackage[guj]{gujarati}       %| also use #ALIAS GUJARATI GUJ
#
#
#  options affecting Input-forms
#
#  \usepackage[7bit]{gujarati}    %|  Velthuis' Hindi/Sanskri transcription
#  \usepackage[csx]{gujarati}     %|  8-bit Sanskrit extension of ISO 646
#  \usepackage[latex]{gujarati}   %|  standardized LaTeX transcription form
#  \usepackage[unicode]{gujarati} %|  ISO 10646-1 + Sinhalese extension
#  \usepackage[samanala]{gujarati}%|  Prasad Dharmasena's transliteration
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
# $Log: gujarati.perl,v $
# Revision 1.1  1998/02/03 05:26:55  RRM
#  --  changed name from  gujrathi.sty  and  gujrathi.perl
#
#

package main;


# preprocessor: indica
sub do_gujarati_indica { &do_indica_gujarathi() }
sub do_gujarati_preprocess { &do_indica_gujarathi() }
sub do_gujarati_guj { &do_indica_guj() }

# input modes
sub do_gujarati_7bit { &do_indica_7bit() }
sub do_gujarati_csx { &do_indica_csx() }
sub do_gujarati_latex { &do_indica_latex() }
sub do_gujarati_unicode { &do_indica_unicode() }
sub do_gujarati_samanala { &do_indica_samanala() }


# load Indica for #GUJARATI

&do_require_package('indica'); 
if (defined &do_indica_gujarathi) {
    &do_indica_gujarathi()
} else { die "\n indica.perl was not loaded, sorry" }

# override Indica variables here
#
#  $INDICA = 'indica';
#  $INDICA_MODE = 'sevenbit';


1;				# Not really necessary...



