function out = nlsim(covar,u,varargin);
% overloaded nlsim for nlmcov class.
% computes output of model with confidence bounds.

stuff = get(covar,'elements');

if isa(u,'double')
  u = nldat(u);
  ystd = u;
elseif isa(u,'nldat')
  ystd = u;
else
  error('second argument must be either nldat or double');
end


model = stuff{1};
S = stuff{2};

N = length(u);
yest = nlsim(model,u);
yvar = zeros(N,1);

J = jacobian(model,u);

for i = 1:N
  yvar(i) = J(i,:)*S*J(i,:)';
end

set(ystd,'data',sqrt(yvar),'chanunits','standard deviation')
out = cat(2,yest,ystd);


