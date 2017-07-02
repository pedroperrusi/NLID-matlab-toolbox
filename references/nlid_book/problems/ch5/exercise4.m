% ch5/exercise4.m Sample solution for chapter 5 computer exercise 4


clear
close all


mod1;
echo on


% set up record lenght and SNR for identification
N = 1000;
dB = 10;

halfN = floor(N/2);

Ts = get(model1,'domainincr');


% create input, noise and noise-free output for identification data
u = nldat(randn(N,1),'domainincr',Ts); 
v = nldat(randn(N,1),'domainincr',Ts); 
y = nlsim(model1,u);


% create cross-validation data
ucv = nldat(randn(N,1),'domainincr',Ts);
ycv = nlsim(model1,ucv);


% place the input and output in a single nldat object.
uy = cat(2,u,y);


h1 = irf(uy,'NLags',32);
set(h1,'comment','identified from noise-free records');

figure(1)
plot(h1)
pos1 = get(gcf,'position');


yest = nlsim(h1,u);
ycvest = nlsim(h1,ucv);

VAFs = [nan double(vaf(y,yest)) double(vaf(ycv,ycvest))];


% Press any key to continue
pause


% now add some noise to the output and try again
z = y + v;
SNR = 20*log10(double(std(y))/double(std(v)))


gain = double(std(y))/(double(std(v))*10^(dB/20));

z = y + gain*v;

SNR = 20*log10(double(std(y))/double(std(gain*v)))



%uz = u;
%set(uz,'data',[double(u) double(z)]);
uz = cat(2,u,z);



h = irf(uz,'NLags',32);
set(h,'comment','Identified from noisy records');

figure(2)
plot(h)

pos2 = pos1;
pos2(2) = pos1(2)-100;
set(gcf,'position',pos2);


yest = nlsim(h,u);
ycvest = nlsim(h,ucv);

VAFs = [VAFs; double(vaf(z,yest)) double(vaf(y,yest)) double(vaf(ycv,ycvest))];

% Press any key to continue
pause


% Now use only the first half of the data records

half_uz = uz(1:halfN);
hhalf = irf(half_uz,'NLags',32);
set(hhalf,'comment','Identified from short, noisy records');

figure(3)
plot(hhalf)
pos3 = pos2;
pos3(2) = pos2(2)-100;
set(gcf,'position',pos3);



yest = nlsim(hhalf,u(1:halfN));
ycvest = nlsim(hhalf,ucv);



VAFs = [VAFs; double(vaf(z(1:halfN),yest)),...
      double(vaf(y(1:halfN),yest)), double(vaf(ycv,ycvest))];


% Press any key to continue
pause

% Now, low-pass filter the input, and see what happens.

[b,a] = butter(2,0.6);
uf = nldat(filter(b,a,double(u)));
set(uf,'domainincr',Ts);
yf = nlsim(model1,uf);

gain = double(std(yf))/(double(std(v))*10^(dB/20));

zf = yf + gain*v;
uzf = nldat([double(uf) double(zf)]);
set(uzf,'domainincr',Ts);
hf = irf(uzf,'Nlags',32);
set(hf,'comment','low pass filtered data');

figure(4)
plot(hf);
pos4 = pos3;
pos4(2) = pos3(2)-100;
set(gcf,'position',pos4);



yest = nlsim(hf,uf);


%% cross validate using a white input.
%% To cross validate against an input with the same spectral content as the
%% identification input, uncomment the next 2 lines. 
%ucv = nldat(filter(b,a,double(ucv)),'domainincr',Ts);
%ycv = nlsim(model1,ucv);

ycvest = nlsim(hf,ucv);


VAFs = [VAFs; double(vaf(zf,yest)),...
      double(vaf(yf,yest)), double(vaf(ycv,ycvest))];

echo off


disp('Prediction Accuracy of Identified Models');
disp('Ident dataset  | versus z(t) | versus y(t) | validation');

fprintf('Noise Free     :  %10.2f %10.2f %12.2f\n',VAFs(1,:))
fprintf('Noisy Data     :  %10.2f %10.2f %12.2f\n',VAFs(2,:))
fprintf('Short Records  :  %10.2f %10.2f %12.2f\n',VAFs(3,:))
fprintf('Low Pass Filt. :  %10.2f %10.2f %12.2f\n',VAFs(4,:))



