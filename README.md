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
   commands to the equivalent ISO-LATIN-1
   character set where possible, 
 * recognizes hypertext links (to multimedia resources or arbitrary
   internet services such as sound/video/ftp/http/news) and links which
   invoke arbitrary program scripts, all expressed as LaTeX commands, 
 * recognizes conditional text which is intended only for the hypertext
   version, or only for the paper (DVI) version, 
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
    * Perl 5.003 (Perl5 Patch level 3) or higher.

    * DBM or NDBM, the Unix DataBase Management system.
      Alternatively, Perl5's SDBM DataBase system.
      Do not care unless you get misconfiguration errors from LaTeX2HTML.

 2. LaTeX commands with equations, figures, tables, etc. 
   As above plus 
    * latex (version 2e recommended but 2.09 acceptable), 
    * dvips (version 5.516 or later) or dvipsk.
      Version 5.62 or higher enhances the performance of image creation
      with a *significant* speed-up. See l2conf.pm for this
      after you are done with the installation.
      Do not use the 'dvips -E' feature unless you have 5.62, else you
      will get broken images.
    * gs (Ghostscript version 4.03 or later),
      with the ppmraw device driver, or even better pnmraw.
      Upgrade to 5.10 or later if you want to go sure about seldom problems
      with 4.03 to avoid (yet unclarified).
    * The netpbm library (ftp://ftp.x.org/R5contrib/).
      Netpbm 1 March 1994 is recommended. Check with 'pnmcrop -version'.
      Some of the filters in those libraries are used during the postscript
      to image conversion.
    * If you want PNG images, you need pnmtopng (current version is 2.31).
      It is not part of netpbm and requires libpng (version 0.89c) and 
      libz (1.0.4). pnmtopng supports transparency and interlace mode.

 3. Transparent inlined GIFs
   If you dislike the gray background color of the generated inlined images
   then the best thing you can do is get the netpbm library (instead of
   the older pbmplus) OR install the giftrans filter by Andreas Ley
   <ley@rz.uni-karlsruhe.de>. Version 1.10.2 is known to work without
   problems but later versions should also be OK.

   LaTeX2HTML also supports the shareware program giftool (by Home Pages, Inc.,
   version 1.0), too. It can also create interlaced GIFs.

Because by default the translator makes use of inlined images in the final
HTML output, it would be better to have a graphical browser.
If only a character based browser is available or
if you want the generated documents to be more portable, then the translator
can be used with the -ascii_mode option. 

If ghostscript or netpbm library are not available
it is still possible to use the translator with the -no_images option. 

If you intend to use any of the special features of the translator 
then you have to include the html.sty file in any LaTeX documents that
use them. 


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

