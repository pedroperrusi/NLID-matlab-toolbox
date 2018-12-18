function IOut = pdefault(IIn)
% set default parameters for wbose

% Copyright 1999-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

p=get_nl(IIn,'parameters');
method = get_nl(IIn,'Method');
% Method is initially set in wbose/mklnbl to be 'laguerre'.  The first line
% sets p(1) to contain method, and it defaults to whatever it used to be.
% the idea is to estabish the help, type and limits properties.
j=size(p);
p(1)=param('name','Method','default',method,'help','Identification method' ,...
    'type','select','limits', {'laguerre' 'Laguerre' 'pdm' 'poly'});
if j < 2
    p(2) = param('name','NFilt','default',NaN,...
        'help','Number of fitlers in filter bank','type','number',...
        'limits',{1 1000});
end
if j<3
    p(3)=param('name','NLags','default',NaN,'help',...
        'Number of lags in each kernel' ,'type','number','limits', {0 1000});
end
if j <4
    p(4)=param('name','OrderMax','default',3,'help',...
        'Maximum order for series' ,'type','number','limits', {0 6});
end


switch lower(method)
    case 'laguerre'
        p(5)=param('name','alpha','default',0.2,'help',...
            'Laguerre decay parameter', 'type','number','limits', {eps 1-eps});
        p = p(1:5);
    case 'pdm'
        p(5) = param('name','mode','default','auto','help',...
            'method to select number of filters','type','select',...
            'limits',{ 'auto' 'fixed' 'manual' });
        p(6) = param('name','id-method','default','laguerre',...
            'help','Initial Kernel Identification Method' , 'type','select',...
            'limits', {'FOA' 'foa' 'Laguerre' 'laguerre'});
        p = p(1:6);
    case 'poly'
        p = p(1:4);
    otherwise
        error(['wbose objects do not support method: ' method]);
end




IOut=IIn;
set(IOut,'Parameters',p);
