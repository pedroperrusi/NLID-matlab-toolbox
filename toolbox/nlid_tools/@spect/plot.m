function plot(S,varargin)
% Plot function for spectrum

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

Sdata=S.nldat;
d=get_nl(Sdata,'data');
cn=get_nl(Sdata,'ChanNames');
dn=get_nl(Sdata,'domainname');
comment=get_nl(S,'comment');
[m,n,o]=size(d);
for i=1:n
    if (n > 1)
        subplot (n,1,i);
    end
    dtemp=abs(d(:,i));
    dp(:,1)=double(dtemp);
    if ~isnan(S.ConfInter(:,i))
        dp(:,2)=abs(S.ConfInter(:,1));
        dp(:,3)=abs(S.ConfInter(:,2));
    end
    
    set(Sdata,'data',dp,'channames','test','comment','');
    V=cat(2,varargin, {'mode' 'super'});
    plot(Sdata,V);
    ylabel(cn{i});
    xlabel(dn);
    title(comment);
end



