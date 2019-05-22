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
## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

# latex2html -html_version 5.0,utf8
# can be used to produce utf-8 output even when input is, for example,
# latin1 in a file with \usepackage[latin1]{inputenc}

package main;

$utf8_str = 'utf-8';
$charset = $utf8_str;
$USE_UTF = 1;
$NO_UTF = '';

1;
