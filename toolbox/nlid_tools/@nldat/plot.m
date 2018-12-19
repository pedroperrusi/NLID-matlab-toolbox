function plot (d, varargin)
% overloaded plot function for "nldat" class
% plot (d, varagin);
% options= 'plotmode' [line] 'plot type (line/xy/Super)
%         'help_flag' 0 'display help (0=No/1=yes)
%          nh - number of horizontal plots'
%          nv - number of vertical plots'
%          nplt - plot number'
%          xmode
%          y mode

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see copying.txt and gpl.txt

options={{'plotmode' 'line' 'plot type (line/xy/Super/bar)'} ...
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
if ischar(d)
    arg_help('nldat/plt',options);
    return
end
if arg_parse(options,varargin)
    return
end
%
% Determine default layout
%
[nsamp, nchan, nreal]= size(d);
if isnan (nv) && isnan (nh)
    % neither nv or nh set
    nh=ceil(nchan/2);
    nv=ceil(nchan/nh);
elseif isnan (nv)
    % nh set
    nv=ceil(nchan/nh);
elseif isnan(nh)
    % nv set
    nh = ceil (nchan/nv);
end


incr=d.DomainIncr;
start=d.DomainStart;
names=d.ChanNames;
if isnan(d.DomainValues)
    t= ((1:nsamp)-1)*incr +start;
else
    t=d.DomainValues;
end
if strcmp(xmode,'log')
    t=log10(t);
end
x=double(d);
if strcmp(ymode,'log')
    x=log10(x);
end
if strcmp(ymode,'db')
    x=20*log10(x);
end

%
% xy plot
%
plotmode=lower(plotmode);
if strcmp(plotmode,'xy')
    for i=1:2:nchan
        plot(x(:,i,:),x(:,i+1,:),'.')
    end
    xlabel(d.ChanNames{1});
    ylabel(d.ChanNames{2});
elseif strcmp(plotmode,'super')
    plot (t,x);
    xlabel(d.DomainName);
    yunits = d.ChanUnits;
    if ~isnan(yunits)
        ylabel(d.ChanUnits);
    end
    title(get(d,'comment'));
    
    % this next hack produces a legend with all of the channel names
    % harvested from the ChanNames cell array.
    numchan = size(x,2);
    cmd = 'legend(''';
    for i = 1:numchan
        cmd = [cmd  d.ChanNames{i} ''','''];
    end
    cmd = [cmd(1:end-1) '2);'];
    eval(cmd);
    % end of legend hack.
    
    
elseif strcmp(plotmode,'bar')
    bar (t,x,1);
else
    %
    % Line plots
    %
    if isnan(nplt)
        nplt=1;
    end
    
    for i=1:nchan
        if (nchan > 1)
            NP=nplt+i-1;
            subplot (nv,nh,NP);
        end
        xd = squeeze(x(:,i,:));
        if nreal==1
            nlc = length(line_color);
            if nlc>0
                plot (t,xd,line_color(max(nlc,i)));
            else
                plot (t,xd);
            end
            try
                ylabel(names{i});
            catch
                ylabel(names)
            end
            if strcmp(xmode,'log')
                xlabel([ 'Log ' d.DomainName]);
            else
                xlabel(d.DomainName);
            end
            
        elseif nreal > 1
            y=(1:nreal);
            if strcmp(moder,'surf')
                surf(y,t,xd);
            elseif strcmp(moder,'mesh')
                mesh(y,t,xd);
            elseif strcmp(moder,'waterfall')
                waterfall(y,t,xd)
            elseif strcmp(moder,'offset')
                for ir=1:nreal
                    xd(:,ir)=xd(:,ir)+offsetr*(ir-1);
                end
                
                plot (t,xd);
            elseif strcmp(moder,'super')
                plot (t,xd);
            end
        end
        
        if i==1
            C=get_nl(d,'comment');
            title(C);
        end
    end
end
%	.../@nldat/plot
