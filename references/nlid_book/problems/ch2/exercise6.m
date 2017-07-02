% exercise 6 chapter 2

echo on

poly1 = polynom;
set(poly1,'type','power','coef',[1; 3; -2]);

rv1 = randv('domainincr',1,'domainmax',999,'mean',1,'sd',2);
data1 = nldat(rv1);

poly_out = nlsim(poly1,data1);

set(poly1,'mean',1,'std',2);
data_min = min(double(data1));
data_max = max(double(data1));

set(poly1,'range',[data_min;data_max]);

poly2 = poly1;
set(poly2,'type','hermite');
test2 = nlsim(poly2,data1);
plot(poly_out - test2);


pause

poly3 = poly1;
set(poly3,'type','tcheb');
test3 = nlsim(poly3,data1);
plot(poly_out - test3);

get(poly1,'coef')

get(poly2,'coef')

get(poly3,'coef')

echo off

