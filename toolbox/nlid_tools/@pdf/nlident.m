function p = nlident (p, z,  varargin)
% CONSTRUCT a pdf  function object
%
% Setup default values
%
% $Revision: 1.7 $
% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

if nargin < 2
    disp('NLIDtakes two inputs for pdf objects: pdf, z' );
elseif nargin > 2
    set(p,varargin)
end
assign (p.Parameters);

if isa(z,'nldat') || isa (z,'double')
    if isa(z,'double')
        z=nldat(z);
    end
    
    x=double(z);
    
    
    % Number of bins
    
    if isnan (NBins)
        NBins=length(x)/10.;
        set(p,'NBins',NBins);
    end
    if isnan(BinMin)
        BinMin=double(min(z));
        set(p,'BinMin',BinMin);
    end
    if isnan(BinMax)
        BinMax=double(max(z));
        set(p,'BinMax',BinMax);
    end
    if BinMin >=BinMax
        error('BinMin must be < BinMax');
    end
    
    %
    Type=lower(Type);
    [dist,dom]=pdfnl(x,NBins,Type,BinMin,BinMax);
    incr=dom(2)-dom(1);
    N=p.nldat;
    switch Type
        case 'cumulativeprobability'
            set(N,'data',dist','channames',{'CumulativeProbabilty'}, ...
                'chanunits','Probabilty','comment','Cumultive Probabilty')
        case 'density'
            set(N,'data',dist','channames',{'Density'}, ...
                'chanunits','count','comment','Density')
        case 'frequency'
            set(N,'data',dist','channames',{'Frequency'}, ...
                'chanunits','count','comment','Frequency')
        case 'probability'
            set(N,'data',dist','channames',{'Probabilty'}, ...
                'chanunits',' ','comment','Probability')
            
    end
    set (N,'domainname',[ 'Value of ' char(get_nl(z,'channames'))]);
    set (N,'DomainStart',min(dom), 'DomainIncr',incr);
    set(N,'domainvalues',dom);
    p.nldat=N;

elseif isa(z,'randv')
    p=randv2pdf(z,Type, NBins, BinMin,BinMax);
    
end
