function figure2
% Generates figure showing elements of the fly retina model used as a 
% running example in Chapters 7 and 8 of 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%
% This is similar to figure 2, but without the block diagram surrounding the
% elements. 

figure
pos = get(gcf,'position');
pos(3) = 1000; pos(4) = 300;
set(gcf,'position',pos);

load LMCmodel
plot(retina);
