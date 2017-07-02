function wb = poly_wb(wb,z);
% fits polynomial to Wiener Bose model, assuming that filter bank has
% already been chosen.

% Copyright 2000-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../../copying.txt and ../../gpl.txt 


stuff = get(wb,'elements');
bank = stuff{1};
mpol = stuff{2};

NFilt = get(wb,'NFilt');
OrderMax = get(wb,'OrderMax');
set(mpol,'OrderMax',OrderMax);

u = z(:,1);
zd = double(z(:,2));

N = get(u,'size');
N = N(1);

Xd = zeros(N,NFilt);
for i = 1:NFilt
  Xd(:,i) = double(nlsim(bank{i},u));
end

X = u;
set(X,'data',[Xd zd]);
mpol = nlident(mpol,X);

elements = {bank mpol};
set(wb,'elements',elements);