function IOut = pdefault(IIn)
% set default parameters for lnlbl

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

p=get_nl(IIn,'parameters');
method = get_nl(IIn,'Method');
% Method is initially set in lnlbl/mklnlbl to be 'kernels'.  The first line
% sets p(1) to contain method, and it defaults to whatever it used to be.
% the idea is to estabish the help, type and limits properties.

j=size(p);
p(1)=param('name','Method','default',method,'help',...
    'Method used to estimate covariance matrix',...
    'type','select','limits', {'hessian', 'Hessian'});


IOut=IIn;
set(IOut,'Parameters',p);
