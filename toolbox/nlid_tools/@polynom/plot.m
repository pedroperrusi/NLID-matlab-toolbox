function plot (sys)

nin=get_nl(sys,'NInputs');
range=get_nl(sys,'Range');
if isnan(range)
    umean = get_nl(sys,'mean');
    ustd = get_nl(sys,'std');
    if isnan(umean+ustd)
        range=[-1 1];
    else
        range=[umean-3*ustd umean+4*ustd];
    end
end

if nin==1
    x=linspace(range(1),range(2))';
    y=double(nlsim(sys,x));
    plot (x,y);
    title('  ');
    xlabel('input');
    ylabel('output');
elseif nin==2
    x=linspace(range(1,1), range(2,1))';
    y=linspace(range(1,2), range(2,2))';
    [X,Y]=meshgrid(x,y);
    Z=cat(2,X(:),Y(:));
    zp=nlsim(sys,Z);
    z=double(zp);
    z=reshape (z,length(x),length(y));
    mesh (x,y,z);
else
    error('plotting not available for polynominal with > 2 inputs');
end

return

% Copyright 2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

% polynom/plot
