LaTeX2HTML README
=================

Contents
--------

* Overview
* Pointers to the User Manual
* Requirements
* Installation
* Troubleshooting
* Support and More Information

Overview
--------

The LaTeX2HTML translator: 

 * breaks up a document into one or more components as specified by
   the user, 
 * provides optional iconic navigation panels on every page which
   contain links to other parts of the document,  
 * handles inlined equations, right-justified
   numbered equations, tables, or figures and any arbitrary environment, 
 * can produce output suitable for browsers that support inlined images
   or character based browsers (as specified by the user), 
 * handles definitions of new commands, environments, and theorems
   even when these are defined in external style files, 
 * handles footnotes, tables of contents, lists of figures and tables,
   bibliographies, and can generate an Index, 
 * translates cross-references into hyperlinks and extends the
   LaTeX cross-referencing mechanism to work not just
   within a document but between documents which may reside in
   remote locations, 
 * translates accent and special character
   commands to the equivalent HTML
   character codes where possible, 
 * recognizes hypertext links (to multimedia resources or arbitrary
   internet services such as sound/video/ftp/http/news) and links which
   invoke arbitrary program scripts, all expressed as LaTeX commands, 
 * recognizes conditional text which is intended only for the hypertext
   version, or only for the paper (PDF) version, 
 * can include raw HTML in a LaTeX document (e.g. in order to specify
   interactive forms), 
 * can deal sensibly with all the commands and environments commonly used 
   with LaTeX as summarized at the back of the LaTeX blue book [1],
   and many of the packages described in the LaTeX Companion, and others. 
 * will try to translate any document with embedded LaTeX commands
   irrespective of whether it is complete or syntactically legal. 

Pointers to the User Manual
---------------------------

The LaTeX2HTML program includes its own manual page. 
The manual page can be viewed by saying "perldoc latex2html"
or "latex2html -help".

See the documentation at 
   http://mirrors.ctan.org/support/latex2html/manual.pdf
for more information and examples.

Other useful links can be found at:  www.latex2html.org
and at the mailing-list site:
	http://tug.org/mailman/listinfo/latex2html

In particular see the pages:
 support.html , Snode1.html , Snode2.html , Snode3.html 
for instructions on how to install the program 
and make your own local copy of the manual in HTML.

Requirements
------------

Please consult the section "Requirements" of the manual at
for more information.

The requirements for using LaTeX2HTML depend on the kind of
translation it is asked to perform as follows: 

 1. LaTeX commands but without equations, figures, tables, etc. 
    * Perl 5.003 or higher.

 2. LaTeX commands with equations, figures, tables, etc. 
   As above plus 
    * latex (pdflatex is used by default)
    * gs (Ghostscript version 4.03 or later),
    * The netpbm library 
    * If you want to process documents written for dvi-producing latex
      (as opposed to pdflatex), you need either dvips or dvipng.
      These are available through the texlive distribution.
 


Installation
------------

LaTeX2HTML is available through the debian, fedora, and macports
package managers.

To install LaTeX2HTML from source please read the file INSTALL.

Troubleshooting
---------------

Please refer to the FAQ file that came with your distribution.


Support and More Information
----------------------------

A LaTeX2HTML mailing list has been set up by the
 TeX User Group (TUG).

To join the list, visit the web-page at:

   http://tug.org/mailman/listinfo/latex2html

and follow the instructions found there.

If this is not possible for some reason, then send a message to: 
            latex2html-request@tug.org 
with the contents 
            subscribe 


To be removed from the list follow the instructions at:

   http://tug.org/mailman/listinfo/latex2html

If this is not possible for some reason, then send a message to: 
           latex2html-request@tug.org 
with the contents 
           unsubscribe


An archive of the mailing list, from 1999 onwards,
can be browsed at:

   http://tug.org/pipermail/latex2html/


License
-------

GNU Public License Version 2


Enjoy!


Original Author:
  Nikos Drakos 
  Computer Based Learning Unit
  University of Leeds.

Most Recent Author:
  Ross Moore 
  Mathematics Department
  Macquarie University, Sydney.

Former Authors:
  Marek Rouchal 
  Infineon Technologies AG
  Munich, Germany

  Jens Lippmann 
  Technische Universit"at Darmstadt.

