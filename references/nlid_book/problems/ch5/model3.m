% ch5/model3a.m


% Parameters lifted from figures 11-13 of KH90
K = -350;    % Nm/rad  at Tmean = 25 Nm
B = 1.5;    % Nm/rad/s
zeta = 0.35;  

% Now, compute G and Omega_n
I = B^2/(K*4*zeta^2);
G = 1/K;
Wn = sqrt(K/I);

fs = 1000;
Ts = 1/fs;
dB = 10;

nums = G*Wn^2;   
dens = [1 2*zeta*Wn Wn^2];   
Hs = tf(nums,dens);
H = c2d(Hs,Ts,'tustin');

u = nldat(randn(11000,1),'domainincr',Ts);
y = 0.1*ddt(u);
%y = ddt(du);


u = nldat(lsim(H,double(y)),'domainincr',Ts);

u = u(1001:11000);
y = y(1001:11000);

v = nldat(randn(10000,1),'domainincr',Ts);
gain = double(std(y))/(double(std(v))*10^(dB/20));
y = y + gain*v;

clear v gain H Hs dens nums I G Wn B K Ts fs zeta dB



