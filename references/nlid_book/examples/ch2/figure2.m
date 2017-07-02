function figure2(figno)

% file to generate figures showing several signals and their
% auto-correlations. 
%
%  This shows how figure 2-2 in 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003
%
%  can be generated using the operators in the NLID toolbox.  Note that all
%  of the fiddly code used to make the plots pretty has been placed at the
%  end.
%
%  To see the effect of the formatting, 
% >> figure2(2)

figure(1);
clf;

if nargin < 1
  figno = 1;
end


randn('state',0);

DataLen = 5;
fs = 200;
Ts = 1/fs;
N = DataLen*fs;

rv1 = randv('sd',3,'domainincr',Ts,'Domainmax',DataLen);
u = nldat(rv1);

taumax = 1;
hlen = taumax*fs+1;

phi_uu = cor;
set(phi_uu,'type','coeff','bias','unbiased','NLags',hlen,'Nsides',2);
phi_uu = nlident(phi_uu,u);


subplot(421)
plot(u)
subplot(422)
plot(phi_uu);


[b,a] = butter(2,0.1);
x = u;
set(x,'data', filter(b,a,double(u)));

phi_xx = nlident(phi_uu,x);


subplot(423)
plot(x);

subplot(424)
plot(phi_xx);


s1 = signalv('omega',2,'domainincr',Ts,'DomainMax',DataLen);
s = nldat(s1);

phi_ss = nlident(phi_uu,s);


subplot(425)
plot(s)

subplot(426)
plot(phi_ss);


z = u + s;
phi_zz = nlident(phi_ss,z);


subplot(427)
plot(z)

subplot(428)
plot(phi_zz);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               FROM HERE ON, IT'S FORMATTING                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if figno > 1
  % cycle through the plots to set axis labels, ticks etc.
  subplot(421)
  set(gca,'xlim',[0 5],'xtick',[0:1:5],'xticklabel',[],...
      'ylim',[-10 10],'ytick',[-10:10:10],...
      'fontsize',12);
  title('Time Domain Signals'); 
  xlabel('');ylabel('');
  hold on
  plot([0 5],[0 0],'k:');
  hold off
  
  
  subplot(422)
  set(gca,'xlim',[-1 1],'xtick',[-1:0.5:1],'xticklabel',[],...
      'ylim',[-0.2 1.2],'ytick',[0 1],...
      'fontsize',12);
  title('Auto-Correlation Coefficient Functions');
  xlabel('');ylabel('');
  hold on
  plot([-1 1],[0 0],'k:');
  plot([0 0],[-1.2 1.2],'k:');
  hold off

  
  
  subplot(423)
  set(gca,'xlim',[0 5],'xtick',[0:1:5],'xticklabel',[],...
      'ylim',[-4 4],'ytick',[-4:4:4],...
      'fontsize',12);
  title(''); xlabel('');ylabel('');
  hold on
  plot([0 5],[0 0],'k:');
  hold off

  
  subplot(424)
  set(gca,'xlim',[-1 1],'xtick',[-1:0.5:1],'xticklabel',[],...
      'ylim',[-0.25 1.2],'ytick',[0 1],...
      'fontsize',12);
  title(''); xlabel('');ylabel('');
  hold on
  plot([-1 1],[0 0],'k:');
  plot([0 0],[-1.2 1.2],'k:');
  hold off

  
  subplot(425)
  set(gca,'xlim',[0 5],'xtick',[0:1:5],'xticklabel',[],...
      'ylim',[-1.2 1.2],'ytick',[-1:1:1],...
      'fontsize',12);
  title(''); xlabel('');ylabel('');
  hold on
  plot([0 5],[0 0],'k:');
  hold off

  
  subplot(426)
  set(gca,'xlim',[-1 1],'xtick',[-1:0.5:1],'xticklabel',[],...
      'ylim',[-1.2 1.2],'ytick',[-1:1:1],...
      'fontsize',12);
  title(''); xlabel('');ylabel('');
  hold on
  plot([-1 1],[0 0],'k:');
  plot([0 0],[-1.2 1.2],'k:');
  hold off

  
  subplot(427)
  set(gca,'xlim',[0 5],'xtick',[0:1:5],'xticklabel',[],...
      'ylim',[-10 10],'ytick',[-10:10:10],...
      'fontsize',12);
  title(''); xlabel('Time (s)');ylabel('');
  hold on
  plot([0 5],[0 0],'k:');
  hold off

  
  subplot(428)
  set(gca,'xlim',[-1 1],'xtick',[-1:0.5:1],'xticklabel',[],...
      'ylim',[-1.2 1.2],'ytick',[-1:1:1],...
      'fontsize',12);
  title(''); xlabel('Lag (s)');ylabel('');
  hold on
  plot([-1 1],[0 0],'k:');
  plot([0 0],[-1.2 1.2],'k:');
  hold off

  
  
  
end



