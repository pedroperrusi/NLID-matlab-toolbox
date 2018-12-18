function IOut = pdefault(IIn)
% set default parameters for irfs

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

p=get_nl(IIn,'parameters');
j=size(p);
p(j+1)=param('name','DisplayFlag','default','true','help','display');
p(j+2)=param('name','Level','default',95,'help','error level');
p(j+3)=param('name','Mode','default','full','help',...
    'pseudo-inverse order selection mode ','type','select',...
    'limits',{'full','auto','manual'});
p(j+4)=param('name','Method','default','tvfil',... 
    'help','Identification method: tvfil/corr/pseudo','limits',...
    {'tvfil', 'corr',' pseudo'});
IOut=IIn;
set(IOut,'Parameters',p);
