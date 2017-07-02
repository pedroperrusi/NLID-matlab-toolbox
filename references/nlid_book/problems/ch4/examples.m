% examples.m  Contructs nonlinear system models for chapter 4 
% computer exercises.

% Set up system parameters
Ts = 1/1000;
Tau1 = 15*Ts;


%  Set up LNL cascade

% impulse input to generage IRFs
imp = [1;zeros(15,1)];

% First filter
b = [0.43,  -0.33,  0]/Ts;
a = [1,  -0.98, 0.33];
g1 = irf;
set(g1,'domainincr',Ts,'comment','First Linear Element');
set(g1,'data',filter(b,a,imp));


b = [0.098 0.195 0.098]/Ts;
a = [1 -0.94 0.33];
g2 = g1;
set(g2,'data',filter(b,a,imp),'comment','Second Linear Element');

g3 = g2;
% multiplication by Ts is to cancel one of the 1/Ts factors from the two
% IRFs. 
set(g3,'data',conv(double(g1),double(g2))*Ts);
set(g3,'comment','Convolution of Linear Elements');

m = polynom;
set(m,'type','power','order',3,'coef',[0.5 1 -1 0.5]');
set(m,'range',[-2;2],'comment','Static Nonlinearity');


ch4_cascade = lnlbl;
set(ch4_cascade,'Elements',{g1, m, g2});

ch4_wiener = lnbl;
set(ch4_wiener,'Elements',{g3, m});


ch4_hammerstein = nlbl;
set(ch4_hammerstein,'Elements',{m,g3});

% create mystery structure for problem 4

% create a dummy filter, to fill out the array of elements
ch4_structure = nlm;
m1 = polynom;
set(m1,'type','power');
set(m1,'coef',[0 0 1]');
m2 = m1;
set(m2,'coef',[0 1 0 -1]');
subsys = {g3 m1; m2 g3};
set(ch4_structure,'elements',subsys);



clear Ts Tau1 imp b a g1 g2 g3 m