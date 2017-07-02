function Fd = delay ( F, delt )
% Add a delay to a fresp object

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

d=2*pi*domain(F);
delphi=d*delt;
f=get(F,'data');
gain = abs(f);
phi = angle(f);
newphi=phi - delphi;
xreal=gain.*cos(newphi);
ximag=gain.*sin(newphi);
x=xreal + i*ximag;
Fd=F;
set(Fd,'data',x);
return;
