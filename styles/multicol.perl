# mutlicol.perl
# written by  Marek Rouchal <marek@saftsack.fs.uni-bayreuth.de>
#
# Last modification: Sun Oct 27 20:37:25 MET 1996
#
# Extension to LaTeX2HTML to translate LaTeX commands from the
# multicol package.
#
# This is file is in alpha stage development. Comments welcome!
#

package main;

# for debugging only
# print "Using multicol.perl\n" if($DEBUG);

# implements the LaTeX environment
#
# \begin{multicols}{n}[header]
#
# Effect: header and environment contents are passed as-is

sub do_env_multicols {
    local($_) = @_;
    # omit {n}
    s/$next_pair_rx//o;
    # get header
    local($tmp,$dum)=&get_next_optional_argument; 
    # concatenate and return
    $_ = $tmp . $_;
    }

1;                              # This must be the last line
