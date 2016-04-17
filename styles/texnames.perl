# perl
# texnames.perl
#   Ronjeet Lal <rsl3047@unix.tamu.edu> 29-MAY-98
#
# Extension to LaTeX2HTML to support texnames.sty
#
# Change Log:
# ===========


package main;

$TeXname = (($HTML_VERSION ge "3.0")? "T<SMALL>E</SMALL>X" : "TeX");
$Laname = (($HTML_VERSION ge "3.0")? "L<SUP><SMALL>A</SMALL></SUP>" : "La");
$MFname = (($HTML_VERSION ge "3.0")? "<SMALL>METAFONT</SMALL>" : "Metafont");
$Xyname = (($HTML_VERSION ge "3.0")? "X<SUB><BIG>Y</BIG></SUB>" : "Xy");
$AmSname = (($HTML_VERSION ge "3.0")? "A<SUB><BIG>M</BIG></SUB>S" : "AmS");
$Bibname = (($HTML_VERSION ge "3.0")? "B<SMALL>IB</SMALL>" : "Bib");
$PiCname = (($HTML_VERSION ge "3.0")? "P<SMALL>I</SMALL>C" : "PiC");
$SLiname = (($HTML_VERSION ge "3.0")? "SL<SUP><SMALL>I</SMALL></SUP>" : "Sli");
$VORname = (($HTML_VERSION ge "3.0")? "V<SMALL>OR</SMALL>" : "Vor");
$VIRname = (($HTML_VERSION ge "3.0")? "V<SMALL>ir</SMALL>" : "Vir");
$Xyname = (($HTML_VERSION ge "3.0")? "X<SUB>Y</SUB>" : "Xy");
$Xypicname = (($HTML_VERSION ge "3.0")? "X<SUB>Y</SUB>-pic" : "Xy-pic");
$LamSname = (($HTML_VERSION ge "3.0")? "L<SUP><SMALL>A</SMALL></SUP><SUB>M</SUB>S" : "LamS");
$LaTeXsub = (($HTML_VERSION ge "3.0")? "2<SUB>e</SUB>" : "2e");
$XyMname = (($HTML_VERSION ge "3.0")? 'X<SUP>Y</SUP><SUB>M</SUB>' : 'XyM');


sub do_cmd_TeX {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo TeX">',$TeXname,'</SPAN>')
	: $TeXname ) . $_[0] }

sub do_cmd_AmS {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo AMS">',$AmSname,'</SPAN>')
	: $AmSname ) . $_[0] }
sub do_cmd_AMS { &do_cmd_AmS(@_) }

sub do_cmd_AmSLaTeX {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo AMS">',$AmSname,'-',$Laname,$TeXname,'</SPAN>')
	: $AmSname.'-'.$Laname.$TeXname ) . $_[0] }
sub do_cmd_AMSLaTeX { &do_cmd_AmSLaTeX(@_) }

sub do_cmd_AmSTeX {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo AMS">',$AmSname,'-',$TeXname,'</SPAN>')
	: $AmSname.'-'.$TeXname ) . $_[0] }
sub do_cmd_AMSTeX { &do_cmd_AmSTeX(@_) }
 
sub do_cmd_BibTeX {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo BibTeX">',$Bibname,$TeXname,'</SPAN>')
	: $Bibname.$TeXname ) . $_[0] }
sub do_cmd_BIBTeX { &do_cmd_BibTeX(@_) }
sub do_cmd_BIBTEX { &do_cmd_BibTeX(@_) }

sub do_cmd_LAMSTeX {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo LAmS">',$LamSname,'-',$TeXname,'</SPAN>')
	: $LamSname.'-'.$TeXname ) . $_[0] }
sub do_cmd_LamSTeX { &do_cmd_LAMSTeX(@_) }
sub do_cmd_LAmSTeX { &do_cmd_LAMSTeX(@_) }
 
sub do_cmd_LaTeX {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo LaTeX">',$Laname,$TeXname,'</SPAN>')
	: $Laname.$TeXname ) . $_[0] }
sub do_cmd_LATEX { &do_cmd_LaTeX(@_) }

sub do_cmd_LaTeXe {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo LaTeX2e">',$Laname,$TeXname,$LaTeXsub,'</SPAN>')
	: $Laname.$TeXname.$LaTeXsub) . $_[0] }

sub do_cmd_LaTeXo {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo LaTeX 2.09">',$Laname,$TeXname,' 2.09</SPAN>')
	: $Laname.$TeXname.' 2.09' ) . $_[0] }

sub do_cmd_MF {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo Metafont">',$MFname,'</SPAN>')
	: $MFname ) . $_[0] }
sub do_cmd_METAFONT { &do_cmd_MF(@_) }

sub do_cmd_SLITEX {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo SLiTeX">',$SLiname,$TeXname,'</SPAN>')
	: $SLiname.$TeXname ) . $_[0] }
sub do_cmd_SLiTeX { &do_cmd_SLITEX(@_) }
sub do_cmd_SliTeX { &do_cmd_SLITEX(@_) }
sub do_cmd_SLITeX { &do_cmd_SLITEX(@_) }

sub do_cmd_PiC {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo PiCTeX">',$PiCname,'</SPAN>')
	: $PiCname ) . $_[0] }

sub do_cmd_PiCTeX {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo PiCTeX">',$PiCname,$TeXname,'</SPAN>')
	: $PiCname.$TeXname ) . $_[0] }

sub do_cmd_VirTeX {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo VirTeX">',$VIRname,$TeXname,'</SPAN>')
	: $VIRname.$TeXname ) . $_[0] }

sub do_cmd_VorTeX {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo VorTeX">',$VORname,$TeXname,'</SPAN>')
	: $VORname.$TeXname ) . $_[0] }

sub do_cmd_Xy {
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo Xy-pic">',$Xyname,'</SPAN>')
	: $Xyname ) . $_[0] }

sub do_cmd_Xypic { 
    ($USING_STYLES ?
	join('','<SPAN CLASS="logo Xy-pic">',$Xypicname,'</SPAN>')
	: $Xypicname ) . $_[0] }

sub do_cmd_XyM {
    ($USING_STYLES ?
        join('','<SPAN CLASS="logo XyM-TeX">',$XyMname,'</SPAN>')
        : $XyMname ) . $_[0] }

sub do_cmd_XyMTeX {
    ($USING_STYLES ?
        join('','<SPAN CLASS="logo XyM-TeX">',$XyMname,'-',$TeXname,'</SPAN>')
        : $XyMname.'-'.$TeXname ) . $_[0] }



1;      # Must be last line


