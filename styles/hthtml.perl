#
# -*-perl-*-
# $Id: hthtml.perl,v 1.1 1996/12/21 19:54:08 JCL Exp $
#
package main;
#
print "Extended interface for LaTeX2HTML, v1.1, 7.11.96\n";
#
# \htlink: a replacement for \htmladdnormallinkfoot which allows
# ~ and _ in the url.
#
# \htlink <text> <url>
#
sub do_cmd_htlink{
    local($_) = @_;
    local($text, $url);
    s/$next_pair_pr_rx/$text = $2; ''/eo;
    s/$next_pair_pr_rx/$url = $2; ''/eo;
    # and recode the ~ (don't turn it to space)
    $url =~ s/~/&#126;/go;
    join('',"<A HREF=\"$url\">$text</A>",$_);
}
#
# \hturl: give an url directly (anchor and text are the same).
#
# \hturl <url>
#
sub do_cmd_hturl{
    local($_) = @_;
    local($url);
    s/$next_pair_pr_rx/$url = $2; ''/eo;
    # and recode the ~ (don't turn it to space)
    $url =~ s/~/&#126;/go;
    join('',"<A HREF=\"$url\">$url</A>",$_);
}
#
# Now, do some special urls:
#
sub do_cmd_htmailto{
    local($_) = @_;
    local($url);
    s/$next_pair_pr_rx/$url = $2; ''/eo;
    join('',"<A HREF=\"mailto:$url\">$url</A>",$_);
}

sub do_env_htdescription{
    &do_env_description;
}

# Offer the possibility to change the configuration
sub do_cmd_htsetvar {
    local($_) = @_;
    local($var, $val);
    s/$next_pair_pr_rx/$var = $2; ''/eo;
    s/$next_pair_pr_rx/$val = $2; ''/eo;
    $val = &revert_to_raw_tex($val);
    eval "\$$var = $val";
    $_;
}

sub do_cmd_htchar {
    local($_) = @_;
    local($val);
    s/$next_pair_pr_rx/$val = $2; ''/eo;
    join('',"&#$val;",$_);
}

#
# \htaddress <text>
# Set <text> as an address.
#
sub do_cmd_htaddress {
    local($_) = @_;
    local($text);
    s/$next_pair_pr_rx/$text = $2; ''/eo;
    join('',"<ADDRESS>$text</ADDRESS>",$_);
}

sub do_cmd_htmetainfo {
    local($_) = @_;
    local($var, $val);
    s/$next_pair_pr_rx/$var = $2; ''/eo;
    s/$next_pair_pr_rx/$val = $2; ''/eo;
    $htmetainfo = "$htmetainfo<META NAME=\"$var\" CONTENT=\"$val\">\n";
    $_;
}

# Replace `meta_information' in latex2html.config
sub meta_information {
    local($_) = @_;
    # Cannot have nested HTML tags...
    do { s/<[^>]*>//g;
         "<META NAME=\"description\" CONTENT=\"$_\">\n" .
	 "<META NAME=\"resource-type\" CONTENT=\"document\">\n" .
	 "<META NAME=\"distribution\" CONTENT=\"global\">\n$htmetainfo" } if $_;
}

1;                              # This must be the last line


