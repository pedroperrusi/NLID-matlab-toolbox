function N = narmax(a,varargin)
% narmax model object
%  Parent: nltop

% Copyright 2000, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

N=mknarmax;
if nargin==0;
   return
elseif nargin==1,
   N=nlmkobj(N,a);
else
   args=varargin;
   N=nlmkobj(N,a,args);
end
%
%
function N=mknarmax
N.Coef=[];
N.Terms={}; % [var lag power] 
N.Method=[];
t=nltop;
N=class(N,'narmax',t);
return

% 1 = input
% 2 = output
% 3 = error
