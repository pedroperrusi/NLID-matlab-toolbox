function F = nlident (F, z,  varargin)
% CONSTRUCT an fresp ( frequency response function object

% Copyright 2001-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

if nargin < 2,
   disp('NLIDtakes two inputs for fresp objects: irf, Z' );
elseif nargin > 2,
   set(F,varargin);
end
% Parse options
[nsamp,nchan,nr]=size(z);
P=get(F,'Parameters');
assign(P); 
ztype=class(z);
% if spectrum
switch ztype
case 'irf'
   F=irf2fresp(z);
   fincr=get(z,'domainincr')*length(z); 
   set (F,'domainname','Frequency','domainincr',1/fincr);
case 'nldat' 
    if isnan (NFFT)
        NFFT=round(length(z)/10.);
    end
    if isnan (Wind),
        Wind=hanning(NFFT);
    end
    Fs=1/z.DomainIncr;
    x=double(z(:,1));
    y=double(z(:,2));
   [ t,f]=tfe (x,y,NFFT, Fs,Wind, NoOverlap,Detrend_Mode);
   [ c,f]=cohere (x,y,NFFT, Fs, Wind, NoOverlap,Detrend_Mode);
   T=nldat(t);
   C=nldat(c);
   O=cat(2,T,C);
   set (O,'domainincr', f(2)-f(1),'domainstart',f(1),'channames', {'tfe' 'cohere'}) ;
   set(O,'domainname','Frequency (Hz)');
   C=get(z,'comment');
   set (O,'comment',['Frequency response:' C]);
   
   F.nldat=O;
     
otherwise
    error (['fresp - does not support data type: ' ztype]);

end

   %
%
