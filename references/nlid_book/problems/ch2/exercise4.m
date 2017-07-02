%% exercise 4 chapter 2.

echo on

fs = 500;
Ts = 1/fs;


%% at this point, there doesn't seem to be a self-contained way to create a
%% square wave.  Create a sine-wave with the appropriate properties, and
%% then take its sign 

sinewave = signalv;
f_sine = 20;

%omega_sine = f_sine*2*pi;
omega_sine = f_sine;
%% This makes no sense -- why is omega a cyclical frequency??

Tmax = 10;

set(sinewave,'domainincr',Ts,'domainmax',Tmax,'omega',omega_sine);
sinewave = nldat(sinewave);

squarewave = sinewave;
set(squarewave,'data',5*sign(double(squarewave)));

MaxTau = 0.5;
phi_ss = cor(squarewave,'NLags',MaxTau/Ts,'type','correl');
set(phi_ss,'channames',{'correlation'},...
    'comment','Auto-Correlation of a square-wave',...
    'domainname','Lag (s)');

plot(phi_ss);


% press any key to continue
pause;

nn = randv('sd',10,'domainincr',Ts,'domainmax',Tmax);
noise = nldat(nn,'comment','Measurement Noise');
noisywave = squarewave+noise;
set(noisywave,'comment','Noisy Square Wave');
plot(noisywave);


% press any key to continue
pause;

phi_nn = cor(noisywave,'NLags',MaxTau/Ts,'type','correl');
set(phi_nn,'channames',{'correlation'},...
    'comment','Auto-Correlation of a noisy square-wave',...
    'domainname','Lag (s)');

plot(phi_nn);


% press any key to continue
pause;



f_cutoff = 20;
f_normalized = f_cutoff/(0.5*fs)
[b,a] = butter(4,f_normalized);
y = filter(b,a,double(noise));
fnoise = noise; 
set(fnoise,'data',y);

filt_noisywave = squarewave+fnoise;
set(filt_noisywave,'comment','Square Wave + Filtered Noise');
plot(filt_noisywave);


% press any key to continue
pause;

phi_mm = cor(filt_noisywave,'NLags',MaxTau/Ts,'type','correl');
set(phi_mm,'channames',{'correlation'},...
    'comment','Auto-Correlation of a square-wave + filtered noise',...
    'domainname','Lag (s)');

plot(phi_mm);



echo off