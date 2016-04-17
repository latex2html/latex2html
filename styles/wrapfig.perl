# wrapfig.perl by Herbert Swan <dprhws.edp.Arco.com>  12-22-95
#
# Extension to LaTeX2HTML supply support for the "wrapfig"
# LaTeX style, as described in "The LaTeX Companion," by
# Goossens, Mittelbach and Samarin (ISBN 0-201-54199-8). 
#
# Change Log:
# ===========

package main;
#
#  Make the wrapfigure environment be translated as
#  an ordinary figure, ignoring its arguments.
#
#

sub do_env_wrapfigure{
    local($_) = @_;

    $contents =~ s/$optional_arg_rx//o;	   # ditch [nlines]
    $contents =~ s/$next_pair_rx//o;	   # ditch {placement}
    $contents =~ s/$next_pair_rx//o;	   # ditch {width}
#   &process_environment("figure", $global{'max_id'}++);
    &do_env_figure($_);
}

&process_commands_in_tex (<<_RAW_ARG_CMDS_);
wrapfigure
_RAW_ARG_CMDS_

1;                              # This must be the last line
