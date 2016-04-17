# nharvard.perl - calls natbib.perl to emulate harvard

package main;

# Setting $HARVARD makes natbib.perl behave differently
$HARVARD=1;

foreach $dir (split(/:/,$LATEX2HTMLSTYLES)) {
    if (-f "$dir/natbib.perl") {
	print "Loading $dir/natbib.perl\n";
	require "$dir/natbib.perl";
	$styles_loaded{"natbib"}=1;
	last
	}
}
	
1; # This must be the last line
