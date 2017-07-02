 function y = cumsum (x, DIM);

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see copying.txt and gpl.txt 

y=nldat(x);
if nargin==1,
  y.Data=cumsum((x.Data));
else
  y.Data=cumsum(x.Data,DIM);
end

set (y,'Comment','Cumsum');
return
% nldat/cumsum
% rek 9 April 2000
