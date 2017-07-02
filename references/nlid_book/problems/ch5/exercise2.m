% ch5/exercise2.m  Sample solution for chapter 5 exercise 2

if ~exist('model1')
  mod1;
end

if ~exist('N')
  N = 500;
end


u = randn(N,1);
u = nldat(u,'domainincr',1/200);
y = nlsim(model1,u);

[h1,UTU] = ex2_fil(u,y,32);

PHIUU = toeplitz(phixy(double(u),32));
 
err = (1/N)*UTU-PHIUU;
mesh(err)