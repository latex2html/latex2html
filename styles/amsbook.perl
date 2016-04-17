# amsbook.perl by Ross Moore <ross@mpce.mq.edu.au>  09-30-97
#
# Extension to LaTeX2HTML V97.1 to support the "AMS book" document class
# and standard LaTeX2e class options.
#
# Change Log:
# ===========

package main;

&do_require_package('amstex');
&do_require_package('amsfonts');

# Suppress option-warning messages:

sub do_amsbook_10pt{}
sub do_amsbook_11pt{}
sub do_amsbook_12pt{}
sub do_amsbook_8pt{}
sub do_amsbook_9pt{}
sub do_amsbook_a4paper{}
sub do_amsbook_a5paper{}
sub do_amsbook_b5paper{}
sub do_amsbook_legalpaper{}
sub do_amsbook_letterpaper{}
sub do_amsbook_executivepaper{}
sub do_amsbook_landscape{}
sub do_amsbook_portrait{}
sub do_amsbook_final{}
sub do_amsbook_draft{}
sub do_amsbook_oneside{}
sub do_amsbook_twoside{}
sub do_amsbook_openright{}
sub do_amsbook_openany{}
sub do_amsbook_onecolumn{}
sub do_amsbook_twocolumn{}
sub do_amsbook_notitlepage{}
sub do_amsbook_titlepage{}
sub do_amsbook_openbib{}

sub do_amsbook_nomath{}

sub do_amsbook_noamsfonts{
    &do_amsfonts_noamsfonts() if (defined &do_amsfonts_noamsfonts);
    $styles_loaded{'noamsfonts'} = 1; }

sub do_amsbook_psamsfonts{
    &do_amsfonts_psamsfonts() if (defined &do_amsfonts_psamsfonts);
    $styles_loaded{'noamsfonts'} = 1; }

sub do_amsbook_centertags{&do_amstex_centertags()}
sub do_amsbook_tbtags{&do_amstex_tbtags()}
sub do_amsbook_leqno{&do_amstex_leqno()}
sub do_amsbook_reqno{&do_amstex_reqno()}
sub do_amsbook_fleqno{&do_amstex_fleqno()}

sub do_amsbook_makeidx{ &do_require_package('makeidx') }


sub do_cmd_thechapter {
    local($_) = @_;
    join('', &do_cmd_arabic('<<0>>chapter<<0>>'), $_);
}
sub do_cmd_thesection {
    local($_) = @_; 
    join('', &translate_commands("\\thechapter")
	,".", &do_cmd_arabic('<<0>>section<<0>>'), $_);
}
sub do_cmd_thesubsection {
    local($_) = @_;
    join('',&translate_commands("\\thesection")
	,"." , &do_cmd_arabic('<<0>>subsection<<0>>'), $_);
}
sub do_cmd_thesubsubsection {
    local($_) = @_;
    join('',&translate_commands("\\thesubsection")
	,"." , &do_cmd_arabic('<<0>>subsubsection<<0>>'), $_);
}
sub do_cmd_theparagraph {
    local($_) = @_;
    join('',&translate_commands("\\thesubsubsection")
	,"." , &do_cmd_arabic('<<0>>paragraph<<0>>'), $_);
}


&addto_dependents('chapter','equation');
&addto_dependents('chapter','footnote');

sub do_cmd_theequation {
    local($_) = @_;
    join('',&translate_commands("\\thechapter")
        ,"." , &do_cmd_arabic('<<0>>equation<<0>>'), $_);
}

sub do_cmd_thefootnote {
    local($_) = @_;
    join('',&translate_commands("\\thechapter")
        ,"." , &do_cmd_arabic('<<0>>footnote<<0>>'), $_);
}

sub do_cmd_textprime {
    local($_) = @_;
    local($this) = &process_in_latex("\$\\scriptsize{\\prime}\$");
    "<SUP>".$this."</SUP>".$_;
}

sub do_cmd_partname { $part_name . @_[0] }
sub do_cmd_indexname { $idx_title . @_[0] }
sub do_cmd_appendixname { $app_title . @_[0] }
sub do_cmd_abstractname { $abs_title . @_[0] }
sub do_cmd_refname { $ref_title . @_[0] }
sub do_cmd_bibname { $bib_title . @_[0] }
sub do_cmd_figurename { $fig_name . @_[0] }
sub do_cmd_tablename { $tab_name . @_[0] }
sub do_cmd_proofname { $prf_name . @_[0] }
sub do_cmd_contentsname { $toc_title . @_[0] }
sub do_cmd_listfigurename { $lof_title . @_[0] }
sub do_cmd_listtablename { $lot_title . @_[0] }

$key_title = "Key words and phrases";
$sbj_title = "1991 Mathematics Subject Classification";

sub do_cmd_keywordsname { $key_title . @_[0] }
sub do_cmd_subjclasssname { $sbj_title . @_[0] }
    
%section_commands = (
	'indexchap' , '2'
	,'specialsection' , '3'
	, %section_commands);

%section_headings = (
	'indexchap' , 'H1'
	,'specialsection' , 'H1'
	, %section_headings);


1;	# Must be last line
