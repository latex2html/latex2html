# supertabular.perl by Ross Moore
#
# Extension to LaTeX2HTML to supply recognition of 
# the extra math symbols defined in the "latexsym" package.
#
# Change Log:
# ===========

package main;
#


%latexsyms = (
	'mho', 'mho', 'Box', 'Box',
	'Diamond', 'Diamond', 'Join', 'Join',
	'lhd', 'lhd', 'rhd', 'rhd',
	'unlhd', 'unlhd', 'unrhd' , 'unrhd',
	'leadsto', 'leadsto',
	'sqsubset', 'sqsubset', 'sqsupset', 'sqsupset'
);

1;                              # This must be the last line
