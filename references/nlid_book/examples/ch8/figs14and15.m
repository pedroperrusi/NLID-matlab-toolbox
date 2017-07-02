function figs14and15
% Generates two figures.  The first shows the IRFs and Nonlinearities of a 
% parallel cascade model identified from the colored noise  dataset of the
% fly retina model used as a running example in Chapters 7 and 8 of 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
% 
% The second figure shows the evolution of the zero, first and second-order
% Volterra kernels as paths are added to the model.

% generate data using white noise input
disp('generating data');
[uc,yc,zc] = GenerateData(8000,13,0);
IdData = cat(2,uc,zc);


pc = pcascade;
set(pc,'method','eig','nlags',50,'npaths',5,'ordermax',8);

pc = nlident(pc,IdData);

% generate Figure 14
figure(1)
clf
plot(pc);
vaf(pc,IdData)

keyboard








