# $Id: luacode.perl,v 1.12 2001/04/18 01:39:21 RRM Exp $
#
# luacode.perl by Georgy Salnikov <sge@nmr.nioch.nsc.ru>  18/06/24
#
# Extension to LaTeX2HTML V2018 to support the "luacode" package
# for lualatex support.
#
# $Log:  $

package main;

# for debugging only
# print "\nUsing luacode.perl\n";

# This tries to support partly the four commands of the luacode package:
# \luadirect{...}
# \luaexec{...}
# \begin{luacode}...\end{luacode}
# \begin{luacode*}...\end{luacode*}
# There is no attempt to interpret any Lua code. The Lua code blocks
# are just skipped by the latex2html interpreter and inserted in images.tex
# so that they could (presumably) be processed if their result
# would be needed while generating some images.

sub do_env_luacode {
  local($_) = @_;
  s/$par_rx/\n\n/gm;		# revert inserted \par commands
  $_ = &make_nowrapper(1)
    . "\\begin{luacode}\n$_\n\\end{luacode}\n"
    . &make_nowrapper(0);
  $_;
}

sub do_env_luacodestar {
  local($_) = @_;
  s/$par_rx/\n\n/gm;		# revert inserted \par commands
  $_ = &make_nowrapper(1)
    . "\\begin{luacode*}\n$_\n\\end{luacode*}\n"
    . &make_nowrapper(0);
  $_;
}

&process_commands_nowrap_in_tex (<<_RAW_ARG_NOWRAP_CMDS_);
luadirect # {}
luaexec # {}
_RAW_ARG_NOWRAP_CMDS_

1;	# Must be last line
