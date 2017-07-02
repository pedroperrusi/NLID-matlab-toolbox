% chapter 4 computer exercise 2

if ~exist('ch4_hammerstein')
  disp('creating models');
  examples;
end

echo on

% get the time step from the wiener cascade
stuff = get(ch4_hammerstein,'elements');
g1 = stuff{2};
Ts = get(g1,'domainincr')
clear g1 stuff


% Create a 1000 point record of white Gaussian noise

rv1 = randv;
set(rv1,'domainincr',Ts,'domainmax',999*Ts);
u = nldat(rv1);

t = cputime;
y = nlsim(ch4_hammerstein,u);
t_wiener = cputime - t;

% conver the wiener cascade into a volterra series model.
vs_model = vseries(ch4_hammerstein);



% extract the kernels from the model.  
kernels = get(vs_model,'elements');

figure(1)
% plot the first-order kernel (kernels{1} is the zero-order kernel).
plot(kernels{2})

figure(2)
% plot is overloaded, so it calls a special method for second-order
% kernels.
plot(kernels{3})

t = cputime;
yvs = nlsim(vs_model,u);
t_vseries = cputime-t;

disp(['Hammerstein Cascade: ' num2str(t_wiener)])
disp(['Volterra Series: ' num2str(t_vseries)])

vaf(y,yvs)



ws1 = wseries(ch4_hammerstein,'variance',1);
kern1s = get(ws1,'elements');

ws2 = wseries(ch4_hammerstein,'variance',2);
kern2s = get(ws2,'elements');

ws10 = wseries(ch4_hammerstein,'variance',10);
kern10s = get(ws10,'elements');


figure(3)

subplot(221)
kk = [double(kern1s{2}) double(kern2s{2}) double(kern10s{2})];
hlen = get(kern1s{2},'NLags');
Ts = get(kern1s{2},'domainincr');
tau = Ts*[0:hlen-1]';
plot(tau,kk)
title('first-order kernels');
legend('\sigma^2 = 1','\sigma^2 = 2','\sigma^2 = 10');
xlabel('lag (seconds)');
ylabel('amplitude');

subplot(222)
plot(kern1s{3})
title('2^{nd}-order kernel, \sigma^2 = 1');


subplot(223)
plot(kern2s{3})
title('2^{nd}-order kernel, \sigma^2 = 2');

subplot(224)
plot(kern10s{3})
title('2^{nd}-order kernel, \sigma^2 = 10');





echo off
