function bl  = nlident (bl, z, varargin)
% Identify a lnbl

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

if nargin > 2
   set (bl,varargin);
end

if isa(z,'nldat') | isa(z,'double')

  if isa(z,'nldat')
    Ts=get(z,'DomainIncr');
  else  
    subsys = get(bl,'elements');
    f1 = subsys{1};
    Ts = get(f1,'domainincr');
    z = nldat(z,'domainincr',Ts);
  end   




  subsys = get(bl,'elements');
  i = subsys{1};  % IRF
  p = subsys{2};  % Polynomial

  x=z(:,1);
  y=z(:,2);
  hlen = get(bl,'NLags');
  mode = get(bl,'mode');
  set(i,'NLags',hlen,'mode',mode);
  switch lower(get(bl,'initialization'))
    case 'correl'
      phi = cor;
      set(phi,'order',1,'NLags',hlen);
      phi = nlident(phi,z);
      h_est = i;
      set(h_est,'data',double(phi));    
    case 'fil'
      h_est = nlident(i, z);
    case 'slice2'
      h_est = cor_slice(i,z,2);
    case 'slice3' 
      h_est = cor_slice(i,z,3);    
    case 'eigen'  
      phi = cor;
      set(phi,'order',2,'NLags',hlen);
      phi = nlident(phi,z);
      [U,S,V] = svd(double(phi));
      h_est = i;
      set(h_est,'data',U(:,1));    
    case 'gen_eigen'
      h_est = wiener_2(z,i);
    otherwise
      error('unrecognized initialization method');
  end


  x_est = nlsim (h_est,x);
  z1 = cat(2,x_est,y);
  Q = get(bl,'OrderMax');
  mode = get(bl,'mode');
  set (p,'Order',Q,'OrderMax',Q,'mode',mode);
  m_est = nlident(p,z1);
  yp = nlsim(m_est,x_est);
  vf = vaf(y,yp);
  set (h_est,'Comment','Linear element');
  bl.nlm{1,1}= h_est;
  set (m_est,'Comment','Static NonLinear Element');
  bl.nlm{1,2}=m_est  ;
  set(bl,'NLags',get(h_est,'NLags'));


  switch get(bl,'method')
    case 'bussgang'
      set(bl,'Comment','LN model identified using Busgang''s theorm');
    case 'hk'
      bl = hk_ident(bl,z);
    case 'phk'
      bl = phk_ident(bl,z);
    case 'lm'
      bl = lm_ident(bl,z);
    otherwise
      error('unrecognized identification method');
  end

else
  error('conversions to models of class lnbl not yet implemented');
end


return


function h = cor_slice(h,z,order)

hlen = get(h,'NLags');
ud = double(z(:,1));
yd = double(z(:,2));
N = length(ud);
uny = z;

switch order
  case 2    
    lag = floor(hlen*rand(1));
    udel = [zeros(lag,1);ud(1:N-lag)];
    set(uny,'data',[ud udel.*yd]);
  case 3
    lag1 = floor(hlen*rand(1));
    ud1 = [zeros(lag1,1);ud(1:N-lag1)];
    lag2 = floor(hlen*rand(1));
    ud2 = [zeros(lag2,1);ud(1:N-lag2)];
    set(uny,'data',[ud ud1.*ud1.*yd]);
  otherwise
    error('unsupported slice order');
end

phi = cor;
set(phi,'order',1,'NLags',hlen);
phi = nlident(phi,uny);
hd = get(phi,'data');


gain = std(yd);
switch order
  case 2    
    hd(lag+1) = hd(lag+1) + randn(1)*gain;
  case 3
    hd(lag1+1) = hd(lag1+1) + randn(1)*gain;
    hd(lag2+1) = hd(lag2+1) + randn(1)*gain;
  otherwise
    error('unsupported slice order');
end

set(h,'data',hd);

return