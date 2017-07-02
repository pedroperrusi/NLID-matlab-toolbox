function [u,y,z] = GenerateData(N,dB,white);
% generate data -- generates data from Fly retina model, using up and
% down sampling to deal with the static nonlinearities.
%
% syntax:  [u,y,z] = GenerateData(N,dB,Tscale,white);


% set the random number generator to a repeatable state
randn('state',0);
dummy = randn(10000,1);
clear dummy;

load LMCmodel % contains model stored in nlm object "retina"

% set default input signal parameters 
if nargin == 0
  N = 8000;
end
if nargin < 2
  dB = 13;
end
if nargin < 3
  white = 0;
end


%% start with Gaussian white noise
uu = 0.325*randn(2*N,1);
uu = uu - mean(uu);

%% simulate the pre-filtering to 250 Hz -- use an 8 pole elliptic 
%% filter with a cutoff at fc = 0.5 (250 Hz), as described in the 
%% paper
%% Guess -- set ripple (0.5) and attenuation (20) as suggested in
%%          Matlab help file

if white
  ui = uu * 0.7;
else
  [bf,af] = ellip(4,0.5,10,0.5);
  ui = filter(bf,af,uu);
end
u = nldat(ui,'DomainIncr',0.001,'ChanNames',...
    {'Input: Incident Light'} );

subsys = get(retina,'elements');
x1 = nlsim(subsys{1},u);
x2 = UpDownPolySim(subsys{2},x1);
x3 = nlsim(subsys{3},x2);
y = UpDownPolySim(subsys{4},x3);

n = randn(2*N,1);
n = n * double(std(y))/(std(n)*10^(dB/20));
n = nldat(n,'domainincr',0.001);
z = y + n;

first = floor(N/2)+1;
last = first + N;
u = u(first:last); set(u,'domainstart',0);
y = y(first:last); set(y,'domainstart',0);
z = z(first:last); set(z,'domainstart',0);





function y = UpDownPolySim(m,u);
% uses up/down sampling to simulate polynomial nonlinearity without
% aliasing.

order = get(m,'order');
ud = get(u,'data');
udu = resample(ud,order,1);
ydu = double(nlsim(m,udu));
yd = resample(ydu,1,order);
y = u;
set(y,'data',yd);
