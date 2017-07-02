% sample solution for computer exercise 1, chapter 6

clear
close all

echo on

load mod1;

u = uz(:,1);

% to check for a white input, compute its autocorrelation
phi = cor;
set(phi,'order',1,'Nsides',2,'NLags',10);
phi = nlident(phi,u);
figure(1);
plot(phi);

% since the auto-correlation is essentially a spike at zero-lag, 
% the input is approximately white

% press any key to continue
pause

% to check for Gaussianity, compute a PDF

exp_pdf = pdf;
set(exp_pdf,'NBins',50,'type','density');
exp_pdf = nlident(exp_pdf,u);
figure(2)
plot(exp_pdf)
hold on

% and compare it with a Gaussian having the same mean and sdev

umean = double(mean(u));
ustd = double(std(u));
rv = randv;
set(rv,'mean',umean,'sd',ustd);
pdf_th = pdf(rv);
plot(pdf_th,'line_color','r');
hold off

legend('Histogram','Gaussian');

% Notice that the histogram largely overlaps the theoretical
% Gaussian PDF, so the input appears to be Gaussian.


% press any key to continue
pause


% now set up an empty Wiener series object

sys1 = wseries;
set(sys1,'OrderMax',2,'NLags',32);
sys1 = nlident(sys1,uz);

figure(3)
plot(sys1);


% press any key to continue
pause


% test the model
vf = vaf(sys1,uz)
% vaf returns a nldat object, change to double to see more figures,
double(vf)


% press any key to continue
pause



% extract the kernels from the model
kernels = get(sys1,'elements')
k1 = double(kernels{2});
k2 = double(kernels{3});


% Check for a LNL structure first.  If the system is not LNL, there is 
% no point testing for either Hammerstein or Wiener structures.

% Compute the marginal second-order kernel
k2m = sum(k2)';
k2ms = smo(k2m,1);

% set up the x-axis
hlen = length(k1);
Ts = get(kernels{2},'domainincr');
tau = [0:hlen-1]'*Ts;


% scale the marginal kernel to best fit the first-order kernel
gain = k2m\k1;
k2m = k2m*gain;
g2 = max(k1)/max(k2m);
k2m = g2*k2m;


figure(4)
plot(tau,[k1,k2m]);
title('Testing for the LNL structure');
xlabel('lag (sec)');
ylabel('Amplitude');
legend('1^{st} order Wiener kernel','2^{nd} order marginal kernel');

% The marginal kernel appears to be very noisy -- enough so that the
% LNL test is inconclusive, probably because k2 is so noisy.


% press any key to continue
pause


% Let's proceed with the Wiener and Hammerstein 
% tests.





% Check for the Hammerstein structure

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

% this doesn't look too bad. The diagonal of the second-order kernel appears
% as though it might be a noisy version of the first-order kernel,
% suggesting a Hammerstein structure. 


% press any key to continue
pause


% Testing further, examine the diagonal, and the first few off-diagonals,
% to see how quickly they go to zero.

figure(6)
d1 = diag(k2);
d2 = [0;diag(k2,1)];
d3 = [0;diag(k2,2);0];

plot(tau,[d1 d2 d3]);
title('Testing for a Hammerstein Structure')
xlabel('lag (sec)')
ylabel('Second-order kernel diagonals')
legend('2^{nd}-order kernel diagonal','1^{st} off-diagonal slice',...
    '2^{nd} off-diagonal slice');

% Note the negative peaks in the first and second off-diagonal slices
% (green and red traces), at a lag of about 0.01 seconds.  These peaks 
% seem to be about twice as big as the largest remaining fluctuations
% in the rest of the kernel -- and therefore appear to be more than
% just noise.

% Thus, the second-order kernel seems to have significant structures 
% away from the diagonal, so the system is unlikely to be a Hammerstein
% casacde.


% press any key to continue
pause

% Test for the Wiener casacde


% Compute the principal singular vector of the second-order kernel, and 
% compare it to the first-order kernel.
[uu,ss,vv] = svd(k2);
ktest = uu(:,1);
gain = ktest\k1;
ktest = ktest*gain;

figure(7)
plot(tau,[k1 ktest])
legend('first-order kernel','principal singular vector of k2');
xlabel('lag (sec)');
ylabel('Amplitude');


% Since the first singular vector of the second-order kernel appears to be 
% proportional to the first-order kernel, we cannot eliminate the Wiener
% cascade as a potential strucutre. At the very least, we can say that the
%measured kernels are consistent with the hypothesis that the underlying
% system has a Wiener structure.

echo off

