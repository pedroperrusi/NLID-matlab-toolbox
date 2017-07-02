% exercise 2 chapter 3


echo on

% create a transfer function linear system object
[b,a] = butter(2,0.25);
Ts = 1/1000;
Gz = tf(b,a,Ts)


% turn it into a state-space model

Gss = ss(Gz)

% and create an impulse response

Girf = impulse(Gz);

% import the impulse response into the nlid toolbox
% we should really automate this one.

sys = irf;
set(sys,'DomainIncr',Ts,'data',Girf);


echo off

