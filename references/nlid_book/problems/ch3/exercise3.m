% exercise 3 chapter 3

echo on

% create a linear system object
[b,a] = butter(2,0.25);
Ts = 1/1000;
Gz = tf(b,a,Ts);


% import the impulse response into the nlid toolbox
% we should really automate this one.

sys = irf;
set(sys,'DomainIncr',Ts,'data',impulse(Gz));


% create a cosine input
sinewave = signalv;
set(sinewave,'domainincr',Ts,'DomainMax',10,'omega',10,'phi',90);
u = nldat(sinewave);

y = nlsim(sys,u);

iodata = [double(u) double(y)];
uy = nldat(iodata(1:200,:));
set(uy,'domainincr',Ts,'ChanNames',{'Input';'Output'});
plot(uy);

echo off
