% sample solution for computer exercise 3, chapter 6

clear
close all

echo on

load catfish;

u = uz(:,1);

% now set up an empty Wiener series object

sys1 = wseries;
set(sys1,'OrderMax',2,'NLags',32);
sys1 = nlident(sys1,uz);

figure(1)
plot(sys1);


% press any key to continue
pause


% test the model
vf = vaf(sys1,uz)
% vaf returns a nldat object, change to double to see more figures,
double(vf)


% press any key to continue
pause


% extract the kernels from the model
kernels = get(sys1,'elements')
k1 = double(kernels{2});
k2 = double(kernels{3});


% set up the tau-axes for plotting
hlen = length(k1);
Ts = get(kernels{2},'domainincr');
tau = [0:hlen-1]'*Ts;


% To test for the Wiener casacde, compute the principal singular vector of
% the second-order kernel, and  compare it to the first-order kernel.
[uu,ss,vv] = svd(k2);
ktest = uu(:,1);
gain = ktest\k1;
ktest = ktest*gain;

figure(2)
plot(tau,[k1 ktest])
legend('first-order kernel','principal singular vector of k2');
xlabel('lag (sec)');
ylabel('Amplitude');

% clearly, the principal singular vector is proportional to the first-order
% kernel, so the kernels are consistent with the hypothesis that the
% underlying system is a Wiener cascade.



% press any key to continue
pause

% set up an empty LNBL (wiener system) object, and set its parameters

sys2 = lnbl;
set(sys2,'method','hk','OrderMax',8,'NLags',32,'Tolerance',0.001);

% identify the model

sys2 = nlident(sys2,uz);
figure(3)
plot(sys2)

%Check to see the model accuracy
vaf(sys2,uz)


% press any key to continue
pause


sys3 = sys2;
set(sys3,'method','phk');
sys3 = nlident(sys3,uz);
figure(4)
plot(sys3)

vaf(sys3,uz)


