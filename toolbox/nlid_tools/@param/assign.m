function assign (p)
% assign values of parameters in calling workspace
n=length(p);
for i=1:length(p)
   name=p.Name{i};
   val=value(p,i);
   assignin('caller',name,val)
end

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 
