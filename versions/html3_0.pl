### File: html3.0.pl
### Language definitions for HTML 3.0
### Written by Marcus E. Hennecke <marcush@leland.stanford.edu>
### Version 0.4,  February 2, 1996

## Copyright (C) 1995 by Marcus E. Hennecke
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

### Extend declarations
%declarations = (
#     'tiny', '<SMALL CLASS="TINY"></SMALL>',
#     'scriptsize', '<SMALL CLASS="SCRIPT"></SMALL>',
#     'footnotesize', '<SMALL CLASS="FOOTNOTE"></SMALL>',
#     'small', '<SMALL CLASS="SMALL"></SMALL>',
#     'large', '<BIG CLASS="LARGE"></BIG>',
#     'Large', '<BIG CLASS="XLARGE"></BIG>',
#     'LARGE', '<BIG CLASS="XXLARGE"></BIG>',
#     'huge', '<BIG CLASS="HUGE"></BIG>',
#     'Huge', '<BIG CLASS="XHUGE"></BIG>',
     'centering', '<DIV ALIGN="CENTER"></DIV>',
     'center', '<DIV ALIGN="CENTER"></DIV>',
     'flushleft', '<DIV ALIGN="LEFT"></DIV>',
     'raggedright', '<DIV ALIGN="LEFT"></DIV>',
     'flushright', '<DIV ALIGN="RIGHT"></DIV>',
     'raggedleft', '<DIV ALIGN="RIGHT"></DIV>',
     %declarations
);

sub do_cmd_underline {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    &lost_argument("underline") unless ($&);
    join('',"<U>$2</U>",$_); 
}

### Allow for alignment to work

sub do_env_center {
    local($_) = @_;
    "<DIV ALIGN=\"CENTER\">\n<P ALIGN=\"CENTER\">$_</P>\n</DIV>";
}
sub do_env_flushright {
    local($_) = @_;
    "<DIV ALIGN=\"RIGHT\">\n<P ALIGN=\"RIGHT\">$_</P>\n</DIV>";
}
sub do_env_flushleft {
    local($_) = @_;
    "<DIV ALIGN=\"LEFT\">\n<P ALIGN=\"LEFT\">$_</P>\n</DIV>";
}

sub do_cmd_centerline {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    &lost_argument("centerline") unless ($&);
    "<DIV ALIGN=\"CENTER\">$&<BR>\n</DIV>$_";
}

sub do_cmd_leftline {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    &lost_argument("leftline") unless ($&);
    "<DIV ALIGN=\"LEFT\">$&<BR>\n</DIV>$_";
}

sub do_cmd_rightline {
    local($_) = @_;
    s/$next_pair_pr_rx//o;
    &lost_argument("rightline") unless ($&);
    "<DIV ALIGN=\"RIGHT\">$&<BR>\n</DIV>$_";
}

