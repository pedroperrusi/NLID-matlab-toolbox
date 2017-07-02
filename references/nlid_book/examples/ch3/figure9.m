function figure9
% function to plot IRF of discrete-time ankle compliance model 
% model used  as the running example in chapter 3. 
%
%  This shows how figure 3-9 in 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003
%
%  can be generated using the operators in the control systems toolbox. 
%

figure(1)
clf;

fs = 200;
Ts = 1/fs;

Hd = ExampleSystem(fs);

t = [0:Ts:0.1];
impulse = zeros(size(t));
impulse(1) = 1/Ts;

h = lsim(Hd,impulse,t);


stem(t,h,'filled');
set(gca,'fontsize',12,'xtick',[0:0.02:0.1],...
    'ylim',[-0.3 0.1],'ytick',[-0.3:0.1:0.1]);
hold on
plot(t,h,':');
plot([0 0.1],[0 0],'-');
hold off
title('Discrete Impulse Response');
xlabel('Lag (s)');
ylabel('Complicance (Nm/rad)');
