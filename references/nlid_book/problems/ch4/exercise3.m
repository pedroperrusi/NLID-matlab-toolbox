% chapter 4 computer exercise 3


if ~exist('ch4_cascade')
  disp('creating models');
  examples;
end

echo on
figure(1)
plot(ch4_cascade);

vs1 = vseries(ch4_cascade);

ws1 = wseries(vs1,'variance',1);

% there isn't yet an elegant way to do this, something like
% ws2 = wseries(ws1,'OrderMax',2);
% would be nice....
kernels = get(ws1,'elements');
new_kernels = cell(3,1);
for i = 1:3
  new_kernels{i} = kernels{i};
end
ws2 = ws1;
set(ws2,'elements',new_kernels,'OrderMax',2);

vs2 = vseries(ws2);

old_kernels = get(vs1,'elements');
new_kernels = get(vs2,'elements');

figure(2)
subplot(221)
plot(old_kernels{2})

subplot(222)
plot(new_kernels{2})

subplot(223)
plot(old_kernels{3})

subplot(224)
plot(new_kernels{3})



echo off