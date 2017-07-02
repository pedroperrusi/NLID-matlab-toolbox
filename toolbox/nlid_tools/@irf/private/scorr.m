function [autoin,autoout,cross] = scorr(x,y,m)
%SCORR  Correlation estimate of one or two data sequences.
%	[autoin,autoout,cross] = scorr(X,Y,M) performs FFT analysis of 
%	X and Y, and returns the M point correllation (2-sided) 
%	auto = scorr(X,M) returns the single sequence correllation.

% Copyright 1991-2003, Robert E Kearney, David T Westwick and Eric J Perreault
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../../copying.txt and ../../gpl.txt 

% quick hack drop in replacement for covf call 
% uses toolbox correlation routines to eliminate dependence on commercial
% sysid toolbox 
x = nldat(x(:),'domainincr',1);
if (nargin == 2);
  NLags = y;
  y = x;
else
  y = nldat(y(:),'domainincr',1);
  NLags = m;
end

phixx = cor(x,'NLags',NLags,'order',1,'NSides',2,...
    'bias','biased','type','correl');
phiyy = cor(phixx,y);
phixy = cor(phixx,cat(2,x,y));

autoin = double(phixx)';
autoout = double(phiyy)';
cross = double(phixy)';

  