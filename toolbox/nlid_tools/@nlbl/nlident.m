function nl  = nlident (nl, z, varargin)
% Identify an NL BLock system
%

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

if (nargin > 2),
  set (nl,varargin);
end

if isa(z,'nldat') | isa(z,'double')

  if isa(z,'nldat')
    Ts=get(z,'DomainIncr');
  else  
    subsys = get(nl,'elements');
    f1 = subsys{2};
    Ts = get(f1,'domainincr');
    z = nldat(z,'domainincr',Ts);
  end   

  numlags=get(nl,'NLags');
  if isnan(numlags'),
    numlags= max(32,length(z)/100);
  end

  p=get(nl,'Parameters');
  m=get(nl,'method');
  switch lower(m)
    case 'hk'
      nl = hammerhk (z,nl,p); 
      set(nl,'Comment',' NL model identified using hk');
      
    case 'sls'

      % Use hk to make initial guess if polynomial has not been specified 
      % i.e. check to see if its coefficients are NaNs
      el=get(nl,'elements');
      coeffs = get(el{1},'coef');

      if isnan(coeffs)
	hk=nlbl;
	set(hk,'Method','hk');
	hk=pdefault(hk);
	phk=get(hk,'Parameters');
	nl = hammerhk (z,nl,phk);
      end
      nl = hammersls(nl,z, p);
      set(nl,'Comment',' NL model identified using sls');

    otherwise
      disp (['Method ' m ' not defined for nlbl']);
  end


else
  error('conversions to models of class nlbl not yet implemented');
end

