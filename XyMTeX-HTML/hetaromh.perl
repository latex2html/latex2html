# $Id: hetaromh.perl,v 1.1 1998/08/24 09:48:48 RRM Exp $
#
#  hetaromh.perl   by Ross Moore <ross@mpce.mq.edu.au>
#
# This file is part of the LaTeX2HTML support for the XyM-TeX package
# for TeX and LaTeX by Shinsaku Fujita
#
# Change Log
# ==========
# $Log hetaromh.perl,v $
#

package main;

&do_require_package('chemstr');

&ignore_commands( <<_IGNORED_CMDS_);
iniflag
iniatom
#  <Six-Membered Heterocycles>
hbonda
hbondb
hbondc
hbondd
hbonde
hbondf
hbondvert
hbondverti
#    Setting skeletal bonds
hskbonda
hskbondf
hskbondc
hskbondd
hskbondb
hskbonde
hskbondvert
hskbondverti
#    Basic Macros
#sixheteroh # [] # {} # {}
#sixheterohi # [] # {} # {}
#    Application Macros
#pyridineh # [] # {}
#pyridinehi # [] # {}
#pyrazineh # [] # {}
#pyrimidineh # [] # {}
#pyrimidinehi # [] # {}
#pyridazineh # [] # {}
#pyridazinehi # [] # {}
#triazineh # [] # {}
#triazinehi # [] # {}
#  <Five-Membered Heterocycles>
#    Basic Macros
#fiveheteroh # [] # {} # {}
#fiveheterohi # [] # {} # {}
#    Application Macros
#pyrroleh # [] # {}
#pyrazoleh # [] # {}
#imidazoleh # [] # {}
#isoxazoleh # [] # {}
#oxazoleh # [] # {}
#pyrrolehi # [] # {}
#pyrazolehi # [] # {}
#imidazolehi # [] # {}
#isoxazolehi # [] # {}
#oxazolehi # [] # {}
#  <Six-Six-Fused Heterocycles>
#    Basic Macros
#decaheteroh # [] # {} # {}
#decaheterohi# [] # {} # {}
#    Application Macros
#quinolineh # [] # {}
#quinolinehi # [] # {}
#isoquinolineh # [] # {}
#isoquinolinehi # [] # {}
#quinoxalineh # [] # {}
#quinazolineh # [] # {}
#quinazolinehi # [] # {}
#cinnolineh # [] # {}
#cinnolinehi # [] # {}
#pteridineh # [] # {}
#pteridinehi # [] # {}
#  <Six-Five-Fused Heterocycles>
#    Basic Macros
#nonaheteroh # [] # {} # {}
#nonaheterohi # [] # {} # {}
#    Application Macros
#purineh # [] # {}
#purinehi # [] # {}
#indoleh # [] # {}
#indolehi # [] # {}
#indolizineh # [] # {}
#indolizinehi # [] # {}
#isoindoleh # [] # {}
#isoindolehi # [] # {}
#benzofuraneh # [] # {}
#benzofuranehi # [] # {}
#isobenzofuraneh # [] # {}
#isobenzofuranehi # [] # {}
#benzoxazoleh # [] # {}
#benzoxazolehi # [] # {}
#  <Building Units>
#sixunith # [] # {} # {} # {}
#fiveunith # [] # {} # {} # {}
#fiveunithi # [] # {} # {} # {}
_IGNORED_CMDS_


#
# Each command is treated as generating a separate inlined image.
#
# If this is inadequate for more complicated structures, then make
# use of the \begin{makeimage}...\end{makeimage} environment
# from the  html.sty  package.
#

&process_commands_in_tex ( <<_INLINE_CMDS_);
#  <Six-Membered Heterocycles>
#    Basic Macros
sixheteroh # [] # {} # {}
sixheterohi # [] # {} # {}
#    Application Macros
pyridineh # [] # {}
pyridinehi # [] # {}
pyrazineh # [] # {}
pyrimidineh # [] # {}
pyrimidinehi # [] # {}
pyridazineh # [] # {}
pyridazinehi # [] # {}
triazineh # [] # {}
triazinehi # [] # {}
#  <Five-Membered Heterocycles>
#    Basic Macros
fiveheteroh # [] # {} # {}
fiveheterohi # [] # {} # {}
#    Application Macros
pyrroleh # [] # {}
pyrazoleh # [] # {}
imidazoleh # [] # {}
isoxazoleh # [] # {}
oxazoleh # [] # {}
pyrrolehi # [] # {}
pyrazolehi # [] # {}
imidazolehi # [] # {}
isoxazolehi # [] # {}
oxazolehi # [] # {}
#  <Six-Six-Fused Heterocycles>
#    Basic Macros
decaheteroh # [] # {} # {}
decaheterohi# [] # {} # {}
#    Application Macros
quinolineh # [] # {}
quinolinehi # [] # {}
isoquinolineh # [] # {}
isoquinolinehi # [] # {}
quinoxalineh # [] # {}
quinazolineh # [] # {}
quinazolinehi # [] # {}
cinnolineh # [] # {}
cinnolinehi # [] # {}
pteridineh # [] # {}
pteridinehi # [] # {}
#  <Six-Five-Fused Heterocycles>
#    Basic Macros
nonaheteroh # [] # {} # {}
nonaheterohi # [] # {} # {}
#    Application Macros
purineh # [] # {}
purinehi # [] # {}
indoleh # [] # {}
indolehi # [] # {}
indolizineh # [] # {}
indolizinehi # [] # {}
isoindoleh # [] # {}
isoindolehi # [] # {}
benzofuraneh # [] # {}
benzofuranehi # [] # {}
isobenzofuraneh # [] # {}
isobenzofuranehi # [] # {}
benzoxazoleh # [] # {}
benzoxazolehi # [] # {}
#  <Building Units>
sixunith # [] # {} # {} # {}
fiveunith # [] # {} # {} # {}
fiveunithi # [] # {} # {} # {}
_INLINE_CMDS_

1;

