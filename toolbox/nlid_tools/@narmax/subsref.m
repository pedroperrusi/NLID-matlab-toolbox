function e = subsref (N,S);
% overlaid subsref for narmax objects
% N(i,j) returns system description ith object in jth path

% Copyright 2000, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

e=narmax;
s=S.subs{1};
if strcmp (S.type, '()'),
   e.Coef=N.Coef(s);
   for i=1:length(s),
      e.Terms{i}=N.Terms{s(1)};
   end

   
   
   
else
   e=NaN;
   error ('NLM subsref not yet implemented for this syntax');
end
return
% nlm/subsref
