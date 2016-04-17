# $Id: babelbst.perl,v 1.2 1998/08/06 14:50:28 UW Exp $
# babelbst.perl - LaTeX2HTML support for the merlin \bbl*** commands
#  (default English style) for use with Patrick Daly's  natbib.sty
# Ross Moore, 29.6.1998 (ross@mpce.mq.edu.au)
# using information supplied by Uli Wortmann


sub do_cmd_bbland { $bbland . @_[0] }
$bbland = 'and' unless ($bbland);

sub do_cmd_bbleditor { $bbleditor . @_[0] }
sub do_cmd_bbled { $bbled . @_[0] }
sub do_cmd_bbleditors { $bbleditors . @_[0] }
sub do_cmd_bbleds { $bbleds . @_[0] }
sub do_cmd_bbledby { $bbledby . @_[0] }
sub do_cmd_bbledition { $bbledition . @_[0] }
sub do_cmd_bbledn { $bbledn . @_[0] }

$bbleditor = 'editor' unless ($bbleditor);
$bbled = 'ed.' unless ($bbled);
$bbleditors = 'editors' unless ($bbleditors);
$bbleds = 'eds.' unless ($bbleds);
$bbledby = 'edited by' unless ($bbledby);
$bbledition = 'edition' unless ($bbledition);
$bbledn = 'edn.' unless ($bbledn);


sub do_cmd_bblVolume { $bblVolume . @_[0] }
sub do_cmd_bblVol { $bblVol . @_[0] }
sub do_cmd_bblvolume { $bblvolume . @_[0] }
sub do_cmd_bblvol { $bblvol . @_[0] }

$bblVolume = 'Volume' unless ($bblVolume);
$bblVol = 'Vol.' unless ($bblVol);
$bblvolume = 'volume' unless ($bblvolume);
$bblvol = 'vol.' unless ($bblvol);


sub do_cmd_bblof { $bblof . @_[0] }
$bblof = '' unless ($bblof);


sub do_cmd_bblNumber { $bblNumber . @_[0] }
sub do_cmd_bblNo { $bblNo . @_[0] }
sub do_cmd_bblnumber { $bblnumber . @_[0] }
sub do_cmd_bblno { $bblno . @_[0] }

$bblNumber = 'Number' unless ($bblNumber);
$bblnumber = 'number' unless ($bblnumber);
$bblNo = 'No.' unless ($bblNo);
$bblno = 'no.' unless ($bblno);


sub do_cmd_bblIn { $bblIn . @_[0] }
sub do_cmd_bblin { $bblin . @_[0] }

$bblIn = 'In' unless ($bblIn);
$bblin = 'in' unless ($bblin);


sub do_cmd_bblpages { $bblpages . @_[0] }
sub do_cmd_bblpage { $bblpage . @_[0] }
sub do_cmd_bblpp { $bblpp . @_[0] }
sub do_cmd_bblp { $bblp . @_[0] }

$bblpages = 'pages' unless ($bblpages);
$bblpage = 'page' unless ($bblpage);
$bblpp = 'p' unless ($bblpp);
$bblp = 'p.' unless ($bblp);


sub do_cmd_bblchapter { $bblchapter . @_[0] }
sub do_cmd_bblchap { $bblchap . @_[0] }

$bblchapter = 'chapter' unless ($bblchapter);
$bblchap = 'chap' unless ($bblchap);


sub do_cmd_bbltechreport { $bbltechreport . @_[0] }
sub do_cmd_bbltechrep { $bbltechrep . @_[0] }

$bbltechreport = 'Technical Report' unless ($bbltechreport);
$bbltechrep = 'Tech. Rep.' unless ($bbltechrep);


sub do_cmd_bblmthesis { $bblmthesis . @_[0] }
$bblmthesis = "Master's thesis" unless ($bblmthesis);

sub do_cmd_bblphdthesis { $bblphdthesis . @_[0] }
$bblphdthesis = 'Ph.D. thesis' unless ($bblphdthesis);


sub do_cmd_bblfirst { $bblfirst. @_[0] }
sub do_cmd_bblfirsto { $bblfirsto. @_[0] }
$bblfirst = 'First' unless ($bblfirst);
$bblfirsto = '1st' unless ($bblfirsto);

sub do_cmd_bblsecond { $bblsecond . @_[0] }
sub do_cmd_bblsecondo { $bblsecondo . @_[0] }
$bblsecond = 'Second' unless ($bblsecond);
$bblsecondo = '2nd' unless ($bblsecondo);

sub do_cmd_bblthird { $bblthird . @_[0] }
sub do_cmd_bblthirdo { $bblthirdo . @_[0] }
$bblthird = 'Third' unless ($bblthird);
$bblthirdo = '3rd' unless ($bblthirdo);

sub do_cmd_bblfourth { $bblfourth . @_[0] }
sub do_cmd_bblfourtho { $bblfourtho . @_[0] }
$bblfourth = 'Fourth' unless ($bblfourth);
$bblfourtho = '4th' unless ($bblfourtho);

sub do_cmd_bblfifth { $bblfifth . @_[0] }
sub do_cmd_bblfiftho { $bblfiftho . @_[0] }
$bblfifth = 'Fifth' unless ($bblfifth);
$bblfiftho = '5th' unless ($bblfiftho);


sub do_cmd_bblst { $bblst . @_[0] }
$bblst = 'st' unless ($bblst);

sub do_cmd_bblnd { $bblnd . @_[0] }
$bblnd = 'nd' unless ($bblnd);

sub do_cmd_bblrd { $bblrd . @_[0] }
$bblrd = 'rd' unless ($bblrd);

sub do_cmd_bblth { $bblth . @_[0] }
$bblth = 'th' unless ($bblth);


sub do_cmd_bbljan { $bbljan . @_[0] }
$bbljan = 'January' unless ($bbljan);

sub do_cmd_bblfeb { $bblfeb . @_[0] }
$bblfeb = 'February' unless ($bblfeb);

sub do_cmd_bblmar { $bblmar . @_[0] }
$bblmar = 'March' unless ($bblmar);

sub do_cmd_bblapr { $bblapr . @_[0] }
$bblapr = 'April' unless ($bblapr);

sub do_cmd_bblmay { $bblmay . @_[0] }
$bblmay = 'May' unless ($bblmay);

sub do_cmd_bbljun { $bbljun . @_[0] }
$bbljun = 'June' unless ($bbljun);

sub do_cmd_bbljul { $bbljul . @_[0] }
$bbljul = 'July' unless ($bbljul);

sub do_cmd_bblaug { $bblaug . @_[0] }
$bblaug = 'August' unless ($bblaug);

sub do_cmd_bblsep { $bblsep . @_[0] }
$bblsep = 'September' unless ($bblsep);

sub do_cmd_bbloct { $bbloct . @_[0] }
$bbloct = 'October' unless ($bbloct);

sub do_cmd_bblnov { $bblnov . @_[0] }
$bblnov = 'November' unless ($bblnov);

sub do_cmd_bbldec { $bbldec . @_[0] }
$bbldec = 'December' unless ($bbldec);


1;
