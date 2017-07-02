function Nout = purgeterms (Nin);
% delete zero elements from terms of a Narmax Model

% Copyright 2000, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

nel=size(Nin);
Nout=narmax;
j=1;
for i=1:nel,
  Nout.Coef(j)=Nin.Coef(i);
  t=Nin.Terms{i};
  [nterms,ncol]=size(t);
  if all(t(:,1)==0),
    Nout.Terms{i}=t(1,:);
  else
    k=find(t(:,1)~=0);
    Nout.Terms{i}=t(k,:);
  end
j=j+1;end


