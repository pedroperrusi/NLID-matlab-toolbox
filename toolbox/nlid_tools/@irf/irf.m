function I = irf (a,varargin)
% impulse response function object
%  Parent: kern

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

I=mkirf;
if nargin==0;
   return
elseif nargin==1,
   I=nlmkobj(I,a);
else
   args=varargin;
   I=nlmkobj(I,a,args);
end


%
%
function i=mkirf
i.name='irf';
K=kern;
i=class(i,'irf',K);;
i=pdefault(i);
set(i,'comment','IRF Model');
set(i,'DomainName','Lag (s)');


return
