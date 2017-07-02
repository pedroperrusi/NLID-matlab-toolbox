function R = randv (a,varargin)
% random variable object
%  Parent: nltop

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

R=mkrandv;
if nargin==0;
   return
elseif nargin>1,
   args=cat(2,{a},varargin);
   set (R,args);
else
   args=varargin;
   R=nlmkobj(R,a,varargin{1});
end

%
%
function r=mkrandv
r.Type='Normal';
r.Parameters=param;
r.DomainIncr=.001;
r.DomainMin=0;
r.DomainMax=1;
N=nltop;
r=class(r,'randv',N);
r=pdefault(r);

return
