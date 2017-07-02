function [h,UTU] = ex2_fil(u,y,hlen);
% direct least squares regression estimate of an IRF.
% part of the solution to chapter 5 exercise 2.
%
%  [h,UTU] = ex2_fil(u,y,hlen);

ud = double(u);
yd = double(y);

N = length(ud);
U = zeros(N,hlen);

udel = ud(:);
for i = 1:hlen
  U(:,i) = udel;
  udel = [0;udel(1:N-1)];
end

%Compute the Hessian
UTU = U'*U;

% Use MATLABs left divide to compute the 
% least square regression solution.
h = U\yd;
