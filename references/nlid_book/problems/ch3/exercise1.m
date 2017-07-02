% exercise 1 chapter 3

echo on

% create a linear system object
[b,a] = butter(2,0.25);
Ts = 1/1000;
Gz = tf(b,a,Ts);

% import it into the nlid toolbox
imp = [1;zeros(31,1)];
sys = irf;
set(sys,'domainincr',Ts,'data',filter(b,a,imp));

% create an input
rv1 = randv('domainincr',Ts,'domainmax',10,'mean',0,'sd',1);
u1 = nldat(rv1);

% create a second input
sinewave = signalv;
set(sinewave,'domainincr',Ts,'DomainMax',10,'omega',10);
u2 = nldat(sinewave);

y1 = nlsim(sys,u1);
y2 = nlsim(sys,u2);

u3 = u1+u2;
y3 = nlsim(sys,u3);

vaf(double(y3),double(y1)+double(y2))

test = y3;
set(test,'data',[double(y1)+double(y2),double(y3)],...
    'ChanNames',{'f(u1) + f(u2)';'f(u1+u2)'},...
    'comment','Checking Superposition' );
plot(test);

echo off
