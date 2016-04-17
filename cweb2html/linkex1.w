% $Id: linkex1.w,v 1.3 1999/10/15 22:02:26 JCL Exp $

\documentclass{cweb}

%begin{latexonly}
% This is a fix to not upset html.sty about missing sectioning commands:
\let\subsection\null\let\subsubsection\null\let\paragraph\null
%end{latexonly}
\usepackage{html}

% This command also turns on the special treatment of refinement names
% such as writing them to the label file.
\HTCweblabels{dvi.obj/linkex1,dvi.obj/linkex2}{html.obj/linkex1,html.obj/linkex2}

\def\CWEB{{\tt CWEB\/}}

\begin{document}


\title{An Example of Linked \CWEB{} Documents}
\author{\htmladdnormallinkfoot{Jens Lippmann}
 {mailto:lippmann@@rbg.informatik.tu-darmstadt.de}}
\date{22 Feb 98}
\maketitle
\begin{abstract}
This example demonstrates the capability of the \CWEB{} to
\texttt{HTML} translator to link stand-alone documents
together.
You are introduced into the example on the next page.
\end{abstract}



@* Example of linked \CWEB{} documents (1/2).

This example demonstrates the capability of {\tt htcweb.sty} to link the two
stand-alone \CWEB{} documents
|@<linkex1.w@>| and
|@<linkex2.w@>| together.
It is also possible to link to single refinements of stand-alone documents,
as example take |@<linkex2 main()@>|.
In contrast to internal refinements of the document, such as
|@<linkex1 main()@>|, I differentiate between inter-refinement and
intra-refinement links.

The {\tt htcweb.perl} package implements this semantics also on the {\tt HTML}
layer, which probably brings out the results at its best.

The link features that {\tt htcweb} provides will help you to mesh your project
sources together, and to create a more hypertext-like presentation of the
project.
From my point of view, this approach strengthens the literate programming
philosophy.
If you are interesting in a living example, see the home page of the
\htmladdnormallinkfoot{{\sc LiPS}}{http://www.rbg.informatik.tu-darmstadt.de}
project, {\sc LiPS} Manual 2.4, ``Der Tupelraum'' (this is in German, but the
project sources like {\tt out.w}, {\tt in.w} are documented in English).
This user manual points to its actual sources, which are themselves meshed
together.

I hope you will appreciate this small demonstration, and wish you a bunch full
of exciting new ideas for your project represantation.


@c
@<linkex1 includes@>@/
@<linkex1 main()@>@/

@
See also the include files used in |@<linkex2 includes@>|.
@<linkex1 includes@>=
#include <stdio.h>

@
See also the main function as defined in |@<linkex2 main()@>|.

You will not be able to follow this link |@<somewhere@>|.
@<linkex1 main()@>=
int main()
{
    printf("%d\n",42);
    exit(0);
}


@
\end{document}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% $Log: linkex1.w,v $
% Revision 1.3  1999/10/15 22:02:26  JCL
% added latexonly sequence that defines \sub...section and \paragraph \null to make html.sty happy
%
% Revision 1.2  1999/04/09 19:25:37  JCL
% changed my e-Mail address
%
% Revision 1.1  1998/02/24 02:29:52  latex2html
% for 98.1
%
%
