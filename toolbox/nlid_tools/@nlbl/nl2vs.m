function vs = nl2vs (nl,vsin);
% Convert  Volterra series from nl model  description
% 

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 



OrderMax = get(vsin,'ordermax');

subsystems = get(nl,'elements');
p = subsystems{1};
p = nlident(p,'type','power');
mc=get(p,'Coef');

h = double(subsystems{2});
Ts = get(subsystems{2},'domainincr');
hlen = length(h);

Q = get(p,'order');
if Q > OrderMax
  % truncate polynomial to aviod producing high-order kernels.
  str = ['truncating Volterra series at order ' num2str(OrderMax)];
  warning(str);
  Q = OrderMax;
end
kernels = cell(Q+1,1);


for q = 1:Q+1
  k = (mc(q)/Ts^(q-2))*hckern(h,q-1);
  kernels{q} = vkern(k,'order',q-1,'domainincr',Ts);
end
vs=vsin;
set(vs,'elements',kernels,'OrderMax',Q,'NLags',hlen,...
    'comment','Transformed Hammerstein Cascade');
