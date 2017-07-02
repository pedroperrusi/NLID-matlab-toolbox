function figure11(figno)
% generates a figure showing that off-diagonal elements  of the Volterra
% kernels of a Hammerstein cascade are all zero, while the diagonal values
% are proportional to the first-order kernel. 
%
%  The Hammerstein cascade model comprises a polynomial
%  approximation to a half-wave rectifier, as its nonlinearity, and the same
%  first-order Volterra kernel as the LNL model of the auditory processing
%  example system used as a running example throughout chapter 4 of:
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%
% Calling figure11, or figure11(1) uses the default NLID toolbox plot
% routines. figure11(2) uses MATLAB handle graphics to dress things up a
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
VSfiber = nlident(VSfiber,fiber,'ordermax',2);

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


% create a Hammerstein cascade, to house the elements
NLfiber = nlbl;
set(NLfiber,'elements',{mt, h},'comment',...
    'Hammerstein Cascade Model of Peripheral Auditory Processing System');



% create a Volterra series model containing the kernels of the Wiener
% cascade. 
VShammer = nlident(VSfiber,NLfiber,'ordermax',2);


% extract the first and second-order kernels
kernels = get(VShammer,'elements');
h1 = kernels{2};
h2 = kernels{3};


% pull the first two diagonals out of the second-order kernel, and 
% put them in first-order kernel objects.
h2d = get(h2,'data');
d0d = diag(h2d);
d0d = d0d*double(h1(1))/d0d(1);
d0 = h1;
set(d0,'data',d0d);

d1d = [diag(h2d,1);0];
d1 = d0;
set(d1,'data',d1d);


% now generate the plots

if figno == 1

subplot(211)
plot(h2)


subplot(212)
plot(h1);
hold on
d0h = plot(d0);
d1h = plot(d1);
hold off

set(d0h,'color','m');
set(d1h,'color',[0 0.5 0]);
legend('First-Order Kernel','Diagonal (Scaled)','Off-Diagonal Slices');

else
  
  % set up ticks and labels for lag axes in ms.
  tauticks = [0:5:15]*1e-4;
  taulabels = [' 0 ';'0.5';' 1 ';'1.5'];

  
subplot(211)
plot(h2(1:16,1:16));
  set(gca,'fontsize',12,'xtick',tauticks,'xticklabel',taulabels,...
      'ytick',tauticks,'yticklabel',taulabels,...
      'zlim',[-2 4]*1e6);
  colormap bone
  shading faceted
  caxis([-10 8]*1e6);
  view([-20 25]);
  title('2^{nd}Order Kernel');
  zlabel('Amplitude');
  xlabel('\tau_1 (ms)');
  ylabel('\tau_2 (ms)');
  grid on

  
  subplot(212)
  h1h = plot(h1(1:16));
hold on
d0h = plot(d0(1:16));
d1h = plot(d1(1:16));
hold off
set(gca,'fontsize',12,'xtick',tauticks,'xticklabel',taulabels);
set(d0h,'linestyle','none','marker','o','markersize',12,'color','k');
set(d1h,'color','k','linestyle','--');
set(h1h,'color','k');
xlabel('Lag (ms)');
ylabel('Amplitude');
title('1^{st} Kernel and Diagonal Slices of 2^{nd} Kernel');
legend('First-Order Kernel','Diagonal (Scaled)','Off-Diagonal Slices');

end
  
return
  

