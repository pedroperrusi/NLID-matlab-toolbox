function I = fresp2irf (F, NSides);
% Convert a frequency response object to IRF
% $Revision: 1.3 $

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

I=IRF;
fd=get(F,'data');
fpos=fd(:,1);
lmax=length(fpos);
fneg=conj(fpos(lmax:-1:2));
f=[fpos;fneg];
iout=real(ifft(f));
Fincr= get(F,'domainincr');
Tincr=1/(2*(Fincr*(lmax-1)));
Tstart=0;
if NSides==2,
    iout=fftshift(iout);
    Tstart=-(length(iout)-1)*Tincr/2
end
    
set(I, 'data',(iout/Tincr));
set (I,'domainincr',Tincr,'domainstart',Tstart); 


