function GaussianRV(figno)

%  file to generate figure or a Gaussian PDF with mean 3 and standard
% deviation 2

randn('state',0);

%nlid_figmod(1,'layout','landscape');

  
figure(1);
clf;


% use randv to create a random variable object containing a zero-mean
% Gaussian RV with mean zero and standard deviation 0.5

mu = 2;
sigma = 3; 
N = 1000;
Ts = 1/2000;

rv1 = randv('type','normal','mean',mu,'SD',sigma,'domainincr',Ts,...
    'domainmax',(N-1)*Ts);

% the next sentence in the problem doesn't make any sense, as this seems to
% have created a realization of the random variable, with 1000 points.
% However, we could put the output of randv into a nldat object, nonetheless.

emg = nldat(rv1);

% to see our handiwork, use get and plot

subplot(211);
plot(emg);

hold on
plot([0 0.5],(mu+sigma)*[1 1],'k:');
plot([0 0.5],(mu-sigma)*[1 1],'k:');
plot([0 0.5],(mu)*[1 1],'k--');
hold off

text(0.51,mu+sigma,'\mu + \sigma');
text(0.51,mu-sigma,'\mu - \sigma');
text(0.51,mu,'\mu');


% Construct the theoretical PDF of the random variable.
%

density2 = pdf(rv1,'NBins',100);
subplot(223)
plot(density2)

 hold on
set(gca,'xlim',[-10 12],'xtick',[-10:5:10],...
    'ylim',[0 0.2],'ytick',[0:0.1:0.2]);
plot(mu*[1 1],[0 0.2],'k:');
plot((mu+sigma)*[1 1],[0 0.2],'k:');
plot((mu-sigma)*[1 1],[0 0.2],'k:');

text(1.25, 0.17,'\mu','horizontalalignment','center',...
    'fontsize',12);

text(5.75, 0.12,'\mu+\sigma',...
    'horizontalalignment','left','fontsize',12);
text(-1.75, 0.12,'\mu-\sigma',...
    'horizontalalignment','right','fontsize',12)

hold off


% Use PDF to construct a histogram for this signal -- use 40 bins
%  The default settings chosen by PDF seem to be a little choppy.

density1 = pdf(emg,'NBins',51,'type','density');
subplot(224)
plot(density1);


hold on
set(gca,'xlim',[-10 12],'xtick',[-10:5:10],...
    'ylim',[0 0.2],'ytick',[0:0.1:0.2]);
plot(mu*[1 1],[0 0.2],'k:');
plot((mu+sigma)*[1 1],[0 0.2],'k:');
plot((mu-sigma)*[1 1],[0 0.2],'k:');

text(1.25, 0.17,'\mu','horizontalalignment','center',...
    'fontsize',12);

text(5.75, 0.12,'\mu+\sigma',...
    'horizontalalignment','left','fontsize',12);
text(-1.75, 0.12,'\mu-\sigma',...
    'horizontalalignment','right','fontsize',12)

hold off



%nlid_style

