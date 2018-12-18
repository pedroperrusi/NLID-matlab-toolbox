function j = pindex (Pin, S)
% Determine the index for a parameter name
j=0;
% Pout = param;
for i=1:length(Pin)
    if strcmpi(Pin.Name{i},S)
        j=i;
        return
    end
end

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt
