function nlmtst(P)
% nltest function for pdf operater
x=randn(10000,1);
X=nldat(x);
P=pdf(X);
plot (P);

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 
