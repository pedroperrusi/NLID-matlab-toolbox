function figure6
% Generates figure showing the effect of smoothing on the Volterra kernels 
% estimated using FOA from the coloured noise input data from the fly retina 
% model used as a running example in Chapters 7 and 8 of 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%

% generate data using coloured noise input
disp('generating data');
[uc,yc,zc] = GenerateData(8000,13,0);
IdData = cat(2,uc,zc);

% identify a versies model using the default FOA
disp('estimating kernels using FOA');
vs = vseries(IdData,'nlags',50);
kernels = get(vs,'elements');
vk1 = kernels{2};
vk2 = kernels{3};

%now smooth the kernels
disp('Smoothing Kernels');
vk1s1 = smo(vk1);
vk2s1 = smo(vk2,1);
vk2s2 = smo(vk2,2);

subplot(211)
plot(cat(2,vk1,vk1s1));
legend('Raw Estimate','Smoothed',4);
title('First-Order Kernel Estimate: Colored Input Data');

subplot(223)
plot(vk2s1);
title('Smoothed Kernel Estimate')
set(gca,'zlim',[-0.5 2]*1e6);

subplot(224)
plot(vk2s2)
title('2 Smoothing Passes');
set(gca,'zlim',[-0.5 2]*1e6);