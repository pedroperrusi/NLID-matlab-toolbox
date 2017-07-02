function vs = nlident (vs, z, varargin)
% Identify a Volterra series model 
%

% Copyright 1999-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

if nargin > 2,
  set(vs,varargin);
end

if isa(z,'nldat') | isa(z,'double')

  if isa(z,'nldat')
    Ts=get(z,'DomainIncr');
  else  
    stuff = get(vs,'elements');
    vk0 = stuff{1};
    Ts = get(vk0,'domainincr');
  end   

  
  

  zd=double(z);
  u=zd(:,1);
  y=zd(:,2);
  numlags=get(vs,'NLags');
  if isnan(numlags),
    numlags=min (16,length(z)/100);
    set(vs,'NLags',numlags);
  end
  %
  % Compute first three kernels uisng fast orthongal method
  method = get(vs,'method');
  switch lower(method)
    case 'foa'
      vs = foa(vs,u,y,Ts);
    case 'laguerre'
      vs = lag_id(vs,u,y,Ts);
  end
elseif isa(z,'nlbl'),
  vs=nl2vs(z,vs); 
elseif isa(z,'lnbl'),
  vs=ln2vs(z,vs);
elseif isa(z,'lnlbl'),
  vs=lnl2vs(z,vs);
elseif isa(z,'wseries')
  vs = ws2vs(z,vs);

elseif isa(z,'wbose')  
  vs = wb2vs(z,vs);
  
elseif isa(z,'pcascade'),
  vs=pc2vs(z,vs); 

elseif isa(z,'nlm'),   
  vs = nlm2vs(z,vs);
  
else
  error (['Vseries does not support inputs of type:' class(z)] );
end

return
% ... @vseries/nlident


function vs = pc2vs (pc, vsin);
% Generate Volterra series from parallel cascade description
%
ordermax=get(vsin,'OrderMax');
k=cell(ordermax+1,1);
for order=0:ordermax
  vskern = pcas2volt(pc,order);
  k{order+1,1}=vskern;
end

vs=vsin;
set(vs,'elements',k);
return






