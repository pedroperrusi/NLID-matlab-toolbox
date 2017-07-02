function O = nlmkobj ( obj, z, arg )
% Standard call for NLID objects
% Parse input
%
%

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see copying.txt and gpl.txt 

objclass=class (obj);
if isa (z,objclass),
   % First argument is object;
   O=z;
   if nargin==3,
      if isa(arg{1},'nldat') | isa(arg{1},'double'),
         % Second Argument is nldata do identification
         O=nlident (O,arg{1},arg{2:end});
      else
         % Second argument is a parameter. Set it. 
         set(O,arg);
      end
   end
else
   % First argument is nldat - ;
   O=obj;
   if nargin==2,
      O=nlident(O, z);
   else
     
      O=nlident(O, z, arg);
   end
   
end
return

% nlmkobj

