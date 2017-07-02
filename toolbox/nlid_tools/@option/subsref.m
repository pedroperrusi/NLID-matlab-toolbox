function P = subsref (O, S); 
p=get(O,'paramlist');
namein=S.subs{1};
for i=1:length(p),
   name=get(p{i},'name');
   if strcmp(name,namein),
      P=p{i};
      return
   end
end
class(S.subs)
error (['parameter: ' S.subs{1} ' not found' ]);


% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 
