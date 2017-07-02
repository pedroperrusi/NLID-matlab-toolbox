function nprod = mtimes (n1,n2)
% mtimes function for narmax models

% Copyright 2000, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

n1=narmax(n1);
n2=narmax(n2);
nel1 =size(n1);
nel2=size(n2);
nprod=narmax;
k=0;
for i=1:nel1,
   for j=1:nel2,
      k=k+1;
      nprod.Coef(k)=n1.Coef(i)*n2.Coef(j);
      nprod.Terms{k}=cat(1,n1.Terms{i},n2.Terms{j});
   end
end
nprod=pwrsimp(nprod);
nprod=collect(nprod);
