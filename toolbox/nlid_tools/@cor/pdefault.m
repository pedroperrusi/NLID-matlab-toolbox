function IOut = pdefault(IIn)
% set default parameters for cor object

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

p=get_nl(IIn,'parameters');
j=size(p);
p(j+1)=param('name','Bias','default','unbiased','help','Biased or unbiased', ...
    'type','select','limits', {'biased' 'unbiased'});
p(j+2)=param('name','Type','default','coeff','help','type of vorrelation function', ...
    'type','select','limits',{'covar' 'correl' 'coeff'});
IOut=IIn;
set(IOut,'Parameters',p);
