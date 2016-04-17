# $Id: hetarom.perl,v 1.1 1998/08/24 09:48:48 RRM Exp $
#
#  hetarom.perl   by Ross Moore <ross@mpce.mq.edu.au>
#
# This file is part of the LaTeX2HTML support for the XyM-TeX package
# for TeX and LaTeX by Shinsaku Fujita
#
# Change Log
# ==========
# $Log hetarom.perl,v $
#

package main;

&do_require_package('chemstr');

&ignore_commands( <<_IGNORED_CMDS_);
iniflag
iniatom
#  <Six-Membered Heterocycles>
bonda
bondb
bondc
bondd
bonde
bondf
bondhoriz
bondhorizi
#    Setting skeletal bonds
skbonda
skbondf
skbondc
skbondd
skbondb
skbonde
skbondhoriz
skbondhorizi
#    Basic Macros
#sixheterov # [] # {} # {}
#sixheterovi # [] # {} # {}
#    Application Macros
#pyridinev # [] # {}
#pyridinevi # [] # {}
#pyrazinev # [] # {}
#pyrimidinev # [] # {}
#pyrimidinevi # [] # {}
#pyridazinev # [] # {}
#pyridazinevi # [] # {}
#triazinev # [] # {}
#triazinevi # [] # {}
#  <Five-Membered Heterocycles>
#    Basic Macros
#fiveheterov # [] # {} # {}
#fiveheterovi # [] # {} # {}
#    Application Macros
#pyrrolev # [] # {}
#pyrazolev # [] # {}
#imidazolev # [] # {}
#isoxazolev # [] # {}
#oxazolev # [] # {}
#pyrrolevi # [] # {}
#pyrazolevi # [] # {}
#imidazolevi # [] # {}
#isoxazolevi # [] # {}
#oxazolevi # [] # {}
#  <Six-Six-Fused Heterocycles>
#    Basic Macros
#decaheterov # [] # {} # {}
#decaheterovi# [] # {} # {}
#    Application Macros
#quinolinev # [] # {}
#quinolinevi # [] # {}
#isoquinolinev # [] # {}
#isoquinolinevi # [] # {}
#quinoxalinev # [] # {}
#quinazolinev # [] # {}
#quinazolinevi # [] # {}
#cinnolinev # [] # {}
#cinnolinevi # [] # {}
#pteridinev # [] # {}
#pteridinevi # [] # {}
#  <Six-Five-Fused Heterocycles>
#    Basic Macros
#nonaheterov # [] # {} # {}
#nonaheterovi # [] # {} # {}
#    Application Macros
#purinev # [] # {}
#purinevi # [] # {}
#indolev # [] # {}
#indolevi # [] # {}
#indolizinev # [] # {}
#indolizinevi # [] # {}
#isoindolev # [] # {}
#isoindolevi # [] # {}
#benzofuranev # [] # {}
#benzofuranevi # [] # {}
#isobenzofuranev # [] # {}
#isobenzofuranevi # [] # {}
#benzoxazolev # [] # {}
#benzoxazolevi # [] # {}
#  <Four-Membered Heterocycles>
#    Setting bonds
bondshoriz
skbondshoriz
#    Basic Macros
#fourhetero # [] # {} # {}
#    Setting inner double bonds
bondtria
bondtrib
skbondtria
skbondtrib
#    Basic Macros
#threehetero # [] # {} # {}
#  <Building Units>
#sixunitv # [] # {} # {} # {}
#fiveunitv # [] # {} # {} # {}
#fiveunitvi # [] # {} # {} # {}
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
sixheterov # [] # {} # {}
sixheterovi # [] # {} # {}
#    Application Macros
pyridinev # [] # {}
pyridinevi # [] # {}
pyrazinev # [] # {}
pyrimidinev # [] # {}
pyrimidinevi # [] # {}
pyridazinev # [] # {}
pyridazinevi # [] # {}
triazinev # [] # {}
triazinevi # [] # {}
#  <Five-Membered Heterocycles>
#    Basic Macros
fiveheterov # [] # {} # {}
fiveheterovi # [] # {} # {}
#    Application Macros
pyrrolev # [] # {}
pyrazolev # [] # {}
imidazolev # [] # {}
isoxazolev # [] # {}
oxazolev # [] # {}
pyrrolevi # [] # {}
pyrazolevi # [] # {}
imidazolevi # [] # {}
isoxazolevi # [] # {}
oxazolevi # [] # {}
#  <Six-Six-Fused Heterocycles>
#    Basic Macros
decaheterov # [] # {} # {}
decaheterovi# [] # {} # {}
#    Application Macros
quinolinev # [] # {}
quinolinevi # [] # {}
isoquinolinev # [] # {}
isoquinolinevi # [] # {}
quinoxalinev # [] # {}
quinazolinev # [] # {}
quinazolinevi # [] # {}
cinnolinev # [] # {}
cinnolinevi # [] # {}
pteridinev # [] # {}
pteridinevi # [] # {}
#  <Six-Five-Fused Heterocycles>
#    Basic Macros
nonaheterov # [] # {} # {}
nonaheterovi # [] # {} # {}
#    Application Macros
purinev # [] # {}
purinevi # [] # {}
indolev # [] # {}
indolevi # [] # {}
indolizinev # [] # {}
indolizinevi # [] # {}
isoindolev # [] # {}
isoindolevi # [] # {}
benzofuranev # [] # {}
benzofuranevi # [] # {}
isobenzofuranev # [] # {}
isobenzofuranevi # [] # {}
benzoxazolev # [] # {}
benzoxazolevi # [] # {}
#    Basic Macros
fourhetero # [] # {} # {}
threehetero # [] # {} # {}
#  <Building Units>
sixunitv # [] # {} # {} # {}
fiveunitv # [] # {} # {} # {}
fiveunitvi # [] # {} # {} # {}
_INLINE_CMDS_

1;

