function p = nlident (pin, z, varargin )
% Overlaid nlident for polynom class

% Copyright 1991-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

global dtw_poly_order dtw_poly_done

if isa(z,'char')
    % z and varargin are property value pairs
    p = nltransform(pin,{z ,varargin{1:end}});
    return
end

if ~(isa (z,'double') || isa(z,'nldat'))
    error (' Second argument must be of class double, or nldat');
end
p=pin;
if nargin >2
    set(p,varargin)
end
assign (p.Parameters);

[nsamp,nchan,nreal]=size(z);
nin = get_nl(p,'NInputs');
dz=double(z);
if nchan == nin
    x=double(domain(z));
    y=dz(:,1:nin);
else
    x=dz(:,1:nin);
    y=dz(:,nin+1);
end


type=get_nl(p,'Type');
set (p,'Range', [min(x) ; max(x)]);
set (p,'Mean',mean(x),'Std',std(x));
switch lower(type)
    case 'power'
        [W,f]=multi_pwr(x,OrderMax);
    case 'hermite'
        % Scale inputs to 0 mean, unit variance.
        for i=1:nchan-1
            x(:,i) = (x(:,i) - mean(x(:,i)))/std(x(:,i));
        end
        [W,f]=multi_herm(x,OrderMax);
    case 'tcheb'
        % Scale inputs to +1 -1;
        for i=1:nchan-1
            a=min(x(:,i));
            b=max(x(:,i));
            cmean=(a+b)/2;
            drange=(b-a)/2;
            x(:,i)=(x(:,i) - cmean)/drange;
        end
        [W,f]=multi_tcheb(x,OrderMax);
end
[Q,R] = qr(W,0);
QtY = Q'*y;
y_sum_sq = sum(y.^2);


% Choose polynomial order....

mode = lower(get_nl(p,'mode'));
switch mode
    case 'auto'
        [coefs,mdls] = poly_mdls(y_sum_sq,nsamp,R,QtY,OrderMax,nin);
        [val,pos] = min(mdls);
        order = pos-1;
        d = factorial(nin+order)/(factorial(nin)*factorial(order));
        coef = coefs(1:d,order+1);
    case 'manual'
        [coefs,mdls,vafs] = poly_mdls(y_sum_sq,nsamp,R,QtY,OrderMax,nin);
        poly_gui('init',mdls,vafs);
        done = 0;
        while ~done
            done = dtw_poly_done;
            pause(0.25);
        end
        order = dtw_poly_order;
        d = factorial(nin+order)/(factorial(nin)*factorial(order));
        coef = coefs(1:d,order+1);
    case 'full'
        % use maximum order,
        order = OrderMax;
        npar = length(QtY);
        coef = qr_solve(R,QtY,npar);
    otherwise
        error('unrecognized mode');
end


set (p,'Coef',coef,'order',order);
return



function p = nltransform(pin,inputs)


ni = length(inputs);

if rem(ni,2)~=0
    error('Property/value pairs must come in even number.')
end


p = pin;
AllProps = pnv(pin,'names','lower');
AsgnValues = pnv(pin,'avalues');

for i = 1:2:ni-1
    P = p.Parameters;
    j = pindex(P,inputs{i});
    if j > 0
        warning('Parameter change will take effect on next identification');
        P=setval(P,inputs{i},inputs{i+1});
        p.Parameters=P;
    else
        % Set each PV pair in turn
        [imatch,status] = pmatch(AllProps,inputs{i});
        error(status)
        Property = AllProps{imatch};
        Value = inputs{i+1};
        
        switch Property
            case 'order'
                % change order and pad/truncate coeff
                if isnan(p.coef)
                    %no coefficients so just change the order
                    p.Order = Value;
                else
                    NumInputs = p.NInputs;
                    OldOrder = p.Order;
                    OldCoeffs = p.Coef;
                    NewCoeffs = multi_pwr(zeros(NumInputs,1),Value);
                    if NewOrder > OldOrder
                        OldLength = length(OldCoeffs);
                        NewCoeffs(1:OldLength) = OldCoeffs;
                    else
                        NewLength = length(NewCoeffs);
                        NewCoeffs = OldCoeffs(1:NewLength);
                    end
                    p.Order = Value;
                    p.Coef = NewCoeffs;
                end
                
                
            case 'type'
                % change type and recompute coeff
                if isnan(p.Coef)
                    %  No coefficients so just set type
                    p.Type = Value;
                elseif strcmp(p.Type,Value)
                    % Type is already set so do nothing
                    break
                elseif p.NInputs > 1
                    error ('Conversion not yet implemented for multiple inputs')
                else
                    Pstats = [p.Range(2) p.Range(1) p.Mean p.Std];
                    Pstats = AllStats(Pstats);
                    cold=(p.Coef);
                    OldType = p.Type;
                    cnew = poly_convert(cold, Pstats, OldType,Value);
                    p.Coef=cnew;
                    p.Type=Value;
                end
                
            otherwise
                % set behaves appropriately, so use it.
                set(p,Property,Value);
        end
    end
end



function PStats = AllStats(PStats)
% fills in missing input stats

if isnan(PStats(1))
    % range has not yet been specified
    % use 3 sigma bounds around mean (if set)
    if isnan(PStats(3))
        % mean not set either, assume zero mean
        PStats(3) = 0;
    end
    if isnan(PStats(4))
        PStats(4) = 1;
    end
    PStats(1) = PStats(3)+3*PStats(4);
    PStats(2) = PStats(3)-3*PStats(4);
end

if isnan(PStats(3))
    % mean has not been specified
    % let the max and min be 3 sigma around the mean.
    PStats(3) = (PStats(1)+PStats(2))/2;
    PStats(4) = (PStats(1)-PStats(3))/3;
end

return



function [coefs,mdls,vafs] = poly_mdls(yss,LenY,R,QtY,OrderMax,nin)

mdls = zeros(OrderMax+1,1);
vafs = mdls;


max_coefs =  factorial(nin+OrderMax)/(factorial(nin)*factorial(OrderMax));
coefs = zeros(max_coefs,OrderMax+1);


% MDL penalty gain
k = log(LenY)/LenY;

if nin == 1
    ends = 1+[0:OrderMax]';
else
    ends = zeros(OrderMax+1,1);
    % ends go at (n+q)! / n! q!
    ends(1) = 1;
    for q = 1:OrderMax
        ends(q+1) = ends(q) * (nin+q)/q;
    end
end

RTR = R'*R;

% compute coefs, vafs and mdls
for q = 0:OrderMax
    d = ends(q+1);
    if d>size(QtY,1)
        break
    end
    coef = qr_solve(R,QtY,d);
    coefs(1:d,q+1) = coef;
    outvar = coef'*RTR(1:d,1:d)*coef;
    resid = yss-outvar;
    mdls(q+1) = resid*(1+k*d);
    vafs(q+1) = 100*(outvar/yss);
end


return


function coef = qr_solve(R,QtY,npar)
% solves for npar coefficients using precomputed QR factorization
% intened to be used to estimate reduced order models
% R is the R matrix from a QR decomposition
% QtY is Q^T y, where Q is from the QR decomposition, and y is the output.

QtY = QtY(1:npar);
R = R(1:npar,1:npar);
coef = R\QtY;

