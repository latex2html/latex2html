# -*- perl -*-
#
# $Id: verbatim.perl,v 1.10 2001/11/29 21:44:13 RRM Exp $
#
# listings.perl
#   Georgy Salnikov <sge@nmr.nioch.nsc.ru> 13/10/20
#
# Extension to LaTeX2HTML V2018 to partly support the "listings" package.
#
# Partly derived from verbatim.perl and verbatimfiles.perl
#
# Change Log:
# ===========
#
# $Log: verbatim.perl,v $
#
# Note:
# This module provides translation for the \lstlisting environment
# and for some more commands of the listings.sty package
#
# Handling decisions are done together with verbatim by LaTeX2HTML main program
#
# Several global variables and arrays are defined in the initialization block
# of the LaTeX2HTML main program:
#
# %lstset_current
# %lstset_langs
# %lstset_pylangs
# %lstset_style
# $lst_name
# $lst_last_counter
# %lst_auto_counter
#

package main;

# This package very probably may be used in listings
&do_require_package("color");

# Implementation of \lstinputlisting[]{}, preparation only
sub do_cmd_lstinputlisting {
  local($_) = @_;
  local($outer,$file);

  local($dum,$option) = &get_verb_optional_argument;
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
  $verbatim{++$global{'verbatim_counter'}} = $option.$file;

  # Do nothing here, just wrap into a verbatim-like lstfile environment.
  # File reading and decorating postponed to &process_lstlisting.
  join('', $closures, $verb_pre
       , $verbatim_mark, 'lstfile', $global{'verbatim_counter'}
       , '#', $verb_post, $reopens, $outer);
}

# Implementation of \lstset{}, preparation only
sub do_cmd_lstset {
  local($_) = @_;
  local($option) = &missing_braces unless (
    (s/$next_pair_pr_rx/$option=$2;''/eo)
    ||(s/$next_pair_rx/$option=$2;''/eo));
  local($outer) = $_;

  # In preamble this just initializes the defaults
  if ($PREAMBLE) {
    my(%opts) = &lst_parse_options($option);
    @lstset_current{keys %opts} = (values %opts);
    return $outer;
  }

  # Do nothing here, just wrap into a verbatim-like lstset environment.
  # Processing options will be done later by &process_lstlisting.
  local($closures,$reopens) = &preserve_open_tags;
  $verbatim{++$global{'verbatim_counter'}} = $option;
  join('', $closures, $verbatim_mark, 'lstset', $global{'verbatim_counter'},
       '#', $reopens, $outer);
}

# Implementation of \lstdefinestyle{}{}, preparation only
sub do_cmd_lstdefinestyle {
  local($_) = @_;
  local($style) = &missing_braces unless (
    (s/$next_pair_pr_rx/$style=$2;''/eo)
    ||(s/$next_pair_rx/$style=$2;''/eo));
  local($option) = &missing_braces unless (
    (s/$next_pair_pr_rx/$option=$2;''/eo)
    ||(s/$next_pair_rx/$option=$2;''/eo));
  local($outer) = $_;

  # In preamble this just creates the new style
  if ($PREAMBLE) {
    my(%opts) = &lst_parse_options($option);
    @{$lstset_style{$style}}{keys %opts} = (values %opts);
    return $outer;
  }

  # Do nothing here, just wrap into a verbatim-like lststyle environment.
  # Processing options will be done later by &process_lstlisting.
  local($closures,$reopens) = &preserve_open_tags;
  $verbatim{++$global{'verbatim_counter'}} = join(',', $style, $option);
  join('', $closures, $verbatim_mark, 'lststyle', $global{'verbatim_counter'},
       '#', $reopens, $outer);
}

# Implementation of \lstname, not much to do
sub do_cmd_lstname { $lst_name . $_[0]; }

# This is the main driver subroutine for the lstlisting environment
sub process_lstlisting {
  local($lst_pre, $lst_post, $lst_cmd, $_) = @_;

  # Check if it was an auxiliary command wrapped into an environment
  if ($lst_cmd eq 'lstset')   { return &set_lstset($_);   }
  if ($lst_cmd eq 'lststyle') { return &set_lststyle($_); }

  # Process an actual lstlisting environment
  local($option,$dum) = &get_verb_optional_argument;
  local($contents) = $_;

  # Fetch current defaults and apply specified options...
  my(%curopts) = %lstset_current;
  my(%opts) = &lst_parse_options($option);

  # First of all, apply either specified or default style if given
  if ($opts{'style'} ne '') {
    @curopts{keys %{$lstset_style{$opts{'style'}}}} =
      (values %{$lstset_style{$opts{'style'}}});
  }
  elsif ($lstset_current{'style'} ne '') {
    @curopts{keys %{$lstset_style{$lstset_current{'style'}}}} =
      (values %{$lstset_style{$lstset_current{'style'}}});
  }

  # Now apply all the other specified options
  @curopts{keys %opts} = (values %opts);

  $lst_name = $curopts{'name'};

  # For wrapped lstinputlisting - replace file name with file contents
  if ($lst_cmd eq 'lstfile') {
    my($dir);
    my($file) = $contents;
    $lst_name = $file;
    my($file2) = "$file.tex";
    if ($file !~ /\.tex$/) {
      # 2nd choice is better than 1st - TeXnical quirk
      ($file,$file2) = ($file2,$file);
    }
    my($inputpath) = $curopts{'inputpath'};
    my($found) = 0;
    foreach $dir ("$texfilepath", split(/:/,$ENV{'TEXINPUTS'})) { 
      if (-f ($_ = "$dir/$inputpath/$file") ||
	  -f ($_ = "$dir/$inputpath/$file2") ||
	  -f ($_ = "$dir/$file") ||
	  -f ($_ = "$dir/$file2")) {
	$found = 1;
	# overread $_ with file contents
	&slurp_input($_);
	last;
      }
    }
    &write_warnings("No file <$file> for lstinputlisting.") unless $found;
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
  # Line numbering (numbers,stepnumber,numberfirstline,numbersep,firstnumber)
  my($i, $counter, $cline, $nlines);
  $cline = '';
  $i = $counter = $nlines = 0;
  my($step) = sprintf("%.0f", $curopts{'stepnumber'});
  my($incr) = $step<=>0;
  $curopts{'numbers'} = 'none' if (! $incr);
  my($nspaces);
  ($nspaces, $dum) = &convert_length ($curopts{'numbersep'}, 1);
  $nspaces = sprintf("%.0f", $nspaces/10);
  my($fcount) = $curopts{'firstnumber'};
  if ($fcount eq 'auto') {
    $fcount = 1;
    if ($lst_name ne '' && $curopts{'numbers'} ne 'none') {
      $lst_auto_counter{$lst_name} = 1
	unless (exists ($lst_auto_counter{$lst_name}));
      $fcount = $lst_auto_counter{$lst_name};
    }
  } elsif ($fcount eq 'last') {
    $fcount = $lst_last_counter;
  } else {
    $fcount = sprintf("%.0f", $fcount);
  }

  # Captioning options group (title, caption, captionpos)
  my($title, $caption, $cappos);
  $cappos = 'TOP';
  $cappos = 'BOTTOM' if ($curopts{'captionpos'} eq 'b');
  $title  = '';
  if ($curopts{'title'} ne '') {
    $_ = $curopts{'title'};
    # Replace braces with marks and try to interpret this as bracketed command
    &lst_translate_option;
    &replace_markers;
    s/^\s+//;
    s/\s+$//;
    $title = $_;
  }
  $caption = '';
  if ($curopts{'caption'} ne '') {
    $_ = $curopts{'caption'};
    # Replace braces with marks and try to interpret this as bracketed command
    &lst_translate_option;
    &replace_markers;
    # Evtl separate short and full captions
    ($option,$dum) = &get_verb_optional_argument;
    s/^\s+//;
    s/\s+$//;
    $_ = $option if ($_ eq '');
    s/^\s+//;
    s/\s+$//;
    $caption = $_;
  }
  # If caption empty, use title
  if ($caption ne '') {
    $caption = 'Listing: ' . $caption;
  } else {
    $caption = $title;
  }

  # basicstyle option: convert it to a pair of opening and closing HTML tags
  my($bstyle_open, $bstyle_close);
  $_ = $curopts{'basicstyle'};
  # Replace braces with marks and try to interpret this as bracketed command
  &lst_translate_option;
  s/$O\d+$C//go;		# Get rid of bracket id's
  s/$OP\d+$CP//go;		# Get rid of processed bracket id's
  $bstyle_open = $bstyle_close = ''
    unless (s/^\s*((<\w+[^>]*>\s*)+)[^<]*((<\/\w+>\s*)+)$/$bstyle_open=$1;$bstyle_close=$3;''/eo);
  $bstyle_open  = $bstyle_open."\n"  if ($bstyle_open  ne '');
  $bstyle_close = "\n".$bstyle_close if ($bstyle_close ne '');

  # Framing options group (frame, framesep, framerule)
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

  # Evtl use Pygments or GNU source-highlight to produce colorized output
  my($lst_lang,$lst_lnum) = ('','');
  if ($USE_HILITE) {
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
      $USE_HILITE = 0;
    }
  }
  if ($USE_HILITE) {
    unless (open (HILITE, ">.$dd${PREFIX}hilite.in")) {
      print "\n\nCannot create pygmentize or source-highlight input file: $!\n";
      print "Generating listings via builtin engine\n\n";
      &write_warnings("\nCannot create pygmentize or source-highlight input file: $!");
      &write_warnings("Generating listings via builtin engine");
      $USE_HILITE = 0;
    }
  }
  if ($USE_HILITE) {
    $lst_pre  =~ s/<PRE[^>]*>//;# highlighting engine inserts <PRE> by itself
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
      } elsif ($option eq 'objective') {
	$_ = 'objc';
      }
    } elsif ($_ eq 'java') {
      if ($option eq 'aspectj') {
	$_ = 'aspectj';
      }
    } elsif ($_ eq '') {
      if ($SRCHILITE =~ /pygmentize/) {
	$_ = 'text';
      } else {
	$_ = 'txt';
      }
    } else {
      if ($SRCHILITE =~ /pygmentize/) {
	$_ = $lstset_pylangs{$_} if exists ($lstset_pylangs{$_});
      } else {
	$_ = $lstset_langs{$_} if exists ($lstset_langs{$_});
      }
    }
    $lst_lang = $_;
    if ($curopts{'numbers'} eq 'left')
    {
      if ($SRCHILITE =~ /pygmentize/) {
	$lst_lnum = ",linenos=table";
      } else {
	$lst_lnum = "--line-number=' '";
      }
    }
  }

  $lst_pre  = $bstyle_open.$lst_pre."\n";
  $lst_post = "\n".$lst_post.$bstyle_close;
  $_ = $contents;

  if ($USE_HILITE) {
    # Pygments and source-highlight can generate line numbers by themselves
    s/^\n//;				# remove leading vertical space
    $_ = &revert_to_raw_tex ($_);
    print HILITE $_;
    close (HILITE);
    if ($SRCHILITE =~ /pygmentize/) {
      print "\n\nRunning $SRCHILITE $HILITE_OPTS -l $lst_lang -f html -O noclasses,nobackground$lst_lnum .$dd${PREFIX}hilite.in\n\n";
      $_ = `$SRCHILITE $HILITE_OPTS -l $lst_lang -f html -O noclasses,nobackground$lst_lnum .$dd${PREFIX}hilite.in`;
      s/<pre\s+style="line-height:\s*\d+%;">/<pre>/;	# clear extra style
    } else {
      print "\n\nRunning $SRCHILITE $HILITE_OPTS --failsafe $lst_lnum -s $lst_lang -i .$dd${PREFIX}hilite.in\n\n";
      $_ = `$SRCHILITE $HILITE_OPTS --failsafe $lst_lnum -s $lst_lang -i .$dd${PREFIX}hilite.in`;
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

# Driver subroutine for the real processing of \lstinline command
sub process_lstinline {
  local($_, $contents) = @_;

  # Get lstinline options
  local($option,$dum) = &get_verb_optional_argument;

  # Fetch current defaults and apply specified options...
  my(%curopts) = %lstset_current;
  my(%opts) = &lst_parse_options($option);

  # First of all, apply either specified or default style if given
  if ($opts{'style'} ne '') {
    @curopts{keys %{$lstset_style{$opts{'style'}}}} =
      (values %{$lstset_style{$opts{'style'}}});
  }
  elsif ($lstset_current{'style'} ne '') {
    @curopts{keys %{$lstset_style{$lstset_current{'style'}}}} =
      (values %{$lstset_style{$lstset_current{'style'}}});
  }

  # Now apply all the other specified options
  @curopts{keys %opts} = (values %opts);

  # basicstyle seems the only option which can be really useful for lstinline
  my($bstyle_open, $bstyle_close);
  $_ = $curopts{'basicstyle'};
  # Replace braces with marks and try to interpret this as bracketed command
  &lst_translate_option;
  s/$O\d+$C//go;		# Get rid of bracket id's
  s/$OP\d+$CP//go;		# Get rid of processed bracket id's
  $bstyle_open = $bstyle_close = ''
    unless (s/^\s*((<\w+[^>]*>\s*)+)[^<]*((<\/\w+>\s*)+)$/$bstyle_open=$1;$bstyle_close=$3;''/eo);

  # Evtl use Pygments or GNU source-highlight to produce colorized output
  my($lst_lang) = '';
  if ($USE_HILITE) {
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
      $USE_HILITE = 0;
    }
  }
  if ($USE_HILITE) {
    unless (open (HILITE, ">.$dd${PREFIX}hilite.in")) {
      print "\n\nCannot create pygmentize or source-highlight input file: $!\n";
      print "Generating listings via builtin engine\n\n";
      &write_warnings("\nCannot create pygmentize or source-highlight input file: $!");
      &write_warnings("Generating listings via builtin engine");
      $USE_HILITE = 0;
    }
  }
  if ($USE_HILITE) {
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
      } elsif ($option eq 'objective') {
	$_ = 'objc';
      }
    } elsif ($_ eq 'java') {
      if ($option eq 'aspectj') {
	$_ = 'aspectj';
      }
    } elsif ($_ eq '') {
      if ($SRCHILITE =~ /pygmentize/) {
	$_ = 'text';
      } else {
	$_ = 'txt';
      }
    } else {
      if ($SRCHILITE =~ /pygmentize/) {
	$_ = $lstset_pylangs{$_} if exists ($lstset_pylangs{$_});
      } else {
	$_ = $lstset_langs{$_} if exists ($lstset_langs{$_});
      }
    }
    $lst_lang = $_;
    $contents =~ s/^\n//;		# remove leading vertical space
    $contents = &revert_to_raw_tex ($contents);
    print HILITE $contents;
    close (HILITE);
    if ($SRCHILITE =~ /pygmentize/) {
      print "\n\nRunning $SRCHILITE $HILITE_OPTS -l $lst_lang -f html -O noclasses,nobackground .$dd${PREFIX}hilite.in\n\n";
      $contents = `$SRCHILITE $HILITE_OPTS -l $lst_lang -f html -O noclasses,nobackground .$dd${PREFIX}hilite.in`;
      $contents =~ s/<pre\s+style="line-height:\s*\d+%;">/<pre>/;
    } else {
      print "\n\nRunning $SRCHILITE $HILITE_OPTS --failsafe -s $lst_lang -i .$dd${PREFIX}hilite.in\n\n";
      $contents = `$SRCHILITE $HILITE_OPTS --failsafe -s $lst_lang -i .$dd${PREFIX}hilite.in`;
    }
    unlink (".$dd${PREFIX}hilite.in");
    $contents =~ s/^.*?<pre>//s;	# remove obstructive starting stuff
    $contents =~ s/<\/pre>.*?$//s;	# remove obstructive trailing stuff
    $contents =~ s/\n$//;		# remove trailing vertical space
  }

  # Make the actual lstinline output
  $bstyle_open.'<code>'.$contents.'</code>'.$bstyle_close;
}

# Driver subroutine for \lstset processing
# Just copy the given set of options to the default options set
sub set_lstset {
  local($_) = @_;
  my(%opts) = &lst_parse_options($_);
  @lstset_current{keys %opts} = (values %opts);
  '';
}

# Driver subroutine for \lstdefinestyle
# Similar to the preceding but maintains distinct named options sets (styles)
sub set_lststyle {
  local($_) = @_;
  local($style) = '' unless (s/^(\w+),/$style=$1;''/eo);
  return '' if ($style eq '');
  my(%opts) = &lst_parse_options($_);
  @{$lstset_style{$style}}{keys %opts} = (values %opts);
  '';
}

# Option parser for lstlisting commands/envs family, this can be tricky
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
    next unless ($par, $val) = /^\s*(\w+?)\s*=\s*(.*)\s*$/s;
    $opts{$par} = $val;
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

&process_commands_wrap_deferred (<<_RAW_ARG_DEFERRED_CMDS_);
lstinputlisting # [] # {}
lstdefinestyle # {} # {}
lstset # {}
_RAW_ARG_DEFERRED_CMDS_

1;			# Must be last line
