function nlid_demo (model_type, xin, noise_level)
% nlid_demo - Demonstrate Object Oriented NLID ientification
% xin - input signal
% model_type - type of model to simulate; see nlid_sim for valid options;
%					 default value is 'LN2';
%


% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see copying.txt and gpl.txt

% Noise level - normalized noise power
nlevel=0;
ans='y';
if nargin==0
    model_type= 'LN2';
end

% Default input signal is unit variance white noise
if nargin < 2
    x=randn (1000,1);
    x=nldat(x,'domainincr',.01);
end

% Default noise level is 10%
if nargin < 3
    noise_level=.1; %
end

pltflg=0;
% Simulate noise-free response
[z,M]=nlid_sim (model_type,x,pltflg);


%% Henerate noisey output measure
y=double(z(:,2));
noise=randn(length(y),1);
scale=sqrt(nlevel*cov(y)/cov(noise));
yn= y + noise*scale;
z(:,2)=nldat(yn);

% plot model
figure (1); plot (M); streamer([ model_type ' Model']);
demo_pause
figure(2);  plot(z,'nh',1);
demo_pause

%% Linear impulse response function
numlags=32;
comment='Linear IRF Model';
disp(comment);
i=irf;
i=nlident(i,z,'NLags',numlags);
demo_plot(i,z,' ');

%% Fit a ln model
comment='LN Model';
disp(comment);
ln=lnbl;
ln=nlident(ln,z, 'NLags',numlags);
demo_plot(ln,z,' ');

%% nl model
comment='NL Model';
disp(comment);
nl=nlbl(z,'Nlags',numlags);
demo_plot(nl,z,' ');
W=wseries(nl);
plot(W);

%% pcascade
comment=('Parallel Cascade model');
disp(comment);
pc = pcascade;
set(pc,'NPaths',5,'OrderMax',5,'NLags',numlags);
pc=nlident(pc,z);
set (pc,'comment','Parallel cascade model');
demo_plot(pc,z,comment);
plot(wseries(pc));

%% wkernel = Lee-Schetzen
comment='Wiener Kernel (LS) Model';
disp(comment);
wk=wseries(z,'NLags',32,'method','LS');
demo_plot(wk,z,comment);

%% wkernel - Toeplitz
comment='Wiener Kernel (Toeplitz) Model';
disp(comment);
wt=wseries(z,'NLags',32,'method','Toeplitz');
demo_plot(wt,z,' ')

%% Voltera kernel (Fast Orthogonal)
comment='Voltera kernel (Fast Orthogonal)';
disp(comment);
vk=vseries(z,'NLags',20);
set(vk,'comment',comment)
demo_plot(vk,z,' ');

%% Wiener kernel (WB ) % Broken
comment='Wiener Bose (Laguerre) Model';
disp(comment);
wb=wbose(z,'Nlags',32,'Nfilt',10,'OrderMax',2);
demo_plot(wb,z,' ');
disp('Done');


function demo_plot (model, z, comment)
ans='y';
u=z(:,1);
y=z(:,2);
yp=nlsim(model,u);
yp=extract(yp,100);
y=extract(y,100);
vf=vaf(y,yp);
zm=cat(2,y,yp);
resid=y-yp;
figure(1);clf
clf;subplot (1,1,1);
plot(model);
figure(2); clf
subplot (2,1,1);
plot(zm,'mode','Super');
title('Preidcted and observed outputs');

subplot (2,1,2);
plot (resid-mean(resid));
xd=double(y);
xd=xd-mean(xd);
axis([ -inf inf min(xd) max(xd)]);
disp(['Vaf =' num2str(double(vf))]);
title('Residuals');
demo_pause
return

function demo_pause
ans=1;
ans=input_l('Continue',ans);
if ans
    return
else
    error('quit'); 
end