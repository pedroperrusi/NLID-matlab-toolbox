function figure17
% function to produce figure showing tests for Wiener and LNL structure
% using data from the peripheral auditory model simulation.
% This is Figure 17 in
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


m2 = wseries(uz,'method','toeplitz','ordermax',2,'nlags',16);
kernels = get(m2,'elements');
wk0 = kernels{1};
wk1 = kernels{2};
wk2 = kernels{3};




phi_uu = cor(u,'nlags',16,'bias','biased');
Phi = toeplitz(double(phi_uu));


% Test for Wiener system
wk2dat = get(wk2,'data');
slices = wk2dat(:,1:3);
sslices = pinv_smo(slices,15,Phi);
sslices = ppscale(sslices,4);
subplot(211);
plot([0:15]/10,sslices);
title('testing for Wiener structure');
legend('\tau_1 = 0','\tau_1 = 0.1 ms','\tau_1 = 0.2 ms',1);
ylabel('Amplitude');



kmarg = sum(wk2dat)';
wk1dat = double(wk1);
lnltest = [wk1dat kmarg];
lnltest = ppscale(pinv_smo(lnltest,15,Phi),4);
subplot(212)
plot([0:15]/10,lnltest);
title('testing for LNL structure');
legend('k^{(1)}(\tau)','\Sigma_i k^{(2)}(\tau,i)',1);
ylabel('Amplitude');
xlabel('Lag (ms)');


function ss = ppscale(s,amp);
% scale columns of s to have peak to peak amplitude of amp
% and make the forst element positive

ns = size(s,2);
ss = s;
for i = 1:ns
  gain = amp/(max(ss(:,i))-min(ss(:,i)));
  if ss(1,i) < 0
    gain = -gain;
  end
  ss(:,i) = ss(:,i)*gain;
end



function xs = pinv_smo(x,n,Phi);
% pseudo-inverse based smoothing -- this should really be 
% an option on the basic smo method (or otherwise incorporated in the
% toolbox. 

[U,S,V] = svd(Phi);
Phin = U(:,1:n)*V(:,1:n)';
xs = Phin*x;



