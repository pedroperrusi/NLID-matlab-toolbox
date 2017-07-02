function fs=nlmtst(fresp)
% fs=nlmtst(fresp) test identification from data
% $Revision: 1.3 $
% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

z=nlid_sim ('L1');
set(z,'comment','Low pass data set');
figure(1);
plot (z); 
fs=fresp(z);
figure(2)
plot(fs);


% test identification by FFTing IRF;

I = irf(z);
FI=fresp(I);
figure(3); plot (FI);
figure(4); plot(I)



