#
#  This sample makefile provides a starting point for building
#  HTML documents which multiple segments and inter-segment
#  dependencies.  This example is included with the V96.1
#  version of latex2html.
#

TOP 	  = report
INT	  = internals.pl
TEXES	  = sec1.tex sec2.tex
SECTIONS  = $(TOP)/sec1.html $(TOP)/sec2.html
TOPTITLE  = "Main Report Title"
S1TITLE	  = "Section 1 title"
S2TITLE   = "Section 2 title"

L2H 	  = latex2html -show_section_numbers
LaTeX	  = latex
DVIPS	  = dvips

COMMON	  = -dir $(TOP) -external_file $(TOP) -contents \
		node1.html -index node3.html
LTOP	  = $(L2H) -info "" -down_url sec1.html -down_title $(S1TITLE) \
		-t $(TOPTITLE) $(TOP).tex
LSEC1	  = $(L2H) $(COMMON) -prefix s1 -info "" -up_url $(TOP).html \
		-up_title $(TOPTITLE) -down_url sec2.html \
		-down_title $(S2TITLE) sec1.tex
LSEC2	  = $(L2H)  $(COMMON) -prefix s2 -up_url sec1.html \
		-up_title $(S1TITLE) sec2.tex

all:	$(TOP).ps $(TOP)/$(TOP).html

$(TOP).dvi:	$(TOP).tex $(TOP).aux
	$(LaTeX) $(TOP).tex

$(TOP).aux:	$(TOP).tex $(TEXES)
	$(LaTeX) $(TOP).tex

$(TOP).ps:	$(TOP).dvi
	$(DVIPS) -o $@ $(TOP)

$(TOP)/$(TOP).html :	$(TOP).tex $(TOP).aux $(SECTIONS)
	$(LTOP)

$(TOP)/sec1.html:	sec1.tex $(TOP)/s2$(INT)
	$(MAKE)	sec1.stamp

$(TOP)/sec2.html:	sec2.tex $(TOP)/s1$(INT)
	$(MAKE)	sec2.stamp

sec1.stamp:	sec1.tex $(TOP)/s2$(INT)
	$(LSEC1)
	touch $@

sec2.stamp:	sec2.tex $(TOP)/s1$(INT)
	$(LSEC2)
	touch $@

$(TOP)/s1$(INT):
	$(LSEC1)

$(TOP)/s2$(INT):
	$(LSEC2)

clean:	
	rm -rf $(TOP) $(TOP).dvi $(TOP).aux $(TOP).log $(TOP).toc \
	    $(TOP).lof $(TOP).ps sec1.ptr sec2.ptr sec1.stamp sec2.stamp

