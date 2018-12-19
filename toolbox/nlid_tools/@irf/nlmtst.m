function I=nlmtst(i)
%
% test IRfs
%

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

% One-sided
delete(get(0,'children'));
z=nlid_sim ('L1');
figure(1);
i=irf(z,'nlags',101);
plot(i)
figure(2);
r1=nlid_resid(i,z);
title('Residuals');

% Two-sided
z1=nldat;
z1(:,1)=z(:,2);
z1(:,2)=z(:,1);
i1=irf(z1,'nsides',2,'nlags',50);
figure(3);
plot(i1)

% Output
I={i i1};

% % test time varying IRF
% % tvtest
% dt=0.01;
% x=randn(100,75);
% y=smo(x,3);
% y(51:100,:)=10*y(51:100,:);
%
% %
% % Now test nlid tools
% %
% x=reshape (x,100,1,75);
% y=reshape (y,100,1,75);
% z=cat(2,x,y);
% Z=nldat(z);
% set(Z,'domainincr',.01);
% i=irf(Z,'nsides',2,'nlags',9,'TV_Flag','Yes','Method','corr');
% ip=zero_pad(i);
% Yp=nlsim(ip,Z(:,1,:));
% figure (4); plot (i);
% title ('Time varying inpulse Response');
