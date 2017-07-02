function uz = RunningEx(N, dB, white, retina);
% generates data-set simulating input/output of fly synapse.
%   uz = RunningEx(N,dB,white);
%
% Output:
%     uz, an NLDAT object containing the input and output
%
% Inputs:
%     N, length of the data records (8000)
%    dB, output SNR in dB (13)
% white, input is white noise (1) or filtered (default, 0)
% retina, input represents the photoreceptor output (default, 1) or 
%         the light input (0), 
  
if nargin == 0
  N = 8000;
end

if nargin < 2
  dB = 13;
end

if nargin < 3
  white = 0;
end

if nargin < 4
  retina = 1;
end



%% get the fly retina model, as well as the 
%% input pre-filter.
load FlyRetinaModel




%% start with Gaussian white noise
uu = 0.4*randn(N,1);
uu = uu - mean(uu);

%% simulate the pre-filtering to 250 Hz
%% af and bf are loaded with the retina model.
if white
  ui = uu * 0.7;
else
  ui = filter(bf,af,uu);
end

subsys = get(RetinaModel,'elements');
hr = subsys{1};
Ts = get(hr,'domainincr');
ui = nldat(ui,'domainincr',Ts);

y = nlsim(RetinaModel,ui);

n = randn(N,1);
n = n * double(std(y))/(std(n)*10^(dB/20));
z = y + n;

if retina
  ur = nlsim(hr,ui);
  uz = cat(2,ur,z);
  set(uz,'channames',{'Photoreceptor Output','LMC Output'});
else
  uz = cat(2,ui,z);
  set(uz,'channames',{'Light Input','LMC Output'});
end  

set(uz,'comment','data from fly retina model');




