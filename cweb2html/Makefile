# $Id: Makefile,v 1.4 1999/12/22 19:38:55 JCL Exp $
#
# Makefile for the CWEB2HTML translator
#   for use on Unix-like operating systems such as Linux only!
#
################################################################################
# Copyright 1998-1999 by Jens Lippmann (lippmann@rbg.informatik.tu-darmstadt.de)
#
# Permission to use, copy, modify, and distribute this software for any
# purpose and without fee is hereby granted, provided that the above
# copyright notice appears in all copies. This software is provided "as is"
# and without any express or implied warranties.
#
################################################################################


#
# Configure:
# This tells where latex2html can be found.
#LATEX2HTML=/usr/local/bin/latex2html
LATEX2HTML=$$HOME/bin/latex2html

#
# Configure:
# This tells where latex2html can be found.
CWEB2HTML=/home/lippmann/latex2html/user/cweb2html/cweb2html

#
# Optional:
# This will appear at every invocation of LaTeX2HTML.
# You could say "-init_file my_init.pl", "-debug", etc.
LATEX2HTMLFLAGS= -nosubdir #-debug

#
# Optional:
# You could use this to set options for CWEB2HTML
CWEB2HTMLFLAGS=


#
# No need for customization below except you want to tune up the Makefile.
#

PERL=perl
PERLFLAGS=
# get the working directory name with this:
PWD=/bin/pwd
# remove files and directories with this
RM=/bin/rm -f
RMDIR=/bin/rmdir
# copy files with this
CP=/bin/cp


LATEX=latex
BIBTEX=bibtex

CWEAVE=cweave
CTANGLE=ctangle

L2HCOMPILE=$(PERL) $(PERLFLAGS) $(LATEX2HTML) $(LATEX2HTMLFLAGS)
C2HCOMPILE=$(PERL) $(PERLFLAGS) $(CWEB2HTML) $(CWEB2HTMLFLAGS)

HTMLDIR=html.obj
DVIDIR=dvi.obj
TEXDIR=tex.obj
CDIR=c.obj

#
# The rules below are structurized to ease introduction of new CWEB files.
# Simply add new file here, and type ``make Makefile'', then ``make''.
#

FILES=	wcltx\
	linkex1\
	linkex2\
	#more_files

default:: wcltx.html

all:: html

html:: $(FILES:%=%.html)

dvi:: $(FILES:%=%.dvi)

tex:: $(FILES:%=%.tex)

c:: $(FILES:%=%.c)



$(HTMLDIR):
	mkdir $(HTMLDIR)

$(DVIDIR):
	mkdir $(DVIDIR)

$(TEXDIR):
	mkdir $(TEXDIR)

$(CDIR):
	mkdir $(CDIR)

clean:: $(FILES:%=%.clean)
	-$(RMDIR) $(CDIR) $(TEXDIR) $(DVIDIR) $(HTMLDIR)

help::	$(FILES:%=%.help)
	@echo;\
	echo "Targets available for this Makefile:";\
	echo "html  -- generate HTML out of all files";\
	echo "dvi   -- generate DVI out of all files";\
	echo "tex   -- generate TEX out of all files";\
	echo "c     -- generate C out of all files";\
	echo "clean -- remove all generated objects"

Makefile::
	$(PERL) $(PERLFLAGS) makemake.pl Makefile FILE

###BEGIN TEMPLATE###
FILE.html: $(TEXDIR) $(DVIDIR) \
	    $(HTMLDIR) $(HTMLDIR)/FILE $(HTMLDIR)/FILE/FILE.html
	@echo $(HTMLDIR)/FILE/FILE.html is up to date...

$(HTMLDIR)/FILE.html: $(HTMLDIR)/FILE $(HTMLDIR)/FILE/FILE.html
	@echo $(HTMLDIR)/FILE/FILE.html is up to date...

$(HTMLDIR)/FILE:
	-mkdir $(HTMLDIR)/FILE

# Technical hints:

# - We must copy the TeX source to the work directory since former
#   l2h versions do not interprete TEXINPUTS to determine the source
#   directory.
#   Further, providing a TeX source file with path prefix will cause
#   former versions of l2h to generate the output in the directory
#   determined by this prefix.
#   Eg. latex2html /path/to/TEXDIR/FILE.tex causes HTML files to be
#   generated in /path/to/TEXDIR, which isn't desired here.
# - We must copy the .aux and .bbl file due to the same fact that
#   they aren't located through TEXINPUTS.
# - We must copy each .perl translation to the work directory in
#   order to be found (another possibility is to put them into the
#   styles directory of LATEX2HTMLDIR defined in latex2html.config,
#   or to set up LATEX2HTMLSTYLES, but we assume this is not done yet.
#
$(HTMLDIR)/FILE/FILE.html: $(DVIDIR)/FILE.dvi
	-$(CP) *.tex *.perl\
	 $(TEXDIR)/FILE.tex $(DVIDIR)/FILE.aux $(DVIDIR)/FILE.bbl\
	 $(HTMLDIR)/FILE
	DIR=`cd $(TEXDIR);$(PWD)`;\
	TEXINPUTS="`$(PWD)`:.:`cd $(TEXDIR);$(PWD)`:$$TEXINPUTS";\
	export TEXINPUTS;\
	cd $(HTMLDIR)/FILE;\
	$(L2HCOMPILE) FILE.tex;\
	$(RM) *.perl *.tex FILE.aux FILE.bbl

FILE.clean:: $(HTMLDIR) $(HTMLDIR)/FILE
	-$(RM) $(HTMLDIR)/FILE/.[a-zA-Z]* $(HTMLDIR)/FILE/?*;\
	$(RM) -r $(HTMLDIR)/FILE/TMP;\
	$(RMDIR) $(HTMLDIR)/FILE


FILE.dvi: $(TEXDIR) $(DVIDIR) $(DVIDIR)/FILE.dvi
	@echo $(DVIDIR)/FILE.dvi is up to date...

$(DVIDIR)/FILE.dvi: $(TEXDIR)/FILE.tex
	-$(C2HCOMPILE) -dest_dir $(TEXDIR) $(TEXDIR)/FILE.tex\
	               $(TEXDIR)/FILE.scn;\
	TEXINPUTS="`$(PWD)`:.:`cd $(TEXDIR);$(PWD)`:$$TEXINPUTS";\
	export TEXINPUTS;\
	BIBINPUTS="`$(PWD)`:$$BIBINPUTS"; export BIBINPUTS;\
	cd $(DVIDIR);\
	$(LATEX) FILE.tex;\
	$(BIBTEX) FILE;\
	$(LATEX) FILE.tex;\
	$(LATEX) FILE.tex
#or use tex-it of Schrod's cweb-sty package: tex-it $(LATEX) FILE

FILE.clean:: $(DVIDIR)
	-$(RM) $(DVIDIR)/FILE.*


FILE.tex: $(TEXDIR) $(TEXDIR)/FILE.tex
	@echo $(TEXDIR)/FILE.tex is up to date...

$(TEXDIR)/FILE.tex: FILE.w
	CWEBINPUTS="`$(PWD)`"; export CWEBINPUTS;\
	cd $(TEXDIR); ln -s $$CWEBINPUTS/FILE.w .;\
	$(CWEAVE) FILE.w;\
	$(RM) FILE.w

FILE.clean:: $(TEXDIR)
	-$(RM) $(TEXDIR)/FILE.*


FILE.c: $(CDIR) $(CDIR)/FILE.c
	@echo $(CDIR)/FILE.c is up to date...

$(CDIR)/FILE.c: FILE.w
	CWEBINPUTS="`$(PWD)`"; export CWEBINPUTS;\
	echo CWEBINPUTS=$$CWEBINPUTS;\
	cd $(CDIR);\
	$(CTANGLE) $$CWEBINPUTS/FILE.w

FILE.clean:: $(CDIR)
	-$(RM) $(CDIR)/FILE.*

FILE.help::
	@echo;\
	echo "Targets available for file FILE:";\
	echo "FILE.html  -- generate HTML out of FILE.w";\
	echo "FILE.dvi   -- generate DVI out of FILE.w";\
	echo "FILE.tex   -- generate TEX out of FILE.w";\
	echo "FILE.c     -- generate C out of FILE.w";\
	echo "FILE.clean -- remove generated objects"

###END TEMPLATE###

# The contents following here is automatically replaced with above
# template for every entry found in the FILES macro.
# If you need to change something below, be aware that this is thrown
# away the next time you type ``make Makefile''.
# To get more resident results you might want to edit above template.

###DO NOT EDIT BELOW THIS LINE###
wcltx.html: $(TEXDIR) $(DVIDIR) \
	    $(HTMLDIR) $(HTMLDIR)/wcltx $(HTMLDIR)/wcltx/wcltx.html
	@echo $(HTMLDIR)/wcltx/wcltx.html is up to date...

$(HTMLDIR)/wcltx.html: $(HTMLDIR)/wcltx $(HTMLDIR)/wcltx/wcltx.html
	@echo $(HTMLDIR)/wcltx/wcltx.html is up to date...

$(HTMLDIR)/wcltx:
	-mkdir $(HTMLDIR)/wcltx


$(HTMLDIR)/wcltx/wcltx.html: $(DVIDIR)/wcltx.dvi
	-$(CP) *.tex *.perl\
	 $(TEXDIR)/wcltx.tex $(DVIDIR)/wcltx.aux $(DVIDIR)/wcltx.bbl\
	 $(HTMLDIR)/wcltx
	DIR=`cd $(TEXDIR);$(PWD)`;\
	TEXINPUTS="`$(PWD)`:.:`cd $(TEXDIR);$(PWD)`:$$TEXINPUTS";\
	export TEXINPUTS;\
	cd $(HTMLDIR)/wcltx;\
	$(L2HCOMPILE) wcltx.tex;\
	$(RM) *.perl *.tex wcltx.aux wcltx.bbl

wcltx.clean:: $(HTMLDIR) $(HTMLDIR)/wcltx
	-$(RM) $(HTMLDIR)/wcltx/.[a-zA-Z]* $(HTMLDIR)/wcltx/?*;\
	$(RM) -r $(HTMLDIR)/wcltx/TMP;\
	$(RMDIR) $(HTMLDIR)/wcltx


wcltx.dvi: $(TEXDIR) $(DVIDIR) $(DVIDIR)/wcltx.dvi
	@echo $(DVIDIR)/wcltx.dvi is up to date...

$(DVIDIR)/wcltx.dvi: $(TEXDIR)/wcltx.tex
	-$(C2HCOMPILE) -dest_dir $(TEXDIR) $(TEXDIR)/wcltx.tex\
	               $(TEXDIR)/wcltx.scn;\
	TEXINPUTS="`$(PWD)`:.:`cd $(TEXDIR);$(PWD)`:$$TEXINPUTS";\
	export TEXINPUTS;\
	BIBINPUTS="`$(PWD)`:$$BIBINPUTS"; export BIBINPUTS;\
	cd $(DVIDIR);\
	$(LATEX) wcltx.tex;\
	$(BIBTEX) wcltx;\
	$(LATEX) wcltx.tex;\
	$(LATEX) wcltx.tex

wcltx.clean:: $(DVIDIR)
	-$(RM) $(DVIDIR)/wcltx.*


wcltx.tex: $(TEXDIR) $(TEXDIR)/wcltx.tex
	@echo $(TEXDIR)/wcltx.tex is up to date...

$(TEXDIR)/wcltx.tex: wcltx.w
	CWEBINPUTS="`$(PWD)`"; export CWEBINPUTS;\
	cd $(TEXDIR); ln -s $$CWEBINPUTS/wcltx.w .;\
	$(CWEAVE) wcltx.w;\
	$(RM) wcltx.w

wcltx.clean:: $(TEXDIR)
	-$(RM) $(TEXDIR)/wcltx.*


wcltx.c: $(CDIR) $(CDIR)/wcltx.c
	@echo $(CDIR)/wcltx.c is up to date...

$(CDIR)/wcltx.c: wcltx.w
	CWEBINPUTS="`$(PWD)`"; export CWEBINPUTS;\
	echo CWEBINPUTS=$$CWEBINPUTS;\
	cd $(CDIR);\
	$(CTANGLE) $$CWEBINPUTS/wcltx.w

wcltx.clean:: $(CDIR)
	-$(RM) $(CDIR)/wcltx.*

wcltx.help::
	@echo;\
	echo "Targets available for file wcltx:";\
	echo "wcltx.html  -- generate HTML out of wcltx.w";\
	echo "wcltx.dvi   -- generate DVI out of wcltx.w";\
	echo "wcltx.tex   -- generate TEX out of wcltx.w";\
	echo "wcltx.c     -- generate C out of wcltx.w";\
	echo "wcltx.clean -- remove generated objects"


linkex1.html: $(TEXDIR) $(DVIDIR) \
	    $(HTMLDIR) $(HTMLDIR)/linkex1 $(HTMLDIR)/linkex1/linkex1.html
	@echo $(HTMLDIR)/linkex1/linkex1.html is up to date...

$(HTMLDIR)/linkex1.html: $(HTMLDIR)/linkex1 $(HTMLDIR)/linkex1/linkex1.html
	@echo $(HTMLDIR)/linkex1/linkex1.html is up to date...

$(HTMLDIR)/linkex1:
	-mkdir $(HTMLDIR)/linkex1


$(HTMLDIR)/linkex1/linkex1.html: $(DVIDIR)/linkex1.dvi
	-$(CP) *.tex *.perl\
	 $(TEXDIR)/linkex1.tex $(DVIDIR)/linkex1.aux $(DVIDIR)/linkex1.bbl\
	 $(HTMLDIR)/linkex1
	DIR=`cd $(TEXDIR);$(PWD)`;\
	TEXINPUTS="`$(PWD)`:.:`cd $(TEXDIR);$(PWD)`:$$TEXINPUTS";\
	export TEXINPUTS;\
	cd $(HTMLDIR)/linkex1;\
	$(L2HCOMPILE) linkex1.tex;\
	$(RM) *.perl *.tex linkex1.aux linkex1.bbl

linkex1.clean:: $(HTMLDIR) $(HTMLDIR)/linkex1
	-$(RM) $(HTMLDIR)/linkex1/.[a-zA-Z]* $(HTMLDIR)/linkex1/?*;\
	$(RM) -r $(HTMLDIR)/linkex1/TMP;\
	$(RMDIR) $(HTMLDIR)/linkex1


linkex1.dvi: $(TEXDIR) $(DVIDIR) $(DVIDIR)/linkex1.dvi
	@echo $(DVIDIR)/linkex1.dvi is up to date...

$(DVIDIR)/linkex1.dvi: $(TEXDIR)/linkex1.tex
	-$(C2HCOMPILE) -dest_dir $(TEXDIR) $(TEXDIR)/linkex1.tex\
	               $(TEXDIR)/linkex1.scn;\
	TEXINPUTS="`$(PWD)`:.:`cd $(TEXDIR);$(PWD)`:$$TEXINPUTS";\
	export TEXINPUTS;\
	BIBINPUTS="`$(PWD)`:$$BIBINPUTS"; export BIBINPUTS;\
	cd $(DVIDIR);\
	$(LATEX) linkex1.tex;\
	$(BIBTEX) linkex1;\
	$(LATEX) linkex1.tex;\
	$(LATEX) linkex1.tex

linkex1.clean:: $(DVIDIR)
	-$(RM) $(DVIDIR)/linkex1.*


linkex1.tex: $(TEXDIR) $(TEXDIR)/linkex1.tex
	@echo $(TEXDIR)/linkex1.tex is up to date...

$(TEXDIR)/linkex1.tex: linkex1.w
	CWEBINPUTS="`$(PWD)`"; export CWEBINPUTS;\
	cd $(TEXDIR); ln -s $$CWEBINPUTS/linkex1.w .;\
	$(CWEAVE) linkex1.w;\
	$(RM) linkex1.w

linkex1.clean:: $(TEXDIR)
	-$(RM) $(TEXDIR)/linkex1.*


linkex1.c: $(CDIR) $(CDIR)/linkex1.c
	@echo $(CDIR)/linkex1.c is up to date...

$(CDIR)/linkex1.c: linkex1.w
	CWEBINPUTS="`$(PWD)`"; export CWEBINPUTS;\
	echo CWEBINPUTS=$$CWEBINPUTS;\
	cd $(CDIR);\
	$(CTANGLE) $$CWEBINPUTS/linkex1.w

linkex1.clean:: $(CDIR)
	-$(RM) $(CDIR)/linkex1.*

linkex1.help::
	@echo;\
	echo "Targets available for file linkex1:";\
	echo "linkex1.html  -- generate HTML out of linkex1.w";\
	echo "linkex1.dvi   -- generate DVI out of linkex1.w";\
	echo "linkex1.tex   -- generate TEX out of linkex1.w";\
	echo "linkex1.c     -- generate C out of linkex1.w";\
	echo "linkex1.clean -- remove generated objects"


linkex2.html: $(TEXDIR) $(DVIDIR) \
	    $(HTMLDIR) $(HTMLDIR)/linkex2 $(HTMLDIR)/linkex2/linkex2.html
	@echo $(HTMLDIR)/linkex2/linkex2.html is up to date...

$(HTMLDIR)/linkex2.html: $(HTMLDIR)/linkex2 $(HTMLDIR)/linkex2/linkex2.html
	@echo $(HTMLDIR)/linkex2/linkex2.html is up to date...

$(HTMLDIR)/linkex2:
	-mkdir $(HTMLDIR)/linkex2


$(HTMLDIR)/linkex2/linkex2.html: $(DVIDIR)/linkex2.dvi
	-$(CP) *.tex *.perl\
	 $(TEXDIR)/linkex2.tex $(DVIDIR)/linkex2.aux $(DVIDIR)/linkex2.bbl\
	 $(HTMLDIR)/linkex2
	DIR=`cd $(TEXDIR);$(PWD)`;\
	TEXINPUTS="`$(PWD)`:.:`cd $(TEXDIR);$(PWD)`:$$TEXINPUTS";\
	export TEXINPUTS;\
	cd $(HTMLDIR)/linkex2;\
	$(L2HCOMPILE) linkex2.tex;\
	$(RM) *.perl *.tex linkex2.aux linkex2.bbl

linkex2.clean:: $(HTMLDIR) $(HTMLDIR)/linkex2
	-$(RM) $(HTMLDIR)/linkex2/.[a-zA-Z]* $(HTMLDIR)/linkex2/?*;\
	$(RM) -r $(HTMLDIR)/linkex2/TMP;\
	$(RMDIR) $(HTMLDIR)/linkex2


linkex2.dvi: $(TEXDIR) $(DVIDIR) $(DVIDIR)/linkex2.dvi
	@echo $(DVIDIR)/linkex2.dvi is up to date...

$(DVIDIR)/linkex2.dvi: $(TEXDIR)/linkex2.tex
	-$(C2HCOMPILE) -dest_dir $(TEXDIR) $(TEXDIR)/linkex2.tex\
	               $(TEXDIR)/linkex2.scn;\
	TEXINPUTS="`$(PWD)`:.:`cd $(TEXDIR);$(PWD)`:$$TEXINPUTS";\
	export TEXINPUTS;\
	BIBINPUTS="`$(PWD)`:$$BIBINPUTS"; export BIBINPUTS;\
	cd $(DVIDIR);\
	$(LATEX) linkex2.tex;\
	$(BIBTEX) linkex2;\
	$(LATEX) linkex2.tex;\
	$(LATEX) linkex2.tex

linkex2.clean:: $(DVIDIR)
	-$(RM) $(DVIDIR)/linkex2.*


linkex2.tex: $(TEXDIR) $(TEXDIR)/linkex2.tex
	@echo $(TEXDIR)/linkex2.tex is up to date...

$(TEXDIR)/linkex2.tex: linkex2.w
	CWEBINPUTS="`$(PWD)`"; export CWEBINPUTS;\
	cd $(TEXDIR); ln -s $$CWEBINPUTS/linkex2.w .;\
	$(CWEAVE) linkex2.w;\
	$(RM) linkex2.w

linkex2.clean:: $(TEXDIR)
	-$(RM) $(TEXDIR)/linkex2.*


linkex2.c: $(CDIR) $(CDIR)/linkex2.c
	@echo $(CDIR)/linkex2.c is up to date...

$(CDIR)/linkex2.c: linkex2.w
	CWEBINPUTS="`$(PWD)`"; export CWEBINPUTS;\
	echo CWEBINPUTS=$$CWEBINPUTS;\
	cd $(CDIR);\
	$(CTANGLE) $$CWEBINPUTS/linkex2.w

linkex2.clean:: $(CDIR)
	-$(RM) $(CDIR)/linkex2.*

linkex2.help::
	@echo;\
	echo "Targets available for file linkex2:";\
	echo "linkex2.html  -- generate HTML out of linkex2.w";\
	echo "linkex2.dvi   -- generate DVI out of linkex2.w";\
	echo "linkex2.tex   -- generate TEX out of linkex2.w";\
	echo "linkex2.c     -- generate C out of linkex2.w";\
	echo "linkex2.clean -- remove generated objects"


