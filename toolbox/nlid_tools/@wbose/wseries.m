function ws = wseries (wb);
% Generate Wiener kernels for Wiener-Bose model

% Copyright 1999-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

impulse = [1;zeros(wb.NLags-1,1)];
basis = laguerre(impulse,wb.NFilt,wb.Alpha,1);
coeff=wb.Coef;
ws=wseries;
k0=0;
k1 = gen_kern(basis,coeff,1);
k2 = gen_kern(basis,coeff,2);
% k3 = gen_kern(basis,coeff,3);
k0=wkern(k0);
k1=wkern(k1);
k2=wkern(k2);
k = { k0;  k1;  k2 };
set(ws,'elements',k);
return




  
