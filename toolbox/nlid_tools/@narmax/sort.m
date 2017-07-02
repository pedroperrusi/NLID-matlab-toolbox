function nsort = sort (n)
% Sort a narmax model into cannonical form

% Copyright 1999-2000, Robert E Kearney and Sunil L Kukreja
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

nel=size(n);
ns=n;
nsort=n;
% sort terms
vsrt=[];;
for i=1:nel,
   t=n.Terms{i};
   tsort=sortrows(t,[1 3 1]);
   ou=[99 99 99 99];
   oy=99;
   for j=1:4,
      % terms in u only
      if all(t(:,1)==j),
         iv=j*10; ou(j)=max(t(:,3));
         break
      elseif any(t(:,1)==j),
         iv=j*10;
         for k=j+1:4,
            if any(t(:,1)==k),
               iv=iv+j;
            end
         end
         break
      end    
   end
   io=sum(t(:,3));
   vsrt=cat(1,vsrt, [iv io]);
   n.Terms{i}=tsort;
end

[esrt,isort]=sortrows(vsrt,[1 2 ]);
nsort.Coef=n.Coef(isort);
% sort by element order
for j=1:nel,
   nsort.Terms{j}=n.Terms{isort(j)};
end

