function y = nlsim ( wb, u )
% Simulate response of wbose mode input data set

% Copyright 1999-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

stuff = get_nl(wb,'elements');
bank = stuff{1};
mpol = stuff{2};

NFilt = get_nl(wb,'NFilt');

N = get_nl(u,'size');
N = N(1);

Xd = zeros(N,NFilt);
for i = 1:NFilt
    Xd(:,i) = double(nlsim(bank{i},u));
end

X = u;
set(X,'data',Xd);
y = nlsim(mpol,X);
return
