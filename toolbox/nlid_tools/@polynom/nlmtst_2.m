function p = nlmtst_2(p)
% nlmtst for power series
% SISO
F=1;
T=get_nl(p,'type');
% Now try two input third order
x=1:20;
x1=x(20:-1:1);
y2 = 10 + 1.1*x + 1.2*x1 + 2.1*x.^2 + 2.2*x.*x1 + 2.3*x1.^2 + ...
    + 3.2*x.^2.*x1 + 3.3*x.*x1.^2 ;   z=cat(2,x',x1',y2');
p=polynom(z,'order',3,'NInputs',2,'type',T);
figure(F);
F=F+1;
clf;
plot (p);
figure(F);
F=F+1;
clf;
nlid_resid(p,z);

% Copyright 2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

