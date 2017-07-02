function lnl = ex1_lnl(volterra,slice)

kernels = get(volterra,'elements');

k0d = double(kernels{1});
k1 = kernels{2};
k1d = double(k1);
k2 = kernels{3};
k2d = double(k2);

hlen = get(k1,'Nlags');
Ts = get(k1,'domainincr');


gd = [k2d(slice:end,slice);zeros(slice-1,1)];
g = irf;
set(g,'domainincr',Ts,'data',gd);

u = nldat(randn(10000,1),'domainincr',Ts);

x1 = nlsim(g ,u);
x2 = nlsim(k1,u);
deconvdat = cat(2,x1,x2);


h = irf;
set(h,'mode','auto','Nlags',hlen);
h = nlident(h,deconvdat);

m = polynom;
set(m,'type','power','order',2,'coef',[0 1 1]');

lnl = lnlbl;
elements = {g m h};
set(lnl,'elements',elements);

vtest = vseries(lnl);

estkernels = get(vtest,'elements');

k1de = double(estkernels{2}); k1de = k1de(1:64);
k2de = double(estkernels{3}); k2de = k2de(1:64,1:64);


c0 = k0d/(Ts*sum(double(h)));
c1 = k1de\k1d;
c2 = (k2de(:)\k2d(:));

set(m,'coef',[c0 c1 c2]');
elements = {g m h};
set(lnl,'elements',elements);

