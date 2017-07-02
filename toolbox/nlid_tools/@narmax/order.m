function [nu,  ne, ny, power] = order(N)
% return the order of a narmax model

% Copyright 1999-2000, Robert E Kearney and Sunil L Kukreja
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

t=N.Terms;
nelements = length(t);
nu=0;
ny=0;
ne=0;
power=0;
T=[];
for i =1:nelements,
   T=cat(1,T,t{i});
end
power=max(T(:,3));
for i=1:3,
   iu=find(T(:,1)==i);
   nt=max(T(iu,2));
   if length(nt)>0,
      nu(i)=nt+1;
   else
      nu(i)=0;
   end
   
end
if nargout ==0,
   nu=[nu power];
   disp([ 'nu ny ne power = ' num2str(nu)]);
   nu=[];
elseif nargout==1,
   nu=[nu power];
end



