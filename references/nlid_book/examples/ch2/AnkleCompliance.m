function H = AnkleCompliance(fs)
% function to set up example system for running example in Chapter 3 
% syntax:  H = ExampleSystem(fs)
% 
% 
%
% The system is a compliance model of the Human Ankle, using values taken
% from Kearney and Hunter (1990).


% Parameters lifted from figures 11-13 of KH90
K = 800;    % Nm/rad  at Tmean = 25 Nm
B = 1.5;    % Nm/rad/s
zeta = 0.2;  

% Now, compute G and Omega_n
I = B^2/(K*4*zeta^2);
G = 1/K;
Wn = sqrt(K/I);


nums = G*Wn^2;   
dens = [1 2*zeta*Wn Wn^2];   
Hs = tf(nums,dens);

if nargin == 0
  fs = 1;
end

Ts = 1/fs;
[hdata,tau] = impulse(Hs);
hlen = max(tau)/Ts;
tau = [0:hlen-1]'*Ts;
hdata = impulse(Hs,tau)/Ts;
hlen = length(hdata);
H = irf;
set(H,'domainincr',Ts,'nsides',1,'data',hdata);



