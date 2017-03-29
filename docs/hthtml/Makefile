#
# $Id: Makefile,v 1.1 1996/12/21 19:56:25 JCL Exp $
#

# set TEXINPUTS to use the hthtml.sty included in this package
LATEX = TEXINPUTS=../../texinputs:: latex
DVIPDF = dvipdf

all: hthtml.pdf hthtml/hthtml.html

hthtml.pdf:      hthtml.dvi
	$(DVIPDF) $< $@

hthtml.dvi: hthtml.tex
	$(LATEX) $<
	@while grep 'Rerun to get cross-references right' $*.log; \
	do $(LATEX) $<; \
	done

hthtml/hthtml.html: hthtml.tex hthtml.dvi
	latex2html -split 0 $<

clean:
	rm -f *.log *.aux *.dvi *.toc *.pdf *~
	rm -rf hthtml

dist: clean all
	gtar cvzf hthtml/hthtml.tar.gz \
	 Makefile README hthtml.sty hthtml.tex hthtml.perl
	rdist -p bin/rdistd

