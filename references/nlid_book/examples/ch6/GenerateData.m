function [u,y,z] = GenerateData(N,ustd,dB,Filt_Order,Filt_cutoff);
% generate data -- generates data from auditory nerve model, using up and
% down sampling to deal with the static nonlinearity.
%
% syntax:  [u,y,z] = GenerateData(N,ustd,dB,Tscale,Fc,Forder);


% set the random number generator to a repeatable state
randn('state',0);
dummy = randn(30000,1);
clear dummy

fiber = PeripheralAuditoryModel;
stuff = get(fiber,'elements');
Ts = get(stuff{1},'domainincr');
Tend = (2*N-1)*Ts;


u = randv('sd',ustd,'domainincr',Ts,'domainmax',Tend);
u = nldat(u);

if nargin > 3
  [bb,aa] = butter(Filt_Order,Filt_cutoff);
  u = nldat(filter(bb,aa,double(u)),'domainincr',Ts);
end

set(u,'channames',{'Amplitude'},'comment','Input: u(t)');

% instead of using the nlsim method for the LNL cascade, we will process
% the signal one element at a time, and up/down sample around the static
% nonlinearity to avoid aliasing errors.
stuff = get(fiber,'elements');
g = stuff{1}; m = stuff{2}; h = stuff{3};
x = nlsim(g,u);
xx = double(x);
xup = resample(xx,10,1);
wup = nlsim(m,xup);
ww = resample(double(wup),1,10);
w = u;
set(w,'data',ww);
y = nlsim(h,w);


ystd = double(std(y));
n = randn(2*N,1);
n = n * ystd/(std(n)*10^(dB/20));
n = nldat(n,'domainincr',Ts);

z = y + n;
set(z,'comment','Output: z(t)');

u = u(N+1:2*N); set(u,'domainstart',0);
y = y(N+1:2*N); set(y,'domainstart',0);
z = z(N+1:2*N); set(z,'domainstart',0);







