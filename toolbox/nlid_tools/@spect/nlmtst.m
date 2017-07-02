function s = nlmtst(S);
% test routine for Spectrum
% Automspecrum;

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

figure (1);
z=nlid_sim('L2');

x=z(:,1);
s=Spect(x);
set(s,'comment','Autospectrum of input');
plot(s);

figure (2);
s=spect(z);
set(s,'comment','Cross spectrum');
plot (s);
