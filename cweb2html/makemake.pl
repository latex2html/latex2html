#!/usr/local/bin/perl

################################################################################
# Copyright 1998-1999 by Jens Lippmann (lippmann@rbg.informatik.tu-darmstadt.de)
#
# Permission to use, copy, modify, and distribute this software for any
# purpose and without fee is hereby granted, provided that the above
# copyright notice appears in all copies. This software is provided "as is"
# and without any express or implied warranties.
#
################################################################################

$BEGIN='###BEGIN TEMPLATE';
$END='###END TEMPLATE';
$DONOTEDIT='###DO NOT EDIT BELOW THIS LINE###';
$FILES='FILES';
$source=shift;
$pattern=shift;

&usage() unless $source && $pattern;
&main;
exit(0);

sub main {
    unlink("$source.bak");
    rename($source,"$source.bak") ||
	die "Cannot rename to $source.bak, $!\n";
    open(OUT,">$source") ||
	die "Cannot open $source, $!\n";

    open(IN,"<$source.bak");
    while (<IN>) {
	$string{'STRING'} .= $_;
    }
    $_ = delete $string{'STRING'}; # Blow it away and return the result
    close IN;

    $*=1; #multiline matching on
    &rip("no $FILES macro found in $source")
	unless /^[ \t]*$FILES[ \t]*=((.*\\\n)*.*)/;
    $files = $1;
    $files =~ s/\#.*\n?//g;
    @files = split(/[ \t]*\\\n[ \t]*|[ \t]+/,$files);
    shift(@files) unless $files[0];

    &rip("no files found in $FILES macro")
	unless $#files >= 0;
    print "files found in FILES macro: <",join('>, <',@files),">\n";

    # get template (one allowed currently)
    &rip("no template found in $source")
	unless /^[ \t]*$BEGIN.*\n([\s\S]*)\n[ \t]*$END/;
    $template = $1;
    # take out comments
    $template =~ s/^[ \t]*#.*\n//g;

    # reduce contents to static part and output it
    s/^[ \t]*$DONOTEDIT[\s\S]*/$DONOTEDIT\n/o;
    print OUT;
    foreach $file (@files) {
	next unless $file;
	if ($file =~ /[\s\\\#]/) {
	    print "rejecting file <$file>";
	}
	else {
	    $_ = $template;
	    s/\b$pattern\b/$file/g;
	    print OUT $_,"\n\n";
	}
    }
    close OUT;
    print "$source is up to date\n";
}


sub rip {
    local($_) = @_;
    rename("$source.bak",$source) ||
	die "$_\nrestoring $source failed also, $!\n";
    die "$_\n";
}


sub usage {
    print<<EOM;
Usage:
    $0 <Source> <Pattern>
    This program is a specialised Makefile generator.
    It renames the Makefile <Source> to <Source>.bak and parses this file for
    any definition of 'FILES' and templates embedded in special begin and end
    delimiters '$BEGIN' and '$END'.
    It outputs an expanded Makefile which replaces <Source>, with one template
    for each entry in 'FILES', whereby any occurrence of the pattern <Pattern>
    is substituted by the entry.
    Substitution will take place everywhere within the template and can not be
    escaped.
EOM
    exit(0);
}
