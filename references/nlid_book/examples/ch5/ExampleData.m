function iodata = ExampleData(dataset,dB);
% generates identification data for the Running Example in Chapter 5
% 
% syntax:  iodata = ExampleData(datatset,snro);
%
% dataset  = [1], white noise
%             2, anti-alias filtering
%             3, low-pass filtered input, and anti-alias filtering.
% 
% snro     [nan], no output noise
%            dB, snr in dB (examples in text used 10 dB).

% re-initialize the random number generator, so that we get the same data
% each time -- that way all the figures will be self-consistent.
randn('state',0);

if nargin < 2
  dB = nan;
  if nargin < 1
    dataset = 1;
  end
end

DataLength = 5000;  % samples
hlen_s = 0.1;        % seconds
fs = 500;            % Hz
ustd = 20  ;         % Nm

% for good data -- white input, anti-alias filtering, additive noise
cutoff = 200;        % Hz
filter_order = 8;    


Fc = cutoff*2*pi;
[bf,af] = besself(filter_order,Fc);
AntiAliasFilter = tf(bf,af);
 

% for poor data, add in a third-order filter at 25 Hz,
cutoff2 = 50;        % Hz
filter_order2 = 3;    

Fc = cutoff2*2*pi;
[bf,af] = butter(filter_order2,Fc,'s');
InputFilter = tf(bf,af);



Ts = 1/fs;
hlen = hlen_s*fs;
Hs = ExampleSystem;

uw = randn(DataLength,1);
uw = uw*ustd/std(uw);
t = [0:DataLength-1]*Ts;

switch dataset
  case 1
    % white input, no filtering
    y = lsim(Hs,uw,t);
    u = uw;
    comment = 'Ankle Model with White Input';
  case 2
    % white input, anti-alias filtering
    yw = lsim(Hs,uw,t);
    u = lsim(AntiAliasFilter,uw,t);
    y = lsim(AntiAliasFilter,yw,t);
    comment = 'Ankle Model with Anti-Alias Filtering';
  case 3
    % low-pass filtered input with anti-alias filtering
     
    uff = lsim(InputFilter,uw,t);
    uff = uff*ustd/std(uff);
    yff = lsim(Hs,uff,t);
     
    u = lsim(AntiAliasFilter,uff,t);
    y = lsim(AntiAliasFilter,yff,t);

    comment = 'Ankle Model with Low-Pass Filtered Input';
  otherwise
    error('undefined dataset');
end

if isnan(dB)
  z = y;
%  comment = [comment, ' (Noise Free Data)'];
else
  v = randn(DataLength,1);
  v = v * std(y)/(std(v)*10^(dB/20));
  if dataset > 1
    % anti-alias filter the output noise
    v = lsim(AntiAliasFilter,v,t);
  end
  z = y + v;
  comment = [comment, ' and Output Noise'];
end

iodata = nldat([u,z],'domainincr',Ts,'domainvalues',t,'domainname','Time',...
    'chanunits',{ 'Nm', 'rad'},'channames',{ 'Torque','Position'},...
    'comment',comment);
   









