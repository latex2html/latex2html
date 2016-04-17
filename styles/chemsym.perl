# Chemsym.perl
# Keith Refson, November 1997
#
#  This version does NOT support the use of '^' and '_' outside math mode.
 package main;

#
# Undo catcode fiddling for images.tex.  This disallows the
# use of _ and ^ outside math mode, but it's probably in math mode there.
#
${AtBeginDocument_hook} .= "\$preamble .= \'\\catcode`\\^=7\n\';";
${AtBeginDocument_hook} .= "\$preamble .= \'\\catcode`\\_=8\n\';";

sub do_cmd_H{join('',"H", $_[0]);}
sub do_cmd_D{join('',"D", $_[0]);}
sub do_cmd_He{join('',"He", $_[0]);}
sub do_cmd_Li{join('',"Li", $_[0]);}
sub do_cmd_Be{join('',"Be", $_[0]);}
sub do_cmd_B{join('',"B", $_[0]);}
sub do_cmd_C{join('',"C", $_[0]);}
sub do_cmd_N{join('',"N", $_[0]);}
sub do_cmd_O{join('',"O", $_[0]);}
sub do_cmd_F{join('',"F", $_[0]);}
sub do_cmd_Ne{join('',"Ne", $_[0]);}
sub do_cmd_Na{join('',"Na", $_[0]);}
sub do_cmd_Mg{join('',"Mg", $_[0]);}
sub do_cmd_Al{join('',"Al", $_[0]);}
sub do_cmd_Si{join('',"Si", $_[0]);}
sub do_cmd_P{join('',"P", $_[0]);}
sub do_cmd_S{join('',"S", $_[0]);}
sub do_cmd_Cl{join('',"Cl", $_[0]);}
sub do_cmd_Ar{join('',"Ar", $_[0]);}
sub do_cmd_K{join('',"K", $_[0]);}
sub do_cmd_Ca{join('',"Ca", $_[0]);}
sub do_cmd_Sc{join('',"Sc", $_[0]);}
sub do_cmd_Ti{join('',"Ti", $_[0]);}
sub do_cmd_V{join('',"V", $_[0]);}
sub do_cmd_Cr{join('',"Cr", $_[0]);}
sub do_cmd_Mn{join('',"Mn", $_[0]);}
sub do_cmd_Fe{join('',"Fe", $_[0]);}
sub do_cmd_Co{join('',"Co", $_[0]);}
sub do_cmd_Ni{join('',"Ni", $_[0]);}
sub do_cmd_Cu{join('',"Cu", $_[0]);}
sub do_cmd_Zn{join('',"Zn", $_[0]);}
sub do_cmd_Ga{join('',"Ga", $_[0]);}
sub do_cmd_Ge{join('',"Ge", $_[0]);}
sub do_cmd_As{join('',"As", $_[0]);}
sub do_cmd_Se{join('',"Se", $_[0]);}
sub do_cmd_Br{join('',"Br", $_[0]);}
sub do_cmd_Kr{join('',"Kr", $_[0]);}
sub do_cmd_Rb{join('',"Rb", $_[0]);}
sub do_cmd_Sr{join('',"Sr", $_[0]);}
sub do_cmd_Y{join('',"Y", $_[0]);}
sub do_cmd_Zr{join('',"Zr", $_[0]);}
sub do_cmd_Nb{join('',"Nb", $_[0]);}
sub do_cmd_Mo{join('',"Mo", $_[0]);}
sub do_cmd_Tc{join('',"Tc", $_[0]);}
sub do_cmd_Ru{join('',"Ru", $_[0]);}
sub do_cmd_Rh{join('',"Rh", $_[0]);}
sub do_cmd_Pd{join('',"Pd", $_[0]);}
sub do_cmd_Ag{join('',"Ag", $_[0]);}
sub do_cmd_Cd{join('',"Cd", $_[0]);}
sub do_cmd_In{join('',"In", $_[0]);}
sub do_cmd_Sn{join('',"Sn", $_[0]);}
sub do_cmd_Sb{join('',"Sb", $_[0]);}
sub do_cmd_Te{join('',"Te", $_[0]);}
sub do_cmd_I{join('',"I", $_[0]);}
sub do_cmd_Xe{join('',"Xe", $_[0]);}
sub do_cmd_Cs{join('',"Cs", $_[0]);}
sub do_cmd_Ba{join('',"Ba", $_[0]);}
sub do_cmd_La{join('',"La", $_[0]);}
sub do_cmd_Ce{join('',"Ce", $_[0]);}
sub do_cmd_Pr{join('',"Pr", $_[0]);}
sub do_cmd_Nd{join('',"Nd", $_[0]);}
sub do_cmd_Pm{join('',"Pm", $_[0]);}
sub do_cmd_Sm{join('',"Sm", $_[0]);}
sub do_cmd_Eu{join('',"Eu", $_[0]);}
sub do_cmd_Gd{join('',"Gd", $_[0]);}
sub do_cmd_Tb{join('',"Tb", $_[0]);}
sub do_cmd_Dy{join('',"Dy", $_[0]);}
sub do_cmd_Ho{join('',"Ho", $_[0]);}
sub do_cmd_Er{join('',"Er", $_[0]);}
sub do_cmd_Tm{join('',"Tm", $_[0]);}
sub do_cmd_Yb{join('',"Yb", $_[0]);}
sub do_cmd_Lu{join('',"Lu", $_[0]);}
sub do_cmd_Hf{join('',"Hf", $_[0]);}
sub do_cmd_Ta{join('',"Ta", $_[0]);}
sub do_cmd_W{join('',"W", $_[0]);}
sub do_cmd_Re{join('',"Re", $_[0]);}
sub do_cmd_Os{join('',"Os", $_[0]);}
sub do_cmd_Ir{join('',"Ir", $_[0]);}
sub do_cmd_Pt{join('',"Pt", $_[0]);}
sub do_cmd_Au{join('',"Au", $_[0]);}
sub do_cmd_Hg{join('',"Hg", $_[0]);}
sub do_cmd_Tl{join('',"Tl", $_[0]);}
sub do_cmd_Pb{join('',"Pb", $_[0]);}
sub do_cmd_Bi{join('',"Bi", $_[0]);}
sub do_cmd_Po{join('',"Po", $_[0]);}
sub do_cmd_At{join('',"At", $_[0]);}
sub do_cmd_Rn{join('',"Rn", $_[0]);}
sub do_cmd_Fr{join('',"Fr", $_[0]);}
sub do_cmd_Ra{join('',"Ra", $_[0]);}
sub do_cmd_Ac{join('',"Ac", $_[0]);}
sub do_cmd_Th{join('',"Th", $_[0]);}
sub do_cmd_Pa{join('',"Pa", $_[0]);}
sub do_cmd_U{join('',"U", $_[0]);}
sub do_cmd_Np{join('',"Np", $_[0]);}
sub do_cmd_Pu{join('',"Pu", $_[0]);}
sub do_cmd_Am{join('',"Am", $_[0]);}
sub do_cmd_Cm{join('',"Cm", $_[0]);}
sub do_cmd_Bk{join('',"Bk", $_[0]);}
sub do_cmd_Cf{join('',"Cf", $_[0]);}
sub do_cmd_Es{join('',"Es", $_[0]);}
sub do_cmd_Fm{join('',"Fm", $_[0]);}
sub do_cmd_Md{join('',"Md", $_[0]);}
sub do_cmd_No{join('',"No", $_[0]);}
sub do_cmd_Lr{join('',"Lr", $_[0]);}
sub do_cmd_Db{join('',"Db", $_[0]);}
sub do_cmd_Jl{join('',"Jl", $_[0]);}
sub do_cmd_Rf{join('',"Rf", $_[0]);}
sub do_cmd_Bh{join('',"Bh", $_[0]);}
sub do_cmd_Hn{join('',"Hn", $_[0]);}
sub do_cmd_Mt{join('',"Mt", $_[0]);}

1;
