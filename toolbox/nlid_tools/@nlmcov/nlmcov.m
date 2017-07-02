function COVAR  = nlmcov (model, z, varargin)
% Class containing an estimated model and its covariance matrix.
% Parent: nlm

% Copyright 2004, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

COVAR=mknlmcov;
if nargin==0;
   return
 end 
subsys = get(COVAR,'elements');
if isa(model,'nlm')|isa(model,'polynom')|isa(model,'irf')
    subsys{1} = model;
    set(COVAR,'elements',subsys);
else
    error('first argument must be either nlm, polynom or irf');
end
if nargin==2,
  COVAR=nlmkobj(COVAR,z);
else
   args=varargin;
   COVAR=nlmkobj(COVAR,z,args);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function covar = mknlmcov
S=nlm;
model = nlm;
covmat = NaN;
elements = {model; covmat};
set (S,'Elements',elements);
covar.ObjType='nlmcov';
covar=class(covar,'nlmcov',S);
set(covar,'method','hessian');
covar=pdefault(covar);
return


