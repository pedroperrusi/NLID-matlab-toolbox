function P = param(a,varargin)
% Parameter object
% Parent: nltop

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

P=mkparam;
if nargin==0
    return
elseif nargin==1
    P=nlmkobj(P,a);
else
    args=cat(2,{a},varargin);
    set(P,args);
end

function P=mkparam
P.Default={ NaN } ;
P.Help={'Help'};
P.Limits={'Limit values'};
P.Name={'Name'};
P.Type={'Real'};
P.Value={NaN};
NLT=nltop;
P=class(P,'param',NLT);
return
