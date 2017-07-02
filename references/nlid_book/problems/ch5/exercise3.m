% ch5/exercise 3  sample solution

clear 
close all
model3
echo on


Ts = get(u,'domainincr');

% fit a one sided IRF from u to y
uy = nldat([double(u) double(y)],'domainincr',Ts);
h1 = irf(uy,'NLags',32);
figure(1)
plot(h1);

yest = nlsim(h1,u);
vaf(y,yest)

% Press any key to continue
pause




% fit a one sided IRF from y to u

yu = nldat([double(y) double(u)],'domainincr',Ts);
hyu = irf(yu,'NLags',32);
figure(2)
plot(hyu);


uest = nlsim(hyu,u);
vaf(u,uest)



% Press any key to continue
pause



% fit a two-sided IRF between u and y
h2 = irf(uy,'NLags',32,'Nsides',2);
y2 = nlsim(h2,u);
vaf(y,y2)
figure(3)
plot(h2);


% Press any key to continue
pause


Hest = fresp(uy);
% still need to fix simulation of fresp models.
figure(4)
plot(Hest);



