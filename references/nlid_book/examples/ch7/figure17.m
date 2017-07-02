function figure17
% Generates figure showing linear elements of a PDM model  
% estimated from the coloured noise input dataset from the fly retina 
% model used as a running example in Chapters 7 and 8 of 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%

% generate data using coloured noise input
disp('generating data');
[uc,yc,zc] = GenerateData(8000,13,0);
IdData = cat(2,uc,zc);

% identify a versies model using LET
disp('estimating Wiener Bose model using LET/PDM');
vsm = vseries(IdData,'method','laguerre','nlags',50,'alpha',0.3,...
    'NumFilt',9,'delay',6);
% and down convert it into a WBOSE using PDMs.
wbm = wbose;
wbm = nlident(wbm,vsm,'method','pdm','nfilt',6);

% note that the maximum number of filters is specified as 6, but the 
% number of filters in the final model is 3.

disp('Extracting IRFs');
subsys = get(wbm,'elements');
filts = subsys{1};
h1 = filts{1};
h2 = filts{2};
h3 = filts{3};

irfs = [get(h1,'data'),get(h2,'data'),get(h3,'data')];
Ts = get(h1,'domainincr');
hlen = get(h1,'nlags');
tau = [0:hlen-1]'*Ts;
clf;
plot(tau,irfs);

title('Three Principal Dynamic Modes of Fly Retina Model');
xlabel('Lag (sec)');
ylabel('Amplitude');
legend('mode 1','mode 2','mode 3',4);

