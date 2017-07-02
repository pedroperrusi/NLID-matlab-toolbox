function IOut = pdefault(IIn);
% set default parameters for kern

% Copyright 1991-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

p=param('name','NLags','default',16,'help','Number of lags', ...
   'type','real','Limits', [ 1 inf]);
p(2)=param('name','NSides','default',1,'help','number of sides', ...
   'type','real','limits',[1 2]);
p(3)=param('name','Order','default',1,'help','kernel order', ...
   'type','real','limits',[1 2]);
p(4)=param('name','TV_Flag','default','No','help','TV_Flag(Yes/No)');

IOut=IIn;
set(IOut,'Parameters',p);
