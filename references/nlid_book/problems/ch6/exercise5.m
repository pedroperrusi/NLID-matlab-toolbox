% sample solution for computer exercise 5, chapter 6

clear
close all

echo on

load reflex;

u = uz(:,1);

% now set up an empty Wiener series object

sys1 = wseries;
set(sys1,'OrderMax',2,'NLags',32);
sys1 = nlident(sys1,uz);

figure(1)
plot(sys1);

% test the model
vf = vaf(sys1,uz)

% press any key to continue
pause


% The kernels are very spiky, probably due to the use of the 
% toeplitz deconvolution with a significantly non-white input.
% To check this, compute the input auto-correlation, and plot it

u = uz(:,1);
phi = cor;
set(phi,'order',1,'Nsides',2,'NLags',30);
phi = nlident(phi,u);
figure(2);
plot(phi);

% Notice that the autocorrelation has significant values out to lags of
% about 0.05 seconds (about 10 samples).  This is probably leads to
% ill-conditioning in the Toeplitz deconvolution.
%


% press any key to continue
pause

% We can't really use Lee-Schezen, because the input is non-white.
% The Lee-Schetzen kernels will be the convolution of the input
% auto-correlation with the Wiener kernels.

sys2 = sys1;
set(sys2,'method','ls');
sys2 = nlident(sys2,uz);

figure(3)
plot(sys2)

% We should be able to test these kernels for the Hammerstein structure,
% keeping in mind the fact that they are the result of convolutions of the
% Wiener kernels and the input auto-correlation.


% press any key to continue
pause

% extract the kernels from the model
kernels = get(sys2,'elements')
k1 = double(kernels{2});
k2 = double(kernels{3});


% set up the tau-axes for plotting
hlen = length(k1);
Ts = get(kernels{2},'domainincr');
tau = [0:hlen-1]'*Ts;



figure(4)
mesh(k2);
view([-45 0]);
title('Diagonal view of the second-order kernel');
zlabel('Amplitude');
ylabel('lag (sec)');
xlabel('lag (sec)');


% Note that the second-order kernel, viewed down the diagonal, resembles
% the input autocorrelation.  Since this kernel is second-order convolution
% of the input auto-correlation with the second-order Wiener kernel, this
% suggests that the second-order Wiener kernel might be diagonal, since the
% second-order cross-corrleation does not appear to be wider than the input
% auto-correlation function.

% Press Any Key to Continue
pause


% Compare the first order kernel, and the diagonal of the second-order
% kernel.


% compare the second-order kernel diagonal to the first-order kernel
k2d = diag(k2);
k2d = k2d*std(k1)/std(k2d);
[val,pos] = max(abs(k1));
k1s = sign(k1(pos));
[val,pos] = max(abs(k2d));
k2ds = sign(k2d(pos));
k2d = k2d*k2ds*k1s;

figure(5)
plot(tau,[k1 k2d]);
title('Testing for a Hammerstein Structure');
xlabel('lag (sec.)');
legend('First-Order Kernel','Scaled 2^{nd} Order Diagonal')

% Although the large negative spike is in the same location in both
% traces, they do not appear to be proportional to eack other.  However this
% could be due to the different convolutions used to generate them.


% Press Any Key to Continue
pause

% Fit a Hammerstein model between the input and output, using the HK
% iteration.

sys3 = nlbl;
set(sys3,'method','hk','NLags',32,'OrderMax',9,'Tolerance',0.001);
sys3 = nlident(sys3,uz);

figure(6)
plot(sys3);

vaf(sys3,uz)

% the model accounts for 86% VAF, which is considerably better than either
% of the second-order Wiener series models.  Notice, also, that the shape of 
% the IRF is quite different from either of the first-order kernels.


echo off