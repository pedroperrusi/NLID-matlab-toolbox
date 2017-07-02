function x = signalv2nldat(z);
% convert signalV class to nldat object
% $Revision: 1.3 $

% Copyright 2002-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


vtype=get(z,'Type');
prm=get(z,'Parameters');
assign (prm);
t=z.DomainMin:z.DomainIncr:z.DomainMax;
switch lower(vtype)
  case 'sine'
    freq = omega*2*pi;
    phir = phi*pi/180;
    x = (sin (freq*t + phir));
    x=nldat(x');
    set(x,'DomainIncr', z.DomainIncr) 
  case 'second_order_irf'
    a1=[ Gain Damping Omega];
    X=fkzw(t,a1);
    comment=get(z,'comment');
    x=nldat(X,'domainstart',z.DomainMin,'domainincr',z.DomainIncr, 'comment',comment);
  otherwise
    error (['Signal type not defined:' vtype]);
end



