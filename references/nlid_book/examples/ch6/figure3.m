function figure3
% function to produce figure showing the second-order Wiener kernel estimated
% from the peripheral auditory model simulation data using Lee-Schetzen
% correlation.  This is Figure 3 in
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%

[u,y,z] = GenerateData(1000,2,10);
uz = cat(2,u,z);

clf

m2 = wseries(uz,'method','LS','ordermax',2,'nlags',16);
kernels = get(m2,'elements');
wk0 = kernels{1};
wk1 = kernels{2};
wk2 = kernels{3};
subplot(211)
plot(wk2);
title('Second-Order Wiener Kernel Estimate');

m1 = m2;
set(m1,'ordermax',1,'elements',{kernels{1:2}}');
y1est = nlsim(m1,u);
y2est = nlsim(m2,u);

v1 = z - y1est;
set(v1,'channames',{'residue v^{(1)}(t)'});

y2 = y2est - y1est;
set(y2,'channames',{'output of k^{(2)}(\tau)'});

vy = cat(2,v1,y2);

set(vy,'comment','Residue and Kernel Output','chanunits','Amplitude');

subplot(212);
plot(vy,'mode','super');
set(gca,'xlim',[0.02 0.026],'ylim',[-0.8 0.8]);
