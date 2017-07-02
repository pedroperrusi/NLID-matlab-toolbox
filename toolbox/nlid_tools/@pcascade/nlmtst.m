function pc=nlmtst(i)
%
% test of nlbl identification
%

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

z=nlid_sim ('PC');
i=pcascade;
pc=nlident(i,z);
figure(1);
plot(pc);
x=z(:,1);
y=z(:,2);
disp('nlsim starting');
yp=nlsim(pc,x);
disp('nlsim done');
z(:,1)=yp;
figure(2);
plot(z);
disp(['vaf = ' num2str(double(vaf(y,yp)))])

% @pcascade/nlmtst
