function pc = nlident (pc,z,  varargin)
% CONSTRUCT an pcascade - parallel cascade mode
%

% $Revision: 1.7 $
% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 
if nargin < 2,
    disp('nlident takes two inputs for pcascade objects: pcasacde, Z' );
elseif nargin > 2,
    set(pc,varargin)
end

if isa(z,'nldat') | isa(z,'double')
    
    if isa(z,'nldat')
        Ts=get(z,'DomainIncr');
    else  
        subsys = get(pc,'elements');
        f1 = bank{1,1};
        Ts = get(f1,'domainincr');
        z = nldat(z,'domainincr',Ts);
    end   
    
    
    method = lower(get(pc,'method'));
    switch method
        case 'eig'      
            pc = pcm_eigen(pc,z,0);
        case 'gen_eig'      
            pc = pcm_eigen(pc,z,1);      
        case 'slice'      
            pc = pcm_slice(pc,z);
	  case {'lm','sls'}
	    pc = pcm_nlls(pc,z);
        otherwise 
            error('unsupported method');
    end
    
    % check mode, and proceed with identification
    
elseif isa(z,'nlm')
    
    % convert z into a wiener-bose model
    ztype = lower(class(z));
    error('transformation from nlm to pcascade not yet implemented');
    
else 
    error('second argument must be a nldat object or a model with parent nlm');
end



return


function pc = pcm_eigen(pc,z,generalized)
% parallel cascade identification via eigenvector method

global dtw_pinv_order;

u = z(:,1);
y = z(:,2);
yest = 0*y;
zsize = size(z);
N = zsize(1);
hlen = get(pc,'NLags');

P = get(pc,'parameters');
assign(P);

path = lnbl;
set(path,'NLags',NLags,'OrderMax',OrderMax,'mode','auto');
% try a first-order pathway

set(path,'initialization','fil');
resid = y - yest;
ur = cat(2,u(hlen+1:N),resid(hlen+1:N));
path = nlident(path,ur);


% check path for significance
% if polynomial order = 0 minimizes the MDL, then 
% the linear dynamics are not significant.

subsys = get(path,'elements');
h = subsys{1};
m = subsys{2};

order = get(m,'order');
if order > 0
    % path is significant, so include
    yest = nlsim(path,u);
    elements = {h m};
    NPar = dtw_pinv_order + order;
    mdl_old = mdl_cost(y,yest,NPar,hlen);
    disp(double(vaf(y,yest)));
    num_paths = 1;
else
    elements = {};
    NPar = 0;
    mdl_old = mdl_cost(y,yest,NPar,hlen);
    disp('no significant first-order path found');
    num_paths = 0;
end

if generalized
    set(path,'initialization','gen_eigen');
else
    set(path,'initialization','eigen');
    dtw_pinv_order = hlen;
end

finished = 0;
while ~finished
    resid = y - yest;
    ur = cat(2,u(hlen+1:N),resid(hlen+1:N));
    path = nlident(path,ur);
    
    
    subsys = get(path,'elements');
    h = subsys{1};
    m = subsys{2};
    order = get(m,'order');
    if order < 1
        finished = 1;
    else
        
        pathout = nlsim(path,u);
        yest_new = yest + pathout;
        NPar_new = NPar + dtw_pinv_order + order -1;
        
        mdl_new = mdl_cost(y,yest_new,NPar_new,hlen);
        if mdl_new < mdl_old
            elements = cat(1,elements,{h m});
            yest = yest_new;
            NPar = NPar_new;
            mdl_old = mdl_new;
            disp(double(vaf(y,yest)));
            num_paths = num_paths + 1;
        else
            finished = 1;
        end  
    end
    if num_paths == NPaths;
        finished=1;
    end
end

set(pc,'elements',elements,'NPaths',num_paths);

return

function pc = pcm_slice(pc,z)
% parallel cascade identification using single slices (original method).




P = get(pc,'parameters');
assign(P);



Ts = get(z,'domainincr');


path = lnbl;
set(path,'NLags',NLags,'OrderMax',OrderMax,'method','bussgang');



subsys = get(path,'elements');
h = subsys{1};
m = subsys{2};
set(h,'domainincr',Ts,'NLags',NLags);
set(m,'OrderMax',OrderMax','type','tcheb');
set(path,'elements',{h m});




u = z(:,1);
y = z(:,2);
resid = y;
zsize = size(z);
N = zsize(1);


% Threshold for rejecting insingificant paths 
% expressed in tersm of Percent VAF -- hence 400 instead of 4 
% in the numerator
if lower(TestPaths(1)) == 'y'
    TestSignificance = 1;
    Threshold = 400/(N-NLags+1);
else
    TestSignificance = 0;
end



% Initialize the model
num_paths = 0;
elements = {};
finished = 0;
paths_tested = 0;


while ~finished
    path_order = ceil(3*rand(1));
    switch path_order
        case 1
            set(path,'initialization','correl');
        case 2
            set(path,'initialization','slice2');
        case 3
            set(path,'initialization','slice3');
        otherwise 
            error('OOPS -- this error message should never get triggered');
    end
    ur = cat(2,u,resid);
    ur0 = ur(NLags+1:N,:);
    path = nlident(path,ur);
    Significant = 1;
    if TestSignificance
        vf = double(vaf(path,ur0));
        if vf < Threshold
            Significant = 0;
        end
    end    
    if Significant
        % add the path to the model
        num_paths = num_paths + 1;
        elements = cat(1,elements,get(path,'elements'));
        set(pc,'elements',elements,'NPaths',num_paths);
        yest = nlsim(pc,u);
        resid = y - yest;
    end
    paths_tested = paths_tested+1;
    if paths_tested > MaxPaths
        finished = 1;
    end
    if num_paths > NPaths
        finished = 1;
    end
    disp([paths_tested double(vaf(pc,z))]);
end

return

function no_outputs = never_called(no_inputs)


if nargin>2,
    set(pc,varargin);
end
if isa(z,'lnl')
    error('lnl2wiener conversion under development');
end

[nsamp,nchan,nreal]=size(z);
numlags=get(pc,'NLags');
if isnan(numlags),
    numlags=min(64, nsamp/10);
end
zd=double(z);
u = zd(:,1,:);
y = zd(:,2,:);
N = length(u);
incr=get(z,'domainincr');
%
% First Order path
%
resid = y;
order=get(pc,'POrderMax');
[h,m,outsum] = wiener_1(u,resid,numlags,order,'a');
hirf=irf;
set (hirf, 'data',h,'Nlags',numlags,'domainincr',incr);
mt= polynom; 
set (mt,'type','power');
set (mt,'Range',m(1:2),'Coef',m(3:length(m)));
elements = { hirf mt };
if vaf(y,outsum) > 100*(numlags/N)
    next_path = 2;
    resid = y - outsum;
    vaf_path = 100*(1 - (std(resid)/std(y))^2);
    vafs(1,:) = [vaf_path vaf_path];
    disp('Path 1 identified');
    disp (['   VAF Path = ' num2str(vaf_path)]);
else
    next_path = 1;
    disp('no significant first order path');
    disp(vaf(y,outsum));
end
numpaths=get(pc,'NPaths');
tol=get(pc,'PTolerance');
for pathnum = next_path:numpaths
    [h,m,out] = wiener_2(u,resid,numlags,order,'a');
    hirf=irf; set (hirf, 'data',h,'NLags',numlags,'domainincr',incr);
    mt= polynom;
    set(mt,'type','tcheb');
    set (mt,'Range',m(1:2),'Coef',m(3:length(m)));
    vaf_path = 100*(1 - (std(resid-out)/std(resid))^2);
    outsum = outsum + out;
    resid = y - outsum;
    vaf_total =  100*(1 - (std(resid)/std(y))^2);
    vafs(pathnum,:) = [vaf_path vaf_total];
    disp(['Path ' num2str(pathnum) ' identified']);
    disp (['   VAF Path = ' num2str(vaf_path)]);
    disp (['   VAF Total = ' num2str(vaf_total)]);
    if vaf_path < tol,
        disp (['VAF Path = ' num2str(vaf_path)]);
        disp ([ 'VAF Path < tol. iteration terminated']);
        pathnum=pathnum-1;
        break
    end
    elements = cat (1, elements, { hirf mt });
end
set(pc,'Elements',elements);
set(pc,'Nlags',numlags,'NPaths',pathnum);
return

