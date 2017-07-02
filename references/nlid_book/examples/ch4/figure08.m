function fiture08(figno)
%  Illustration of the Wiener cascade test on the Volterra kernels of the
%  Peripheral Auditory Processing modek,  see figure 4-8 in:
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%
% Calling figure08, or figure08(1) uses the default NLID toolbox plot
% routines. figure08(2) uses MATLAB handle graphics to dress things up a
% bit.

if nargin<1
  figno = 1;
end

figure(1);
clf;

% construct the LNL model for the running example.
fiber = PeripheralAuditoryModel(100);

% Get the zero and first-order Volterra kernels for the LNL model
VSfiber = vseries;
VSfiber = nlident(VSfiber,fiber,'ordermax',2);

% extract the first-order kernel
kernels = get(VSfiber,'elements');
h1 = kernels{2};
h2 = kernels{3};


% extract the first three slices of the second-order kernel object, and 
% store them in first-order kernel objects
slice1 = h1; slice2 = h1;slice3 = h1;
set(slice1,'data',double(h2(:,1)));
set(slice2,'data',double(h2(:,2)));
set(slice3,'data',double(h2(:,3)));


% normalize the slices, since they are so different, there is no need to
% offset them.

s1s = normalize_slice(slice1);
s2s = normalize_slice(slice2);
s3s = normalize_slice(slice3);


% Now generate the figure.

if figno == 1

  subplot(211);
  
  s1h = plot(slice1);
  hold on
  s2h = plot(slice2);
  s3h = plot(slice3);
  hold off
  set(s2h,'color','m');
  set(s3h,'color',[0 0.5 0]);
  legend('\tau_1 = 0','\tau_1 = 0.1','\tau_1 = 0.2');
  title('Kernel Slices');
  
  subplot(212);
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
    disp('To see formatting similar to figure 4-8, type');
    disp('>> figure08(2)');
  end

else
  
  
  % set up ticks and labels for lag axes in ms.
  tauticks = [0:5:15]*1e-4;
  taulabels = [' 0 ';'0.5';' 1 ';'1.5'];

 
  subplot(211);
   % plot only the 0-15ms of the kernel slices.
  % output the handle, so that we can change the color, line-style, etc.
  s1h = plot(slice1(1:16));
  hold on
  s2h = plot(slice2(1:16));
  s3h = plot(slice3(1:16));
  hold off
  set(gca,'fontsize',12);
  set(s1h,'color','k','linestyle','--');
  set(s2h,'color','k','linestyle','-.');
  set(s3h,'color','k','linestyle',':');
  title('Slices of the Second-Order Kernel');
  ylabel('Amplitude');
  xlabel('Lag (ms)');
  set(gca,'xtick',[0:5:15]*1e-4,'xticklabel',taulabels);
  legend('\tau_1 = 0','\tau_1 = 0.1','\tau_1 = 0.2');



  subplot(212);
  s1sh = plot(s1s(1:16));
  hold on
  s2sh = plot(s2s(1:16));
  s3sh = plot(s3s(1:16));
  hold off
  set(gca,'fontsize',12,'ylim',[-0.25 0.85]);
  set(s1sh,'color','k','linestyle','--');
  set(s2sh,'color','k','linestyle','-.');
  set(s3sh,'color','k','linestyle',':');
  title('Normalized Kernel Slices');
  ylabel('Amplitude');
  xlabel('Lag (ms)');
  set(gca,'xtick',[0:5:15]*1e-4,'xticklabel',taulabels);


end

return



function nslice = normalize_slice(slice);

sd = double(slice);
ppamp = max(sd) - min(sd);
sd = sign(sd(1))*sd/ppamp;
nslice = slice;
set(nslice,'data',sd);





