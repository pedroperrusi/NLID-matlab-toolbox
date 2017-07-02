function Sout = pdefault(SIn)
% Set default parameters for a pdf object

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

p=param('name','Type','default','Probability','help','Type of pdf',  ...
   'Type','Select',...
   'Limits',{'Density' 'Frequency' 'Probability','Analytical'});
p(2)=param('name','NBins','default',NaN,'help','Number of bins',  ...
   'Type','number', 'limits', {1 inf});
p(3)=param('name','BinMin','default',NaN,'help','Lowest Bin Value',  ...
'Type','number','limits',{1 inf});
p(4)=param('name','BinMax','default',NaN,'help','Highest Bin Value',  ...
'Type','number','limits',{1 inf});

Sout=SIn;
set(Sout,'Parameters',p);

