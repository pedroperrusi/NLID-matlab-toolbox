function F = irf2fresp(I)
% converts irf model to frequency response

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

F=fresp;
k=get_nl(I,'Data');
fr=fft(k);
l=1+(floor(length(fr)/2));
fr=fr(1:l);
Tincr=get_nl(I,'domainincr');
fftincr=1/(Tincr*(length(k)-1));
fr=fr*Tincr;
set(F,'data',fr,'domainstart',0, 'domainincr',fftincr );