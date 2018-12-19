function P = polynom (z, varargin)
% polynominal object
%  Parent: nltop

% Copyright 2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

P=mkpoly;
if nargin==0
    return
elseif nargin==1
    P=nlmkobj(P,z);
else
    args=varargin;
    P=nlmkobj(P,z,args);
end



return
function s=mkpoly
s.Coef= NaN;
s.Mean=NaN;
s.NInputs=1;
s.Order=5;
s.Parameters=param;
s.Range=[NaN;NaN];
s.Std=NaN;
s.Type='hermite';
s.VAF=NaN;
N=nltop;
s=class(s,'polynom',N);
s=pdefault(s);
return



% @polynom/polynom
