function x=nld_signals (type, varargin)
% generate various signals as nldat objets
%
% type = normal
%
% options = mean [ 0 ] mwan
%		    = sd [1] standard deviation
%	       = incr [.001] sampling incrmenet
%	       = nsamp = number of samples
%


% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see copying.txt and gpl.txt 

switch lower(type),
case 'normal'
        x=gen_normal(varargin)
  case 'rectangular'
  case 'pulse'
     x=gen_pulse(varargin)
 case 'ramp'
     x=gen_ramp(varargin)
  case 'sine'
     x=gen_sine(varargin)
   otherwise
   error (['Signal type:' type ' is not defined']);
end
function x = gen_normal(varargin)
 options = { { 'incr' 0.001 'Sampling interval'} ...
      {'meanval' 1 'mean'} ...
      {'sd' 1 'standard deviation'} ...
      {'tmax' 1 'end time'} };
arg_parse(options,varargin);
nsamp = 1 + tmax/incr;
 x=random_dev('normal', nsamp, meanval, sd );
 x=nldat(x, 'DomainIncr', incr);

function x = gen_pulse(varargin)
options = { {'amp' 1 'amplitude'} ...
      { 'incr' 0.001 'Sampling interval'} ...
      {'tstart' .1 'start of pulse'} ...
      {'width' .1 'width'} ...
      {'tmax' 1 'record length'} };
arg_parse(options,varargin);
nsamp = 1 + tmax/incr;
x=zeros(nsamp,1);
jstart= tstart/incr;
jend=jstart+ width/incr;
x(jstart:jend)=amp;
x=nldat(x, 'DomainIncr', incr);


function x= gen_sine(varargin)
options = { { 'incr' 0.001 'Sampling interval'} ...
      {'amp' 1 'amplitude'} ...
      {'freq' 1 'frequency'} ...
      {'phi' 0 'phase '} ...
      {'tmax' 1 'end time'} };
arg_parse(options,varargin);

t=(0:incr:tmax)';
freq = freq*2*pi;
phi = phi*pi/180;
x = amp*(sin (freq*t + phi));
x=nldat(x);
set(x,'DomainIncr', incr)


function x = gen_ramp ( varargin )
options = { { 'incr' 0.001 'Sampling interval'} ...
      {'amp' 1 'amplitude'} ...
      {'slope' 1 'slope'} ...
      {'tstart' .1 'start time'} ...
      {'tmax' 1 'end time'} };
arg_parse (options, varargin);
Ns= 1 + tmax/incr;
x=zeros(Ns,1);
delx = slope*incr;
j=tstart/incr;
for y= 0:delx:amp,
   x(j)=y;
   j=j+1;
end
x(j:Ns)=y;
x=nldat(x);
set(x,'DomainIncr', incr)



