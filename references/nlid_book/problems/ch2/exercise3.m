% computer exercise 3 chapter 2

echo on

fs = 200;
Ts = 1/fs;
N = 10000;


Tstop = (N-1)*Ts;
rsig = nldat(randv('domainincr',Ts,'domainmax',Tstop));

tau = 1;
phi_rr = cor(rsig,'NLags',tau/Ts,'type','correl');
set(phi_rr,'channames',{'correlation'},...
    'comment','Auto-Correlation of rsig',...
    'domainname','Lag (s)');


plot(phi_rr);


% press any key to continue
pause;

%% this isn't elegant, but I can't figure out how else to do this.
%% Pull the data out of the correlation object, and work directly with it.

phi_data = double(phi_rr);
[peak_val,peak_pos] = max(abs(phi_data));

disp(['peak amplitude: ' num2str(peak_val)]);

not_peak = phi_data(peak_pos+1:end);

disp(['Std. Dev. of rest: ', num2str(std(not_peak))]);



% press any key to continue
pause;

%% filtering with an IIR filter is still a problem.  Either, one can
%% extract the data from the nldat object, and then create another nldat
%% object from the output of filter

f_cutoff = 10;
f_normalized = f_cutoff/(0.5*fs)
[b,a] = butter(2,f_normalized);
y = filter(b,a,double(rsig));
fsig1 = rsig; 
set(fsig1,'data',y);

%% alternately, we could change the IIR filter into a FIR filter, and put it
%% in an IRF object.

hlen = 0.2/Ts;
imp = [1;zeros(hlen,1)];
irf1 = irf;
set(irf1,'data',filter(b,a,imp),'domainincr',Ts);
fsig2 = nlsim(irf1,rsig);

fsig = fsig1;

plot(fsig);


% press any key to continue
pause;

phi_ff = cor(fsig,'NLags',tau/Ts,'type','correl');
set(phi_ff,'channames',{'correlation'},...
    'comment','Auto-Correlation of filtered noise',...
    'domainname','Lag (s)');


plot(phi_ff);
drawnow;

%% again, to manimpulate the correlation function, we will have to resort to
%% extracting it into a double.


phi_data = double(phi_ff);
[peak_val,peak_pos] = max(abs(phi_data));

disp(['peak amplitude: ' num2str(peak_val)]);

%% The central peak seems to be gone by about 0.1 seconds. So call any lages
%% greater than 0.1 seconds "distant"

start_distant_lags = peak_pos + 0.1/Ts;
distant_lags = phi_data(start_distant_lags:end);

%% note, the question needs the word ratio in here somewhere.  Fix this in
%% the page proofs.

noise_level = std(distant_lags);
disp(['Correlation peak SNR: ',num2str(peak_val/noise_level)]);

positive_lags = phi_data(peak_pos:end);
peak_end = min(find(abs(positive_lags)<noise_level))*Ts;
disp(['The peak ends at T =', num2str(peak_end), ' seconds']);




echo off
