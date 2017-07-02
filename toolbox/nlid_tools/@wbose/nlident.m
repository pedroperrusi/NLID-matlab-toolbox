function wb = nlident (wb, z, varargin)
% Identify a Wiener bose model 
%

% Copyright 1999-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


if ~isa(wb,'wbose')
  error ('First input must be of class wbose')
end   

if nargin > 2,
  set(wb,varargin);
end



if isa(z,'nldat') | isa(z,'double')

  if isa(z,'nldat')
    Ts=get(z,'DomainIncr');
  else  
    bank = get(wb,'elements');
    f1 = bank{1};
    Ts = get(f1,'domainincr');
    z = nldat(z,'domainincr',Ts);
  end   

  method = lower(get(wb,'method'));
  switch method
    case 'laguerre'
      wb = laguerre_wb(wb,z);
    case 'pdm'
      vs = vseries;
      IDmethod = get(wb,'id-method');
      set(vs,'method',IDmethod,'NLags',get(wb,'NLags'),'ordermax',2);
      vs = nlident(vs,z);
      wb = pdm(vs,wb);
      wb = poly_wb(wb,z);
    case 'poly'
      wb = poly_wb(wb,z);
    otherwise 
      error('unsupported method');
  end
  
  
  
  
  % check mode, and proceed with identification

elseif isa(z,'nlm')
  
  % convert z into a wiener-bose model
  ztype = lower(class(z));
  switch ztype
  
  case 'vseries'
    wb = pdm(z,wb);
  case 'lnbl'
    stuff = get(z,'elements');
    h = stuff{1};
    hlen = get(h,'NLags');
    mpol = stuff{2};
    bank = {h};
    set(wb,'elements',{bank mpol},'NFilt',1,'NLags',hlen);
  case 'wbose'
    set(z, varargin);
    wb = z;
  otherwise
    vsz = nlident(vseries,z);
    wb = pdm(vsz,wb);
  end

else 
  error('second argument must be a model with parent nlm');
end

   
   
return


function wb = pdm(z,wb)
% Principal dynamic modes conversion of a Wiener/Volterra series into a 
% Wiener Bose model.

global dtw_pdm_nfilt dtw_pdm_done


kernels = get(z,'elements');
k0 = kernels{1}; k0d = double(k0);
k1 = kernels{2}; k1d = double(k1);
k2 = kernels{3}; k2d = double(k2);

Ts = get(k1,'domainincr');
hlen = get(k1,'NLags');

H = [k0d 0.5*Ts*k1d'; 0.5*Ts*k1d k2d*Ts^2];
[uu,ss,vv] = svd(H);
ss = diag(ss);


% if LET was used to construct kernels, limit the number of modes
% to the number of Laguerre filters

kernel_method = lower(get(z,'method'));
if strcmp(kernel_method,'laguerre')
  max_modes = get(z,'NumFilt');
  ss = ss(1:max_modes);
else
  max_modes = hlen;
end



mode = lower(get(wb,'mode'));

switch mode
  case 'fixed'
    num_filts = get(wb,'NFilt');
  case 'auto'
    num_filts = min_mdl(ss,hlen);
  case 'manual'
    % use the pinverse order selection routine (move?).
    % for now, do something simple
    dtw_pdm_nfilt = min_mdl(ss,hlen);
    pdm_gui('init',ss,uu(:,1:max_modes));
    done = 0;  
    while ~done;
      done = dtw_pdm_done;
      pause(0.25);
    end
    num_filts = dtw_pdm_nfilt;


end

filt = irf(irf,'NLags',hlen,'domainincr',Ts);
bank = cell(num_filts,1);
set(wb,'NFilt',num_filts);

for i = 1:num_filts
  set(filt,'data',uu(2:end,i));
  bank{i} = filt;
end

% now fit the first- and second-order polynomial coefficients.... 

% generate the 'kernel components' due to each pair modes, and 
% solve a least squares fit to the kernel values.

coeff0 = k0d;

Bank = uu(2:end,1:num_filts);
coeff1 = Bank\k1d; 

k2vec = k2d(:);
Bank2 = zeros(hlen^2,num_filts*(num_filts+1)/2);
offset = 1;
for i = 1:num_filts
  for j = i:num_filts
    kk = Bank(:,i)*Bank(:,j)';
    kk = (kk + kk')/2;
    Bank2(:,offset) = kk(:);
    offset = offset + 1;
  end
end
coeff2 = Bank2\k2vec;

mpol = polynom;
set(mpol,'NInputs',num_filts,'Order',2,'type','power');
set(mpol,'coef',[coeff0; coeff1; coeff2]);

set(wb,'elements',{bank mpol});

return

function num_filts = min_mdl(ss,hlen)
% compute the MDL with respect to the entries in the 
% symmetric matrix containing the 0, first and second-order 
% kernels.  Choose the number of modes that minimizes the MDL


num_vals = (hlen+1)*(hlen+2)/2;  % number of unique elements in matrix
k = log(num_vals)/num_vals;      % MDL penalty gain

resid = (ss.^2)/sum(ss.^2);      % normalized residual variance as a
                                 % function of the number of modes
% compute the MDL, and minimize it.				 
% There are 2 parameters per mode (linear and quadratic gains).
% plus one for the 0 order gain.
mdl = resid(2:end) +  k*(2*[1:length(ss)-1]'+1);
[val,num_filts] = min(mdl);     




% ... @wbose/nlident
