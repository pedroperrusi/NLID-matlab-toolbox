function Nout = purge (Nin);
% delete zero elements from a Narmax Model

% Copyright 2000, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

nel=size(Nin);
Nout=narmax;
j=1;
for i=1:nel,
   if abs(Nin.Coef(i)) > 0,
      Nout.Coef(j)=Nin.Coef(i);
      Nout.Terms{j}=Nin.Terms{i};
      j=j+1;
   else
   end
end

      
   
