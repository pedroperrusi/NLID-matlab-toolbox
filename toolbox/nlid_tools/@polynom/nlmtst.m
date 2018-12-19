function [p,z] = nlmtst(p)
% nlmtst for polynom objects

ptypes = { 'tcheb' 'power' 'hermite' };
nx=2;ny=2;
F=1;
% Generate polnomial data set
%
z=nlid_sim('poly');
subplot (nx,ny,1);
plot (z,'mode','xy');
title('data');
F=1;
for t=1:length(ptypes)
    p=polynom(z,'type',ptypes{t},'order',3,'ninputs',1);
    F=F+1;
    subplot (nx,ny,F);
    plot(p);
    title (ptypes{t});
end

return
% nlid_resid(p,z);

% Now try two input third order
x1=x(20:-1:1);
y2 = 10 + 1.1*x + 1.2*x1 + 2.1*x.^2 + 2.2*x.*x1 + 2.3*x1.^2 + ...
    + 3.2*x.^2.*x1 + 3.3*x.*x1.^2
z=cat(2,x',x1',y2');
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
