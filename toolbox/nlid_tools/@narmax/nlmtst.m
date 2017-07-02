function [n,z]=nlmtst(N)
% Test routine for narmax objects
%


% Copyright 1999-2000, Robert E Kearney and Sunil L Kukreja
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


disp('Test parsing and display');
s1='10u(n)';
n1=narmax(s1);
display(s1);
display(n1);

% power
s2='.1y(n-1)';
n2=narmax(s2);

% products

s3='10u^2(n-1)*y(n-2)';
n3=narmax(s3);

fprintf('\n String: %s \n',  s3)
disp('gives narmax model');
disp(n3);

%
% multiple terms
%


s4='10u^2(n-1)*y(n-2) + 20u^3(n-2)*y(n-3)*e(n-4)';
n4=narmax(s4);
fprintf('\n String %s',  s4)
disp('gives narmax model');
disp(n4);

%
%
s5= '0.4u(n-1)+0.4u^2(n-1)+0.4u^3(n-1)+0.8y(n-1)-0.8e(n-1)+e(n)';
n5=narmax(s5);
fprintf('\n String %s \n',  s5)
disp('gives narmax model');
disp(n5);

%
% Summation
fprintf('\n Test addition of two narmax models');
disp('Sum of:')
disp(n1)
disp('and ');
disp(n2);
disp('Equals');
n12=n1+n2;
disp(n12);
%
% products
fprintf('\n');
fprintf('Test products of two narmax models');
fprintf('\nProduct of:\n');
disp(n3);
disp('and ');
disp(n3);
disp('Equals');
n34=n3*n4;
disp(n34);

%
% Test simulation
%
n=n1+n2;
x=nldat(rand(1000,1));
y=nlsim(n,x);
z=cat(2,x,y);
plot(z);








