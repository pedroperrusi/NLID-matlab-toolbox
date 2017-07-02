function figure3

%  function to generate figure of IRF model of ankle compliance model used
%  as the running example in chapter 3.
%
%  This shows how figure 3-3 in 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003
%
%  can be generated using the operators in the NLID toolbox. 
%

figure(1)
clf;

Hs = ExampleSystem;

% use the control systems toolbox operators to compute the impulse response
% of the transfer fucntion model produced by ExampleSystem.
fs = 1000;
Ts = 1/fs;
t = [0:Ts:0.1];
impulse = zeros(size(t));
impulse(1) = 1/Ts;
h = lsim(Hs,impulse,t);

ComplianceIRF = irf;
set(ComplianceIRF,'domainincr',Ts,'data',h);

plot(ComplianceIRF);
set(gca,'fontsize',12,'ylim',[-0.3 0.1],'ytick',[-0.3:0.1:0.1],...
    'xlim',[0 0.1],'xtick',[0:0.05:0.1]);
title('Impulse Response');
xlabel('Lag (s)');
ylabel('Complicance (Nm/rad)');



