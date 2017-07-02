% exercise 7 chapter 2

% generate data from exercise 6
poly1 = polynom;
set(poly1,'type','power','coef',[1; 3; -2]);

rv1 = randv('domainincr',1,'domainmax',999,'mean',1,'sd',2);
data1 = nldat(rv1);

poly_out = nlsim(poly1,data1);

set(poly1,'mean',1,'std',2);
data_min = min(double(data1));
data_max = max(double(data1));

set(poly1,'range',[data_min;data_max]);
echo on

iodata = data1;
set(iodata,'data',[double(data1) double(poly_out)]);

idpower = polynom(iodata,'type','power');
plot(idpower)

% press any key
pause;


idherm = polynom(iodata,'type','hermite');
plot(idherm)

% press any key
pause;


idtcheb = polynom(iodata,'type','tcheb');
plot(idtcheb)

% press any key
pause;


signal_sd = std(double(poly_out));
dB = 10;
noise_sd = signal_sd/10^(dB/20);
rv2 = randv('domainincr',1,'domainmax',999,'mean',0,'sd',noise_sd);
noise = nldat(rv2);

poly_out_n = poly_out + noise;


iodata_n = data1;
set(iodata_n,'data',[double(data1) double(poly_out_n)]);



idpower2 = polynom(iodata_n,'type','power');
plot(idpower2)

% press any key
pause;


idherm2 = polynom(iodata_n,'type','hermite');
plot(idherm2)

% press any key
pause;


idtcheb2 = polynom(iodata_n,'type','tcheb');
plot(idtcheb2)


% press any key
pause;



rv3 = randv('domainincr',1,'domainmax',999,'mean',1,'sd',4);
data2 = nldat(rv3);
out2 = nlsim(poly1,data2);

out_power2 = nlsim(idpower2,data2);
out_herm2 = nlsim(idherm2,data2);
out_tcheb2 = nlsim(idtcheb2,data2);

test_power = out_power2;
set(test_power,'data',[double(out2) double(out_power2)]);
set(test_power,'ChanNames',{'true output';'power series prediction'});

plot(test_power);


% press any key
pause;


test_herm = out_herm2;
set(test_herm,'data',[double(out2) double(out_herm2)]);
set(test_herm,'ChanNames',{'true output';'hermite prediction'});

plot(test_herm);


% press any key
pause;


test_tcheb = out_tcheb2;
set(test_tcheb,'data',[double(out2) double(out_tcheb2)]);
set(test_tcheb,'ChanNames',{'true output';'tchebyshev prediction'});

plot(test_tcheb);







echo off