function S = spect (z,varargin)
% power spectrum object
% Parent: nldat

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

S =mkspect;
if nargin==0
    return
elseif nargin==1
    S=nlmkobj(S,z);
else
    args=varargin;
    S=nlmkobj(S,z,args);
end

%
%
function s=mkspect
s.ConfInter=NaN;
s.Parameters =param;
SpectData=nldat;
set(SpectData,'DomainName','Frequency');
s=class(s,'spect',SpectData);
s=pdefault(s);
return

