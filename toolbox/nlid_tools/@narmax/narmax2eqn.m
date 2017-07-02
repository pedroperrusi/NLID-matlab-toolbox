function eqn= narmax2eqn(N);
% Convert a narmax object to equation format

% Copyright 1999-2000, Robert E Kearney and Sunil L Kukreja
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

nterms=size(N); 
vars='uyze';
sel=' '; 
% loop for each term
for i=1:nterms
   el=N.Terms{i};
   [nel,m]=size(el);
   xcoef=N.Coef(i);
   if xcoef>=0,
         sel=[sel ' +'];
      elseif xcoef <0,
         sel = [sel ' -'];
      end
    
    if (abs(xcoef) >= 0),
         sel=[sel num2str(abs(xcoef))];
      end
% loop for each element in term
   for j=1:nel,
      xvar = el(j,1);
      xlag = -el(j,2);
      xpower = el(j,3);
      if xvar >0,
         if j>1,
         sel=[sel '*'];
      end

         
      sel=[sel vars(xvar)];
      if xpower ~= 1,
            sel = [sel '^' int2str(xpower)];
      end
      sel=[sel '(n'];
      if (xlag ~=0),
            sel=[sel int2str(xlag)];
         end
         sel=[sel ')'];end
      
         
   end
   
   end
   eqn=sel;
   % narmax/narmax2eqn
