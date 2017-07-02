% exercise 4 chapter 3

echo on

% create a linear system object
[b,a] = butter(2,0.25);
Ts = 1/1000;
Gz = tf(b,a,Ts);

% import the impulse response into the nlid toolbox
% we should really automate this one.

sys = irf;
set(sys,'DomainIncr',Ts,'data',impulse(Gz));

% create a second linear system

Hz = tf(1,[1 -0.85],Ts);
sys2 = sys;
set(sys2,'data',impulse(Hz));

% create an input
rv1 = randv('domainincr',Ts,'domainmax',10,'mean',0,'sd',1);
u1 = nldat(rv1);

y1 = nlsim(sys2,nlsim(sys,u1));
y2 = nlsim(sys,nlsim(sys2,u1));


vaf(double(y1),double(y2))

test = y1;
set(test,'data',[double(y1),double(y2)],...
    'ChanNames',{'h(g(u))';'g(h(u))'},...
    'comment','Checking Commutativity of Linear Systems' );
plot(test);




echo off
