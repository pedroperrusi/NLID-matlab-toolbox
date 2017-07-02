function figure4(figno)

% file to generate figures showing how the cross-correlation can be 
% used to examine the relationship between two signals.
%
%  This shows how figure 2-4 in 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003
%
%  can be generated using the operators in the NLID toolbox.  Note that all
%  of the fiddly code used to make the plots pretty has been placed at the
%  end.
%
%  To see the effect of the formatting, 
% >> figure4(2)




if nargin < 1
   figno = 1;
 end

figure(1);
clf;


randn('state',0);

DataLen = 5;
fs = 200;
Ts = 1/fs;
N = DataLen*fs;

taumax = 0.2;
hlen = taumax*fs+1;

%% First Row

u = nldat(randv('domainincr',Ts,'DomainMax',DataLen));
y = nldat(randv('domainincr',Ts,'DomainMax',DataLen));
uy = cat(2,u,y);

phi = nlident(cor,uy,'nsides',2,'bias','unbiased',...
    'type','coeff','nlags',hlen);

subplot(331)
plot(u)

subplot(332)
plot(y)

subplot(333)
plot(phi)



%% Second Row

% create a delayed version of u by filtering it with a 
% 
delay = 0.1*fs;   % 0.1 second delay
hdel = zeros(delay,1);
hdel(delay) = 1/Ts;
h = irf;
set(h,'domainincr',Ts,'data',hdel);
udel = nlsim(h,u);

y2 = 0.5*udel + y;
uy2 = cat(2,u,y2);
phi = nlident(phi,uy2);

subplot(334)
plot(u)

subplot(335)
plot(y2)

subplot(336)
plot(phi)

% Third Row, u is filtered by a delayed ankle compliance model


H = AnkleCompliance(fs);
y3 =  5*nlsim(H,u) + 0.25*y;
uy3 = cat(2,u,y3);
phi = nlident(phi,uy3);


subplot(337)
plot(u)

subplot(338)
plot(y3)

subplot(339)
plot(phi)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               FROM HERE ON, IT'S FORMATTING                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if figno > 1

  subplot(331)
  set(gca,'fontsize',12,...
      'xlim',[0 5],'xtick',[0 5],'xticklabel',[],...
      'ylim',[-3.5 3.5],'ytick',[-3:3:3]);
  title('First Input, u(t)'); xlabel(''); ylabel('');


  subplot(332)
  set(gca,'fontsize',12,...
      'xlim',[0 5],'xtick',[0 5],'xticklabel',[],...
      'ylim',[-3.5 3.5],'ytick',[-3:3:3]);
  title('Second Input, y(t)'); xlabel(''); ylabel('');

  subplot(333)
  set(gca,'fontsize',12, ...
      'xlim',[-0.2 0.2],'xtick',[-0.2:0.2:0.2],'xticklabel',[],...
      'ylim',[-0.5 1]);
  hold on
  plot([0 0],[-0.5 1],':');
  hold off
  title('Corr. Coeff.: \phi_{uy}(\tau)'); xlabel(''); ylabel('');


  subplot(334)
  set(gca,'fontsize',12,...
      'xlim',[0 5],'xtick',[0 5],'xticklabel',[],...
      'ylim',[-3.5 3.5],'ytick',[-3:3:3]);
  title(''); xlabel(''); ylabel('');


  subplot(335)
  set(gca,'fontsize',12,...
      'xlim',[0 5],'xtick',[0 5],'xticklabel',[],...
      'ylim',[-3.5 3.5],'ytick',[-3:3:3]);
  title(''); xlabel(''); ylabel('');

  subplot(336)
  set(gca,'fontsize',12, ...
      'xlim',[-0.2 0.2],'xtick',[-0.2:0.2:0.2],'xticklabel',[],...
      'ylim',[-0.5 1]);
  hold on
  plot([0 0],[-0.5 1],':');
  hold off
  title(''); xlabel(''); ylabel('');


  subplot(337)
  set(gca,'fontsize',12,...
      'xlim',[0 5],'xtick',[0 5],...
      'ylim',[-3.5 3.5],'ytick',[-3:3:3]);
  title(''); xlabel('Time (s)'); ylabel('');


  subplot(338)
  set(gca,'fontsize',12,...
      'xlim',[0 5],'xtick',[0 5],...
      'ylim',[-3.5 3.5],'ytick',[-3:3:3]);
  title(''); xlabel('Time (s)'); ylabel('');

  subplot(339)
  set(gca,'fontsize',12, ...
      'xlim',[-0.2 0.2],'xtick',[-0.2:0.2:0.2],...
      'ylim',[-0.5 1]);
  hold on
  plot([0 0],[-0.5 1],':');
  hold off
  title(''); xlabel('Lag (s)'); ylabel('');

end







