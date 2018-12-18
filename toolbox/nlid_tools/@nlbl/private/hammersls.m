function [hammer,vafs] = hammersls(hammer,uy,p)
%  Hammerstein system identification using separable least squares.
%
% syntax:  [hammer,vafs] = HammerSLS(uy,hammer,tp)
%  where hammer is a nlm object containing a hammerstein cascade.
%        uy is an nldat objects containing the input-output data
%        tp is a vector containing training parameters
%
% tp = [max_its, threshold, accel, decel, delta, display];
%
% See Westwick, D.T., and Kearney, R.E., Separable Least Squares
%     Identification of Nonlinear Hammerstein Models: Application to
%     Stretch Reflex Dynamics. Annals of Biomedical Engineering,
%     29:707--718, 2001.

% Copyright 2000-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../../copying.txt and ../../gpl.txt




% call the standard L-M SLS training parameter routine.

assign(p)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Get Data                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = get_nl(uy,'data');
u = data(:,1);
y = data(:,2);
Ts = get_nl(uy,'domainincr');
N = length(u);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Get Initial Model and do some Error Checking        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% make sure it is a Hammerstein system
if ~isa(hammer,'nlm')
    error('initial model must be an nlm object');
end

elements = get_nl(hammer,'Elements');
if any (size(get_nl(hammer,'Elements')) ~= [1 2])
    error('initial model is not a Hammerstein cascade');
end

SNL = elements{1};
H = elements{2};

if ~isa(SNL,'polynom')
    error('first element must be a polynomial');
end
if ~isa(H,'irf')
    error('second element must be an IRF');
end

% Now, we know that the initial model is a Hammerstein system, so we can
% proceed.


% make sure that the polynomial is orthogonalized using the statistics of
% the identification input.

poly_type = get_nl(SNL,'type');
SNL = poly_rescale(SNL,u);
m = get_nl(SNL,'Coef');
order = get_nl(SNL,'order');


hlen = get_nl(H,'Nlags');


% allocate storage
X = ones(N,hlen);
U = ones(N,order+1);
ea = zeros(N,order+1);
ec = zeros(N,hlen);



% normalize u for orthogonalization, if necessary
switch lower(poly_type(1))
    case 'p'
        U = multi_pwr(u,order);
    case 'h'
        un = (u - mean(u))/std(u);
        U = multi_herm(un,order);
    case 't'
        avg = (max(u)+min(u))/2;
        rng = max(u) - min(u);
        un = (u - avg)*2/rng;
        U = multi_tcheb(un,order);
    otherwise
        error('poly-type not recognized');
end
x = U*m;

% put lagged copies of x into the regressor matrix,X.
X(:,1) = x;
for i = 2:hlen
    X(:,i) = [0;X(1:N-1,i-1)];
end
h = X\y;
e = y - X*h;
ystd = std(y);
old_error = std(e)/ystd;
updated = 1;

if DisplayFlag
    plot(hammer);
end

vafs = [];
for step = 1:max_its
    vafs = [vafs; 100*(1-old_error^2)];
    
    % Jacobean wrt the linear parameters (ec in Sjoberg) is just the
    % regression matrix (X in this code)
    if updated
        
        % Jacobean wrt polynomial coefficients is equal to h*U(:,i)
        for i = 1:order+1
            ea(:,i) = -filter(h,1,U(:,i));
        end
        
        ec_term = X*inv(X'*X);
        Qc_ea = ea - ec_term *(X'*ea);
        QTQ = Qc_ea'*Qc_ea;
        QTe = Qc_ea'*e;
    end
    
    % the separable least squares/LM step
    dm = inv(QTQ + delta*eye(order+1))*QTe;
    new_m = m - dm;
    new_m = new_m / sqrt(sum(new_m.^2));
    new_x = U*new_m;
    
    
    X(:,1) = new_x;
    for i = 2:hlen
        X(:,i) = [0;X(1:N-1,i-1)];
    end
    
    new_h = X\y;
    new_e = y - X*new_h;
    new_error = std(new_e)/ystd;
    if new_error < old_error
        old_error = new_error;
        h = new_h;
        m = new_m;
        set(H,'data',h);
        set(SNL,'Coef',m);
        elements = {SNL, H};
        set(hammer,'Elements',elements);
        e = new_e;
        x = new_x;
        delta = delta * accel;
        updated = 1;
    else
        delta = delta * decel;
        updated = 0;
    end
    if DisplayFlag
        fprintf('Step %4i Error %6.4f\n', step ,old_error)
        plot(hammer);
        drawnow;
    end
    if new_error < error_threshold
        break
    end
end

% correct the linear subsystem for the sampling rate.
set(H,'data',h/Ts);
elements = {SNL, H};
set(hammer,'Elements',elements);