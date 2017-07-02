function figure18
% function to produce figure showing the LNL cascade estimated
% from the peripheral auditory model simulation data using the HK 
% iteration.  This is Figure 18 in
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%

N = 1000;
ustd=2;
dB=10;


% filter for input signal
Forder =  4;
Fc = 0.75;



[u,y,z] = GenerateData(N,ustd,dB,Forder,Fc);
uz = cat(2,u,z);

m1 = lnlbl;
m1 = nlident(m1,uz,'ordermax',6,'nlags1',16,'nlags2',16,'maxits',10);

% since the input is fairly bandlimited, smooth the first IRF, and
% do a little more optimization.
% This should really be incorporated as an option into the nlident method.
% Of course, we could get really fancy, and use a pseudo-inverse based
% smoothing of the IRF too.
stuff = get(m1,'elements');
g = stuff{1}; 
stuff{1} = smo(g);
set(m1,'elements', stuff);

m1 = nlident(m1,uz,'initialization','self','innerloop',10,'maxits',1);
plot(m1)
