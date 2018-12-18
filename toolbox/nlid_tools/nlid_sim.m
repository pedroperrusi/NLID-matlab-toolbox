function [Z,M] = nlid_sim (option,U,pltflg, nsmo)
% nlid_sim - simjulate various nonlinear systems
% usage:
%			z = nlid_sim (u,option, pltflg)
% where
%	u 			= input signal
%	option 	= system type
%  pltflg	= plot model simulated

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see copying.txt and gpl.txt

if nargin < 4
    nsmo=0;
    disp('No Smoothing');
end
if nargin <3
    pltflg=0;
end
if nargin<2  || isempty(U)
    u=4*(rand(2200,1)-.5);
    incr=0.01;
    U=nldat(u,'domainincr',incr);
else
    incr=get_nl(U,'domainincr');
end
if nargin==0 || isempty(option)
    opts = { 'L1'; 'L2' ; 'LNRect'; 'LN2'; 'LN3'; 'N3L'; 'N2L'; ...
        'LNL'; 'PC'; 'POLY' };
    o=menu('Option',opts);
    option=opts{o};
end
comment='undefined';
k=1;
z=.5;
w=5*2*pi;
t=0:incr:.5;
a1=[ k z w];
a2=[ 5. 1.5 20*2*pi];
[irf1]=fkzw(t,a1);
I1=irf;
set(I1,'data',irf1,'domainincr',incr);
[irf2, di]=fkzw(t,a2);
I2=irf;set(I2,'data',irf2,'domainincr',incr);
P2=polynom;
set(P2,'type','power','coef',[100 25 10 ]');
P3=polynom; set(P3,'type','power','coef',[200 50 -10 5]');

%  And the coefficients of the Nonlinearity are...

option=upper(option);
switch option
    % linear
    case 'L1'
        plot(I1);
        Y = nlsim(I1,U);
        set (Y,'Comment', 'One-side low pass');
        comment='L1';
        M=I1;
    case 'L2'
        Y = nlsim(I2,U);
        M=I2;
        subplot (1,1,1);
        plot(I2);
        title('L2');
        set (Y,'DomainIncr',.01,'Comment', 'I2: One-side low pass');
        comment='Linear data set 2';
        % LN
        
    case 'LNRECT'
        disp('ln')
        x = filter(irf1,1,u);                % filter with the first L
        y= max (x,0);
        Y=nldat(y);
        comment='LN Threshold data set';
        if pltflg==1
            clf;
            subplot (1,2,1);
            plot (irf1);
            title('L1');
            subplot (1,2,2);
            plot (x,y,'.');
            title('N');
        end
    case 'LN2'
        x = nlsim(I1,U);
        Y= nlsim(P2,x);
        M=lnbl; set(M,'elements',{I1 P2});
        comment='LN2 data set';
    case 'LN3'
        x = nlsim(I2,U);             % filter with the first L
        Y= nlsim(P3,x);
        M=lnbl; set(M,'elements',{I1 P3});
        comment='LN2 data set';
        % NL
    case 'N3L'
        x=nlsim(P3,U);
        Y=nlsim(I1,x);
        M=nlbl; set(M,'elements',{P3 I1});
        comment='NL Cubic data set';
    case 'N2L'
        x=nlsim(P2,U);
        Y=nlsim(I1,x);
        M=nlbl; set(M,'elements',{P2 I1});
        comment='NL Quadratic data set';
        %LNL
    case 'LNL'
        x=nlsim(I1,U);
        z=nlsim(P3,x);
        Y=nlsim(I2,z);
        comment='LNL data set';
        M=lnlbl; set(M,'elements',{I1 P3 I2});
    case 'PC'
        x1=nlsim(I1,U);
        y1=nlsim(P2,x1);
        x2=nlsim(I2,U);
        y2=nlsim(P3,x2);
        Y=y1-y2;
        M=pcascade;
        set(M,'elements',{ I1 P2; I2 P3});
        Y=x1+x2;
        comment='Parallel Cascade Data set';
    case 'POLY'
        Y=nlsim(P3,U);
        M=P3;
    otherwise
        error ('not defined');
end
Z=cat(2, U,Y);
Z=extract(Z,100);
set (Z, 'ChanNames', { 'zin' 'zout' }, 'DomainIncr',.01,'DomainStart',0);
set (Z,'Comment',comment,'DomainName','S');
