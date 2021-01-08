# -*- perl -*-
#
# $Id:  $
#
# nameref.perl
#   Georgy Salnikov <sge@nmr.nioch.nsc.ru> 02/01/21
#
# Extension to LaTeX2HTML V2020 to support the "nameref" package
#
# $Log:  $
#
# Note:
# This package provides formatting references with section name
# but without section number. The support is extremely primitive.

package main;

# for debugging only
#print "\nUsing nameref.perl\n";

# &process_ref does everything...
sub do_cmd_nameref {
  local($_) = @_;
  &process_ref($cross_ref_mark, $name_ref_mark);
}

sub do_cmd_Nameref {
  local($arg) = @_;
  join('', "'", &do_cmd_nameref($arg), "' on page ", &do_cmd_pageref($arg));
}

&process_commands_wrap_deferred (<<_RAW_ARG_DEFERRED_CMDS_);
nameref # {}
Nameref # {}
_RAW_ARG_DEFERRED_CMDS_

1;	# Must be last line
