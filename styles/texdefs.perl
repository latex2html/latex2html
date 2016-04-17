# Like get_body_newcommand above, but for simple raw TeX \defs

package main;

$meta_cmd_rx =~ s/([\|\(])newcommand/$1\[egx\]?def\|newcommand/
    unless $meta_cmd_rx =~ /[\|\)]def/;

sub get_body_def {
#    local(*_) = @_;
    local($after_R) = @_;
    local($_) = $$after_R;
    my $argn,$cmd,$body,$is_simple_def,$tmp;
    ($cmd,$tmp) = &get_next(2);
    $cmd =~ s/^\s*\\//s;
    if (/^\@/) { s/^(\@[\w\@]*)/$cmd.= $1;''/se } # @-letter

    ($argn,$tmp) = &get_next(3);
    $argn = 0 unless $argn;

    ($body,$tmp) = &get_next(1);
    $tmp = "do_cmd_$cmd";
#    if ($is_simple_def && !defined (&$tmp))
    if ($is_simple_def )
	{ $new_command{$cmd} = join(':!:',$argn,$body,'}'); }    
    $$after_R = $_;
    ''; # $_;
}

sub get_body_gdef { &get_body_def(@_) }
sub get_body_edef { &get_body_def(@_) }
sub get_body_xdef { &get_body_def(@_) }

######################### Other Concessions to TeX #############################

sub do_cmd_newdimen {
    local($_) = @_;
    local($name, $pat) = &get_next_tex_cmd;
    &add_to_preamble("def", "\\newdimen$pat");
    $_;
}
sub do_cmd_newbox {
    local($_) = @_;
    local($name, $pat) = &get_next_tex_cmd;
    &add_to_preamble("def", "\\newbox$pat");
    $_;
}

# JCL
# Convert decimal, octal, hexadecimal, one letter and
# one letter macro into char specification.
#
sub do_cmd_char {
    local($_) = @_;
# some special characters are already turned into l2h internal
# representation.
# Get its represention from the table and use it like as regexp form.
    local($spmquot) = &escape_rx_chars($html_specials{'"'});
# Get all internal special char representations as implied during
# preprocessing.
    local($spmrx) = join("\000",values %html_specials);
# escape regexp special chars (not really necessary yet, but why not)
    $spmrx =~ s:([\\(){}[\]\^\$*+?.|]):\\$1:g;
    $spmrx =~ s/\000/|/g;
    $spmrx = "(.)" unless $spmrx =~ s/(.+)/($1|.)/;

    s/^[ \t]*(\d{1,3})[ \t]*/&#$1;/ &&
	return($_);

    s/^[ \t]*\'(\d{1,3})[ \t]*/"&#".oct($1).";"/e &&
	return($_);

    s/^[ \t]*$spmquot(\d{1,2})[ \t]*/"&#".hex($1).";"/e &&
	return($_);

# This is a kludge to work together with german.perl. Brrr.
    s/^[ \t]*\'\'(\d{1,2})[ \t]*/"&#".hex($1).";"/e &&
	return($_);

# If l2h's special char marker represents more than one character,
# it's already in the &#xxx; form. Else convert the single character
# into &#xxx; with the ord() command.
    s/^[ \t]*\`\\?$spmrx[ \t]*/
	(length($html_specials_inv{$1}) > 1 ?
	 $html_specials_inv{$1} : "&#".ord($html_specials_inv{$1}||$1).";")/e &&
	     return($_);

    &write_warnings(join('',
			 "Could not find character number in \\char",
			 (/\n/ ? $` : $_), " etc.\n"));
    $_;
}


&ignore_commands( <<_IGNORED_CMDS_);
vskip # &ignore_numeric_argument
hskip # &ignore_numeric_argument
kern # &ignore_numeric_argument
#bgroup
#egroup
_IGNORED_CMDS_


1; 		# Must be last line
