% ch5/mod1.m Script to create model system for chapter 5 exercise 1.

% create the impulse response of a delayed, buttewrworth filter.
[b,a] = butter(4,0.25);
x = [zeros(3,1); 1; zeros(28,1)];
h = filter(b,a,x);

% place the IRF in an IRF object
model1 = irf;
set(model1,'domainincr',1/200, 'data',h);
set(model1,'comment','Model for Chapter 5, Exercise 1');


clear h a b x