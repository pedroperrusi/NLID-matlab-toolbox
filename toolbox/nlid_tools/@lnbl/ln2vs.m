function vs=ln2vs (ln, vsin)
% generate Volterra kernels for Wiener cascade model

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


OrderMax = get(vsin,'ordermax');

stuff = get(ln,'elements');
h = double(stuff{1});
hlen = length(h);
Ts = get(stuff{1},'domainincr');
p = stuff{2};
p = nlident(p,'type','power');
mc=get(p,'Coef');
Q = get(p,'order');
if Q > OrderMax
  % truncate polynomial to aviod producing high-order kernels.
  str = ['truncating Volterra series at order ' num2str(OrderMax)];
  warning(str);
  Q = OrderMax;
end
kernels = cell(Q+1,1);


for q = 1:Q+1
  k = mc(q)*wckern(h,q-1);
  kernels{q} = vkern(k,'order',q-1,'domainincr',Ts);
end
vs=vsin;
set(vs,'elements',kernels,'NLags',hlen,...
    'comment','Transformed Wiener Cascade');