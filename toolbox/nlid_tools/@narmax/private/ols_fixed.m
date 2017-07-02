function [N, err] = ols_fixed (Nin, Z)
% ordinary least squares identification of a NarMax model with
% a fixed strucuture

% Copyright 1998-2000, Robert E Kearney and Sunil L Kukreja
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


z=  double(Z);
[nsamp,ncol]=size(z);
y=z(:,2);
% error not defined so do not estimate
if ncol==2,
  N=droperrs(Nin);
else
  N=Nin;
  z(:,4)=z(:,3);
end
RM = narmax_rmt (N,z);
theta= RM\y;
z_hat=RM*theta;
err=y-z_hat;
N.Coef=theta';

