function LN  = lnbl (z, varargin)
% Linear-Nonlinear block model
% Parent: nlm

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

LN=mklnbl;
if nargin==0;
   return
elseif nargin==1,
  LN=nlmkobj(LN,z);
else
   args=varargin;
   LN=nlmkobj(LN,z,args);
end



% lnbl/lnbl

function bl = mklnbl
S=nlm;
i=irf;
t=polynom;
set(t,'Type','tcheb');
elements = { i t };
set (S,'Elements',elements);
bl.ObjType='lnbl';
bl=class(bl,'lnbl',S);
set(bl,'method','bussgang');
bl=pdefault(bl);
return


