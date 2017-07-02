function Nout = droperrs (Nin)
% drop terms with errors from a narmax model

% Copyright 1999-2003, Robert E Kearney and Sunil L Kukreja
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

Nout=narmax;
nel=size(Nin);
for i=1:nel,
   el=getel(Nin,i);
   t=get(el,'terms');
   if any(t{1}(:,1)==4),
   else
      Nout=Nout+el;
   end
   
end
