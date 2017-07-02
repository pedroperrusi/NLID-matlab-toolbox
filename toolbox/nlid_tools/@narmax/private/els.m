function [theta,vlabel,lenu,err,z_hat,PHI]=els(u,y,N,n,nx,ny,iter);
%  Extended least squares
%
%  [theta,vlabel,lenu,err,z_hat,PHI]=els(u,y,N,n,nx,ny,iter);
%
%  INPUTS:
%  u - input
%  y - output
%  N - number of data points to be used 
%  n - nonlinerity order
%  nx - input lag order
%  ny - ouput lag order
%  iter- number of iterations for improving noise model
%
%  OUTPUTS:
%  theta - estimated parameters
%  vlabel - parameter labels
%  lenu- number of columns that are purely due to input
%  err - residuals
%  z_hat - predicted output
%  PHI - regressor matrix
%
%
%
%
%       Copyright Sunil L. Kukreja 16 November 1999 
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%setup the i-o data
%Identification Data Set 
x=u(1:N); %input data to be used for estimation
z=y(1:N); %output data to be used for estimation
e=[];     %initially has to be empty

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              ORDINARY LEAST SQUARES                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[theta,vlabel,PHI,Q,R,err]=ols(u,y,N,n,nx,ny);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      EXTENDED REGRESSOR MATRIX                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ne=ny; %assuming output additive noise
[vlabel,lenu]=name2(n,nx,ny,ne);

for jj=1:iter

PHI2=fastrmt2(N,n,nx,ny,ne,x',z',err');
PHI=[PHI(:,1:lenu) PHI2];
[a,b]=size(PHI);
clear PHI2

[Q,R]=rmmgs(Q,R,[PHI z],lenu);

gamma=R(1:b,b+1);
R=R(1:b,1:b);
theta=R\gamma;

z_hat=PHI*theta;
err=z-z_hat;

end
vlabel=vlabel';
