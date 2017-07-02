function i=nlmtst(i)
%
% test of lnlbl identification
%


% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


z=nlid_sim ('LNL');
i=lnlbl;

i=nlident(i,z);
figure(1);

nlid_resid(i,z);

figure(2)
plot(i)

%error ('nlmtst not yet implemented for lnlbl');

% lnbl/nlmtst
