# floatfig.perl by Herbert Swan <dprhws.edp.Arco.com>  12-22-95
#
# Extension to LaTeX2HTML supply support for the "floatfig"
# LaTeX style, as described in "The LaTeX Companion," by
# Goossens, Mittelbach and Samarin (ISBN 0-201-54199-8). 
#
# Change Log:
# ===========

package main;
#
#  Make the floatingfigure environment be translated as
#  an ordinary figure, ignoring the mandatory width.
#
#

sub do_env_floatingfigure {
    local($_) = @_;

    $contents =~ s/$next_pair_rx//o;
    &process_environment("figure", $global{'max_id'}++);
    }

sub do_env_floatingfigure { &do_env_figure(@_) }

&ignore_commands( <<_IGNORED_CMDS_);
initfloatingfigs
_IGNORED_CMDS_

&process_commands_in_tex (<<_RAW_ARG_CMDS_);
floatingfigure # <<endfloatingfigure>>
_RAW_ARG_CMDS_

1;                              # This must be the last line
