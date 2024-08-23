# -*- perl -*-
#
# $Id:  $
#
# minted.perl
#   Georgy Salnikov <sge@nmr.nioch.nsc.ru> 24/08/20
#
# Extension to LaTeX2HTML V2024 to partly support the "minted" package.
#
# Partly derived from listings.perl
#
# Change Log:
# ===========
#
# $Log:  $
#
# Note:
# This module provides translation for the \minted environment
# and for some more commands of the minted.sty package
#
# Handling decisions are done together with verbatim by LaTeX2HTML main program
#
# Several global variables and arrays are defined in the initialization block
# of the LaTeX2HTML main program:
#
# %minted_current
# %minted_lex
# %mintinline_current
# %mintinline_lex
# %mint_langs
# $mint_last_counter
#

package main;

my $MINTED_HILITE = 1;

# This package very probably may be used in minted
&do_require_package("color");

# Implementation of \inputminted[]{}{}, preparation only
sub do_cmd_inputminted {
  local($_) = @_;
  local($outer,$lexer,$file);

  local($dum,$option) = &get_verb_optional_argument;
  $lexer = &missing_braces unless (
    (s/$next_pair_pr_rx/$lexer=$2;''/eo)
    ||(s/$next_pair_rx/$lexer=$2;''/eo));
  $lexer = "\L$lexer";
  $file = &missing_braces unless (
    (s/$next_pair_pr_rx/$file=$2;''/eo)
    ||(s/$next_pair_rx/$file=$2;''/eo));
  $outer = $_;

  local($closures,$reopens) = &preserve_open_tags;
  my ($verb_pre,$verb_post) = ('<PRE>','</PRE>');
  if ($USING_STYLES) {
    $env_id .= ' CLASS="verbatim"' unless ($env_id =~ /(^|\s)CLASS\s*\=/i);
    $verb_pre =~ s/>/ $env_id>/;
  }

  # %verbatim not coupled to a dbm => will not work in subprocesses, but don't mind
  $verbatim{++$global{'verbatim_counter'}} = $option.'{'.$lexer.'}'.$file;

  # Do nothing here, just wrap into a verbatim-like minted environment.
  # File reading and decorating postponed to &process_minted.
  join('', $closures, $verb_pre
       , $verbatim_mark, 'mintfile', $global{'verbatim_counter'}
       , '#', $verb_post, $reopens, $outer);
}

# Implementation of \setminted[]{}, preparation only
sub do_cmd_setminted {
  local($_) = @_;
  local($dum,$lexer) = &get_verb_optional_argument;
  $lexer = "\L$lexer";
  local($option) = &missing_braces unless (
    (s/$next_pair_pr_rx/$option=$2;''/eo)
    ||(s/$next_pair_rx/$option=$2;''/eo));
  local($outer) = $_;

  # In preamble this just initializes the defaults
  if ($PREAMBLE) {
    $dum = "\L$dum";
    my(%opts) = &lst_parse_options($option);
    if ($dum eq '') {
      @minted_current{keys %opts} = (values %opts);
    } else {
      @{$minted_lex{$dum}}{keys %opts} = (values %opts);
    }
    return $outer;
  }

  # Do nothing here, just wrap into a verbatim-like setminted environment.
  # Processing options will be done later by &process_minted.
  local($closures,$reopens) = &preserve_open_tags;
  $verbatim{++$global{'verbatim_counter'}} = $lexer.$option;
  join('', $closures, $verbatim_mark, 'setminted', $global{'verbatim_counter'},
       '#', $reopens, $outer);
}

# Implementation of \setmintedinline[]{}, preparation only
sub do_cmd_setmintedinline {
  local($_) = @_;
  local($dum,$lexer) = &get_verb_optional_argument;
  $lexer = "\L$lexer";
  local($option) = &missing_braces unless (
    (s/$next_pair_pr_rx/$option=$2;''/eo)
    ||(s/$next_pair_rx/$option=$2;''/eo));
  local($outer) = $_;

  # In preamble this just initializes the defaults
  if ($PREAMBLE) {
    $dum = "\L$dum";
    my(%opts) = &lst_parse_options($option);
    if ($dum eq '') {
      @mintinline_current{keys %opts} = (values %opts);
    } else {
      @{$mintinline_lex{$dum}}{keys %opts} = (values %opts);
    }
    return $outer;
  }

  # Do nothing here, just wrap into a verbatim-like setmintedinline environment.
  # Processing options will be done later by &process_minted.
  local($closures,$reopens) = &preserve_open_tags;
  $verbatim{++$global{'verbatim_counter'}} = $lexer.$option;
  join('', $closures, $verbatim_mark, 'setmintedinline',
       $global{'verbatim_counter'}, '#', $reopens, $outer);
}

# Implementation of \usemintedstyle[]{}, preparation only
sub do_cmd_usemintedstyle {
  local($_) = @_;
  local($dum,$lexer) = &get_verb_optional_argument;
  $lexer = "\L$lexer";
  local($style) = &missing_braces unless (
    (s/$next_pair_pr_rx/$style=$2;''/eo)
    ||(s/$next_pair_rx/$style=$2;''/eo));
  local($outer) = $_;

  # In preamble this just initializes the defaults
  if ($PREAMBLE) {
    $dum = "\L$dum";
    if ($dum eq '') {
      $minted_current{'style'} = $style;
    } else {
      $minted_lex{$dum}{'style'} = $style;
    }
    return $outer;
  }

  # Do nothing here, just wrap into a verbatim-like setminted environment.
  # Processing options will be done later by &process_minted.
  local($closures,$reopens) = &preserve_open_tags;
  $verbatim{++$global{'verbatim_counter'}} = $lexer.$style;
  join('', $closures, $verbatim_mark, 'usemintedstyle',
       $global{'verbatim_counter'}, '#', $reopens, $outer);
}

# This is the main driver subroutine for the minted environment
sub process_minted {
  local($lst_pre, $lst_post, $lst_cmd, $_) = @_;

  # Check if it was an auxiliary command wrapped into an environment
  if ($lst_cmd eq 'setminted')       { return &set_setminted($_);       }
  if ($lst_cmd eq 'setmintedinline') { return &set_setmintedinline($_); }
  if ($lst_cmd eq 'usemintedstyle')  { return &set_usemintedstyle($_);  }

  # Process an actual minted environment
  local($option,$dum) = &get_verb_optional_argument;
  local($lexer) = &missing_braces unless (
    (s/$next_pair_pr_rx/$lexer=$2;''/eo)
    ||(s/$next_pair_rx/$lexer=$2;''/eo)
    ||(s/$verb_braces_rx/$lexer=$1;''/eo));
  $lexer = "\L$lexer";
  local($contents) = $_;

  # Fetch current defaults and apply specified options...
  my(%curopts) = %minted_current;
  my(%opts) = &lst_parse_options($option);

  # First of all, apply language specific options if any
  @curopts{keys %{$minted_lex{$lexer}}} = (values %{$minted_lex{$lexer}});

  # Now apply all the other specified options
  @curopts{keys %opts} = (values %opts);

  # For wrapped inputminted - replace file name with file contents
  if ($lst_cmd eq 'mintfile') {
    my($dir);
    my($file) = $contents;
    my($file2) = "$file.tex";
    if ($file !~ /\.tex$/) {
      # 2nd choice is better than 1st - TeXnical quirk
      ($file,$file2) = ($file2,$file);
    }
    my($found) = 0;
    foreach $dir ("$texfilepath", split(/:/,$ENV{'TEXINPUTS'})) { 
      if (-f ($_ = "$dir/$file") || -f ($_ = "$dir/$file2")) {
	$found = 1;
	# overread $_ with file contents
	&slurp_input($_);
	last;
      }
    }
    &write_warnings("No file <$file> for inputminted.") unless $found;
    # pre_process file contents
    if (defined &replace_all_html_special_chars) {
      &replace_all_html_special_chars;
    } else {
      &replace_html_special_chars;
    }
    s/\n$//;		# vertical space is contributed by </PRE> already.
    $contents = $_;
  }

  # Interpret the rest of options in sequence...
  # Line numbering (linenos,numbers,stepnumber,numberfirstline,numbersep,firstnumber)
  my($i, $counter, $cline, $nlines);
  $cline = '';
  $i = $counter = $nlines = 0;
  my($step) = sprintf("%.0f", $curopts{'stepnumber'});
  my($incr) = $step<=>0;
  $curopts{'linenos'} = 'true' if ($curopts{'numbers'} ne 'none');
  $curopts{'numbers'} = 'none' if ($curopts{'linenos'} ne 'true' || !$incr);
  $curopts{'numbers'} = 'left' if ($curopts{'linenos'} eq 'true' &&
				   $curopts{'numbers'} eq 'none' && $incr);
  my($nspaces);
  ($nspaces, $dum) = &convert_length ($curopts{'numbersep'}, 1);
  $nspaces = sprintf("%.0f", $nspaces/10);
  my($fcount) = $curopts{'firstnumber'};
  if ($fcount eq 'auto') {
    $fcount = 1;
  } elsif ($fcount eq 'last') {
    $fcount = $mint_last_counter;
  } else {
    $fcount = sprintf("%.0f", $fcount);
  }

  # Framing options group (frame, framesep, framerule)
  my($frame) = 'VOID';
  $frame = 'LHS'    if ($curopts{'frame'} eq 'leftline');
  $frame = 'ABOVE'  if ($curopts{'frame'} eq 'topline');
  $frame = 'BELOW'  if ($curopts{'frame'} eq 'bottomline');
  $frame = 'HSIDES' if ($curopts{'frame'} eq 'lines');
  $frame = 'BORDER' if ($curopts{'frame'} eq 'single');
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

  # Coloring options group (bgcolor, rulecolor)
  my($bgcolor) = $curopts{'bgcolor'};
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
  }
  $rulecolor = $_;
  $rulecolor = " BORDERCOLOR=\"$rulecolor\"" unless ($rulecolor eq '');

  # Evtl use Pygments or GNU source-highlight to produce colorized output
  my($lst_lnum,$mint_style) = ('','');
  if ($MINTED_HILITE) {
    unless ($SRCHILITE ne '' && -x $SRCHILITE) {
      if ($SRCHILITE ne '') {
	print "\n\n$SRCHILITE cannot be executed\n";
	&write_warnings("\n$SRCHILITE cannot be executed");
      } else {
	print "\n\npygmentize or source-highlight executable not available\n";
	&write_warnings("\npygmentize or source-highlight executable not available");
      }
      print "Generating listings via builtin engine\n\n";
      &write_warnings("Generating listings via builtin engine");
      $MINTED_HILITE = 0;
    }
  }
  if ($MINTED_HILITE) {
    unless (open (HILITE, ">.$dd${PREFIX}hilite.in")) {
      print "\n\nCannot create pygmentize or source-highlight input file: $!\n";
      print "Generating listings via builtin engine\n\n";
      &write_warnings("\nCannot create pygmentize or source-highlight input file: $!");
      &write_warnings("Generating listings via builtin engine");
      $MINTED_HILITE = 0;
    }
  }
  if ($MINTED_HILITE) {
    $lst_pre  =~ s/<PRE[^>]*>//;# highlighting engine inserts <PRE> by itself
    $lst_post =~ s/<\/PRE>//;
    # evtl language rewriting (for source-highlight only)
    $lexer = 'text' if $lexer eq '';
    unless ($SRCHILITE =~ /pygmentize/) {
      $lexer = $mint_langs{$lexer} if exists ($mint_langs{$lexer});
    }
    if ($curopts{'numbers'} eq 'left')
    {
      if ($SRCHILITE =~ /pygmentize/) {
	$lst_lnum = ",linenos=table";
      } else {
	$lst_lnum = "--line-number=' '";
      }
    }
    $mint_style = ",style=$curopts{'style'}" if $curopts{'style'} ne '';
  }

  $_ = $contents;

  if ($MINTED_HILITE) {
    # Pygments and source-highlight can generate line numbers by themselves
    s/^\n//;				# remove leading vertical space
    $_ = &revert_to_raw_tex ($_);
    print HILITE $_;
    close (HILITE);
    if ($SRCHILITE =~ /pygmentize/) {
      print "\n\nRunning $SRCHILITE $HILITE_OPTS -l $lexer -f html -O noclasses,nobackground$mint_style$lst_lnum .$dd${PREFIX}hilite.in\n\n";
      $_ = `$SRCHILITE $HILITE_OPTS -l $lexer -f html -O noclasses,nobackground$mint_style$lst_lnum .$dd${PREFIX}hilite.in`;
      s/<pre\s+style="line-height:\s*\d+%;">/<pre>/;	# clear extra style
    } else {
      print "\n\nRunning $SRCHILITE $HILITE_OPTS --failsafe $lst_lnum -s $lexer -i .$dd${PREFIX}hilite.in\n\n";
      $_ = `$SRCHILITE $HILITE_OPTS --failsafe $lst_lnum -s $lexer -i .$dd${PREFIX}hilite.in`;
    }
    unlink (".$dd${PREFIX}hilite.in");
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
      $mint_last_counter = $counter+$incr;
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
      $mint_last_counter = $counter;
      $cline =~ s/\n$//;
      $_ = "<TABLE><TR><TD>"
	.$lst_pre.$_.$lst_post."</TD><TD ALIGN=\"RIGHT\">"
	.$lst_pre.$cline.$lst_post."</TD></TR></TABLE>";
      $lst_pre = $lst_post = '';
    }
  }

  # Frames and coloring are generated also as a synthetic table
  if ($HTML_VERSION > 2.1) {
    $lst_pre = "<TABLE FRAME=\"$frame\" CELLPADDING=\"$framesep\""
      .$framerule.$bgcolor.$rulecolor.">"
      ."<TR><TD>\n".$lst_pre;
    $lst_post = $lst_post."\n</TD></TR></TABLE>";
  }

  # WHEW !!!
  $lst_pre.$_.$lst_post."\n";
}

# Driver subroutine for the real processing of \mint command
sub process_mint {
  local($_, $lexer, $contents) = @_;
  local($lst_pre, $lst_post) = ('<PRE>', '</PRE>');

  # Process an actual mint command
  local($option,$dum) = &get_verb_optional_argument;
  $_ = $lexer;
  $lexer = &missing_braces unless (
    (s/$next_pair_pr_rx/$lexer=$2;''/eo)
    ||(s/$next_pair_rx/$lexer=$2;''/eo)
    ||(s/$verb_braces_rx/$lexer=$1;''/eo));
  $lexer = "\L$lexer";

  # Fetch current defaults and apply specified options...
  my(%curopts) = %minted_current;
  my(%opts) = &lst_parse_options($option);

  # First of all, apply language specific options if any
  @curopts{keys %{$minted_lex{$lexer}}} = (values %{$minted_lex{$lexer}});

  # Now apply all the other specified options
  @curopts{keys %opts} = (values %opts);

  # Interpret the rest of options in sequence...
  # Line numbering (linenos,numbers,stepnumber,numberfirstline,numbersep,firstnumber)
  my($i, $counter, $cline, $nlines);
  $cline = '';
  $i = $counter = $nlines = 0;
  my($step) = sprintf("%.0f", $curopts{'stepnumber'});
  my($incr) = $step<=>0;
  $curopts{'linenos'} = 'true' if ($curopts{'numbers'} ne 'none');
  $curopts{'numbers'} = 'none' if ($curopts{'linenos'} ne 'true' || !$incr);
  $curopts{'numbers'} = 'left' if ($curopts{'linenos'} eq 'true' &&
				   $curopts{'numbers'} eq 'none' && $incr);
  my($nspaces);
  ($nspaces, $dum) = &convert_length ($curopts{'numbersep'}, 1);
  $nspaces = sprintf("%.0f", $nspaces/10);
  my($fcount) = $curopts{'firstnumber'};
  if ($fcount eq 'auto') {
    $fcount = 1;
  } elsif ($fcount eq 'last') {
    $fcount = $mint_last_counter;
  } else {
    $fcount = sprintf("%.0f", $fcount);
  }

  # Framing options group (frame, framesep, framerule)
  my($frame) = 'VOID';
  $frame = 'LHS'    if ($curopts{'frame'} eq 'leftline');
  $frame = 'ABOVE'  if ($curopts{'frame'} eq 'topline');
  $frame = 'BELOW'  if ($curopts{'frame'} eq 'bottomline');
  $frame = 'HSIDES' if ($curopts{'frame'} eq 'lines');
  $frame = 'BORDER' if ($curopts{'frame'} eq 'single');
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

  # Coloring options group (bgcolor, rulecolor)
  my($bgcolor) = $curopts{'bgcolor'};
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
  }
  $rulecolor = $_;
  $rulecolor = " BORDERCOLOR=\"$rulecolor\"" unless ($rulecolor eq '');

  # Evtl use Pygments or GNU source-highlight to produce colorized output
  my($lst_lnum,$mint_style) = ('','');
  if ($MINTED_HILITE) {
    unless ($SRCHILITE ne '' && -x $SRCHILITE) {
      if ($SRCHILITE ne '') {
	print "\n\n$SRCHILITE cannot be executed\n";
	&write_warnings("\n$SRCHILITE cannot be executed");
      } else {
	print "\n\npygmentize or source-highlight executable not available\n";
	&write_warnings("\npygmentize or source-highlight executable not available");
      }
      print "Generating listings via builtin engine\n\n";
      &write_warnings("Generating listings via builtin engine");
      $MINTED_HILITE = 0;
    }
  }
  if ($MINTED_HILITE) {
    unless (open (HILITE, ">.$dd${PREFIX}hilite.in")) {
      print "\n\nCannot create pygmentize or source-highlight input file: $!\n";
      print "Generating listings via builtin engine\n\n";
      &write_warnings("\nCannot create pygmentize or source-highlight input file: $!");
      &write_warnings("Generating listings via builtin engine");
      $MINTED_HILITE = 0;
    }
  }
  if ($MINTED_HILITE) {
    $lst_pre  =~ s/<PRE[^>]*>//;# highlighting engine inserts <PRE> by itself
    $lst_post =~ s/<\/PRE>//;
    # evtl language rewriting (for source-highlight only)
    $lexer = 'text' if $lexer eq '';
    unless ($SRCHILITE =~ /pygmentize/) {
      $lexer = $mint_langs{$lexer} if exists ($mint_langs{$lexer});
    }
    if ($curopts{'numbers'} eq 'left')
    {
      if ($SRCHILITE =~ /pygmentize/) {
	$lst_lnum = ",linenos=table";
      } else {
	$lst_lnum = "--line-number=' '";
      }
    }
    $mint_style = ",style=$curopts{'style'}" if $curopts{'style'} ne '';
  }

  $_ = $contents;

  if ($MINTED_HILITE) {
    # Pygments and source-highlight can generate line numbers by themselves
    s/^\n//;				# remove leading vertical space
    $_ = &revert_to_raw_tex ($_);
    print HILITE $_;
    close (HILITE);
    if ($SRCHILITE =~ /pygmentize/) {
      print "\n\nRunning $SRCHILITE $HILITE_OPTS -l $lexer -f html -O noclasses,nobackground$mint_style$lst_lnum .$dd${PREFIX}hilite.in\n\n";
      $_ = `$SRCHILITE $HILITE_OPTS -l $lexer -f html -O noclasses,nobackground$mint_style$lst_lnum .$dd${PREFIX}hilite.in`;
      s/<pre\s+style="line-height:\s*\d+%;">/<pre>/;	# clear extra style
    } else {
      print "\n\nRunning $SRCHILITE $HILITE_OPTS --failsafe $lst_lnum -s $lexer -i .$dd${PREFIX}hilite.in\n\n";
      $_ = `$SRCHILITE $HILITE_OPTS --failsafe $lst_lnum -s $lexer -i .$dd${PREFIX}hilite.in`;
    }
    unlink (".$dd${PREFIX}hilite.in");
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
      $mint_last_counter = $counter+$incr;
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
      $mint_last_counter = $counter;
      $cline =~ s/\n$//;
      $_ = "<TABLE><TR><TD>"
	.$lst_pre.$_.$lst_post."</TD><TD ALIGN=\"RIGHT\">"
	.$lst_pre.$cline.$lst_post."</TD></TR></TABLE>";
      $lst_pre = $lst_post = '';
    }
  }

  # Frames and coloring are generated also as a synthetic table
  if ($HTML_VERSION > 2.1) {
    $lst_pre = "<TABLE FRAME=\"$frame\" CELLPADDING=\"$framesep\""
      .$framerule.$bgcolor.$rulecolor.">"
      ."<TR><TD>\n".$lst_pre;
    $lst_post = $lst_post."\n</TD></TR></TABLE>";
  }

  # WHEW !!!
  $lst_pre.$_.$lst_post."\n";
}

# Driver subroutine for the real processing of \mintinline command
sub process_mintinline {
  local($_, $lexer, $contents) = @_;

  # Get mintinline options
  local($option,$dum) = &get_verb_optional_argument;
  $_ = $lexer;
  $lexer = &missing_braces unless (
    (s/$next_pair_pr_rx/$lexer=$2;''/eo)
    ||(s/$next_pair_rx/$lexer=$2;''/eo)
    ||(s/$verb_braces_rx/$lexer=$1;''/eo));
  $lexer = "\L$lexer";

  # Fetch current defaults and apply specified options...
  my(%curopts) = %minted_current;
  my(%opts) = &lst_parse_options($option);

  # First of all, apply language specific options if any
  @curopts{keys %{$minted_lex{$lexer}}} = (values %{$minted_lex{$lexer}});

  # Now apply mintinline specific options if any
  @curopts{keys %mintinline_current} = (values %mintinline_current);
  @curopts{keys %{$mintinline_lex{$lexer}}} = (values %{$mintinline_lex{$lexer}});

  # Now apply all the other specified options
  @curopts{keys %opts} = (values %opts);

  # Evtl use Pygments or GNU source-highlight to produce colorized output
  my($mint_style) = '';
  if ($MINTED_HILITE) {
    unless ($SRCHILITE ne '' && -x $SRCHILITE) {
      if ($SRCHILITE ne '') {
	print "\n\n$SRCHILITE cannot be executed\n";
	&write_warnings("\n$SRCHILITE cannot be executed");
      } else {
	print "\n\npygmentize or source-highlight executable not available\n";
	&write_warnings("\npygmentize or source-highlight executable not available");
      }
      print "Generating listings via builtin engine\n\n";
      &write_warnings("Generating listings via builtin engine");
      $MINTED_HILITE = 0;
    }
  }
  if ($MINTED_HILITE) {
    unless (open (HILITE, ">.$dd${PREFIX}hilite.in")) {
      print "\n\nCannot create pygmentize or source-highlight input file: $!\n";
      print "Generating listings via builtin engine\n\n";
      &write_warnings("\nCannot create pygmentize or source-highlight input file: $!");
      &write_warnings("Generating listings via builtin engine");
      $MINTED_HILITE = 0;
    }
  }
  if ($MINTED_HILITE) {
    # evtl language rewriting (for source-highlight only)
    $lexer = 'text' if $lexer eq '';
    unless ($SRCHILITE =~ /pygmentize/) {
      $lexer = $mint_langs{$lexer} if exists ($mint_langs{$lexer});
    }
    # style seems the only option which can be really useful for mintinline
    $mint_style = ",style=$curopts{'style'}" if $curopts{'style'} ne '';
    # Pygments and source-highlight can generate line numbers by themselves
    $contents =~ s/^\n//;		# remove leading vertical space
    $contents = &revert_to_raw_tex ($contents);
    print HILITE $contents;
    close (HILITE);
    if ($SRCHILITE =~ /pygmentize/) {
      print "\n\nRunning $SRCHILITE $HILITE_OPTS -l $lexer -f html -O noclasses,nobackground$mint_style .$dd${PREFIX}hilite.in\n\n";
      $contents = `$SRCHILITE $HILITE_OPTS -l $lexer -f html -O noclasses,nobackground$mint_style .$dd${PREFIX}hilite.in`;
      $contents =~ s/<pre\s+style="line-height:\s*\d+%;">/<pre>/;
    } else {
      print "\n\nRunning $SRCHILITE $HILITE_OPTS --failsafe -s $lexer -i .$dd${PREFIX}hilite.in\n\n";
      $contents = `$SRCHILITE $HILITE_OPTS --failsafe -s $lexer -i .$dd${PREFIX}hilite.in`;
    }
    unlink (".$dd${PREFIX}hilite.in");
    $contents =~ s/^.*?<pre>//s;	# remove obstructive starting stuff
    $contents =~ s/<\/pre>.*?$//s;	# remove obstructive trailing stuff
    $contents =~ s/\n$//;		# remove trailing vertical space
  }

  # Make the actual mintinline output
  '<code>'.$contents.'</code>';
}

# Driver subroutine for \setminted processing
# Just copy the given set of options to the default options set
sub set_setminted {
  local($_) = @_;
  local($lexer,$dum) = &get_verb_optional_argument;
  $lexer = "\L$lexer";
  my(%opts) = &lst_parse_options($_);
  if ($lexer eq '') {
    @minted_current{keys %opts} = (values %opts);
  } else {
    @{$minted_lex{$lexer}}{keys %opts} = (values %opts);
  }
  '';
}

# Driver subroutine for \setmintedinline processing
# Just copy the given set of options to the default options set
sub set_setmintedinline {
  local($_) = @_;
  local($lexer,$dum) = &get_verb_optional_argument;
  $lexer = "\L$lexer";
  my(%opts) = &lst_parse_options($_);
  if ($lexer eq '') {
    @mintinline_current{keys %opts} = (values %opts);
  } else {
    @{$mintinline_lex{$lexer}}{keys %opts} = (values %opts);
  }
  '';
}

# Driver subroutine for \usemintedstyle processing
# Just copy the given style to the default options set
sub set_usemintedstyle {
  local($_) = @_;
  local($lexer,$dum) = &get_verb_optional_argument;
  $lexer = "\L$lexer";
  local($style) = $_;
  if ($lexer eq '') {
    $minted_current{'style'} = $style;
  } else {
    $minted_lex{$lexer}{'style'} = $style;
  }
  '';
}

# Option parser for minted commands/envs family, this can be tricky
sub lst_parse_options {
  local($_) = @_;

  # First get rid of comment marks
  s/(\\\w+)$comment_mark\d*\s*?\n[ \t]*/$1 \n/go;
  s/($comment_mark\d*\s*)+\n[ \t]*/\n/go;

  # Find any kinds of brackets to keep them intact
  # for the case if they might have commas inside
  my(@fields, @chunks);
  my($before, $match, $after);
  while (/$any_next_pair_pr_rx|$any_next_pair_rx4|$opt_arg_rx|$verb_braces_rx/)
  {
    ($before, $match, $after) = ($`, $&, $');
    @chunks = split(/,/, $before);
    $fields[$#fields] .= shift(@chunks) if @fields;
    push(@fields, @chunks);
    $fields[$#fields] .= $match;
    $_ = $after;
  }
  @chunks = split(/,/);
  $fields[$#fields] .= shift(@chunks) if @fields;
  push(@fields, @chunks);

  # All options are separated, now split them to option name and value
  my(%opts);
  my($par, $val);
  foreach (@fields) {
    if (($par, $val) = /^\s*(\w+?)\s*=\s*(.*)\s*$/s) {
      $opts{$par} = $val;
    } elsif (($par) = /^\s*(\w+?)\s*$/s) {	# boolean option
      $opts{$par} = 'true';
    }
  }
  %opts;
}

# Replace braces with marks and try to interpret this as a bracketed command
sub lst_translate_option {
  # Modifies $_
  &mark_string($_);
  my($br_id) = ++$global{'max_id'};
  $_ = $O.$br_id.$C.$_.$O.$br_id.$C;
  $_ = &translate_environments($_);
  $_ = &translate_commands($_);
}

# &get_next_optional_argument is not well suited for minted
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

&process_commands_wrap_deferred (<<_RAW_ARG_DEFERRED_CMDS_);
inputminted # [] # {} # {}
setminted # [] # {}
setmintedinline # [] # {}
usemintedstyle # [] # {}
_RAW_ARG_DEFERRED_CMDS_

1;			# Must be last line
