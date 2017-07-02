function K = kern (x,varargin)
% kernel object
%  Parent: nldat 

% Copyright 1991-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


K=mkkern;
if nargin==0;
   return
else
   args=varargin;
   K=nlmkobj(K,x,args);
end


%
%
function i=mkkern
Kernel=nldat;
i.Parameters=param;
i=class(i,'kern',Kernel);
i=pdefault(i);
return
% kern/kern
% rek 8 April 2000 Use nldat to store data
% rek 6 April 2001 Add TV_Flag  
