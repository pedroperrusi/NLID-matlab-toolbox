function str=getname(j,nx,ny,ne);
% returns names of terms from a narmax model

% Copyright 2000, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

if 
  j==1   str='1*';
elseif ((j>1)&(j<=nx+1+1))  
  str=['x(t-' num2str(j-2) ')' ];
elseif ((j>nx+1+1)&(j<=nx+ny+1+1)) 
  str= ['y(t-' num2str(j-nx-2) ')']; 
else 
  str=['e(t-' num2str(j-nx-ny-2) ')' ]; 
end


