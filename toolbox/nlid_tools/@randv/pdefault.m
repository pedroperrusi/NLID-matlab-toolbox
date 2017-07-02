function IOut = pdefault(IIn);
% set default parameters for kern


% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

p=param('name','Mean','default',0,'help','Mean', ...
   'type','real','Limits', [ -inf inf]);
p(2)=param('name','SD','default',1,'help','Standard Deviation', ...
   'type','real','Limits', [ -inf inf]);
IOut=IIn;
set(IOut,'Parameters',p);
