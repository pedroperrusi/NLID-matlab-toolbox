% sample solution for chapter 7 computer exericse 3

echo on

clear
close all
load pdm_models


figure(1)
plot(TwoModes)


% generate a unit variance white Gaussian signal
u = nldat(randn(10000,1),'domainincr',0.01);

% and compute the system's response to it
y = nlsim(TwoModes,u);


% use principal dynamic modes to identify the system
uy = cat(2,u,y);

wbm = wbose;
set(wbm,'method','pdm','NLags',32,'mode','manual');
wbm = nlident(wbm,uy);

% extract the (first) two IRFs from the identified model
subsys = get(wbm,'elements');
fbank = subsys{1};
h1e = fbank{1};
h2e = fbank{2};


% and generate an X-Y plot of their outputs
x1e = nlsim(h1e,u);
x2e = nlsim(h2e,u);

figure(2)
plot(double(x1e),double(x2e),'.');
title('X-Y plot of the two PDM outputs');
xlabel('Mode 1 Output');
ylabel('Mode 2 Output');

% press any key to continue
pause;

% now double the input amplitude, 
u2 = 2*u;
y2 = nlsim(TwoModes,u2);
uy2 = cat(2,u2,y2);

wbm2 = nlident(wbm,uy2);

subsys = get(wbm2,'elements');
fbank = subsys{1};


if length(fbank)>2
  h1e = double(fbank{1});
  h2e = double(fbank{2});
  h3e = double(fbank{3});

  s = svd([h1e h2e h3e],0)
  
  % The singular values show that there are only 2
  %  linearly indelendent modes -- the third mode is essentially a linear
  %  combination of the first 2.
  

end

echo off

