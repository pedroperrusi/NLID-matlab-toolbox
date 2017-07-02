function i=nlmtst(i)
%
% test of nlbl identification
%

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

z=nlid_sim ('N2L');
i=nlbl;
set(i,'method','hk');
i=nlident(i,z);
figure(1);

nlid_resid(i,z);plot(i);
set(i,'method','sls','parameters',{'max_its' 10});
i=nlident(i,z);
figure(2);

nlid_resid(i,z);
plot(i);
% nlbl/nlmtst
