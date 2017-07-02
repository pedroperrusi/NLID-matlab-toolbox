function figure18
% Generates figure showing first and second order Volterra kernels of a
% Wiener-Bise model identified using Principal Dynamic Model analysis.
% Kernels are generated using the  first 1,2 and 3 PDMs.  Wiener-Bose model
% estimated from the coloured noise input dataset from the fly retina 
% model used as a running example in Chapters 7 and 8 of 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%

% generate data using coloured noise input
disp('generating data');
[uc,yc,zc] = GenerateData(8000,13,0);
IdData = cat(2,uc,zc);

% identify a versies model using LET
disp('estimating Wiener Bose model using LET/PDM');
vsm = vseries(IdData,'method','laguerre','nlags',50,'alpha',0.3,...
    'NumFilt',9,'delay',6);
% and down convert it into a WBOSE using PDMs.
wbm = wbose;
wbm1 = nlident(wbm,vsm,'method','pdm','mode','fixed','nfilt',1);
wbm2 = nlident(wbm,vsm,'method','pdm','mode','fixed','nfilt',2);
wbm3 = nlident(wbm,vsm,'method','pdm','mode','fixed','nfilt',3);

% note that the maximum number of filters is specified as 6, but the 
% number of filters in the final model is 3.


disp('Generating Kernels');

vs1 = vseries(wbm1,'ordermax',2);
vs2 = vseries(wbm2,'ordermax',2);
vs3 = vseries(wbm3,'ordermax',2);

kernels = get(vs1,'elements');
vk11 = kernels{2};
vk12 = kernels{3};


kernels = get(vs2,'elements');
vk21 = kernels{2};
vk22 = kernels{3};


kernels = get(vs3,'elements');
vk31 = kernels{2};
vk32 = kernels{3};


clf
pos = get(gcf,'position');
ydiff = 600 - pos(4);
pos(2) = pos(2)-ydiff;
pos(4) = 600;
set(gcf,'position',pos);






subplot(321)
plot(vk11)
title('h^{(1)}(\tau)');
set(gca,'ylim',[-7 3]*1e3);


subplot(322)
plot(vk12(1:32,1:32))
title('h^{(2)}(\tau_1,\tau_2)');
set(gca,'zlim',[-0.6 2.5]*1e6);


subplot(323)
plot(vk21)
set(gca,'ylim',[-7 3]*1e3);

subplot(324)
plot(vk22(1:32,1:32))
set(gca,'zlim',[-0.6 2.5]*1e6);

subplot(325)
plot(vk31)
set(gca,'ylim',[-7 3]*1e3);

subplot(326)
plot(vk32(1:32,1:32))
set(gca,'zlim',[-0.6 2.5]*1e6);




