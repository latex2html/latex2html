### File: utf8.pl
### Version 0.1,  September 21, 1999
### Written by Ross Moore <ross@maths.mq.edu.au>
###
### UTF-8 encoding of character set code-points
###

## Copyright (C) 1999 by Ross R Moore
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

$utf8_str = 'utf-8';
$charset = $utf8_str;
$USE_UTF = 1;
$NO_UTF = '';

sub convert_to_utf8 {
    $_[0] =~ s/([\200-\377])/print $1;&to_utf8(ord($1))/egs;
    $_[0] =~ s/\&#(\d{2,});/print $&;&to_utf8($1)/egs;
}

sub to_utf8 {
    local($code) = @_;
    return () unless ($code);
    if ($code < 128 ) {return chr($code) };
    my ($str,$top,$level) = ('',128,64);
    while (($code > 63)&&($level>4)) {
        $top += $level; $level /= 2;
	$str = chr(128+$code%64).$str;
        $code = int($code/64);
    }
    if ($top+$code > 255) {
        print STDERR  "\n*** character $_[0] out of range for UTF-8 ***"; 
	'';
    } else { chr($top+$code).$str }
}

1;
