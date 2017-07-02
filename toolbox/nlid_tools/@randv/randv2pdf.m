function P=randv2pdf(z, type, nbin, binmin,binmax);
% converts a randv object into a pdf object

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

vtype=lower(get(z,'Type'));

if isnan (nbin),
   nbin=20;
end
if isnan(binmin),
   binmin=double(min(nldat(z)));
end
if isnan(binmax), 
   binmax=double(max(nldat(z)));
end
binincr=(binmax-binmin)/nbin;

prm=get(z,'Parameters');
p=zeros(3,1);
for i=1:length(prm),
     p(i)=value(prm(i));
  end

dom = [ binmin:binincr:binmax]';  
x=mkpdf(vtype, dom, p(1),p(2),p(3));
P=pdf;
set(P,'domainname',[ 'Value of ' char(get(z,'Type'))], ...
   'domainstart',binmin,'domainincr',binincr, 'channame', {type});
set(P,'Data',x');
set(P,'type','analytical','NBins',nbin,'BinMin',binmin,'BinMax',binmax);
set(P,'domainvalues',dom);