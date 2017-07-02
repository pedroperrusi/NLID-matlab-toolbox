function IOut = pdefault(IIn);
% set default parameters for kern

% Copyright 2002-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

p=param('name','omega','default',1,'help','frequency', ...
   'type','real','Limits', [ 0 inf]);
p(2)=param('name','phi','default',0,'help','Phase shift rad', ...
   'type','real','Limits', [ -inf inf]);
IOut=IIn;
set(IOut,'Parameters',p);
