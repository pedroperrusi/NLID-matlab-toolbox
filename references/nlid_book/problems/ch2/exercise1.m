% computer exercise 1 chapter 2

clear
close all

echo on
% use randv to create a random variable object containing a zero-mean
% Gaussian RV with mean zero and standard deviation 0.5

rv1 = randv('SD',0.5);

% the next sentence in the problem doesn't make any sense, as this seems to
% have created a realization of the random variable, with 1000 points.
% However, we could put the output of randv into a nldat object, nonetheless.

emg = nldat(rv1,'ChanNames',{'EMG (mV)'},'ChanUnits','mV',...
    'comment','Unrectified EMG');

% to see our handiwork, use get and plot

get(emg);
figure(1)
plot(emg);

% press any key to continue
pause;

% Use PDF to construct a histogram for this signal -- use 40 bins
%  The default settings chosen by PDF seem to be a little choppy.

density1 = pdf(emg,'NBins',40,'type','density');
figure(2)
plot(density1);

% Construct the theoretical PDF of the random variable.
%
density2 = pdf(rv1);
figure(3)
plot(density2);


% To find the number of points greater than 1,
sum(double(emg)>1)
% Similarly, to find the number of points less than -1
sum(double(emg)<-1)

