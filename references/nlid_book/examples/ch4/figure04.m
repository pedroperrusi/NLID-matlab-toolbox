function figure04(figno)
% function to draw first and second-order Volterra kernels of peripheral
% auditory processing example system.
% 
% Calling figure04, or figure04(1) uses the default plotting operations
% implemented in the NLID toolbox to plot the Volterra series.  
%
% Calling figure04(2) reproduces most of the formatting used to produce
% figure 4-4 in
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003
%

fiber = PeripheralAuditoryModel(100);
hlen = 16;

figure(1)
clf

if nargin<1
  figno=1;
end

sigma_u1 = 1;
sigma_u2 = 0.1;

ws1 = nlident(wseries,fiber,'variance',sigma_u1^2);

ws2 = nlident(wseries,fiber,'variance',sigma_u2^2);

if figno == 1
  % use overloaded plot operators to plot Wiener series.
  % put each model in a separate plot window.
  figure(1)
  clf
  plot(ws1)
  figure(2)
  clf
  plot(ws2)
  if nargin < 1
    disp('Generated using default NLID Toolbox plot function');
    disp('To see formatting similar to figure 4-2, type');
    disp('>> figure04(2)');
  end

else
  
  % plot each kernel individually
  % extract the kernels from the wseries objects.
  kernels = get(ws1,'elements');
  wk11 = kernels{2};
  wk21 = kernels{3};

  kernels = get(ws2,'elements');
  wk12 = kernels{2};
  wk22 = kernels{3};


  subplot(221)
  % plot the first-order Wiener kernel using the overloaded plot function
  hh = plot(wk11);
  
  % use MATLAB handle graphics to format the plot
  set(hh,'color','k');
  tauticks = ['0';' ';' ';'1'];
  set(gca,'fontsize',12,'xlim',[0 1.5]*1e-3,'xtick',[0:0.5:1.5]*1e-3,...
      'xticklabel',tauticks);
  ylabel('1^{st} Kernel');
  xlabel('Lag (ms)');
  title('\sigma_u = 1');


  subplot(222)
  % plot the first-order Wiener kernel using the overloaded plot function
  hh = plot(wk12);
  
  % use MATLAB handle graphics to format the plot
  set(hh,'color','k');  
  set(gca,'fontsize',12,'xlim',[0 1.5]*1e-3,'xtick',[0:0.5:1.5]*1e-3,...
      'xticklabel',tauticks);
  xlabel('Lag (ms)');
  ylabel('1^{st} Kernel');
  title('\sigma_u = 0.1');


  subplot(223)
  % plot the second-order Wiener kernel using the overloaded plot function
  % plot only lags 0-10 on both axes, to concentrate on the interesting part
  % of the kernel
  plot(wk21(1:11,1:11));
  
  % use MATLAB handle graphics to format the plot
  tauticks = ['0';' ';'1'];
  set(gca,'fontsize',12,'zlim',[-2 4]*1e+6,'xlim',[0 1e-3],...
      'xtick',[0:0.5:1]*1e-3,'xticklabel',tauticks,...
      'ylim',[0 1e-3],'ytick',[0:0.5:1]*1e-3,'yticklabel',tauticks);
  colormap bone
  shading faceted
  caxis([-12 8]*1e7);
  view([60 25]);
  grid on
  zlabel('2^{nd} Kernel');
  xlabel('Lag (ms)');
  ylabel('Lag (ms)');



  subplot(224)
  % plot the second-order Wiener kernel using the overloaded plot function
  % plot only lags 0-10 on both axes, to concentrate on the interesting part
  % of the kernel
  plot(wk22(1:11,1:11));

  % use MATLAB handle graphics to format the plot
  set(gca,'fontsize',12,'zlim',[-2 4]*1e+6,'xlim',[0 1e-3],...
      'xtick',[0:0.5:1]*1e-3,'xticklabel',tauticks,...
      'ylim',[0 1e-3],'ytick',[0:0.5:1]*1e-3,'yticklabel',tauticks);
  colormap bone
  shading faceted
  caxis([-12 8]*1e7);
  view([60 25]);
  grid on
  xlabel('Lag (ms)');
  ylabel('Lag (ms)');
  zlabel('2^{nd} Kernel');


end





