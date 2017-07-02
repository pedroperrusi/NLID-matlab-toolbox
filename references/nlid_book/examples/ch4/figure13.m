function fiture13(figno)
%  Illustration of the LNL cascade test on the Volterra kernels of the
%  Peripheral Auditory Processing model,  see figure 4-13 in:
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%
% Calling figure13, or figure13(1) uses the default NLID toolbox plot
% routines. figure13(2) uses MATLAB handle graphics to dress things up a
% bit.

if nargin<1
  figno = 1;
end

figure(1);
clf;

% construct the LNL model for the running example.
fiber = PeripheralAuditoryModel(100);

% Get the zero through second-order Volterra kernels for the LNL model
VSfiber = vseries;
VSfiber = nlident(VSfiber,fiber,'ordermax',2);

% extract the first- and second-order kernels
kernels = get(VSfiber,'elements');
h1 = kernels{2};
h2 = kernels{3};


% extract the first four slices of the second-order kernel object, and 
% store them in first-order kernel objects
slice1 = h1; slice2 = h1;slice3 = h1; slice4 = h1;
set(slice1,'data',double(h2(:,1)));
set(slice2,'data',double(h2(:,2)));
set(slice3,'data',double(h2(:,3)));
set(slice4,'data',double(h2(:,4)));

% normalize the slices, since they are so different, there is no need to
% offset them.

s1s = normalize_slice(slice1);
s2s = normalize_slice(slice2);
s3s = normalize_slice(slice3);
s4s = normalize_slice(slice4);

% compute the marginal kernel from the second-order kernel

hm = h1;
hmd = sum(h2);
hmd = hmd*max(double(h1))/max(hmd);
set(hm,'data',hmd(:));
% hmd is a row -- the data in a first-order kernel is assumed to be a
% column.  This should really be fixed in the set method for a first-order
% kernel.... 


if figno == 1
  subplot(221)
  plot(h1);
  
  subplot(222)
  plot(h2);
  
  subplot(223)
  s1sh = plot(s1s);
  hold on
  s2sh = plot(s2s);
  s3sh = plot(s3s);
  s4sh = plot(s4s);
  hold off
  set(s2sh,'color','m');
  set(s3sh,'color',[0 0.5 0]);
  set(s4sh,'color','r');
  title('Normalized Kernel Slices');
  legend('\tau_1 = 0','\tau_1 = 0.1','\tau_1 = 0.2','\tau = 0.3');

  subplot(224)
  h1h = plot(h1);
  hold on
  hmh = plot(hm);
  hold off
  set(hmh,'color','m');
  legend('First-Order Kernel','Marginal Kernel (Scaled)');
  title('LNL Test');
  
  
  if nargin < 1
    disp('Generated using default NLID Toolbox plot function');
    disp('To see formatting similar to figure 4-13, type');
    disp('>> figure13(2)');
  end

else

    
  % set up ticks and labels for lag axes in ms.
  tauticks = [0:5:15]*1e-4;
  taulabels = [' 0 ';'0.5';' 1 ';'1.5'];

  
  subplot(221)
  h1h = plot(h1(1:16));
  set(gca,'fontsize',12,'xtick',tauticks,'xticklabel',taulabels);
  set(h1h,'color','k');
  ylabel('Amplitude');
  xlabel('\tau (ms)');
  title('1^{st} Kernel');

  
  subplot(222)
  plot(h2(1:16,1:16));
  set(gca,'fontsize',12,'zlim',[-1.8 4.5]*1e6,...
      'xlim',[0 1.5]*1e-3,'xtick',tauticks,'xticklabel',taulabels,...
      'ylim',[0 1.5]*1e-3,'ytick',tauticks,'yticklabel',taulabels);
  colormap bone
  shading faceted
  caxis([-12 8]*1e6);
  view([60 25]);
  title('2^{nd} Kernel');
  zh = zlabel('h_2(\tau_1,\tau_2)');
  xh = xlabel('\tau_1 (ms)');
  yh = ylabel('\tau_2 (ms)');
  grid on


  subplot(223)
  s1sh = plot(s1s(1:16));
  hold on
  s2sh = plot(s2s(1:16));
  s3sh = plot(s3s(1:16));
  s4sh = plot(s4s(1:16));
  hold off
  set(gca,'fontsize',12,'xtick',tauticks,'xticklabel',taulabels);
  set(s1sh,'color','k');
  set(s2sh,'color','k','linestyle','--');
  set(s3sh,'color','k','linestyle','-.');
  set(s4sh,'color','k','linestyle',':');
  title('First 4 Slices');
  legend('\tau_2 = 0','\tau_2 = 0.1','\tau_2 = 0.2','\tau_2 = 0.3');
  xlabel('\tau_1 (ms)');
  ylabel('h_2(\tau_1,\tau_2)');
  
  

  subplot(224)
  h1h = plot(h1(1:16));
  hold on
  hmh = plot(hm(1:16));
  hold off
  set(gca,'fontsize',12,'xtick',tauticks,'xticklabel',taulabels);  
  set(h1h,'color','k');
  set(hmh,'color','k','linestyle','none','marker','o');
  legend('1^{st} Kernel','Marginal');
  title('LNL Test');
  ylabel('Amplitude');
  xlabel('\tau (ms)');
  
  
end





function nslice = normalize_slice(slice);

sd = double(slice);
ppamp = max(sd) - min(sd);
sd = sign(sd(1))*sd/ppamp;
nslice = slice;
set(nslice,'data',sd);




