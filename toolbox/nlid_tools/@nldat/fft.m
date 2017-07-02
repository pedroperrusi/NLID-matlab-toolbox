function z = fft(x);
% fft function for nldat variables;
% z = fft(x);
%
% matlab's fft is applied to each realization of all channels in data set
% $Revision: 1.1 $


% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see copying.txt and gpl.txt 

[nsamp, nchan, nreal]=size(x);
z=x;
z.DomainIncr= 1/(nsamp*x.DomainIncr);
set(z,'comment','FFT of input');
z.DomainStart=0;
z.DomainName='Frequency Hz'; 
for ichan=1:nchan,
    for ireal=1:nreal,
        z.Data(1:end,ichan,ireal)=fft(x.Data(1:end,ichan,ireal));
    end
end
