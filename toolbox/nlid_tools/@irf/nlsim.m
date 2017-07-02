function y = nlsim ( model, xin )
% Simulate response of IRF to input data set
% input options not fill defined as yet
%

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

filter = get(model,'data');
if isa(xin,'double'),
    xin=nldat(xin);
    set(xin,'domainincr',get(model,'domainincr'));
end
delx = get(xin,'domainincr');
deli=get(model,'domainincr');
if delx ~= deli,
    W=(str2mat('Model & data have different domain increments', ...
        'the output of the IRF depends on the sampling rate', ...
        'Output may be scaled incorrectly and/or have the wrong increment'));
    warning(' ');disp(W)
end
x=double (xin);

incr = get (model,'domainincr');
P=get(model,'parameters');
assign(P);
%
% Simulate a time-varying response
%
if strcmp(TV_Flag,'Yes'),
   if NSides==1,
       sides='one';
   else
       sides='two';
   end
   x=x(:,1,:);  
   x=squeeze(x);
   filter=squeeze(filter);
   filter=filter;
   yout = etvc(x,filter,incr,sides);
   [n,m]=size(yout);
   yout=reshape(yout,n,1,m);
   y=xin;
   set(y,'Comment','filtered','Data',yout);
   %
   % Simulate a time-invariant response
   %
else
  x=x(:,1);  
    
    [nsamp, nchan,nreal]= size(filter);
    for i=1:nchan,
        for j=1:nreal,
            yout(:,i,j) = filter_ts(filter(:,i,j), x, NSides, incr);
        end
    end
    y=xin;
    set(y,'Comment','filtered','Data',yout);
end

% 19 Mar 01 REK Add support for TV IRfs
