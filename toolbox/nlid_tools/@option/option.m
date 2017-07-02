function O = param(a,varargin)
% option object
% Parent: nltop

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

O=mkoption;
if nargin==0;
   return
elseif nargin==1,
   O=nlmkobj(O,a);
else
   args=varargin;
   %P=nlmkobj(P,a,args);
   set(O,a,args);
end

%
%
function O=mkoption
O.ParamList= {param };
NLT=nltop;
O=class(O,'Option',NLT);;
return
