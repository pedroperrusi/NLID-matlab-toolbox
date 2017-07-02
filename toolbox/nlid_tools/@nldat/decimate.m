function y = decimate (d, n);
% overloaded decimate fuction for "data" class
% usage  y = decimate (d, n);

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see copying.txt and gpl.txt 

[nsamp,nchan,nreal]=size(d);
y=nldat(d);
for i=1:nchan,
   for j=1:nreal,
      xin = d.Data(:,i,j);
      dout(:,i,j)=decimate(xin,n);
   end
end
y.Data=dout;
y.DomainIncr=d.DomainIncr*n;
y.DomainStart=d.DomainStart + (n-1)*d.DomainIncr;

% 24 Jan 2002 Set DomainStart correctly.


