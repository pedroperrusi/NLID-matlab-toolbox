function WS = wseries (z, varargin)
% Wiener Series model object
%  Parent: nlm

% Copyright 1999-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

WS=mkwseries;
if nargin==0
    return
elseif nargin==1
    WS=nlmkobj(WS,z);
else
    args=varargin;
    WS=nlmkobj(WS,z,args);
end



function w =mkwseries
% Structure of wseries
N=nlm;
wk=wkern;
w0=wkern(wk,'order',0);
w1=wkern(wk,'order',1);
w2=wkern(wk,'order',2);
el = { w0 ; w1; w2 };
w.ObjName='Wiener Series';
set(N,'Elements',el);
w=class(w,'wseries',N);
set(w,'Method','Toeplitz');
w=pdefault(w);
return

% .../@wseries/wseries
