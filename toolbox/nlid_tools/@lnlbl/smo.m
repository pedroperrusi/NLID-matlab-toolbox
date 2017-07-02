function hs = smo (h, npass);
% smo for nlbl objects

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

hs=h;
el=get(h,'elements');
irf=el{1,2};
irf=smo(irf,npass);
el{1,2}=irf;
set (hs,'elements',el);
return
