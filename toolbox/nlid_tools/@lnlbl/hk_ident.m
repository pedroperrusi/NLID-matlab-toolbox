function m0 = hk_ident(m0,uy);
% Identification of LNL cascade using the Hunter-Korenberg
% iterative cross-correlation method.
%
% See:  M.J. Korenberg and I.W. Hunter, The identification of nonlinear 
%      biological systems: LNL cascade models.
%      Biological Cybernetics, 55:125-134, 1986.
%
% syntax  m0 = hk_ident(m0,uy);
%   TP = [num_svs, accel, decel, NumIts1,NumIts2]; 
% 
% num_svs: number of svs used in computation of initial IRF
%               if num_svs == 0, then start from m0


% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 



% get data
u = uy(:,1);
y = uy(:,2);


%1 extract objects
blocks = get(m0,'elements');
h = blocks{1};
m = blocks{2};
g = blocks{3};



accel = get(m0,'accel');
decel = get(m0,'decel');
NumIts2 = get(m0,'InnerLoop');
NumIts1 = get(m0,'MaxIts');
step_size = get(m0,'step');

mh = nlbl;
set(mh,'elements',{m g});

Ts = get(u,'DomainIncr');

N = length(double(u));
hlen = length(double(h));


testout = nlsim(m0,u);
err = y - testout;
vf = double(vaf(y,testout));
old_vaf = vf;
vafs = vf


new_h = h;
new_m = m0;


for i = 1:NumIts1
  a_count = 0;
  for j = 1:NumIts2
    stuff = get(m0,'elements');
    h = stuff{1}; m = stuff{2}; g = stuff{3};
    delta = LMStep(u,err,m0,step_size);
    set(new_h,'data', double(h) + delta);
    set(new_m,'elements',{new_h m g});
    testout = nlsim(new_m,u);
    vf = double(vaf(y,testout));
    if vf > old_vaf
      old_vaf = vf;
      err = y - testout;
      m0 = NormalizeLNL(new_m);
      step_size = accel*step_size;
      a_count = a_count + 1;
%      disp('accelerating');
    else  
      step_size = decel*step_size;
%      disp('decelerating');
    end
  end
  plot(m0); drawnow;
  disp([num2str(a_count) ' accelerations']);
  if a_count > 0
    [new_m,new_err,vf] = BestHammer (m0,uy);
    a_count = 0;
    disp(vf-old_vaf)
    if vf > old_vaf
      old_vaf = vf;
      m0 = new_m;
      err = new_err;
      disp('Hammerstein Updated');
%      step_size = 100*step_size;
    else
      disp('No Improvement in Hammerstein Fit');
    end
  end  
  vafs(i+1) = old_vaf;
  disp(old_vaf);
end


function [m0,h] = NormalizeLNL(m0);


blocks = get(m0,'elements');
h = blocks{1};
m = blocks{2};
g = blocks{3};

hh = double(h);
gain = std(hh);
set(h,'data',hh/gain);

range = get(m,'Range');
set(m,'Range',range/gain);

gg = double(g);
gain = std(gg);
set(g,'data',gg/gain);

coeffs = get(m,'coef');
coeffs = coeffs*gain;
set(m,'coef',coeffs);

set(m0,'elements',{h m g});







function delta = LMStep(u,err,m0,step_size);

N = length(double(u));
Ts = get(u,'DomainIncr');
stuff = get(m0,'elements');
h = stuff{1};
hlen = length(h);

m = stuff{2};
mdot = ddx(m);
xx = double(nlsim(mdot,nlsim(h,u)));
g = stuff{3};  


X = zeros(N,hlen);
ud = double(u);
for i = 1:hlen
    temp = nldat(ud.*xx,'DomainIncr',Ts);
    X(:,i) = Ts*double(nlsim(g,temp));
    ud = [0;ud(1:N-1)];
  end

  
%delta = inv(X'*X + step_size*eye(hlen))*X'*double(err);
delta = [X;sqrt(step_size)*eye(hlen)]\[double(err);zeros(hlen,1)];



function X = FDJacobian(u,m0)

N = length(double(u));
Ts = get(u,'DomainIncr');
stuff = get(m0,'elements');
h = stuff{1};
hlen = length(h);

m = stuff{2};
g = stuff{3};

X = zeros(N,hlen);
y = nlsim(m0,u);
yd = y;
md = m0;
hd = h;


for i = 1:hlen
  hh = double(h);
  delta = 0.001*hh(i);
  hh(i) = hh(i) + delta;
  set(hd,'data',hh);
  set(md,'elements',{hd m g});
  yd = nlsim(md,u);
  X(:,i) = double(yd - y)/delta;
end



