function figs10to12
% Generates three figures.  The first shows the IRFs and Nonlinearities of a 5
% path separable Volterra network identified from the colored noise  dataset
% of the fly retina model used as a running example in Chapters 7 and 8 of 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
% 
% The second figure shows the zero, first and second-order Volterra kernels
% of the SVN model.  The third figure shows the noise free output,
% measurement noise and prediction errors in the validation segment.

% generate data using white noise input
disp('generating data');
[uc,yc,zc] = GenerateData(8000,13,0);
IdData = cat(2,uc,zc);


svn = pcascade;
set(svn,'method','lm','nlags',50,'npaths',5,'ordermax',4,'MaxIts',50);
%set(svn,'method','lm','nlags',16,'npaths',3,'ordermax',2);

disp('Identifying Separable Volterra Network using Levenberg Marquardt');
disp('This may take a while');
svn = nlident(svn,IdData);

% generate Figure 10
figure(1)
clf
plot(svn);
vaf(svn,IdData)

% generate Figure 11
figure(2)
clf
vs = vseries(svn);
plot(vs);


% generate Figure 12
figure(3)

[u,y,z] = GenerateData(8192,13,0);



yest = nlsim(svn,u);
noise = z-y;
err = y-yest;

subplot(311)
set(y,'comment','Noise Free Output','channames',{' '});
plot(y(8001:8192));

subplot(312)
set(noise,'comment','Measurement Noise','channames',{' '});
plot(noise(8001:8192));


subplot(313)
set(err,'comment','Prediction Errors','channames',{' '});
plot(err(8001:8192));









