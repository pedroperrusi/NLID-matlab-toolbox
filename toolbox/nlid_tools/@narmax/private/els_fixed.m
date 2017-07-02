function [N, err] = els_fixed (Nin, Z)
% extended least squares identification of a NarMax model with
% a fixed strucuture
% use ols to get first estimate of noise;

% Copyright 2000, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

[Nout,err]=ols_fixed(Nin, Z);
%
% Convert model to els;
Nout=Nout+'e(n)';
Nels = ols2els(Nout);
z=cat(2,Z,err);
z(:,3)=err;
y=double(z(:,2));
RM = els_rmt (Nels,double(z));
theta= RM\y;
z_hat=RM*theta;
new_err=y-z_hat;
Nels.Coef=theta;
N=Nels
return

