function [R, V, yp] = nlid_resid( M, z, p);
% computes and displays prediction error in model output.


% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see copying.txt and gpl.txt 

if isa(M,'polynom');
   nin=get(M,'NInputs');
   x=z(:,1:nin);
   y=z(:,nin+1);
else
   x=z(:,1);
   y=z(:,2);
   
end

yp= nlsim(M,x);
R=y-yp;
V=vaf(y,yp);
if (nargin > 2)
	return
end

subplot (4,1,1);
plot(y);
title('Observed');
subplot (4,1,2);
plot (yp);
Vt=['Vaf = ' num2str(chop(double(V),4))];

title(['Predicted ' Vt]);

subplot (4,1,3);
plot (cat(2,y,yp),'mode','Super');
title('Superimposed');
subplot (4,1,4);
plot (R);
T= ('Residuals' );
title(T);
disp(Vt);

