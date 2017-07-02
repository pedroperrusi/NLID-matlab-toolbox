function H = ExampleSystem(fs)
% function to set up example system for running example in Chapter 3 
% syntax:  H = ExampleSystem(fs)
%
% If fs is specified, a discrete-time model, with sampling frequency fs is
% returned, otherwise, H will be a continuous-time model.
%
% The system is a compliance model of the Human Ankle, using values taken
% from Kearney and Hunter (1990).


% Parameters lifted from figures 11-13 of KH90
K = -350;    % Nm/rad  at Tmean = 25 Nm
B = 1.5;    % Nm/rad/s
zeta = 0.35;  

% Now, compute G and Omega_n
I = B^2/(K*4*zeta^2);
G = 1/K;
Wn = sqrt(K/I);


nums = G*Wn^2;   
dens = [1 2*zeta*Wn Wn^2];   
Hs = tf(nums,dens);

if nargin == 0
  H = Hs;
else
  H = c2d(Hs,1/fs,'tustin');   % discretize with bilinear transform.
end
