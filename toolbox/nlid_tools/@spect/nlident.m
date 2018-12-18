function S = nlident (Sin, z, varargin)
% identify spect objects

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt


S=Sin;
z=nldat(z);
if nargin < 2
    disp('nlident takes two inputs for cor objects: cor, Z' );
elseif nargin > 2
    set(S,varargin)
end
[nsamp,nchan,nreal]=size(z);
incr=get_nl(z,'DomainIncr');
ninputs=1;
noutputs=nchan-ninputs;
p=get_nl(S,'parameters');
assign(p)
if isnan(NFFT)
    NFFT=nsamp/10;
end
NFFT = round(NFFT);
if isnan(NoOverlap)
    NoOverlap=0;
end
if isnan(Wind)
    Wind=NFFT;
end
wind=Wind';
incr=get_nl(z,'DomainIncr');
fs=1/incr;
Order=1;

%
% noutputs =0 so we have an autospectrum
%
if noutputs==0
    for ireal=1:nreal
        x=double(z(:,1,ireal));
        switch Order
            case 1
                switch Detrend_Mode
                    case 'mean'
                        x = detrend(x,'constant');
                    case 'linear'
                        x = detrend(x,'linear');
                end
                if isnan(ConfidenceLevel)
                    %                     [pxx,f]= psd  (x, NFFT, fs, Wind, NoOverlap,
                    %                     Detrend_Mode); % Original
                    [pxx,f]= pwelch(x, Wind, NoOverlap, NFFT, fs);
                    S.ConfInter=NaN;
                else
                    [pxx,pxxc, f]= pwelch(x, Wind, NoOverlap, NFFT,...
                        fs, 'ConfidenceLevel',ConfidenceLevel);
                    S.ConfInter=pxxc;
                end
                
            case 2
                error ('high order auto-spectra not defined yet')
        end
        if ireal==1
            domega=f(2)-f(1);
            N=nldat(pxx);
            nme = get_nl(z,'channames');
            set (N,'data',pxx,'Domainincr',domega,  'channame',{'Gxx'}, ...
                'comment',['Spectrum of ' char(nme)],'DomainName','Frequency');
        else
            N=cat(3,N,nldat(pxx));
        end
        S.nldat=N;
    end
    
    
elseif ninputs ==1 && noutputs ==1
    a=double(z);
    x=a(:,1);
    y=a(:,2);
    switch Order
        case 1
        switch Detrend_Mode
            case 'mean'
           x = detrend(x,'constant');
           y = detrend(y,'constant');
            case 'linear'
           x = detrend(x,'linear');
           y = detrend(y,'linear');
        end
            if isnan(ConfidenceLevel)
                [pxy,pxyc,f]=cpsd(x, y, Wind, NoOverlap, NFFT, fs);
                S.ConfInter=NaN;
            else
                [pxy,pxyc, f]= cpsd(x, y, Wind, NoOverlap, NFFT,...
                    fs, 'ConfidenceLevel',ConfidenceLevel);
                S.ConfInter=pxyc;
            end
            
        case 2
            error ('high order spectrum not defined yet')
    end
    domega=f(2)-f(1);
    N=nldat(pxy);
    set (N,'Domainincr',domega, 'DomainName','Frequency', ...
        'channame',{'Pxy'});
    S.nldat=N;
    
else
    error ('multiple outputs not yet implement');
end

% ... spect/nlident
