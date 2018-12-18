function plot (M)
% plot function for tvm objects

% Copyright 2000, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

ModelType=get_nl(M, 'Model_Type');
switch ModelType
    case 'irf'
        Incr = get_nl(M,'DomainIncr');
        Start=get_nl(M,'DomainStart');
        dn=get_nl(M,'DomainName');
        Z=get_nl(M,'data');
        c=get_nl(M,'comment');
        for i=1:length(Z)
            z(:,i)=get_nl(Z{i},'data');
        end
        % x axis is lag
        lag=domain(Z{i});
        lagname=get_nl(Z{i},'domainname');
        % yaxis is time
        time=domain(M);
        m=mesh(lag,time,z');
        ylabel(dn);
        xlabel(lagname);
        
        title(c);
    case 'polynom'
        p=get_nl(M,'data');
        nsamp=length(p);
        ds=get_nl(M,'domainstart');
        di=get_nl(M,'domainincr');
        t= ds + (0:nsamp-1)*di;
        range=get_nl(p{1},'range');
        x=linspace(range(1),range(2));
        nreal=length(x);
        x1=repmat(x,nsamp,1);
        x1=reshape(x1,nsamp,1,nreal);
        x1=nldat(x1,'domainincr',di,'domainstart',ds);
        z=nlsim(M,x1);
        z=squeeze(double(z));
        m=mesh(x',t',z);
        xlabel('Input amplitude');
        ylabel('Domain');
        dn=get_nl(M,'domainname'); ylabel(dn);
        c=get_nl(M,'comment'); title(c);
    case 'nlbl'
        D=get (M,'data');
        for i=1:length(D)
            mi=D{i};
            sn{i,1}=mi{1,1};
            dl{i,1}=mi{1,2};
        end
        TVSN=M;
        set (TVSN,'model_type','polynom','data',sn);
        TVDL=M;
        set (TVDL,'model_type','irf','data',dl);
        subplot (1,2,1);
        plot (TVSN)
        subplot (1,2,2);
        plot (TVDL)
        c=get_nl(M,'comment'); title(c);
        
        
    otherwise
        error (['tvm/plot - model type:'  ModelType ' not defined']);
end

