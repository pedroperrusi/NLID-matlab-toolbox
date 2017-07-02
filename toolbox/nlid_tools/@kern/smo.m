function ks = smo(k,n);
% overloaded smooth function for kern objects
%
% syntax ks = smo(k,n);
% n is the number of passes (default 1).

% Copyright 1999-2003, Robert E Kearney, David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see copying.txt and gpl.txt 


if nargin<2,
 n=1;
end


ks=k;
kdat=get(k,'Data');
order = get(k,'order');

switch order
  case 0
    % zero order kenel -- do nothing
    kdat = kdat;
  case 1
    % first order kernel -- smooth it.
    kdat = smo(kdat,n);
  case 2  
    % second order kernel -- use a 2d smoother
    kdat = smo_2d(kdat,n);    
  case 3
    [nr,nc,nl] = size(kdat);
    for i = 1:nl
      kdat(:,:,i) = smo_2d(squeeze(kdat(:,:,i)),n);
    end
    for i = 1:nc
      kdat(:,i,:) = smo_2d(squeeze(kdat(:,i,:)),n);
    end
    for i = 1:nr
      kdat(i,:,:) = smo_2d(squeeze(kdat(i,:,:)),n);
    end
  otherwise
    error('smo not implemented for kernels of order 4 and up');
end

cc = get(k,'comment');
if strcmp(cc,'Default comment')
  cc = 'smoothed';
else
  cc = ['smoothed ' cc];
end

set(ks,'data',kdat,'comment',cc);

  

function ks = smo_2d(k,n);
% smo will smooth a matrix column by column -- so we have to transpose
% to smooth all of the rows, and transpose back again.

ks = smo(k,n);
ks = smo(ks',n)';
