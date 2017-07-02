function TVMnew = tvm (x,varargin)
% define and create time-varying model objects
%  Parent: nldat 

% Copyright 2000, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

TVMnew=mktvm;
if nargin==0;
   return
elseif nargin ==1,
    if isa (x,'tvm'),
        TVMNew=x;
        return
    end
    TVMnew=nlmkobj(TVMnew,x)
       
else
   args=varargin;
   TVMnew=nlmkobj(TVMnew,x,args);
end


%
%
function TVM=mktvm
Model=nldat;
TVM.Model_Type='irf';
TVM.Parameters=param;
TVM=class(TVM,'tvm',Model);
TVM=pdefault(TVM,'irf');

return
