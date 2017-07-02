function H = hessian(p,z,varargin);
% computes hessian for least squares estimate of a polynomial


% Copyright 2004, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


% make sure that the second argumment is either nldat or double,
% and contains enough colums for input(s) and output


if ~(isa (z,'double') | isa(z,'nldat'))
  error (' Second argument must be of class double, or nldat');
end
[nsamp,nchan,nreal]=size(z);
nin = get(p,'NInputs');

order = get(p,'order');
dz=double(z);
if nchan == nin,
   x=double(domain(z));
   y=dz(:,1:nin);
else
   x=dz(:,1:nin);
   y=dz(:,nin+1);
end
type=get(p,'Type');
switch lower(type);
 case 'power'
   [W,f]=multi_pwr(x,order);
 case 'hermite'
   % Scale inputs to 0 mean, unit variance.
   for i=1:nchan-1,
     x(:,i) = (x(:,i) - mean(x(:,i)))/std(x(:,i));
   end
   [W,f]=multi_herm(x,order);
 case 'tcheb'
   % Scale inputs to +1 -1;
   for i=1:nchan-1,
      a=min(x(:,i));
      b=max(x(:,i));
      cmean=(a+b)/2;
      drange=(b-a)/2;
      x(:,i)=(x(:,i) - cmean)/drange;
    end
   [W,f]=multi_tcheb(x,order);
end


H = (W'*W)/nsamp;

