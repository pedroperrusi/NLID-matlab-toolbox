function figure02(figno)
% function to draw first and second-order Volterra kernels of peripheral
% auditory processing example system.
% 
% Calling figure02, or figure02(1) uses the default plotting operations
% implemented in the NLID toolbox to plot the Volterra series.  
%
% Calling figure02(2) reproduces most of the formatting used to produce
% figure 4-2 in
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003
%

fiber = PeripheralAuditoryModel(100);

figure(1)
clf

if nargin<1
  figno=1;
end




% Compute the Volterra kernels
VSfiber = vseries;
VSfiber = nlident(VSfiber,fiber,'ordermax',2);
if figno == 1
  plot(VSfiber);
  if nargin < 1
    disp('Generated using default NLID Toolbox plot function');
    disp('To see formatting similar to figure 4-2, type');
    disp('>> figure02(2)');
  end
else
  % extract kernels from the vseries object
  kernels = get(VSfiber,'elements');
  volterra1 = kernels{2};
  volterra2 = kernels{3};

  % select the number of lags to be displayed
  hlen1 = 16;
  hlen2 = 11;

  
  axes('position',[0.13 0.6811 0.775 0.2439]);
  
  % plot only lags 1 through hlen1 of the first-order kernel
  vk1h = plot(volterra1(1:hlen1));
  set(vk1h,'color','k');
  
  % use MATLAB handle graphics operations to format the plot.
  set(gca,'fontsize',12,'xlim',[0 0.0015],'xtick',[0:5:15]*0.0001,...
      'xticklabel',[' 0 ';'   ';'   ';'1.5']);
  xh = xlabel('Lag (ms)');
  ylabel('Amplitude');
  title('First-Order Kernel');
  pos = get(xh,'position');
  pos(2) = pos(2) + 200;
  set(xh,'position',pos);

  axes('position',[0.13 0.11 0.775 0.4439]);
  % plot only lags 1 through hlen2 of the second-order kernel
  plot(volterra2(1:hlen2,1:hlen2));
  
  % use MATLAB handle graphics operations to format the plot.
  colormap bone
  caxis([-12 8]*1e7);
  shading faceted
  view([60 25]);
  
  set(gca,'fontsize',12);
  set(gca,'xtick',[0:0.5:1]*1e-3,'ytick',[0:0.5:1]*1e-3);
  tauticks = ['0';' ';'1'];
  set(gca,'xticklabel',tauticks,'yticklabel',tauticks);
  set(gca,'zlim',[-1.5 5]*1e6);
  xh = xlabel('Lag (ms)');
  yh = ylabel('Lag (ms)');
  zlabel('Amplitude');
  title('Second-Order Kernel');

  pos = get(xh,'position');
  pos(3) = pos(3) + 2e6;
  set(xh,'position',pos);

  pos = get(yh,'position');
  pos(3) = pos(3) + 1e6;
  set(yh,'position',pos);

end





