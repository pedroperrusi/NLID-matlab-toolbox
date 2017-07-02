function figure2
% function to produce figure showing the first-order Wiener kernel estimated
% from the peripheral auditory model simulation data using Lee-Schetzen
% correlation.  This is Figure 2 in
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%

[u,y,z] = GenerateData(1000,2,10);
uz = cat(2,u,z);

clf

m1 = wseries(uz,'method','LS','ordermax',1,'nlags',16);
kernels = get(m1,'elements');
wk0 = kernels{1};
wk1 = kernels{2};
subplot(211)
plot(wk1);
title('First-Order Wiener Kernel Estimate');


v0 = z - double(wk0);
set(v0,'channames',{'residue v^{(0)}(t)'});
y1 = nlsim(m1,u) -  double(wk0);
set(y1,'channames',{'output of k^{(1)}(\tau)'});

vy = cat(2,v0,y1);

set(vy,'comment','Residue and Kernel Output','chanunits','Amplitude');

subplot(212);
plot(vy,'mode','super');
set(gca,'xlim',[0.02 0.026],'ylim',[-0.75 1.25]);
