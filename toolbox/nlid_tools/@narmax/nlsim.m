function y = nlsim ( N, x )
% Simulate response of a NARMAX model to input data set

% Copyright 1999-2000, Robert E Kearney and Sunil L Kukreja
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

xd=double(x);
[nsamp, nxin] =size(x);
X=zeros (nsamp,3);
X(:,1)=xd(:,1);
if nxin > 1,
   X(:,4)=xd(:,2);
end


nelement=size(N);

for i=1:nsamp,
   y=0;
   for j=1:nelement,
      terms=N.Terms{j};
      [nterm,nval]=size(terms);
      yterm=N.Coef(j);
      for k=1:nterm,
         var=terms(k,1);
         lag=i-terms(k,2);
         power=terms(k,3);
         if lag < 1,
            yterm=0;
         else
            yterm= yterm*(X(lag,var)^power);
         end
      end
      y=y+yterm;
   end
   X(i,2)=y;
   
end
y=nldat(X(:,2));
