function P = pdf (a,varargin)
% Probabilty Distribution Function Object
% Parent: nldat

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

P=mkpdf;
if nargin==0
    return
elseif nargin==1
    P=nlmkobj(P,a);
else
    args=varargin;
    P=nlmkobj(P,a,args);
end


function p=mkpdf
p.Parameters=param;
N=nldat;
set(N,'DomainIncr',NaN, 'DomainStart',NaN,'Size',NaN);
set (N,'Comment','pdf');
p=class(p,'pdf',N);
p=pdefault(p);

return
