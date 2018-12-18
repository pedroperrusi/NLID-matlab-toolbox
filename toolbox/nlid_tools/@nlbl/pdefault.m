function NLout = pdefault (NLin)
% Set default parameter sets for nlbl objects

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

p= get_nl(NLin,'Parameters');
method=get_nl(NLin,'method');
p(1) = param('name','Method','default',method,...
    'help','Identification Method','type','select',...
    'limits',{'hk', 'sls'});
j = size(p);

if j< 2
    p(2)=param('name','OrderMax','default',2,...
        'help','Maximum order for series' ,...
        'type','number','limits', {0 10});
end
if j< 3
    p(3)=param('name','NLags','default',NaN,...
        'help','Number of lags in each kernel' ,...
        'type','number','limits', {0 1000});
end
if j < 4
    p(4)=param('name','DisplayFlag','default',1,'help','Display flag ');
end

switch lower(method)
    case 'hk'
        
        p(5)=param('name','Tolerance','default',.1,'help','Tolerance for interation');
        pout=p(1:5);
        
    case 'sls'
        %
        %   max_its: 20 (iterations)
        %   threshold: 0 (normalized mean squared error).
        %   accel:  0.8  (ridge is multiplied by 0.8 following a successful update).
        %   decel:  2    (ridge is multiplied by 2 following a failed update).
        %   delta:  10   (initial size of the ridge added to the Hessian)
        %   display: 1   (binary, display intermediate results)
        
        tp_defaults = [20 0 0.8 2 10 0]';
        
        p(5)=param('name','max_its','default',20,'help','Maximum number of iterations');
        p(6)=param('name','error_threshold','default',.01,'help','NMSE for success');
        p(7)=param('name','accel','default',.8,'help','ridge multiplied by accell after successful update');
        p(8)=param('name','decel','default',2,'help','ridge multipled bu devel after successful update');
        p(9)=param('name','delta','default',10,'help','initial size of ridge added to Hessian');
        pout=p;
        
        
    otherwise
        error (['Method:' method ' not defined for nlbl objects']);
end
NLout=NLin;
set(NLout,'parameters',pout);


