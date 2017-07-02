function figs8and9
% Generates two figures.  The first shows the IRFs and Nonlinearities of a 5
% path separable Volterra network identified from the white dataset of the
% fly retina model used as a running example in Chapters 7 and 8 of 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
% 
% The second figure shows the zero, first and second-order Volterra kernels
% of the SVN model.

% generate data using white noise input
disp('generating data');
[uw,yw,zw] = GenerateData(8000,13,1);
IdData = cat(2,uw,zw);


svn = pcascade;
set(svn,'method','lm','nlags',50,'npaths',5,'ordermax',4,'MaxIts',50);
%set(svn,'method','lm','nlags',16,'npaths',3,'ordermax',2);

disp('Identifying Separable Volterra Network using Levenberg Marquardt');
disp('This may take a while');
svn = nlident(svn,IdData);

figure(1)
clf
plot(svn);
vaf(svn,IdData)

figure(2)
clf
vs = vseries(svn);
plot(vs);


return






