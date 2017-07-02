% sample solution for chapter 7, computer exercise 1, part 1


clear
close all
echo on


% first, do a single trial, without noise

% generate some noise-free data with a WGN input
N = 10000; % length of data records
uy = ex1_data(N);

% estimate kernels using FOA

sys1 = vseries;
set(sys1,'method','foa','NLags',64,'OrderMax',2);
sys1 = nlident(sys1,uy);

figure(1)
plot(sys1);
vaf(sys1,uy)

sys2 = sys1;
set(sys2,'method','laguerre','NumFilt',18);
sys2 = nlident(sys2,uy);


figure(2)
plot(sys2);
vaf(sys2,uy)

% press any key to continue
pause;

% construct a LNL model that approximates the 0-2 order kernels
sys3 = ex1_lnl(sys1,6);
figure(3)
plot(sys3)
vaf(sys3,uy)

sys4 = vseries(sys3);
kernels = get(sys4,'elements');
k1 = kernels{2};
k1d = double(k1);
set(k1,'data',k1d(1:64));
kernels{2} = k1;
k2 = kernels{3};
k2d = double(k2);
set(k2,'data',k2d(1:64,1:64));
kernels{3} = k2;
set(sys4,'elements',kernels);





figure(4)
plot(sys4)


% press any key to continue
pause;


echo off

