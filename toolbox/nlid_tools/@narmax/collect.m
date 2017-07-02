function Nout = collect(Nin)
% function Nout=collect(Nin) 
% collect like terms in a naxmax model

% Copyright 1999-2003, Robert E Kearney and Sunil L Kukreja
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


Nel=size(Nin);
if Nel==1,
  Nout=Nin;
  return
else
  Nout=narmax;
end
Nin=sort(Nin);
Nout.Coef(1)=Nin.Coef(1);
Nout.Terms{1}=Nin.Terms{1};
jout=1;
for i=2:Nel,        
  if all(size(Nin.Terms{i})==size(Nin.Terms{i-1})) ...
	& all(Nin.Terms{i}==Nin.Terms{i-1}),
    Nout.Coef(jout)=Nout.Coef(jout)+Nin.Coef(i);
  else
    jout=jout+1;
    Nout.Coef(jout)=Nin.Coef(i);
    Nout.Terms{jout}=Nin.Terms{i};
  end
end
Nout=purge(Nout);
Nout=purgeterms(Nout);
 
 
 
