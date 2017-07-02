function k = nlident ( k, z, varargin )
% Default identification for kernel objects
% simply set the kernel values equal to z

% Copyright 1991-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

set (k, 'data',z);
if length(varargin) > 0,
   set (k,varargin);
end

return
