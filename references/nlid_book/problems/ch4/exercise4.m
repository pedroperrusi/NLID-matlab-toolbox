% chapter 4 computer exercise 4


if ~exist('ch4_structure')
  disp('creating models');
  examples;
end

echo on
% convert the model into a volterra series
vs_model = vseries(ch4_structure);

% extract the kernels from the vseries object.
% the first kernel in the series is the zero order kernel.
kernels = get(vs_model,'elements');
k1 = double(kernels{2});
k2 = double(kernels{3});

slices = k2(:,1:5);
figure(1)
plot(slices);
title('slices of second-order kernel');

norm_slices = slices*diag(1./std(slices));
figure(2);
plot(norm_slices);
k1n = k1/std(k1);
hold on
plot(k1n,'k');
hold off
title('first-order kernel and normalized slices');
legend('slice 1','slice 2','slice 3','slice 4','slice 5','first kernel');


% press any key to continue
pause

% now check to see if this really is a wiener system.
figure(3)
plot(ch4_structure);


%NO -- it is a parallel combination of a Wiener and a Hammerstein....
    
echo off