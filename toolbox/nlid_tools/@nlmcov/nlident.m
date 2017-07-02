function covar  = nlident (covar, z, varargin)
% Construct a nlmcov for an identified model.

% Copyright 2004, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

stuff = get(covar,'elements');
model = stuff{1};
covmat = stuff{2};


% figure out if we have been passed a model, or just some data.
if isa(z,'nldat') | isa(z,'double')
  % z contains identification data (we hope)
  % make sure that the model has been specified in covar
  if ~isa(model,'vseries') & ~isa(model,'polynom') & ~isa(model,'irf')
    error('only vseries, polynom and irf classes supported (so far)');
  end 
  if nargin > 2
    set(covar,varargin);
  end
elseif ~isa(z,'vseries') & ~isa(z,'polynom')  & ~isa(model,'irf')
  error('only vseries, polynom and irf classes supported (so far)');
else
  % second argument is either a vseries or a polynom
  model = z;
  if nargin == 2
    error('must provide identification data');
  else
    z = varargin{1};
    if nargin > 3
      nargs = length(varargin);
      args = varargin{2:nargs};
      set(covar,args);
    end
  end
end

% at this point, model contains the model, and z contains the
% identification data.  Make sure that z contains at least two columns.

[N,nchan,nreal] = size(z);

if nchan < 2
    error('both input and output are required');
end

H = hessian(model,z);
if isa(model,'irf')
  % irf was probably estimated using a pseudo-inverse, so Hessian will be
  % rank defficient.  Use pinv instead of inv to eliminate singular vectors
  % that were deleted in identification.
  covmat = pinv(H)/N;
else
  covmat = inv(H)/N;
end

resid = double(nlid_resid(model,z,0));
% third argument suppresses display
npar = size(H,1);
N = length(resid);
evar = (1/(N-npar))*sum(resid.^2);

covmat = covmat*evar;

stuff = {model;covmat};
set(covar,'elements',stuff);



return
