function vf = vaf (x,y, DIM)
% VAF function for nldat sets

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see copying.txt and gpl.txt 

if nargin ==2,
  DIM='total';
end
[nsamp,nchan,nreal]=size(x);
xd=double(x);
yd=double(y);
switch DIM
  case 'sample'
    % Compute VAF for each sample time
    for isamp=1:nsamp,
      for ich=1:nchan,
	xt=squeeze(xd(isamp,ich,:));
	yt=squeeze(yd(isamp,ich,:));
	v = (1-cov(xt-yt)/cov(xt))*100;
	vf(isamp,ich,1)=v;
      end
    end
    dn='Time';
    di=get(x,'DomainIncr');
    cmt='Variance accounted for at each time';
    
  case 'total'
    % Compute total VAF for each channel
    for ich=1:nchan,
      xt=squeeze(xd(:,ich,:));
      yt=squeeze(yd(:,ich,:));
      xt=xt(:);
      yt=yt(:);
      v = (1-cov(xt-yt)/cov(xt))*100;
      vf(1,ich,1)=v;
    end
    dn=' ';
    di=1;
    cmt='Total Variance Accounted for';
  case 'realization'
    % Compute VAF for each realization 
    
    for ireal=1:nreal,
      for ich=1:nchan,
	xt=xd(:,ich,ireal);
	yt=yd(:,ich,ireal);
	v = (1-cov(xt-yt)/cov(xt))*100;
	vf(1,ich,ireal)=v;
      end
    end
    di=1;
    dn='Realization number';
    cmt='VAF for each realization';
  otherwise
    error 'Bad option'
end
vf=squeeze(vf);
vf=nldat(vf);
set(vf,'ChanNames',{'VAF'},'ChanUnits','%','DomainIncr',di,'DomainName',dn, 'Comment',cmt);

return
