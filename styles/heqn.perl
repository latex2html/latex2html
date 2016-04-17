### File:  heqn.perl
### Optional LaTeX2HTML style file
### Written by Herbert W. Swan <dprhws@edp.Arco.com>
### Version 0.1,  December 22, 1995
### This is part of the 96.1 release of LaTeX2HTML by Nikos Drakos

## Copyright (C) 1995 by Herbert W. Swan
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


package main;
#
#  This package is invoked by including the "heqn" style (package) in
#  your LaTeX source file.  It was no effect on the LaTeX version of
#  your document, but it alters they way equations are processed
#  by LaTeX2HTML.  This style file causes the equation numbers for
#  equations in the "equation" environment to be processed by
#  LaTeX2HTML as text in front of the equation.  The advantage of
#  doing this is that the equations become order-independent and
#  do not have to be regenerated every time the document is modified
#  in the slightest way.  A side-effect of this routine is that
#  equation numbers are left-justified.
#

&process_commands_in_tex (<<_RAW_ARG_CMDS_);
equation # <<\\endequation>>
eqnarray # <<\\endeqnarray>>
_RAW_ARG_CMDS_

$global{'eqn_number'} = 0;

sub do_env_equation {
   local ($_) = @_;
   local ($eqn_number, $equation_id, $image_id, $step_id, $eqnstr);
   local($attribs, $border);
   if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
   elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
   $equation_id = $global{'max_id'}++;
   $image_id = $equation_id + 1;
   $step_id = ++$global{'max_id'};

   $eqn_number = $global{'eqn_number'} + 1;
   $global{'eqn_number'} = $eqn_number;

   $eqnstr = &make_end_cmd_rx($step_id) . "equation" . 
	&make_end_cmd_rx($step_id);
   &do_cmd_refstepcounter($eqnstr);
   $contents = "\\htmlimage$O$image_id${C}align=middle$O$image_id$C".$contents;
   $contents = &process_undefined_environment('displaymath',$equation_id,$contents);
   if (($border)&&($HTML_VERSION > 2.1 )) { 
	$contents = &make_table( $border, $attribs, '', '', '', $contents ) 
   } else { 
	$contents =~ s/<P>([\w\W]*)/<P>($eqn_number)$1/;
	$contents .= "<BR" . (($HTML_VERSION ge 3.2)? ' CLEAR="ALL"' : ''). ">";
   }
   $contents;
   }

sub do_env_eqnarray {
   local ($cntnts) = @_;
   local ($nlines) = 1;
   local ($eqn_number, $image_id1, $image_id2, $pre);
   local($attribs, $border);
   if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
   elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
#
#  First, put leqno into the preamble, if it's not already there.
#
   $_ = $preamble;
   if (! /leqno/) {
	s/(\\document)(class|style)\[([^]]*)]\{/$1$2\[$3,leqno\]\{/;
	s/(\\document)(class|style)\{/$1$2\[leqno\]\{/;
	$preamble = $_;
	}
   $order_sensitive_rx =~ s/eqnarray\[\^\*\]\|//;
#
#  Count the number of \\'s and \nonumber's there are:
#  (If there are more than one \nonumber's on a single line:  Tough luck!)
#
   $_ = $cntnts;
   s/\\\\/do{$nlines++; $&}/ge;
   s/\\nonumber/do{$nlines--; $&}/ge;
#
#  Update the internal counters.
#
   $eqn_number = $global{'eqn_number'};
   $global{'eqn_number'} = $eqn_number + $nlines if ($nlines > 0);
   $image_id = $global{'max_id'}++;
   $html_id1 = $global{'max_id'}++;
   $html_id2 = $global{'max_id'}++;
#
#  Left-justfy the equation array.
#
   $contents = "\\html$O$html_id2${C}eqn$eqn_number$O$html_id2$C".$contents;
   $contents = "\\htmlimage$O$html_id1${C}align=nojustify$O$html_id1$C".$contents;
   $contents = &process_undefined_environment('eqnarray', $image_id, $contents);
   if (($border)&&($HTML_VERSION > 2.1 )) { 
	$contents = &make_table( $border, $attribs, '', '', '', $contents ) 
   } else {
	$contents = "<P>" . $contents . "</P>";
	$contents .= "<BR" . (($HTML_VERSION ge 3.2)? ' CLEAR="ALL"' : ''). ">";
   }
   $contents;
}


1;                              # This must be the last line





