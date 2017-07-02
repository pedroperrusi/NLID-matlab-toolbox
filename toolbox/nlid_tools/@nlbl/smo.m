function hs = smo (h, npass);
% smo nlbl object

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

if nargin == 1,
   npass=1;
end
hs=h;
el=get(h,'elements');
irf=el{1,2};
el{1,2}=smo(irf,npass);
set(hs,'elements',el);
