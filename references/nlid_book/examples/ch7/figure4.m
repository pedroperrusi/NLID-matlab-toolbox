function figure4
% Generates figure showing first and second order Volterra kernels estimated
% from white noise dataset from the fly retina 
% model used as a running example in Chapters 7 and 8 of 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%

% generate data using white noise input
disp('generating data');
[uw,yw,zw] = GenerateData(8000,13,1);
IdData = cat(2,uw,zw);

% identify a model using FOA
disp('Identifying Model using FOA');
vs = vseries;
set(vs,'method','foa','nlags',50);
vs = nlident(vs,IdData);

% estimate the covariance matrix
disp('Estimating Covariance matrix');
vscov = nlmcov(vs,IdData);

% use the covariance matrix to estimate confidence bounds on the 
% estimated kernels

clf
plot(vscov);



