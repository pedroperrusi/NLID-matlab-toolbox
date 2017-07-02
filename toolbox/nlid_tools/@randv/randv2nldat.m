function d = randv2nldat(z);
% converts a randv object into a nldat object

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


t=z.DomainMin:z.DomainIncr:z.DomainMax;
SZ=length(t);

vtype=get(z,'Type');
prm=get(z,'Parameters');
p=zeros(3,1);
for i=1:length(prm),
  p(i)=value(prm(i));
end
x=mknldat(vtype, SZ, p(1),p(2),p(3));
d=nldat(x,'Comment', [vtype ' Variable' ],'DomainIncr', ...
    z.DomainIncr,'DomainStart',z.DomainMin);	

