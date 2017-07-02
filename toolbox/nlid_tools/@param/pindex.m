function j = pindex (P, S); 
% Determine the index for a parameter name
j=0;
Pout=param;
for i=1:length(P),
   if strcmp(lower(P.Name{i}),lower(S)),
      j=i;
   end
end

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 
