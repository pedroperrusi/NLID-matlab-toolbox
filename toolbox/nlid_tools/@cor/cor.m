function C = cor (a,varargin)
%correlation function object
% Parent: kern

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt


C=mkcor;
if nargin==0
    return
elseif nargin==1
    C=nlmkobj(C,a);
else
    args=varargin;
    C=nlmkobj(C,a,args);
end

function c=mkcor
c.name='cor';
K=kern;
c=class(c,'cor',K);
c=pdefault(c);
return
