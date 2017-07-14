#
#  Makefile  for the...
#
#    LaTeX2HTML  documentation & User Manual
#
#  by  Ross Moore <ross@maths.mq.edu.au>
#  and  Herb Swan <dprhws@edp.Arco.COM>
#
#  20 April 1996
#
#  modified for v97.1 by  Ross Moore
#
#  10 July 1997
#

#
# These are the usual calls to application programs
#
DVIPS = dvips
DVIPDF = dvipdf
# set TEXINPUTS to use the html.sty included in this package
LATEX = TEXINPUTS=../texinputs:: latex
MAKEINDEX = makeindex
BIBTEX = bibtex

# L2H = latex2html  -no_math -html_version 3.2,math -scalable_fonts
L2H = latex2html  -no_math -html_version 4.0,math


#
# ... however some TeX installations require more,
# to set path-variables before calling other scripts.
# For example...
#
TEXMF = /usr/lib/texmf

LATEXINPUTDIR = $(TEXMF)/tex/latex//
PKFONTDIR = $(TEXMF)/fonts/public//pk/cx//
BSTINPUTS = $(TEXMF)/bibtex/bst

#DVIPS     = PKFONTS=.:$(TEXMF)/fonts/public//pk/cx// $(TEXMF)/bin/dvips
#LATEX     = TEXFONTS=.:$(PKFONTDIR):$$TEXFONTS;TEXINPUTS=.:$(LATEXINPUTDIR);latex
#BIBTEX    = set BSTINPUTS .:$(BSTINPUTS);bibtex



TOP	= manual
LIC	= licence
CRE	= credits
DAT	= l2hfiles.dat
OVW	= overview
SUP	= support
ENV	= features
HYP	= hypextra
MAN	= userman
PRO	= problems
CHA	= changes
INT	= internals.pl
IND	= index.pl
FIG	= figure.pl
TAB	= table.pl
TOPTITLE  = "LaTeX2HTML"
S1TITLE	  = "Overview"
S2TITLE	  = "Installation"
#S3TITLE	  = "User_Manual"
S3TITLE	  = "Environments_and_Special_Features"
S4TITLE   = "Hypertext_Extensions"
#S5TITLE   = "Features"
S5TITLE   = "Customising_the_Layout"
S6TITLE   = "Problems"
S7TITLE   = "Changes"
CHGTITLE   = "Changes"
CONTENTS = "node6"
CHGNODE = "node8"
REFNODE = "node9"
GLOSSNODE = "node10"
INDEXNODE = "node11"
BIBLIO	= "Bibliography"
GLOSS	= "Glossary"



COMMON	  = -external_file $(TOP) -dir $(TOP) -info 0 -short_index \
		-contents $(CONTENTS).html -index $(INDEXNODE).html \
		-biblio $(REFNODE) -no_auto_link -no_footnode \
		-split 6 -link 6 -up_url $(TOP).html -up_title $(TOPTITLE)

LTOP	  =  -short_index -split 4 -link 5 -no_auto_link\
		 -t $(TOPTITLE) $(TOP).tex

LSEC1	  = $(COMMON) -prefix O  \
		-prev_url $(TOP).html -prev_title $(TOPTITLE) \
		-down_url $(SUP).html -down_title $(S2TITLE)  $(OVW).tex

LSEC2	  = $(COMMON) -prefix S  -debug \
		-prev_url $(OVW).html -prev_title $(S1TITLE) \
		-down_url $(ENV).html -down_title $(S3TITLE)  $(SUP).tex

#		-down_url $(MAN).html -down_title $(S3TITLE)  $(SUP).tex

LSEC3	  = $(COMMON) -prefix E \
		-prev_url ../$(TOP)/$(SUP).html -prev_title $(S2TITLE) \
		-down_url ../$(TOP)/$(HYP).html -down_title $(S4TITLE)  $(ENV).tex

#		-down_url ../$(TOP)/$(HYP).html -down_title $(S4TITLE)  $(MAN).tex

LSEC4	  = $(COMMON) -prefix H \
		-prev_url ../$(TOP)/$(ENV).html -prev_title $(S3TITLE) \
		-down_url ../$(TOP)/$(MAN).html -down_title $(S5TITLE)  $(HYP).tex

#		-prev_url ../$(TOP)/$(MAN).html -prev_title $(S3TITLE) \
#		-down_url ../$(TOP)/$(FEA).html -down_title $(S5TITLE)  $(HYP).tex

LSEC5	  = $(COMMON) -prefix M \
		-prev_url ../$(TOP)/$(HYP).html -prev_title $(S4TITLE) \
		-down_url ../$(TOP)/$(PRO).html -down_title $(S6TITLE)  $(MAN).tex

#		-down_url ../$(TOP)/$(PRO).html -down_title $(S6TITLE)  $(FEA).tex

LSEC6	  = $(COMMON) -prefix P \
		-prev_url ../$(TOP)/$(MAN).html -prev_title $(S5TITLE) \
		-down_url ../$(TOP)/$(REFNODE).html -down_title $(BIBLIO)  $(PRO).tex

#		-prev_url ../$(TOP)/$(FEA).html -prev_title $(S5TITLE) \

#		-down_url ../$(TOP)/$(CHGNODE).html -down_title $(CHGTITLE)  $(PRO).tex


LSEC7	  = $(COMMON) -prefix C -dir $(TOP)  -info 0  \
		-prev_url ../$(TOP)/$(PRO).html -prev_title $(S6TITLE) \
		-down_url ../$(TOP)/$(GLOSSNODE).html -down_title $(GLOSS)  $(CHA).tex


#
#  dvi- and  PostScript versions
#

manual.pdf:      manual.dvi
	$(DVIPDF) manual.dvi $@

manual.ps:      manual.dvi
	$(DVIPS) manual.dvi -o $@

manual.aux manual.cb: \
	    manual.tex credits.tex licence.tex overview.tex \
	    support.tex userman.tex hypextra.tex features.tex \
	    problems.tex l2hfiles.dat  manhtml.tex l2hman.sty
	$(LATEX) manual.tex
	$(LATEX) manual.tex

manual.glo manual.idx: \
	    manual.tex credits.tex licence.tex overview.tex \
	    support.tex userman.tex hypextra.tex features.tex \
	    problems.tex l2hfiles.dat  manhtml.tex l2hman.sty
	$(LATEX) manual.tex

manual.dvi:     manual.aux manual.ind manual.gls manual.cb
	$(LATEX) manual.tex

manual.ind:     manual.idx
	$(MAKEINDEX) -s l2hidx.ist manual.idx

manual.gls:     manual.glo l2hglo.ist
	$(MAKEINDEX) -o $@ -s l2hglo.ist manual.glo

manual.bbl:	manual.aux
	$(BIBTEX) manual




$(TOP).html: $(TOP).aux
	$(MAKE) fresh


fresh:
	$(L2H) $(LTOP);
	$(L2H) $(LSEC3); $(L2H) $(LSEC4);
	$(L2H) $(LSEC5);
	$(L2H) $(LSEC2);
	$(L2H) $(LSEC6);
	$(L2H) $(LSEC1);
	$(L2H) $(LSEC3); $(L2H) $(LSEC4);
	$(L2H) $(LTOP);
	touch $(TOP)/[HEMPSO]$(INT) $(TOP)/$(INT);
	touch [HEMPSO].stamp $(TOP).stamp;

html:
	$(MAKE) $(TOP).stamp;
	$(MAKE) E.stamp; $(MAKE) H.stamp;
	$(MAKE) M.stamp;
	$(MAKE) S.stamp;
	$(MAKE) P.stamp;
	$(MAKE) O.stamp;
	$(MAKE) E.stamp; $(MAKE) H.stamp;
	$(MAKE) $(TOP).stamp;


twosteps:
	if test -f "manual/images.log"; then  \
	rm -f manual/images.log; \
	make noimages; make images;  fi ;

noimages:
	$(L2H) -short_index -no_images manual.tex

images:
	$(L2H) -short_index -images_only manual.tex

htmlclean:
	rm -f manual/.??* manual/*TMP*

clean:
	rm -f manual.dvi manual.ps manual.glo manual.log manual.aux \
	    manual.ilg manual.lof manual.lot manual.cb manual.idx manual.ind \
	    manual.toc manual.gls
	rm -f *.ptr


#
#  HTML version, as a segmented document
#

$(TOP).stamp:	$(TOP).tex  \
	$(TOP)/O$(INT) $(TOP)/H$(INT) $(TOP)/E$(INT) $(TOP)/M$(INT) $(TOP)/P$(INT) $(TOP)/S$(INT)
	$(L2H) $(LTOP)
	touch $@

$(TOP)/$(TOP).html:	$(TOP).stamp O.stamp S.stamp M.stamp H.stamp E.stamp P.stamp
	$(L2H) $(LTOP)
	$(MAKE) htmlclean

$(TOP)/$(INT):	$(TOP).tex
	$(L2H) $(LTOP)


$(TOP)images:
	$(L2Hon) $(LTOP)


sections:
	$(L2H) $(LSEC4);
	$(L2H) $(LSEC6);
	$(L2H) $(LSEC5);
	$(L2H) $(LSEC1);
	$(L2H) $(LSEC2);
	$(L2H) $(LSEC3);


$(TOP)/$(OVW).html:	$(OVW).tex $(TOP)/$(INT) \
		$(TOP)/H$(INT) $(TOP)/E$(INT) $(TOP)/M$(INT) $(TOP)/P$(INT) $(TOP)/S$(INT)
	$(MAKE)	O.stamp

$(OVW):
	$(L2H) $(LSEC1)


O.stamp:	$(OVW).tex
	$(L2H) $(LSEC1)
	touch $@

$(TOP)/O$(INT):
	$(L2H) $(LSEC1)



$(TOP)/$(SUP).html:	$(SUP).tex $(TOP)/$(INT) \
			$(TOP)/H$(INT) $(TOP)/E$(INT) $(TOP)/M$(INT)
	$(MAKE)	S.stamp

$(SUP):
	$(L2H) $(LSEC2)

S.stamp:	$(SUP).tex $(TOP)/$(INT)
	$(L2H) $(LSEC2)
	touch $@

$(TOP)/S$(INT):
	$(L2H) $(LSEC2)



$(TOP)/$(MAN).html:	$(MAN).tex $(TOP)/$(INT) $(TOP)/H$(INT) $(TOP)/E$(INT)
	$(MAKE)	M.stamp

$(MAN):
	$(L2H) $(LSEC5)

M.stamp:	$(MAN).tex $(TOP)/$(INT)
	$(L2H) $(LSEC5)
	touch $@

$(TOP)/M$(INT):
	$(L2H) $(LSEC5)



$(TOP)/$(HYP).html:	$(HYP).tex $(TOP)/$(INT) $(TOP)/M$(INT) $(TOP)/E$(INT) $(TOP)/O$(INT)
	$(MAKE)	H.stamp

$(HYP):
	$(L2H) $(LSEC4)

H.stamp:	$(HYP).tex $(TOP)/$(INT)
	$(L2H) $(LSEC4)
	touch $@

$(TOP)/H$(INT):
	$(L2H) $(LSEC4)



$(TOP)/$(ENV).html:	$(ENV).tex $(TOP)/$(INT) $(TOP)/M$(INT) $(TOP)/H$(INT) $(TOP)/S$(INT)
	$(MAKE)	E.stamp

$(ENV):
	$(L2H) $(LSEC3)

E.stamp:	$(ENV).tex $(TOP)/$(INT)
	$(L2H) $(LSEC3)
	touch $@

$(TOP)/E$(INT):
	$(L2H) $(LSEC3)



$(TOP)/$(PRO).html:	$(PRO).tex $(TOP)/$(INT) \
		$(TOP)/M$(INT) $(TOP)/H$(INT) $(TOP)/S$(INT) $(TOP)/E$(INT)
	$(MAKE)	P.stamp

$(PRO):
	$(L2H) $(LSEC6)

P.stamp:	$(PRO).tex $(TOP)/$(INT)
	$(L2H) $(LSEC6)
	touch $@

$(TOP)/P$(INT):
	$(L2H) $(LSEC6)



$(TOP)/$(CHA).html:	$(CHA).tex $(TOP)/$(INT)
	$(MAKE)	C.stamp

$(CHA):
	$(L2H) $(LSEC7)

C.stamp:	$(CHA).tex $(TOP)/$(INT)
	$(L2H) $(LSEC7)
	touch $@

$(TOP)/C$(INT):
	$(L2H) $(LSEC7)

