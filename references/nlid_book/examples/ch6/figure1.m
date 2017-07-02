function figure1
% function to produce figure showin the data used in the running example 
% throughout chapter 6 of
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%

[u,y,z] = GenerateData(1000,2,10);

subplot(211);
plot(u);
set(gca,'xlim',[0.02 0.035],'ylim',[-8 6]);

subplot(212);
plot(z);
set(gca,'xlim',[0.02 0.035]);