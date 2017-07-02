function figure10(figno)
%  function to draw Hammerstein cascade model with a polynomial
%  approximation to a half-wave rectifier as its nonlinearity, and the same
%  first-order Volterra kernel as the LNL model of the auditory processing
%  example system used as a running example throughout chapter 4 of:
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%
% Note:  version in text used xfig to draw block diagram.
% Calling figure10, or figure10(1) uses the default NLID toolbox plot
% routines. figure10(2) uses MATLAB handle graphics to dress things up a
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


% create a Hammerstein cascade, to house the elements
NLfiber = nlbl;
set(NLfiber,'elements',{mt, h},'comment',...
    'Hammerstein Cascade Model of Peripheral Auditory Processing System');


switch figno
  case 1
    plot(NLfiber);
otherwise
  subplot(222)
  plot(h);
  set(gca,'fontsize',12,'xlim',[0 0.0015],'xtick',[0:0.5:1.5]*1e-3,...
      'xticklabel',['  0';'0.5';'1.0';'1.5']);
  title('Dynamic Linear');
  xlabel('Lag (ms)');
  ylabel('Amplitude');
  
  subplot(221)
  plot(mt);
  set(gca,'fontsize',12,'xlim',[-2.5 2.5],'xtick',[-2:2:2],...
      'ytick',[-1:1:3]);
  
  hold on
  plot([-2.5 2.5],[0 0],'k:');
  plot([0 0],[-1 3],'k:');
  hold off
  title('Static Nonlinear');
  xlabel('Input');
  ylabel('Output');

end








