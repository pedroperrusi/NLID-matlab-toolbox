function display (O)
% display options
PL=O.ParamList;
disp('Option object:')
for i=1:length(PL),
   p=PL{i};
get(p)
end

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 
