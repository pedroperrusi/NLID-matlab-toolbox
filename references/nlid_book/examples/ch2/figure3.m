function figure3(figno)

% file to generate figures showing the relationship between the
% auto-correlations, auto-covariance and auto-correlation coefficient
% functions.  
%
%  This shows how figure 2-3 in 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003
%
%  can be generated using the operators in the NLID toolbox.  Note that all
%  of the fiddly code used to make the plots pretty has been placed at the
%  end.
%
%  To see the effect of the formatting, 
% >> figure3(2)


if nargin < 1
  figno = 1
end




figure(1);
clf;
randn('state',0);

DataLen = 1;
fs = 1000;
Ts = 1/fs;
N = DataLen*fs;


rv1 = randv('sd',1,'domainincr',Ts,'Domainmax',DataLen);
u = nldat(rv1);
uo = u + 2;
u10 = u*10;
u100 = u*100;


taumax = 0.01;
hlen = taumax*fs+1;
tau = [-hlen+1:hlen-1]*Ts;
phi = cor(cor,'nsides',2,'bias','unbiased','nlags',hlen);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  First Row of panels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(441)
% time signal
plot(u)

subplot(442)
% auto-correlation
phi = nlident(phi,u,'type','correl');
plot(phi);

subplot(443)
% auto-covariance
phi = nlident(phi,u,'type','covar');
plot(phi);

subplot(444)
% auto-correlation
phi = nlident(phi,u,'type','coeff');
plot(phi);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%  Second Row of Panels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

subplot(445)
% time signal
plot(uo)

subplot(446)
% auto-correlation
phi = nlident(phi,uo,'type','correl');
plot(phi);

subplot(447)
% auto-covariance
phi = nlident(phi,uo,'type','covar');
plot(phi);

subplot(448)
% auto-correlation
phi = nlident(phi,uo,'type','coeff');
plot(phi);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%  Third Row of Panels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

subplot(449)
% time signal
plot(u10)

subplot(4,4,10)
% auto-correlation
phi = nlident(phi,u10,'type','correl');
plot(phi);

subplot(4,4,11)
% auto-covariance
phi = nlident(phi,u10,'type','covar');
plot(phi);

subplot(4,4,12)
% auto-correlation
phi = nlident(phi,u10,'type','coeff');
plot(phi);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%  Fourth Row of Panels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

subplot(4,4,13)
% time signal
plot(u100)

subplot(4,4,14)
% auto-correlation
phi = nlident(phi,u100,'type','correl');
plot(phi);

subplot(4,4,15)
% auto-covariance
phi = nlident(phi,u100,'type','covar');
plot(phi);

subplot(4,4,16)
% auto-correlation
phi = nlident(phi,u100,'type','coeff');
plot(phi);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               FROM HERE ON, IT'S FORMATTING                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if figno > 1

  
  tauticks = ['-10';'   ';' 10'];
  timeticks = ['0';' ';'1'];
  ten_k = ['  0';'10K'];
  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%  First Row of Panels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
  
  subplot(441);
  set(gca,'fontsize',12,'ylim',[-5 5],'ytick',[-4:4:4],...
      'xlim',[0 1],'xtick',[0:0.5:1],'xticklabel',[]);
  title('Signal'); xlabel('');ylabel('');
  
  subplot(442);
  set(gca,'fontsize',12,'xlim',[-0.01 0.01],...
      'xtick',[-0.01:0.01:0.01],'xticklabel',[],...
      'ylim',[-0.1 1.1],'ytick',[0 1]);
  hold on
  plot([-0.01 0.01],[0 0],'k:');
  plot([0 0],[-0.2 1.2],'k:');
  hold off
  title('Correlation'); xlabel('');ylabel('');
  
  subplot(443);
  set(gca,'fontsize',12,'xlim',[-0.01 0.01],...
      'xtick',[-0.01:0.01:0.01],'xticklabel',[],...
      'ylim',[-0.1 1.1],'ytick',[0 1]);
  hold on
  plot([-0.01 0.01],[0 0],':');
  plot([0 0],[-0.2 1.2],':');
  hold off
  title('Covariance'); xlabel('');ylabel('');

    
  subplot(444);
  set(gca,'fontsize',12,'xlim',[-0.01 0.01],...
      'xtick',[-0.01:0.01:0.01],'xticklabel',[],...
      'ylim',[-0.1 1.1],'ytick',[0 1]);
  hold on
  plot([-0.01 0.01],[0 0],':');
  plot([0 0],[-0.2 1.2],':');
  hold off
  title('Cooefficient');xlabel('');ylabel('');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%  Second Row of Panels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  


  subplot(445);
  set(gca,'fontsize',12,'ylim',[-5 5],'ytick',[-4:4:4],...
      'xlim',[0 1],'xtick',[0:0.5:1],'xticklabel',[]);
  title(''); xlabel('');ylabel('');
  
  subplot(446);
  set(gca,'fontsize',12,'xlim',[-0.01 0.01],...
      'xtick',[-0.01:0.01:0.01],'xticklabel',[],...
      'ylim',[0 5],'ytick',[0 5]);
  hold on
  plot([-0.01 0.01],[0 0],'k:');
  plot([0 0],[0 5],'k:');
  hold off
  title(''); xlabel('');ylabel('');
  
  subplot(447);
  set(gca,'fontsize',12,'xlim',[-0.01 0.01],...
      'xtick',[-0.01:0.01:0.01],'xticklabel',[],...
      'ylim',[-0.1 1.1],'ytick',[0 1]);
  hold on
  plot([-0.01 0.01],[0 0],':');
  plot([0 0],[-0.2 1.2],':');
  hold off
  title(''); xlabel('');ylabel('');

    
  subplot(448);
  set(gca,'fontsize',12,'xlim',[-0.01 0.01],...
      'xtick',[-0.01:0.01:0.01],'xticklabel',[],...
      'ylim',[-0.1 1.1],'ytick',[0 1]);
  hold on
  plot([-0.01 0.01],[0 0],':');
  plot([0 0],[-0.2 1.2],':');
  hold off
  title('');xlabel('');ylabel('');
  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%  Third Row of Panels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  


  subplot(4,4,9);
  set(gca,'fontsize',12,'ylim',[-50 50],'ytick',[-40:40:40],...
      'xlim',[0 1],'xtick',[0:0.5:1],'xticklabel',[]);
  title(''); xlabel('');ylabel('');
  
  subplot(4,4,10);
  set(gca,'fontsize',12,'xlim',[-0.01 0.01],...
      'xtick',[-0.01:0.01:0.01],'xticklabel',[],...
      'ylim',[-10 110],'ytick',[0 100]);
  hold on
  plot([-0.01 0.01],[0 0],'k:');
  plot([0 0],[-10 110],'k:');
  hold off
  title(''); xlabel('');ylabel('');
  
  subplot(4,4,11);
  set(gca,'fontsize',12,'xlim',[-0.01 0.01],...
      'xtick',[-0.01:0.01:0.01],'xticklabel',[],...
      'ylim',[-10 110],'ytick',[0 100]);
  hold on
  plot([-0.01 0.01],[0 0],':');
  plot([0 0],[-10 110],':');
  hold off
  title(''); xlabel('');ylabel('');

    
  subplot(4,4,12);
  set(gca,'fontsize',12,'xlim',[-0.01 0.01],...
      'xtick',[-0.01:0.01:0.01],'xticklabel',[],...
      'ylim',[-0.1 1.1],'ytick',[0 1]);
  hold on
  plot([-0.01 0.01],[0 0],':');
  plot([0 0],[-0.2 1.2],':');
  hold off
  title('');xlabel('');ylabel('');
  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%  Fourth Row of Panels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  


  subplot(4,4,13);
  set(gca,'fontsize',12,'ylim',[-500 500],'ytick',[-400:400:400],...
      'xlim',[0 1],'xtick',[0:0.5:1],'xticklabel',timeticks);
  title(''); xlabel('Time (s)');ylabel('');
  
  subplot(4,4,14);
  set(gca,'fontsize',12,'xlim',[-0.01 0.01],...
      'xtick',[-0.01:0.01:0.01],'xticklabel',tauticks,...
      'ylim',[-1000 11000],'ytick',[0 10000],'yticklabel',ten_k);
  hold on
  plot([-0.01 0.01],[0 0],'k:');
  plot([0 0],[-1000 11000],'k:');
  hold off
  title(''); xlabel('Lag (ms)');ylabel('');
  
  subplot(4,4,15);
  set(gca,'fontsize',12,'xlim',[-0.01 0.01],...
      'xtick',[-0.01:0.01:0.01],'xticklabel',tauticks,...
      'ylim',[-1000 11000],'ytick',[0 10000],'yticklabel',ten_k);
  hold on
  plot([-0.01 0.01],[0 0],':');
  plot([0 0],[-1000 11000],':');
  hold off
  title(''); xlabel('Lag (ms)');ylabel('');

    
  subplot(4,4,16);
  set(gca,'fontsize',12,'xlim',[-0.01 0.01],...
      'xtick',[-0.01:0.01:0.01],'xticklabel',tauticks,...
      'ylim',[-0.1 1.1],'ytick',[0 1]);
  hold on
  plot([-0.01 0.01],[0 0],':');
  plot([0 0],[-0.2 1.2],':');
  hold off
  title('');xlabel('Lag (ms)');ylabel('');
  
  

end







