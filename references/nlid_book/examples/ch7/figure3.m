function figure3
% Generates figure showing i/o data from the fly retina model used as a 
% running example in Chapters 7 and 8 of 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%

% generate data using white noise input;
[uw,yw,zw] = GenerateData(8000,13,1);

% generate data using coloured noise input 
[uc,yc,zc] = GenerateData(8000,13,0);

subplot(321)
plot(uw);
SetAxes(1);
title('White Input Data');
ylabel('Input: u(t)');


subplot(323)
plot(yw);
SetAxes(2);
ylabel('Clean Output: y(t)');


subplot(325)
plot(zw);
SetAxes(2);
ylabel('Noisy Output: z(t)');
xlabel('Time (sec)');


subplot(322)
plot(uc);
SetAxes(1);
title('Colored Input Data');
ylabel(' ');


subplot(324)
plot(yc);
SetAxes(2);
ylabel(' ');


subplot(326)
plot(zc);
SetAxes(2);
ylabel(' ');
xlabel('Time (sec)');






function SetAxes(rownum)

set(gca,'xlim',[5 5.2]);
if rownum==1
  set(gca,'ylim',[-0.8 0.8]);
else
  set(gca,'ylim',[-12 12]);
end
xlabel(' ');
ylabel(' ');
title(' ');