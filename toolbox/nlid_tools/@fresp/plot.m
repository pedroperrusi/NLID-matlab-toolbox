function plot (F,varargin)
% plot a frequency response object
%  xmode [linear/log] determines mode for plotting frequency axis
%

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

options={{'mode' 'line' 'plot type (line/xy/Super/bar)'} ...
    {'help_flag' 0 'display help (0=No/1=yes)'} ...
    {'line_color' '' 'Line color'} ...
    {'nh' NaN 'Number of horizontal plots'} ...
    {'nv' NaN 'Number of vertical plots'} ...
    {'nplt' 1 'Plot Number' } ...
    {'moder' 'super' 'mode for plotting realizations' } ...
    {'offsetr' 1 'offset for plotting realizations' } ...
    {'xmode' 'linear' 'x axes mode [linear/log' } ...
    {'ymode' 'linear' 'y axes mode [linear/log/db' } ...
    };
if ischar(F)
    arg_help('nldat/plt',options);
    return
end
if arg_parse(options,varargin)
    return
end

f=get_nl(F,'Data');
fd=f(:,1);
f1=(abs(fd));
f1=20*log10(f1);
f2=180*(unwrap(angle(fd))/pi);
[m,n]=size(f);
if n==1
    nv=2;
    f3=NaN;
else
    nv=3;
    f3=f(:,2);
end

V=varargin;
subplot (nv,1,1);
f=F.nldat;
title(' ');
%
% Het rid of 0's for log plots
if strcmp(xmode,'log')
    imin=find(domain(f)>0, 1 );
    f=f(imin:length(f));
    f1=f2(imin:length(f1));
    f2=f2(imin:length(f2));
end


%    end
%end
set(f,'data',f1,'ChanNames',{'Gain'});

plot(f,'xmode',xmode);
ylabel('Gain (db)');xlabel('');
subplot (nv,1,2);
title(' ');
set(f,'data',f2,'ChanNames',{'Phase'});
plot(f,V);title('');
ylabel('Phase (degrees)');
if ~isnan(f3)
    xlabel('');
    subplot (nv,1,3);
    set(f,'data',f3,'ChanNames',{'Coherence'});
    plot(f,V);title('');
    title(' ');
end

