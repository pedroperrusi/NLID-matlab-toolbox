function x = random_dev(type, dim, p1,p2,p3)
% Generates deviates for various  proability densities
%
% usage:
%          x = random_dev (type, n, p1, p2, p3 )
%
% where
%     n is the dimension of the array to generate.
%     the other parameters are used as follows:
%
%         type              p1       p2            p3     
%
%       'normal',            mean     standard deviation 
%       'chi-square',        dof
%       'student-t',         dof
%       'f-distribution'     dof1     dof2
%       'log-normal',        mean     variance    offset  
%       'rectangular',       xmin     xmax
%       'exponential',       mean
%    'discrete-rectangular'  imin     imax
%       'binomial',          n        probabilty
%       'Poisson'            mean 
%
%deviates from different  distributions
%
% Correct problem with F-distribution.

% Copyright 2002-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../../copying.txt and ../../gpl.txt 


% {{{ Parse input and check validity

type=lower(type);
if (length(dim) ==1),
  n = 1 ;
  m = dim(1);
elseif (length(dim)==2),
  m = dim(1);
  n = dim(2);
else,
  disp('ERROR - output array must be of dimension 1 or 2')
  x=NaN;
  return
end

% }}}

% {{{ normal

if (strcmp(type,'normal')),
  mu=p1;
  sd=p2;
  x=(mu + sd*randn(m,n));

% }}}
% {{{ discrete-rectangular

elseif (strcmp(type,'discrete-rectangular')),
  xmin = p1-1;
  xmax = p2;
  x=xmin +(xmax-xmin)*rand(m,n);
  x=ceil(x);

% }}}
% {{{ rectangular

elseif (strcmp(type,'rectangular')),
  xmin = p1;
  xmax = p2;
  x=xmin +(xmax-xmin)*rand(m,n);

% }}}
% {{{ chi-square deviates

elseif (strcmp(type,'chi-square')),
  dof=p1;
  x=randn(dof,m*n);
  x=sum(x.^2);
  x=reshape(x,m,n);

% }}}
% {{{ student-t deviates

elseif (strcmp(type,'student-t')),
  dof = p1;
  x1 = randn(m,n);

  % x2 - chi-square deviates
  
  x2=randn(dof,m*n);
  x2=sum(x2.^2);
  x2=reshape(x2,m,n);

  % gnerate t-distribution deviates
  
  x= sqrt(dof) * ( x1 ./ sqrt(x2));
  

% }}}
% {{{ F-deviates

elseif (strcmp(type,'f-distribution')),

   % {{{  parse input and check validity

  %
  if (nargin < 4),
    disp('ERROR: random_pdf  not enough parameters specified');
    disp('Usage is: x = random_pdf(''F-distribution'',n,dof1,dof2');
    x=NaN
    return
  end
  if (p1<=1) | (p2<=1),
    disp('ERROR: Both values for degrees-of-freedom must be > 1');
    x=NaN;
    return
    end

% }}}
   % {{{ Generate F-distribution deviates

  dof1 = p1;
  dof2 = p2;
  %
  % x1 - chi-square deviate with dof1 degrees of freedom
  %
  x1=randn(dof1,m*n);
  x1=sum(x1.^2);
  x1=reshape(x1,m,n);

  %
  %x2 - chi-square deviate with dof2 degrees of freedom
  %
  x2=randn(dof2,m*n);
  x2=sum(x2.^2);
  x2=reshape(x2,m,n);

  %
  % generate deviates
  
  x= (x1/dof1) ./ (x2/dof2);

% }}}

% }}}
% {{{ exponential deviates

elseif (strcmp(type,'exponential')),
  mu=p1;
  x=rand(m,n);
  y=x(:);
  while (any(y==0)),
    i=find(y==0);
    y(i)=rand(i,1);
  end
  x=-mu*log(y);
  x=reshape(x,m,n);

% }}}
% {{{ log-normal deviates

else if (strcmp(type,'log-normal')),
  mu = p1;
  var=p2;
  offset=p3;
  z=mu + var*randn(m,n);
  x= exp(z) + offset;
  

% }}}
% {{{ b deviates
elseif (strcmp(type,'binomial')),
% 
% {{{  parse input and check its validity
  if (nargin <4),
    disp('ERROR: random_pdf  not enough parameters specified');
    disp('Usage is: f = random_dev(''binomial'',n,number-of-event,probability');
    x=NaN
    return
  end

% }}}
prob=p2;
  ntrial=p1;
  x=zeros(m,n);
  for i=1:ntrial,
    xt=rand(m,n);
    j=find(xt < prob);
    x(j)=x(j)+1;
  end

% }}}
% {{{ Poisson deviates

elseif (strcmp(type,'poisson')),
  mu=p1;
  count = zeros(m,n);
  xt = ones (m,n);
  xlimit = exp(-mu);

  done =0;
  while ~ done,
    xt= xt .* randn (m,n);
    i = find (xt > xlimit);
    if isempty(i),
      done=1;
    else,
      count(i)=count(i)+1;
    end
  end
  x=count;

% }}}


else
  disp('distribution not available')
end
end


% {{{ Emacs local variables

% Local variables:
% folded-file: t
% end;

% }}}
