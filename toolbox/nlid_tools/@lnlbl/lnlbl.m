function LNL  = lnlbl (z, varargin)
% Linear-NonLinear-Linear block model
% Parent: nlm

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

LNL=mklnlbl;
if nargin==0;
   return
elseif nargin==1,
  LNL=nlmkobj(LNL,z);
else
   args=varargin;
   LNL=nlmkobj(LNL,z,args);
end



% lnlbl/lnlbl

function lnl = mklnlbl
S=nlm;
i=irf;
j=irf;
t=polynom;
set(t,'Type','tcheb');
elements = { i t j};
set (S,'Elements',elements);
lnl.ObjType='LNL';
lnl=class(lnl,'lnlbl',S);
set(lnl,'method','hk');
lnl=pdefault(lnl);
return


