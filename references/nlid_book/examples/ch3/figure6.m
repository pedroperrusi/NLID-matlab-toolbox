function figure5
% function to generate pole-zero map of discrete-time ankle compliance
% model used  as the running example in chapter 3. 
%
%  This shows how figure 3-6 in 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003
%
%  can be generated using the operators in the control systems toolbox. 
%

figure(1)
clf;

Hd = ExampleSystem(200);

[p,z] = pzmap(Hd);
xmin = -1.1; 
xmax = 1.1;
ymin = -1.1;
ymax = 1.1;

poles = plot(real(p),imag(p),'x');
axis ([ xmin xmax ymin ymax]);
set(gca,'fontsize',12);
axis square
hold on
zeros = plot(real(z),imag(z),'o');
% Plot Unit circle
t=0:.1:6.3;
plot(sin(t),cos(t));
plot([xmin xmax],[0 0],':', [0 0],[ymin ymax],':');
hold off

xlabel('Real');
ylabel('Imaginary');
set(poles,'markersize',18);
set(zeros,'markersize',18);
title('Pole-Zero Map of the Discrete-Time Human Ankle Compliance Model');