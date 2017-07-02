% sample solution for exercise 2, chapter 8

clear
close all
echo on


[bf,af] = butter(2,0.5);
u = filter(bf,af,randn(10000,1));
[b,a] = butter(4,0.25);
x = filter(b,a,u);
y = x.^2;
y = y - mean(y);

Ts = 1/100;
u = nldat(u,'domainincr',Ts);
y = nldat(y,'domainincr',Ts);
uy = cat(2,u,y);


% make sure that the input and output are linearly incorrelated
phi = cor;
set(phi,'type','coeff','NLags',50,'bias','biased');
phi = nlident(phi,uy);
figure(1)
plot(phi)
title('First-order Cross-correlation coefficient function');
pause(1);

% Now try the iteration

h = irf;
set(h,'data', randn(50,1),'mode','auto','domainincr',Ts);
x = nlsim(h,u);
xy = x;

Hs = zeros(50,10);

for i = 1:10  
  set(xy,'data', double(x).*double(y));
  h = nlident(h,cat(2,u,xy));
  hd = double(h);
  hd = hd/norm(hd);
  set(h,'data',hd);
  x = nlsim(h,u);
  Hs(:,i) = hd;
  figure(2)
  plot(h);
  title_string = ['Iteration: ' num2str(i)];
  title(title_string);
  pause(0.5);
end
  
path = lnbl;
set(path,'initialization','gen_eigen','NLags',50,'OrderMax',8);
path = nlident(path,uy);
subsys = get(path,'elements');
figure(3)
plot(subsys{1});
title('IRF identified using generalized eigenvector approach');

echo off



