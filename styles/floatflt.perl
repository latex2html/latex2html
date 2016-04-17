# floatfflt.perl by Herbert Swan <hswan.perc.Arco.com>  07-17-96
#
# Extension to LaTeX2HTML supply support for the "floatflt"
# package by Mats Dahlgren <mats@physchem.kth.se>.
#
# Change Log:
# ===========

package main;
#
#  Make the floatingfigure environment be translated as
#  an ordinary figure, ignoring the mandatory width and
#  optional positioning parameter.  (Figures may be positioned
#  by the \htmlimage command.)
#
#

sub do_env_floatingfigure {
    local($_) = @_;
    local($opt);
    $contents =~ s/$optional_arg_rx/$opt=$1;''/eo;
    $contents =~ s/$next_pair_rx//o;
    &process_environment("figure", $global{'max_id'}++);
    }
sub do_env_floatingfigure { &do_env_figure(@_) }

#
#  Make the floatingtable environment be translated as
#  an ordinary table, ignoring optional positional parameter.
#

sub do_env_floatingtable {
    local($_) = @_;
    local($opt);
    $contents =~ s/$optional_arg_rx/$opt=$1;''/eo;
    &process_environment("table", $global{'max_id'}++);
    }
sub do_env_floatingtable { &do_env_table(@_) }

#
#  The following command is no longer needed for LaTeX2e:
#
&ignore_commands( <<_IGNORED_CMDS_);
initfloatingfigs
_IGNORED_CMDS_

&process_commands_in_tex (<<_RAW_ARG_CMDS_);
floatingfigure
floatingtable
_RAW_ARG_CMDS_

1;                              # This must be the last line
