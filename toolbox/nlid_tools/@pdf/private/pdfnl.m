function [dist,dom] = pdf(x,numbins,option, dmin, dmax)
% compute the probabilty distibution of a signal
%	THE FUNCTION PDF COMPUTES THE PROBABILITY DISTRIBUTION FUNCTION
%	OF A GIVE CHANNEL X.
%
%	USAGE:	[dist,dom] = pdf(x,numbins,option)
%
%	x	: input vector
%	numbins: number of bins used in order to calculate the 
%		  discrete PDF or normalized histogram.
%	option  - string determined result
%                     'freq' - frequency histogram Ni
%                     'prob' - probabilty function Ni/Ntotal
%                     'dens' - proabilty density Ni/Ntotal*BinWidth
%


% Copyright 1991-2003, Robert E Kearney and Eric J Perreault
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

if (nargin==2),
  option='probability';
end
scale = length(x);
xs = sort(x);
mx = double(dmax);
mn = double(dmin);
binwidth = (mx - mn)/numbins;
dom=(mn + binwidth/2):binwidth:(mx - binwidth/2);
dommax = max(size(dom));
dist = zeros(size(dom));
k = 1;
binsum = 0;
for i=1:scale
	if xs(i) <= (mn + k*binwidth)
	   binsum = binsum + 1;
	else
	   dist(k) = binsum;
	   if ( k < dommax ) 
	       k = k+1;
	       binsum = 1;
	   end
	end 
end
dist(k) = binsum;
if (strcmp(option,'frequency')),
  dist = dist;
elseif(strcmp(option,'probability')),
    dist = dist / scale;
elseif(strcmp(option,'density')),
  dist = dist / (binwidth*scale);
else
  disp(['pdf - bad option:' option]);
  dist=[];
end
  
