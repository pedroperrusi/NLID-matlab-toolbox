function F = nlident (F, z,  varargin)
% CONSTRUCT an fresp ( frequency response function object

% Copyright 2001-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

if nargin < 2
    disp('NLIDtakes two inputs for fresp objects: irf, Z' );
elseif nargin > 2
    set(F,varargin);
end
% Parse options
[nsamp,nchan,nr]=size(z);
P=get_nl(F,'Parameters');
assign(P);
ztype=class(z);
% if spectrum
switch ztype
    case 'irf'
        F=irf2fresp(z);
        fincr=get_nl(z,'domainincr')*length(z);
        set (F,'domainname','Frequency','domainincr',1/fincr);
    case 'nldat'
        if isnan (NFFT)
            NFFT=round(length(z)/10.);
        end
        if isnan (Wind)
            Wind=hanning(NFFT);
        end
        Fs=1/z.DomainIncr;
        x=double(z(:,1));
        y=double(z(:,2));
        if strcmpi(Detrend_Mode,'mean')
            x = detrend(x,'constant');
            y = detrend(y,'constant');
        elseif strcmpi(Detrend_Mode,'linear')
            x = detrend(x,'linear');
            y = detrend(y,'linear');
        end
%         [ t,f]=tfe (x,y,NFFT, Fs,Wind, NoOverlap,Detrend_Mode); % Original
        [ t,f]=tfestimate(x, y, Wind, NoOverlap, NFFT, Fs);
        [ c,f]=mscohere(x, y, Wind, NoOverlap, NFFT, Fs);
        T=nldat(t);
        C=nldat(c);
        O=cat(2,T,C);
        set (O,'domainincr', f(2)-f(1),'domainstart',f(1),'channames', {'tfe' 'cohere'}) ;
        set(O,'domainname','Frequency (Hz)');
        C=get_nl(z,'comment');
        set (O,'comment',['Frequency response:' C]);
        
        F.nldat=O;
        
    otherwise
        error (['fresp - does not support data type: ' ztype]);
        
end