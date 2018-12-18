function F = fresp (a,varargin)
% frequency response function object
%  Parent: nldat

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 
    
F = mkfresp;
if nargin==0
    % Generate an empty fresp variable
    return
elseif nargin==1
    F = nlmkobj(F,a);
else
    args=varargin;
    F = nlmkobj(F,a,args);
end

function F=mkfresp
FreqResp=nldat;
F.Parameters=param;
F=class(F,'fresp',FreqResp);
F=pdefault(F);

return

% V01-02 Added tfe functionality 
% V01-03 11 Jan 2002 REK Added support for 'Wind', 'NoOverLap' and 'DeTrend_Mode' paramters.
