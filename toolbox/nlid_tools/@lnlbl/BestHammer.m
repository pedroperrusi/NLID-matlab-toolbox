function [m0,err,vf] = BestHammer (m0,uy,method)
% computes Hammerstein model to follow first IRF.

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

if nargin < 3
    method = 'hk';
end

blocks = get_nl(m0,'elements');
h = blocks{1};
m = blocks{2};
g = blocks{3};

u = uy(:,1);
y = uy(:,2);

Ts = get_nl(u,'DomainIncr');
order = get_nl(m,'OrderMax');
hlen = get_nl(g,'NLags');
x = nlsim(h,u);

hdata = cat(2,x,y);
mh = nlbl(hdata,'method',method,'OrderMax',order,'NLags',hlen,...
    'Tolerance',0.01);
hblocks = get_nl(mh,'elements');
m = hblocks{1};
g = hblocks{2};
set(m0,'elements',{h m g});

if nargout > 1
    testout = nlsim(m0,u);
    err = y - testout;
    vf = double(vaf(y,testout));
end
