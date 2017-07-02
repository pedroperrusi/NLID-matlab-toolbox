% sample solution for chapter 5 computer exercise 1

if ~exist('model1')
  mod1;
end

close all
echo on

% first, create the input step function, and simulate the output.

udata = [zeros(10,1);ones(40,1)];
u = nldat(udata,'domainincr',1/200);
y = nlsim(model1,u);

% Plot the model to see the IRF that we are trying to estimage

figure(1)
plot(model1);

% Press any key to continue
pause

% Plot the input ad output, and the differentiated output.
% Note that the differentiated step response is, as expected, the impulse
% respones. 

figure(2)
subplot(311)
plot(u)
subplot(312)
plot(y);
yd = ddt(y);
subplot(313)
plot(yd);
figure(2);


% Press any key to continue
pause

% Now, add some noise to the output, and watch what happens.


n = randn(50,1);
ydata = double(y);
n = n *std(ydata)/(std(n)*10);
zdata = ydata+n;
z = y;
set(z,'data',zdata);


% In this case, there is very little noise, 
% However, the differentiation (even using a Golay-Savitzky filter, as done
% by ddt) amplifies the high frequency noise, increasing the noise level in
% the IRF estimate.

figure(3)
subplot(311)
plot(u)
subplot(312)
plot(z);
zd = ddt(z);
subplot(313)
plot(zd);

echo off

