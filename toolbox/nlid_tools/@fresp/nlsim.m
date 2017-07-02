function y = nlsim ( F, xin )
% Simulate response of fresp  to input data set
% input options not fill defined as yet
%

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

xin=nldat(xin);
f=double(get(F,'Data'));
% strip out the coherence (second column of f)
f = f(:,1);
% generate negative frequency points in frequency response.
% note that DC and fs/2 should only appear once, so remove the first 
% last points.
fn=[f;conj(f(length(f)-1:-1:2))];
B=ifft(fn);
B=real(B(1:length(f)));
%B = real(B);
x=double (xin);
yt=fftfilt(B,x,length(B));
y=xin;
set(y,'Comment','filtered','Data',yt);
