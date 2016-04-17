#
# $Id: Makefile,v 1.1 1996/12/21 19:56:25 JCL Exp $
#

all: hthtml.dvi hthtml/hthtml.html

hthtml.dvi: hthtml.tex
	latex $<
	@while grep 'Rerun to get cross-references right' $*.log; \
	do latex $<; \
	done

hthtml/hthtml.html: hthtml.tex hthtml.dvi
	latex2html -split 0 $<

clean:
	rm -f *.log *.aux *.dvi *.toc *~
	rm -rf hthtml

dist: clean all
	gtar cvzf hthtml/hthtml.tar.gz \
	 Makefile README hthtml.sty hthtml.tex hthtml.perl
	rdist -p bin/rdistd

