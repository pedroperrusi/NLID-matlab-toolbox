function vs=wb2vs (wb, vs)
% generate Volterra kernels for Wiener-Bose model

% Copyright 2004, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


OrderMax = get(vs,'ordermax');
if OrderMax > 3
  disp('Truncating VSeries to Order 3');
  OrderMax = 3;
  set(vs,'ordermax',3);
end
kernels = cell(OrderMax+1,1);

subsys = get(wb,'elements');
fbank = subsys{1};
poly = subsys{2};

poly = nlident(poly,'type','power');
coeff = get(poly,'coef');

NFilt = length(fbank);
NLags = get(fbank{1},'NLags');



basis = zeros(NLags,NFilt);
for i = 1:NFilt
  basis(:,i) = get(fbank{i},'data');
end
Ts = get(fbank{1},'domainincr');
set(vs,'nlags',NLags);

vkernel = vkern;
set(vkernel,'nlags',NLags,'domainincr',Ts);
for i = 0:OrderMax
  vk = gen_kern(basis,coeff,i); 
  set(vkernel,'order',i,'data',vk);
  kernels{i+1} = vkernel;
end
set(vs,'elements',kernels,'comment','Transformed Wiener Bose Model');
