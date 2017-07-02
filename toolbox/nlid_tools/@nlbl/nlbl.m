function NL  = nlbl (z, varargin)
% nlbl  - Nonlinear-Linear block model
% Parent: nlm

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

% Setup default values
%
% Parse input
%
%
NL = mknlbl;
if nargin==0;
   return
elseif nargin==1,
   NL=nlmkobj(NL,z);
else
   args=varargin;
   NL=nlmkobj(NL,z,args);
end



function bl = mknlbl
S=nlm;
i=irf;
t=polynom;
set(t,'Type','tcheb');
elements = { t i };
set (S,'Elements',elements);
bl.ObjTyp='NLBL';
bl=class(bl,'nlbl',S);
set(bl,'method','sls');
return


