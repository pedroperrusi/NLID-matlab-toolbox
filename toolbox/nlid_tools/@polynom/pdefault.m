function IOut = pdefault(IIn);
% set default parameters for polynom objects

% Copyright 2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

p=param('name','Mode','default','auto','help','order selection method',...
    'type','select','limits',{'auto','full','manual'});
p(2)=param('name','OrderMax','default',10,'help','maximum order to evaluate');
IOut=IIn;
set(IOut,'Parameters',p);      
