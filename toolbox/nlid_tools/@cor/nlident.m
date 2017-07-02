function C = nlident (Cin, A, varargin);
% identify correlation objects
%

% Copyright 1999-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

C=Cin;
A=nldat(A);
if nargin < 2,
   disp('nlident takes two inputs for cor objects: cor, Z' );
elseif nargin > 2,
   set(C,varargin)
end
[nsamp,nchan,nreal]=size(A);
incr=get(A,'DomainIncr');
domainName=get(A,'domainName');
if isnan(incr),
   error('cor estimation requires domainincr to be specified');
end

ninputs=1;
noutputs=nchan-ninputs;
p=get(C,'parameters');
assign(p)



if isnan(NLags),
   NLags = nsamp/10;
end
% Remove mean for covariance and coefficient functions
%
if any(strcmp(Type,{'covar' 'coeff'})),
   A=A-mean(A);
end

x = double(A(:,1));

switch noutputs
  case 0
    % auto-correlation, so use input as output and compute cross
    % correlation.
    y = x;
  case 1
    % cross-correlation, output is second column of Adata
    y = double(A(:,2));
  otherwise
    % we have multiple outputs, so bail
    error ('multiple outputs not yet implemented');
end

switch Order
  case 0
    cx = mean(y);
    
  case 1
    [xc]=xcorr(y,x,round(NLags-1),Bias);
    if NSides == 1
      xc = xc(NLags:end);
      start = 0;
    else
      start= -(NLags-1)*incr;
  end
  
case 2
  if NSides == 1
    yd = y;
    M = NLags;
    start = 0;
  else
    yd = zeros(nsamp,1);
    yd(NLags:end) = y(1:nsamp-NLags+1);
    start = -incr*(NLags-1);
    M = 2*NLags-1;
  end
  xc=corx2y(x,yd,M);
  Bias = 'biased';
  
case 3
  if NSides == 1
    yd = y;
    M = NLags;
    start = 0;
  else
    yd = zeros(nsamp,1);
    yd(NLags:end) = y(1:nsamp-NLags+1);
    start = -incr*(NLags-1);
    M = 2*NLags-1;
  end
  xc=corx3y(x,yd,M);
  xc = reshape(xc,M,M,M);
  Bias = 'biased';
    
otherwise
  error('fourth and higher order correlations not yet implemented');
end
  

if strcmp(Type,'coeff')
  % coefficient function, so normalize.
  xc = xc/(std(x)^Order*std(y));
end



set(C,'Data',xc,...
   'Nlags',NLags', ...
   'NSides',NSides,...
   'DomainIncr',incr, ...
   'Bias',Bias,...
   'Comment',['Correlation for:' get(A,'comment')], ...
   'DomainStart',start, 'domainName',domainName);
% ... cor/nlident  

