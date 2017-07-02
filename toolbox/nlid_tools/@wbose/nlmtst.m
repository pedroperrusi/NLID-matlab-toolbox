function wb=nlmtst(i)
%
% test of vseries identification
%

% Copyright 1999-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

z=nlid_sim ('LN2');
% vseries - fast orthogoal
wb=wbose(z,'NLags',20);
figure(1)
nlid_resid ( wb, z);
figure (2);
ws=wseries(wb);
plot(ws);


% wbose/nlmtst
