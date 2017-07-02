function H = hessian(htau,z,varargin)
% compute the hessian for a pseudo-inverse based IRF estimate.


% Copyright 2004, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


% make sure that the second argumment is either nldat or double,
% and contains enough colums for input(s) and output


if ~(isa (z,'double') | isa(z,'nldat'))
  error (' Second argument must be of class double, or nldat');
end

P = get(htau,'parameters');
assign(P);
Ts = get(htau,'DomainIncr');

if strcmp(lower(TV_Flag),'yes')
  error('covariance computation not yet implemented for time varying IRFs');
end

u = double(z(:,1));
y = double(z(:,2));
N = length(u);
J = zeros(N,NLags);

J(:,1) = u;
for i = 2:NLags
  J(:,i) = [0;J(1:N-1,i-1)];
end

Phi = cor(z(:,1),'nlags',NLags,'type','covar','bias','biased');
phi_uu = double(Phi);
phi_uy = double(nlident(Phi,z));


% full rank hessian;
H = toeplitz(phi_uu);
  
% figure out whether or not a full-rank solution was used.
Beta = phi_uy(:);
[U,S,V] = svd(H);
svs = diag(S); 
Sinv = 1./svs;
  
%  sort the "modes" in order of their output contribution, rather than in
%  order of input power (default provided by the svd)
  

out_var = diag(Sinv)*((U'*Beta).^2);
[coeff,indeces] = sort(out_var);
indeces = flipud(indeces);
coeff = flipud(coeff);
V = V(:,indeces);
U = U(:,indeces);
svs = svs(indeces);
Sinv = Sinv(indeces);

% now build up the solutions, one by one


hs = zeros(NLags,NLags);
hs(:,1) = U(:,1)*(V(:,1)'*Beta/svs(1));
for i = 2:NLags
  hs(:,i) = hs(:,i-1) +  V(:,i)*(U(:,i)'*Beta/svs(i));
end

hs = hs/Ts;

% and find the one that is the closest to the IRF estimate
% so that we can determine the number of terms included in the
% pseudo-inverse. 
vafs = zeros(NLags,1);
for i = 1:NLags
  vafs(i) = vaf(double(htau),hs(:,i));
end

[val,pos] = max(vafs);


H = U(:,1:pos)*diag(svs(1:pos))*V(:,1:pos)';



