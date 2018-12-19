function x = flb2nld ( f, N )
% Read a nld object from flb

% Copyright 1999-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see copying.txt and gpl.txt

if nargin == 1
    x=flbtomat(f);
    return
end

% Read an nldat type from an flb file
[x, comment, incr, domain_name, ...
    channel_name, domain_start]= flbtomat(f,N);
x=nldat(x);
set(x,'Comment',comment,'DomainIncr',incr, ...
    'DomainName',domain_name,'DomainStart',domain_start);

% Channel Names
r=channel_name;
i=0;
while ~isempty(r)
    [t,r]=strtok(r,'|');
    i=i+1;
    cn{i}=t;
end
set(x,'ChanNames',cn);
return
