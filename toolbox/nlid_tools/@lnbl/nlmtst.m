function i=nlmtst(i)
%
% test of lnbl identification
%

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

z=nlid_sim ('LN2');
i=lnbl;
i=nlident(lnbl,z,'NLags',128);
figure(1);
plot(i);
x=z(:,1);
y=z(:,2);
yp=nlsim(i,x);
z(:,1)=yp;
figure(2);
plot(z);
vaf(y,yp);

% lnbl/nlmtst
