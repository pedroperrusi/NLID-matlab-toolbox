% exercise 5 chapter 2

echo on

%% problem calls for 10000 points, but that isn't enough to make the
%% higher-order results work 
x = randv('domainincr',1,'domainmax',99999);
gaussnoise = nldat(x);

phi1 = cor(gaussnoise,'type','correl');
set(phi1,'comment','first-order auto-correlation of Gaussian noise');
plot(phi1)

% type any key to continue
pause


phi2 = cor(gaussnoise,'type','correl','order',2);
set(phi2,'comment','second-order auto-correlation of Gaussian noise');
plot(phi2);


% type any key to continue
pause


xx = double(gaussnoise);
gn2 = gaussnoise;
xx2 = xx.^2;
xx2 = (xx2-mean(xx2))/std(xx2);
set(gn2,'data',xx2);


phi1a = cor(gn2,'type','correl','order',1);
set(phi1a,'comment','first-order auto-correlation of squared Gaussian noise');
plot(phi1a);


% type any key to continue
pause


phi2a = cor(gn2,'type','correl','order',2);
set(phi2a,'comment','second-order auto-correlation of squared Gaussian noise');
plot(phi2a);


% type any key to continue
pause

xx3 = xx.^3;
gn3 = gaussnoise;
xx3 = (xx3 - mean(xx3))/std(xx3);
set(gn3,'data',xx3);


phi1b = cor(gn3,'type','correl','order',1);
set(phi1b,'comment','first-order auto-correlation of cubed Gaussian noise');
plot(phi1b);


% type any key to continue
pause

%% it appears that plot does not use the comment as a title for surface like
%% objects... 
phi2b = cor(gn3,'type','correl','order',2);
set(phi2b,'comment','second-order auto-correlation of cubed Gaussian noise');
plot(phi2b);




echo off
