function z = nltst(p);
% nltst for power series
% SISO
x=1:20;
y= 10 + 1.1*x + 2.2*x.^2 + 3.3*x.^3;
z=cat(2,x',y');
p=nlident(p,z,'order',3,'type','power','ninputs',1);
clf;
figure(1);
plot(p);
figure(2);
nlid_resid(p,z);
%
% Now try two input third order
x1=x(20:-1:1);
y2 = 10 + 1.1*x + 1.2*x1 + 2.1*x.^2 + 2.2*x.*x1 + 2.3*x1.^2 + ...
   + 3.2*x.^2.*x1 + 3.3*x.*x1.^2 
z=cat(2,x',x1',y2');
p=nlident(p,z,'order',3,'NInputs',2,'type','power');
figure(3);
clf;
plot (p);
figure(4);
clf; 
nlid_resid(p,z);

% Copyright 2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 
