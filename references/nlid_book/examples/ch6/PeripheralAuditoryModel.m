function fiber = PeripheralAuditoryModel(irfstd)
% object oriented version of single auditory nerve fiber model used as a
% running example in chapter 4 of
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003

if nargin < 1
  irfstd = 100;
end



% sampling frequency of 10,000 Hz gives a center frequency of about 1160 Hz.
fs = 10000; 
Ts = 1/fs;


%  Parameters Describing the System
%  Peripheral Auditory System model used by Korenberg in fast 
%  orthogonal paper.
%  LNL cascade with two identical bandpass filters

hlen = 16;
tau = (1000*Ts)*[0:hlen-1]';
b = (0.5/Ts)*[0.85497034486562;  -0.67345188433146;  0];
a = [1;  -0.97703289817211; 0.33238613029324];
g = irf;


imp = [1;zeros(hlen-1,1)];
gdat = filter(b,a,imp);


set(g,'Data',gdat,'DomainIncr',Ts);

% Nonlinearity fit a polynomial to a half-wave rectifier over [-3 3]
u = [-3:0.01:3]';
y = half_wave(u);
z = nldat([u y]);
mt = polynom(z,'type','tcheb','ordermax',8);

fiber = lnlbl;
set(fiber,'Elements',{g, mt, g});
fiber = NormalizeLNL(fiber,irfstd);
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function m0 = NormalizeLNL(m0,irfstd);
 
if nargin == 1
  irfstd = 1;
end

 
blocks = get(m0,'elements');
h = blocks{1};
m = blocks{2};
g = blocks{3};
 
hh = double(h);
gain = std(hh)/irfstd;
set(h,'data',hh/gain);
 
range = get(m,'Range');
set(m,'Range',range/gain);
set(m,'mean',get(m,'mean')/gain,'std',get(m,'std')/gain);

gg = double(g);
gain = std(gg)/irfstd;
set(g,'data',gg/gain);         

coeffs = get(m,'coef');
coeffs = coeffs*gain;
set(m,'coef',coeffs);
 
set(m0,'elements',{h m g});   





