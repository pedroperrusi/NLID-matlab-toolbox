% sample solution for chapter 7 computer exericse 2

echo on

clear
close all
load pdm_models




% generate a unit variance filtered Gaussian signal
[b,a] = butter(4,0.4);
u = nldat(filter(b,a,randn(10000,1)),'domainincr',0.01);

% and compute the system's response to it
y = nlsim(TwoModes,u);

% extract the two IRFs from the model
subsys = get(TwoModes,'elements');
fbank = subsys{1};
h1 = fbank{1};
h2 = fbank{2};

% and generate an X-Y plot of their outputs
x1 = nlsim(h1,u);
x2 = nlsim(h2,u);

figure(1)
plot(double(x1),double(x2),'.');
title('X-Y plot of the two filter outputs');
xlabel('Filter 1 Output');
ylabel('Filter 2 Output');


% notice that the plot is an ellipse, whose major axis runs at an angle of
% about 45 degrees.  This means that the outputs of the two filters are
% correlated with each other, rather than being orthogonal.

% press any key to continue
pause;


% use principal dynamic modes to identify the system
uy = cat(2,u,y);

wbm = wbose;
set(wbm,'method','pdm','NLags',16,'mode','fixed','NFilt',2);
wbm = nlident(wbm,uy);

% extract the two IRFs from the identified model
subsys = get(wbm,'elements');
fbank = subsys{1};
h1e = fbank{1};
h2e = fbank{2};


% and generate an X-Y plot of their outputs
x1e = nlsim(h1e,u);
x2e = nlsim(h2e,u);

figure(2)
plot(double(x1e),double(x2e),'.');
max1 = max(abs(double(x1e)));
max2 = max(abs(double(x2e)));
lim = max(max1,max2);
set(gca,'ylim',[-lim lim],'xlim',[-lim lim]);



title('X-Y plot of the two PDM outputs');
xlabel('Mode 1 Output');
ylabel('Mode 2 Output');


% The XY plot is slightly elliptical, with the major axis pointing about
% 45 degrees to the left.  Thus, the outputs of the two modes are beginning
% to become correlated with each other.  Try reducing the input bandwidth
% even farther, and see what happens.


% press any key to continue
pause;


% Compare the identified IRFs with those of the simulation model

figure(3)


% normalize the filters, and make sure that the largest peaks are positive
h1d = double(h1); h1d = h1d/std(h1d);
[val,pos] = max(abs(h1d)); h1d = h1d*sign(h1d(pos));

h2d = double(h2); h2d = h2d/std(h2d);
[val,pos] = max(abs(h2d)); h2d = h2d*sign(h2d(pos)); 

h1de = double(h1e); h1de = h1de/std(h1de);
[val,pos] = max(abs(h1de)); h1de = h1de*sign(h1de(pos));

h2de = double(h2e); h2de = h2de/std(h2de);
[val,pos] = max(abs(h2de)); h2de = h2de*sign(h2de(pos)); 

tau1 = [0:length(h1)-1]'/100;
tau2 = [0:length(h1e)-1]'/100;

plot(tau1,h1d); hold on
plot(tau1,h2d,'r');
plot(tau2,h1de,'b--');
plot(tau2,h2de,'r--');
hold off

legend('Filter 1','Filter 2','Mode 1','Mode 2');
title('Comparison of Simulated Filters and Identified Modes');
ylabel('Normalized Amplitude');
xlabel('Lag (sec)');


echo off