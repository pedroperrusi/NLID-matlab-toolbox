function figure8
% function to produce figure showing the second-order Wiener kernel estimated
% from the peripheral auditory model simulation data using Lee-Schetzen
% correlation.  This is Figure 8 in
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%


N = 1000;
ustd=2;
dB=10;


% filter for input signal
Forder =  4;
Fc = 0.75;


[u,y,z] = GenerateData(N,ustd,dB,Forder,Fc);
uz = cat(2,u,z);



m1 = wseries(uz,'method','Toeplitz','ordermax',2,'nlags',16);

% get the kernels of the identified model
kernels = get(m1,'elements');
wk0 = kernels{1};
wk1 = kernels{2};
wk2 = kernels{3};

% smooth the kernels
wk1s = smo(wk1);
wk2s = smo(wk2);
%% need to overlay smo for kernel objects (dim 2 and higher)





subplot(221)
plot(wk1);
title('Unsmoothed Estimates');

subplot(222)
plot(wk1s);
title('Smoothed Estimates');

subplot(223)
plot(wk2);

subplot(224)
plot(wk2s);




