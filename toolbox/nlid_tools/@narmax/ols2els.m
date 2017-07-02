function Ne = ols2els (No)
% convert from ols to els representation

% Copyright 1999-2000, Robert E Kearney and Sunil L Kukreja
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

nel=size(No);
Ne=narmax;
disp(No);
for i=1:nel,
   S.type='()';
   S.subs={i};
   el=subsref(No,S);
   disp(el);
   [nterm, ncol]=size(el.Terms{1});
   t=el.Terms{1};
   elout='1';
   p=narmax('1');
   pt=narmax('z(n)-e(n)');
   
   for j=1:nterm,
      if t(j,1)==2,
         disp('yterm');t(j,:)
         lag=t(j,2);
         pwr=t(j,3);
         pt.Terms{1}=[3 lag 1];
         pt.Terms{2}=[4 lag 1];
         for k=1:pwr,
            p=p*pt;
         end
         
         t(j,:)=[0 0 0];
      end
   end
   el.Terms{1}=t;
   el=el*p;
   disp(el)
   Ne=Ne+el;
end

