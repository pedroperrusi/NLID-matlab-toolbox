function figure5


% function to generate pole-zero map of continuous-time ankle compliance
% model used  as the running example in chapter 3. 
%
%  This shows how figure 3-5 in 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003
%
%  can be generated using the operators in the control systems toolbox. 
%

figure(1)
clf;

Hs = ExampleSystem;
[p,z]=pzmap(Hs);
xmin=-60;
xmax=20;
ymin=-200;
ymax=200;
poles = plot (real(p),imag(p),'x');
axis ([ xmin xmax ymin ymax]);hold on
plot([xmin xmax],[0 0],':', [0 0],[ymin ymax],':');
hold off
set(gca,'fontsize',12);
set(poles,'markersize',18);
xlabel('Real Frequency (rad/sec)');
ylabel('Imaginary (rad/sec)');
title('Pole-Zero Map of the Human Ankle Compliance Model');
