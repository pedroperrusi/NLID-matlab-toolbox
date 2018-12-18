function x = getvalue(p,i)
% Return value of a parameter

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

if nargin==1
    i=1;
end
if isnan(p.Value{i})
    x=p.Default{i};
else
    x=p.Value{i};
end
switch p.Type{i}
    case 'real'
        x=double(x);
end



