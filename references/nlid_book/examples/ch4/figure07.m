function figure06(figno)
%  Illustration of the Wiener cascdae test on the Volterra kernels of the
%  Wiener cascade in figure 4-6. see figure 4-7 in:
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%
% Calling figure07, or figure07(1) uses the default NLID toolbox plot
% routines. figure07(2) uses MATLAB handle graphics to dress things up a
% bit.


% if no figure is specified, choose minimal formatting
if nargin<1
  figno = 1;
end

figure(1);
clf;

% construct the LNL model for the running example.
fiber = PeripheralAuditoryModel(100);

% Get the zero and first-order Volterra kernels for the LNL model
VSfiber = vseries;
VSfiber = nlident(VSfiber,fiber,'ordermax',1);

% extract the first-order kernel
kernels = get(VSfiber,'elements');
h = kernels{2};
set(h,'comment','Linear Impulse Response');

% construct the nonlinearity

% Nonlinearity fit a polynomial to a half-wave rectifier over [-3 3]
u = [-3:0.01:3]';
y = half_wave(u);
z = nldat([u y]);
mt = polynom(z,'type','tcheb','order',8);
set(mt,'comment','Static Nonlinearity');


% create a Wiener cascade, to house the elements
LNfiber = lnbl;
set(LNfiber,'elements',{h, mt},'comment',...
    'Wiener Cascade Model of Peripheral Auditory Processing System');

% create a Volterra series model containing the kernels of the Wiener
% cascade. 
VSwiener = nlident(VSfiber,LNfiber,'ordermax',2);

% extract the first and second-order kernels
kernels = get(VSwiener,'elements');
h1 = kernels{2};
h2 = kernels{3};


% extract the first three slices of the second-order kernel object, and 
% store them in first-order kernel objects
slice1 = h1; slice2 = h1;slice3 = h1;
set(slice1,'data',double(h2(:,1)));
set(slice2,'data',double(h2(:,2)));
set(slice3,'data',double(h2(:,3)));


% normalize the slices, and offset them slightly, for display purposes
offset = 0.1;
s1s = slice1*(1/double(slice1(1)));
s2s = slice2*(1/double(slice2(1))) - offset;
s3s = slice3*(1/double(slice3(1))) - 2*offset;


% Now generate the figure.

if figno == 1

  subplot(221)
  plot(h1);

  subplot(222)
  plot(h2);

  subplot(223);
  s1h = plot(slice1);
  hold on
  s2h = plot(slice2);
  s3h = plot(slice3);
  hold off
  set(s2h,'color','m');
  set(s3h,'color',[0 0.5 0]);
  legend('\tau_1 = 0','\tau_1 = 0.1','\tau_1 = 0.2');
  title('Kernel Slices');
  
  subplot(224);
  s1sh = plot(s1s);
  hold on
  s2sh = plot(s2s);
  s3sh = plot(s3s);
  hold off
  set(s2sh,'color','m');
  set(s3sh,'color',[0 0.5 0]);
  title('Normalized Kernel Slices');

  if nargin < 1
    disp('Generated using default NLID Toolbox plot function');
    disp('To see formatting similar to figure 4-7, type');
    disp('>> figure07(2)');
  end

  

else

  % set up ticks and labels for lag axes in ms.
  tauticks = [0:5:15]*1e-4;
  taulabels = [' 0 ';'0.5';' 1 ';'1.5'];

 
  % plot only the 0-15ms of the first-order kernel.
  % output the handle, so that we can change the color, line-style, etc.
  subplot(221)
  h1h = plot(h1(1:16));  
  set(h1h,'color','k');
  set(gca,'fontsize',12,'ylim',[-220 420]);
  title('First-Order Kernel');
  ylabel('Amplitude');
  xlabel('Lag (ms)');
  set(gca,'xtick',[0:5:15]*1e-4,'xticklabel',taulabels);



  subplot(222)
  plot(h2(1:16,1:16));
  set(gca,'fontsize',12,'zlim',[-4 6]*1e5,...
      'xlim',[0 1.5]*1e-3,'xtick',tauticks,'xticklabel',taulabels,...
      'ylim',[0 1.5]*1e-3,'ytick',tauticks,'yticklabel',taulabels);
  colormap bone
  shading faceted
  caxis([-12 8]*1e6);
  view([60 25]);
  title('Second-Order Kernel');
  zh = zlabel('');
  xh = xlabel('\tau_1 (ms)');
  yh = ylabel('\tau_2 (ms)');
  grid on


  subplot(223);
  s1h = plot(slice1(1:16));
  hold on
  s2h = plot(slice2(1:16));
  s3h = plot(slice3(1:16));
  hold off
  set(gca,'fontsize',12);
  set(s1h,'color','k','linestyle','--');
  set(s2h,'color','k','linestyle','-.');
  set(s3h,'color','k','linestyle',':');
  title('Kernel Slices');
  ylabel('Amplitude');
  xlabel('Lag (ms)');
  set(gca,'xtick',[0:5:15]*1e-4,'xticklabel',taulabels);
  legend('\tau_1 = 0','\tau_1 = 0.1','\tau_1 = 0.2');



  subplot(224);
  s1sh = plot(s1s(1:16));
  hold on
  s2sh = plot(s2s(1:16));
  s3sh = plot(s3s(1:16));
  hold off
  set(gca,'fontsize',12);
  set(s1sh,'color','k','linestyle','--');
  set(s2sh,'color','k','linestyle','-.');
  set(s3sh,'color','k','linestyle',':');
  title('Normalized Kernel Slices');
  ylabel('Amplitude');
  xlabel('Lag (ms)');
  set(gca,'xtick',[0:5:15]*1e-4,'xticklabel',taulabels);

end








