### File:  htmllist.perl
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
#  The left-hand entries in this table are mnemonic names that
#  users may place in \htmlitemmark{}.  The right-hand entries
#  are the names of the corresponding .gif files, located in
#  the $ICONSERVER directory, which will be inserted for every
#  \item within the "htmllist" environment.
#
#  This table may be customised at installation.
#
#
%ImageMarks = (
	'BlueBall',		'blueball',
	'RedBall',		'redball',
	'OrangeBall',		'orangeball',
	'GreenBall',		'greenball',
	'PinkBall',		'pinkball',
	'PurpleBall',		'purpleball',
	'WhiteBall',		'whiteball',
	'YellowBall',		'yellowball',
	);

%ImageSizeMarks = (
	'BlueBall',		'WIDTH="14" HEIGHT="14"',
	'RedBall',		'WIDTH="14" HEIGHT="14"',
	'OrangeBall',		'WIDTH="14" HEIGHT="14"',
	'GreenBall',		'WIDTH="14" HEIGHT="14"',
	'PinkBall',		'WIDTH="14" HEIGHT="14"',
	'PurpleBall',		'WIDTH="14" HEIGHT="14"',
	'WhiteBall',		'WIDTH="14" HEIGHT="14"',
	'YellowBall',		'WIDTH="14" HEIGHT="14"',
	);

#
#  The htmllist environment is equivalent to the description
#  environment in the printed copy, but produces bold descriptions
#  with optional image marks in the HTML version.
#
#  Example:
#
#	\begin{htmllist}[WhiteBall]
#	\item[Item 1:] This will have a white ball
#	\item[Item 2:] This will also have a white ball
#	\htmlitemmark{RedBall}
#	\item[Item 3:] This will have a red ball
#	\end{htmllist}
#
sub do_env_htmlliststar{
  &do_env_htmllist(@_," COMPACT");
}

sub set_htmllist_marker {
    local($icon) = @_;
    local($ICONSERVER) = ($LOCAL_ICONS ? '' : $ICONSERVER.$dd );
    if (!($ImageMarks{$icon})) {
	print "\nUnknown icon '$icon' for htmllist marker";
	&write_warnings("Unknown icon '$icon' for htmllist marker");
	return();
    }
    local($mark_size,$imagemark) = $ImageSizeMarks{$icon};
    $icon = "$ICONSERVER$ImageMarks{$icon}.$IMAGE_TYPE" if ($ImageMarks{$icon});
    $imagemark = '<IMG ' . $mark_size . ' SRC="' . $icon . '" ALT="*">';
    $imagemark =~ s/~/&#126;/g;	# Allow ~'s in $ICONSERVER
    # mark as used, in case $LOCAL_ICONS: thanks, Roman E. Pavlov
    $used_icons{$icon} = 1; 
    $imagemark;
}

sub do_env_htmllist{
    local($_, $compact) = @_;
    local($bullet,$pat) = &get_next_optional_argument;
    #RRM - catch nested lists
    $_ = &translate_environments($_);
  
    $compact = "" unless $compact;
    local($imagemark,$mark,$item_len,$desc_len,$mark_len,$mark_size);
    $imagemark = &set_htmllist_marker($bullet) if ($bullet);

    local($Maxlength) = 99999;
    local($i,@items_done);
    print "[";
    while (1) {
	print "*";
	$item_len = $mark_len = $desc_len = $Maxlength;
	$desc_len = length($`) if (/$item_description_rx/);
	$mark_len = length($`) if (/\\htmlitemmark/);
	$item_len = length($`) if (/\\item$delimiter_rx/);
	# exit when none of them match
	last if ($item_len == $Maxlength && $mark_len == $Maxlength
	    && $desc_len == $Maxlength);
	if ($mark_len < $item_len && $mark_len < $desc_len) {
	    if (/\\htmlitemmark/) {
		$_ = $&.$';
		push(@items_done,&translate_commands($`));
		$mark = &missing_braces unless (
		    (s/\\htmlitemmark$any_next_pair_pr_rx/$mark=$2;''/eom)
		    ||(s/\\htmlitemmark$any_next_pair_rx/$mark=$2;''/eom));
		$imagemark = &set_htmllist_marker($mark) if ($mark);
#		$mark_size = $ImageSizeMarks{$mark};
#		$mark = "$ICONSERVER/$ImageMarks{$2}.gif" if ($ImageMarks{$2});
#		$imagemark = '<IMG ' . $mark_size . ' SRC="' . $mark . '" ALT="*">';
#		$imagemark =~ s/~/&#126;/g;	# Allow ~'s in $ICONSERVER
	    }
	} elsif ($item_len < $desc_len) {
	    /\\item$delimiter_rx/;
	    push(@items_done,&translate_commands($`),
		    "<DT>$imagemark\n<DD>$1");
		$_=$';
	} else  {
	    /$item_description_rx\s*($labels_rx8)?\s*/;
	    push(@items_done,&translate_commands($`),
		"<DT>$imagemark" 
		. (($9)? "<A NAME=\"$9\">\n<B>$1<\/B><\/A>" : "\n<B>$1<\/B>" ) 
		."\n<DD>");
		$_=$';
	}
    }
    $_ = join('',@items_done, $_); undef @items_done;

    #RRM: cannot have anything before the first <LI>
    local($savedRS) = $/; $/='';
    $_ =~ /<D(T|D)>/s;
    local($preitems);
    if ($`) {
	local($preitems) = $`; $_ = $&.$';
	$preitems =~ s/<P( [^>]*)?>//g;
	$preitems = "\n".$preitems if $preitems;
    }
    $/ = $savedRS;

    $_ = '<DT>'.$_ unless (/^\s*<D(D|T)/);
    print "]";
    join('',$preitems,"<DL$compact>", $_, '</DL>');
}

1;                              # This must be the last line











