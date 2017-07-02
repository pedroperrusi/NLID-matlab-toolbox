function IOut = pdefault(IIn);
% set default parameters for fresp

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

p=param('name','Display_Flag','default','true','help','display');
p(2)=param('name','Method','default','tfe','help','Estimation method');
p(3)=param('name','NFFT','default',NaN,'help','segment length');
p(4)=param('name','NoOverlap','default',0,'help','Number of points window overlaps');
p(5)=param('name','Wind','default', NaN,'help','Window ');
p(6)=param('name','Detrend_Mode','default','mean','Help','Detrend (linear/mean/none' , ...
   'type','STRING');
set(IIn,'Parameters',p);
IOut=IIn;
