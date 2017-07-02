function nsum = plus (n1,n2)
% plus functionm for narmax models

% Copyright 2000, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

n1=narmax(n1);
n2=narmax(n2);
nsum=narmax;
nsum.Coef=cat(2,n1.Coef,n2.Coef);
nsum.Terms=cat(2,n1.Terms,n2.Terms);
nsum=pwrsimp(nsum);
nsum=collect(nsum);


