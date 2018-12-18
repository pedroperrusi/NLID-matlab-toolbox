function y = nlsim ( sys, xin )
% Simulate response of polynominal series to input data set

% Copyright 2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

p=get_nl(sys);
nin=get_nl(sys,'NInputs');
[nsamp,nchan,nreal]=size(xin);
if (nchan ~= nin)
    error ('Number of input channels does not match polynominal');
end
if strcmp(class(xin),'nldat')
    y=xin;
else
    y=nldat;
end
x=double (xin);
[nr,nc]=size(x);
if nin > nc
    error ('dimension mismatch');
else
    order=get_nl(sys,'Order');
    type=get_nl(sys,'type');
    coef=get_nl(sys,'Coef');
    switch lower(type)
        case 'power'
            P=multi_pwr(x,order);
            yout=P*coef;
        case 'hermite'
            for i=1:nchan
                x(:,i) = (x(:,i) - sys.Mean(i))/sys.Std(i);
            end
            P=multi_herm (x,order);
            yout=P*coef;
        case 'tcheb'
            for i=1:nchan
                % Scale input with same scale factor
                % used in estimating the polynomial
                r=get_nl(sys,'range');
                a=r(1,i);
                b=r(2,i);
                x(:,i)=(2*x(:,i) -(b+a))/(b-a);
            end
            P=multi_tcheb (x,order);
            yout=P*coef;
    end
    
end
set(y,'Data',yout);
set(y,'Comment','Power-series prediction');


% polynom/nlsim
