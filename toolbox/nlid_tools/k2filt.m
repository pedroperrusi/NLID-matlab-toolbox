function y=k2filt(kern,x)
% compute the output from a second order kernel
%
%	THIS FUNCTION COMPUTES THE OUTPUT FROM A SECOND
%	ORDER KERNEL.
%
%	USAGE :	 y=k2filt(kern,x)
%
% EJP Jan 1991
% REK Jun 1994 Modified for Matlab 4


% Copyright 1991-2003, Robert E Kearney Eric J Perreault and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see copying.txt and gpl.txt


lenx = length(x);
[nrx,ncx]=size(x);
if (nrx > 1)
    x=x';
end
[nr,nc]=size(kern);
if (nr ~= nc)
    error('Kernel is not square');
end
shift = nr;
y=zeros(size(x));
x=[zeros(1,shift) x];

for k = 1:lenx
    y(k) = x((k+shift):-1:k+1)*kern*x((k+shift):-1:k+1)';
end
if (nrx > 1)
    y=y';
end


