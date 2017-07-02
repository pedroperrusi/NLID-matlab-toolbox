function n = nltop(a, varargin)
% Top level object for nlid
%  Parent: none
   %
   % Setup default values
if nargin== 0,
   n.Comment='Default comment';
   n.Version='1.01';
   n=class(n,'nltop');
elseif isa (a,'n');
   s=a;
  else
   error(['nltop does not support inputs of class ' class(s)])
end
return

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

