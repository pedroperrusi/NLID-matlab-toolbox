function m0 = hk_init(m0,uy);
% initial lnl model, first-order fit to first-order kernel
% for details see
%
%      M.J. Korenberg and I.W. Hunter, The identification of nonlinear 
%      biological systems: LNL cascade models.
%      Biological Cybernetics, 55:125-134, 1986.
%

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


%1 extract objects
blocks = get(m0,'elements');
h = blocks{1};
m = blocks{2};
g = blocks{3};

hlen = get(m0,'NLags1');
glen = get(m0,'NLags2');
memory = hlen+glen;
set(h,'NLags',hlen);
set(g,'NLags',glen);

% estimate first order kernel
k1 = h;
set(k1,'NLags',memory,'mode','auto');
k1 = nlident(k1,uy);
Ts = get(k1,'domainincr');

% fit an appropriate first-order unity gain system to the kernel.
% use 10/90 rise time in step response as about 2.2 time constants.
% using the 10/90 rise time should eliminate any problems caused by 
% delays in the system. (However, it won't work for high-pass systems)




step_response = cumsum(double(k1));
fin_value = step_response(end);
if fin_value<0
  ste_response = -step_response;
  fin_value = -fin_value;
end

t90 = min(find(step_response > 0.9*fin_value));
t10 = min(find(step_response > 0.1*fin_value)); 
tau = (Ts/2.2)*(t90-t10);


t = [0:hlen-1]'*Ts;
if tau > 0
  hh = exp(-t/tau)/Ts;
else
  hh = [1/Ts;zeros(hlen-1,1)];
end
set(h,'data',hh,'domainincr',Ts);
set(g,'domainincr',Ts); 
set(m0,'elements',{h m g});
m0 = BestHammer(m0,uy,'hk');







