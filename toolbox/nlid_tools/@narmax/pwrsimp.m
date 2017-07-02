function Npower = pwrsimp (N)
% simplify narmax momdel by converting products of
% like terms into powers

% Copyright 2000, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

el=size(N);
N=sort(N);
Npower=narmax;
for iel = 1:el,
   Npower.Coef(iel)=N.Coef(iel);
   t=N.Terms{iel};
   nterms=size(t);
   tout=t(1,:);
   jout=1;
   for iterm = 2:nterms
      iprev=iterm-1;
      if all(t(iterm,1:2)==t(iprev,1:2));
         tout(jout,3)=tout(jout,3)+t(iterm,3);
      else
         jout=jout+1;
         tout(jout,:)=t(iterm,:);
      end   
   end
   Npower.Terms{iel}=tout;
end
Npower=sort(Npower);
