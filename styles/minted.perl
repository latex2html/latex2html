# -*- perl -*-
#
# minted.perl adapted from listings.perl
#
# calls "pygmentize" executable to add color markup in html
#
# this is a type of verbatim environment - verbatim-like
# processing is in main latex2html program
#

package main;

$USE_HILITE = 1;
$SRCHILITE = '/usr/bin/pygmentize';

# This package very probably may be used in listings
&do_require_package("color");

# This is the main driver subroutine for the minted environment
sub process_minted {
  local($lst_pre, $lst_post, $lst_cmd, $_) = @_;

  my($lst_pre) = '';
  my($lst_post) = '';
  

  local($option,$dum) = &get_verb_optional_argument;

  # first arg of minted is the programming language
  # \begin{minted}{c}
  $language = &missing_braces unless (
    (s/$verb_braces_rx/$language=$1;''/eo)
      );
  $curopts{'language'} = $language;
  
  local($contents) = $_;
  
  my($frame) = 'VOID';
  $frame = 'LHS'    if ($curopts{'frame'} eq 'leftline');
  $frame = 'ABOVE'  if ($curopts{'frame'} eq 'topline');
  $frame = 'BELOW'  if ($curopts{'frame'} eq 'bottomline');
  $frame = 'HSIDES' if ($curopts{'frame'} eq 'lines');
  $frame = 'BORDER'
    if ($curopts{'frame'} eq 'single' || $curopts{'frame'} eq 'shadowbox');
  if ($curopts{'frame'} =~ /^[trblTRBL]+$/) {
    my($t, $r, $b, $l, $c);
    foreach $c (split //, $curopts{'frame'}) {
      $t = 1 if ("\L$c" eq 't');
      $r = 1 if ("\L$c" eq 'r');
      $b = 1 if ("\L$c" eq 'b');
      $l = 1 if ("\L$c" eq 'l');
    }
    if ($t && $r && $b && $l) { $frame = 'BORDER'; }
    elsif ($t && $b)          { $frame = 'HSIDES'; }
    elsif ($r && $l)          { $frame = 'VSIDES'; }
    elsif ($t)                { $frame = 'ABOVE';  }
    elsif ($b)                { $frame = 'BELOW';  }
    elsif ($l)                { $frame = 'LHS';    }
    elsif ($r)                { $frame = 'RHS';    }
  }
  my($framesep);
  ($framesep, $dum) = &convert_length ($curopts{'framesep'}, 1);
  $framesep = sprintf("%.0f", $framesep);
  my($framerule);
  ($framerule, $dum) = &convert_length ($curopts{'framerule'}, 1);
  $framerule = sprintf("%.0f", $framerule);
  if ($framerule == 1) { # Special case specifying a very thin border
    $framerule = '';
  } else {
    $framerule = " BORDER=\"$framerule\"";
  }

  # Coloring options group (backgroundcolor, rulecolor)
  my($bgcolor);
  $_ = $curopts{'backgroundcolor'};
  if (/^\s*\\/) {
    # Translate as a command and extract color value from the HTML tag
    &lst_translate_option;
    s/$O\d+$C//go;		# Get rid of bracket id's
    s/$OP\d+$CP//go;		# Get rid of processed bracket id's
    # Extract color value or clear the malformed contents
    $_ = ''
      unless (s/^\s*<FONT\s+COLOR\s*=\s*"\s*// && s/\s*"\s*>\s*<\/FONT>\s*$//);
  } else {
    # Must be a \color command
    $_ = '';
  }
  $bgcolor = $_;
  $bgcolor = " BGCOLOR=\"$bgcolor\"" unless ($bgcolor eq '');
  my($rulecolor);
  $_ = $curopts{'rulecolor'};
  if (/^\s*\\/) {
    # Translate as a command and extract color value from the HTML tag
    &lst_translate_option;
    s/$O\d+$C//go;		# Get rid of bracket id's
    s/$OP\d+$CP//go;		# Get rid of processed bracket id's
    # Extract color value or clear the malformed contents
    $_ = ''
      unless (s/^\s*<FONT\s+COLOR\s*=\s*"\s*// && s/\s*"\s*>\s*<\/FONT>\s*$//);
  } else {
    # Must be a \color command
    $_ = '';
  }
  $rulecolor = $_;
  $rulecolor = " BORDERCOLOR=\"$rulecolor\"" unless ($rulecolor eq '');

  # Evtl use GNU pygmentize to produce colorized output
  my($lst_lang,$lst_lnum) = ('','');
  if ($USE_HILITE) {
    unless ($SRCHILITE ne '' && -x $SRCHILITE) {
      print "\n\npygmentize executable not available :$SRCHILITE:\n";
      print "Generating listings via builtin engine\n\n";
      &write_warnings("\npygmentize executable not available");
      &write_warnings("Generating listings via builtin engine");
      $USE_HILITE = 0;
    }
  }
  if ($USE_HILITE) {
    unless (open (HILITE, ">.$dd${PREFIX}hilite.in")) {
      print "\n\nCannot create pygmentize input file: $!\n";
      print "Generating listings via builtin engine\n\n";
      &write_warnings("\nCannot create pygmentize input file: $!");
      &write_warnings("Generating listings via builtin engine");
      $USE_HILITE = 0;
    }
  }
  if ($USE_HILITE) {
    $lst_pre  =~ s/<PRE>//;	# pygmentize inserts <PRE> by itself
    $lst_post =~ s/<\/PRE>//;
    $_ = $curopts{'language'};
    s/$O\d+$C//go;		# Get rid of bracket id's
    s/$OP\d+$CP//go;		# Get rid of processed bracket id's
    ($option,$dum) = &get_verb_optional_argument;
    s/\s+//;			# Remove white space and make lowercase
    $_ = "\L$_";
    $option =~ s/\s+//;
    $option = "\L$option";
    # evtl language rewriting
    if ($_ eq 'c') {
      if ($option eq 'sharp') {
	$_ = 'csharp';
      }
    } elsif ($_ eq '') {
      $_ = 'txt';
    } else {
      $_ = $lstset_langs{$_} if exists ($lstset_langs{$_});
    }
    $lst_lang = $_;
    $lst_lnum = "--line-number=' '" if $curopts{'numbers'} eq 'left';
  }

  $lst_pre  = $bstyle_open.$lst_pre."\n";
  $lst_post = "\n".$lst_post.$bstyle_close;
  $_ = $contents;

  if ($USE_HILITE) {
    # source-highlight can generate line numbers (left only) by itself
    s/^\n//;				# remove leading vertical space
    $_ = &revert_to_raw_tex ($_);
    print HILITE $_;
    close (HILITE);
    my $cmd = "$SRCHILITE -f html -O noclasses -l $lst_lang .$dd${PREFIX}hilite.in";
    print "\n\nRunning $cmd\n\n";
    $_ = `$cmd`;
#    unlink (".$dd${PREFIX}hilite.in");
    s/\n$//;				# remove trailing vertical space
  } else {
    # Evtl generate line numbers by builtin engine
    if ($curopts{'numbers'} eq 'left') {
      # Insert numbers from the left side.
      $counter = $fcount-$incr;
      s/^/$i++; $counter+=$incr;
      (($counter % $step) &&
      ($curopts{'numberfirstline'} ne 'true' || $i > 1)) ?
      ('     ' . ' ' x $nspaces) :
      (sprintf("%5d",$counter) . ' ' x $nspaces)/mge;
      $lst_last_counter = $counter+$incr;
      $lst_auto_counter{$lst_name} = $lst_last_counter
	if $curopts{'firstnumber'} eq 'auto' && $lst_name ne '';
    } elsif ($curopts{'numbers'} eq 'right' && $HTML_VERSION > 2.1) {
      # Inserting right padded numbers for every line is tricky.
      # Do it as a table with two huge columns with verbatim contents.
      # But only if HTML version is high enough...
      s/$/$nlines++;''/mge;
      for ($counter=$fcount; $i<$nlines; $i++) {
	$cline .= (($counter % $step) &&
		   ($curopts{'numberfirstline'} ne 'true' || $i > 0)) ?
	  (' ' x $nspaces . "     \n") :
	  (' ' x $nspaces . sprintf("%d\n",$counter));
	$counter += $incr;
      }
      $lst_last_counter = $counter;
      $lst_auto_counter{$lst_name} = $lst_last_counter
	if $curopts{'firstnumber'} eq 'auto' && $lst_name ne '';
      $cline =~ s/\n$//;
      $_ = "<TABLE><TR><TD>"
	.$lst_pre.$_.$lst_post."</TD><TD ALIGN=\"RIGHT\">"
	.$lst_pre.$cline.$lst_post."</TD></TR></TABLE>";
      $lst_pre = $lst_post = '';
    }
  }

  # Frames, captions and coloring are generated also as a synthetic table
  if ($HTML_VERSION > 2.1) {
    $lst_pre = "<TABLE FRAME=\"$frame\" CELLPADDING=\"$framesep\""
      .$framerule.$bgcolor.$rulecolor.">"
      .(($caption ne '') ?
	("\n<CAPTION ALIGN=\"$cappos\">".$caption."</CAPTION>\n") : '')
      ."<TR><TD>\n".$lst_pre;
    $lst_post = $lst_post."\n</TD></TR></TABLE>";
  }

  # WHEW !!!
  $lst_pre.$_.$lst_post."\n";
}

# &get_next_optional_argument is not well suited for lstlisting
# Here is a special version of &get_next_optional_argument
sub get_verb_optional_argument {
  local($next, $pat);
  my($before, $match, $after);
  $next = $pat = $match = '';
  if (s/^(\[)/$pat=$1;''/eo) {
    # Find any kinds of braces not to stuck on [] evtl nested between them
    while (/$any_next_pair_pr_rx|$any_next_pair_rx4|$verb_braces_rx|\]/) {
      ($before, $match, $after) = ($`, $&, $');
      $next .= $before;
      $pat  .= $before;
      if ($match eq ']') {
	$pat .= $match;
	$_ = $after;
	# Before returning, remove comment mark and newline after closing ]
	s/^[ \t]*($comment_mark\d*[ \t]*)*\n//o;
	last;
      }
      $next .= $match;
      $pat  .= $match;
      $_ = $after;
    }
    if ($match ne ']') {
      # Closing ] not found, revert back $_ and clear arguments
      $_ = $pat . $_;
      $next = $pat = '';
    }
  }
  # Imitate return of &get_next_optional_argument
  ($next, $pat);
}

1;			# Must be last line
