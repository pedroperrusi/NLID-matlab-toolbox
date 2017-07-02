function Sout = pdefault(SIn)
% Set default parameters for a spect object

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

p=param('name','NFFT','default',NaN,'help','Length of FFT',  ...
'Type','Real','Limits',[-1 1]);
p(2)=param('name','ConfidenceLevel','default',NaN, ...
   'help','Confidence level for error estimate', 'Type','REAL');
p(3)=param('name','NoOverlap','default',NaN,'Help','Overlap between FFT segments');
p(4)=param('name','Wind','default',NaN,'Help','Window function', ...
   'type','REAL');
p(5)=param('name','Detrend_Mode','default','mean','Help','Detrend (linear/mean/none' , ...
   'type','STRING');

p(6)=param('name','Type','default','Auto','Help','Type of spectrum');
Sout=SIn;
set(Sout,'Parameters',p);
% 11 Jan 2001 REK cheange default DeTrend_mode to 'mean'
