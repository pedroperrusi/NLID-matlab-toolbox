function y = min (x, DIM);
y=nldat(x);
if nargin==1,
  y.Data=min((x.Data));
else
  y.Data=min(x.Data,[],DIM);
end

set (y,'Comment','Min');
return
% nldat/min

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see copying.txt and gpl.txt 
