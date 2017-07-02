function [theta,vlabel,PHI,Q,R,err]=ols(u,y,N,n,nx,ny);
%  Ordinary least squares
%
%  [theta,vlabel,PHI,Q,R,err]=ols(u,y,N,n,nx,ny);
%
%  INPUTS:
%  u - input
%  y - output
%  N - number of data points to be used 
%  n - nonlinerity order
%  nx - input lag order
%  ny - ouput lag order
%
%  OUTPUTS:
%  theta - estimated parameters
%  vlabel - parameter labels
%  PHI - regressor matrix
%  Q - orthogonal decomposition of PHI
%  R - triangular decomposition of PHI
%  err - residuals
% 
%
%
%
%       Copyright Sunil L. Kukreja 16 November 1999 
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%setup the i-o data
ne=0; %initially has to be zero

%Identification Data Set 
x=u(1:N); %input data to be used for estimation
z=y(1:N); %output data to be used for estimation
e=[];     %initially has to be empty

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           REGRESSOR MATRIX                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[vlabel,lenu]=name2(n,nx,ny,ne);
PHI=rmt2(N,n,nx,ny,ne,x',z',e');
[a,b]=size(PHI);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       ORTHOGONALIZE REGRESSOR MATRIX                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Q,R]=mgs([PHI z]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           PARAMETER VECTOR                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gamma=R(1:b,b+1);
R=R(1:b,1:b);
theta=R\gamma;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               RESIDUALS                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z_hat=PHI*theta;
err=z-z_hat;
vlabel=vlabel';
