# supertabular.perl by Denis Koelewijn
#
# Extension to LaTeX2HTML supply support for the "supertabular"
# LaTeX style, as described in "The LaTeX Companion," by
# Goossens, Mittelbach and Samarin (ISBN 0-201-54199-8). 
#
# Change Log:
# ===========

package main;
#
#  Translate the supertabular environment as
#  an ordinary table.
#
#

sub do_env_supertabular {
#   local($_) = @_;
#   &process_environment("tabular", $global{'max_id'}++);
    &do_env_tabular(@_);
    }

sub do_cmd_tablecaption {
    local($_) = @_;
    local($contents);
    local($cap_env, $captions, $cap_anchors) = ('table','','');
    $contents = &missing_braces unless (
        (s/$next_pair_pr_rx/$contents = $&;''/e)
        ||(s/$next_pair_rx/$contents = $&;''/e));
    $contents = "\\caption". $contents;
    &extract_captions;
    $TABLE_CAPTION = $cap_anchors.$captions;
    $_;
}

sub do_cmd_tablehead {
    local($_) = @_;
    local($text);
    $text = &missing_braces unless (
        (s/$next_pair_pr_rx/$text = $2;''/e)
        ||(s/$next_pair_rx/$text = $2;''/e));
    $TABLE_TITLE_TEXT = $text unless ($TABLE_TITLE_TEXT);
    $_;
}

sub do_cmd_tablefirsthead {
    local($_) = @_;
    local($text);
    $text = &missing_braces unless (
        (s/$next_pair_pr_rx/$text = $2;''/e)
        ||(s/$next_pair_rx/$text = $2;''/e));
    $TABLE_TITLE_TEXT = $text;
    $_;
}

sub do_cmd_tabletail {
    local($_) = @_;
    local($text);
    $text = &missing_braces unless (
        (s/$next_pair_pr_rx/$text = $2;''/e)
        ||(s/$next_pair_rx/$text = $2;''/e));
    $TABLE_TAIL_TEXT = $text unless ($TABLE_TAIL_TEXT);
    $_;
}

sub do_cmd_tablelasttail {
    local($_) = @_;
    local($text);
    $text = &missing_braces unless (
        (s/$next_pair_pr_rx/$text = $2;''/e)
        ||(s/$next_pair_rx/$text = $2;''/e));
    $TABLE_TAIL_TEXT = $text;
    $_;
}


&process_commands_wrap_deferred( <<_RAW_ARG_CMDS_);
tablecaption # {}
tablehead # {}
tabletail # {}
tablefirsthead # {}
tablelasttail # {}
_RAW_ARG_CMDS_

1;                              # This must be the last line



