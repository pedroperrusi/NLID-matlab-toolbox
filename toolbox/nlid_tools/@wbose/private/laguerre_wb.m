function wb = laguerre_wb (wb,uz)
%  Laguerre based identification of Wiener-Bose model.

% Copyright 2000-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../../copying.txt and ../../gpl.txt 

Qmax = get(wb,'OrderMax');
hlen = get(wb,'NLags');
alpha = get(wb,'alpha');
num_filt = get(wb,'NumFilt');

Ts = get(uz,'domainincr');

u = double(uz(:,1));
y = double(uz(:,2));


% set any missing parameters
if isnan(num_filt)
  if isnan(alpha)
    num_filt = ceil(hlen/4);
  else
    num_filt = num_filters(hlen,alpha);
  end
  set(vs,'NumFilt',num_filt);
end

if isnan(alpha)
  alpha = ch_alpha(hlen,num_filt);
  set(vs,'alpha',alpha);
end

u_basis = laguerre_basis(u,num_filt,alpha);

elements = get(wb,'elements');
bank = elements{1};
static = elements{2};
set(static,'OrderMax',Qmax,'NInputs',num_filt);
static = nlident(static,[u_basis y]);

impulse = [1;zeros(hlen-1,1)];
basis = laguerre_basis(impulse,num_filt,alpha);

filt = bank{1};
set(filt, 'domianincr',Ts);
for i = 1:num_filt
  set(filt,'data',basis(:,i));
  bank{i} = filt;
end

elements = {bank static};






set(vs,'elements',elements);
set(vs,'comment','Identified using Laguerre Expansion');

function basis = laguerre_basis(x,num_filt,alpha)

data_len = length(x);
x = x(:);
basis = zeros(data_len,num_filt);
alpha_srt = sqrt(alpha);
laga = [alpha_srt,-1];
lagb = [1, -alpha_srt];

basis(:,1) = filter(sqrt(1-alpha),[1, -alpha_srt],x);
for i = 2:num_filt
  basis(:,i) = filter(laga,lagb,basis(:,i-1));
end


function nfilt = num_filters(hlen,alpha)

imp = [1;zeros(2*hlen,1)];
basis = laguerre_basis(imp,hlen,alpha);

searching = 1;
nfilt = 1;

while searching
  idx = max(find(abs(basis(:,nfilt))>0.01));
  if idx > hlen-1
    searching = 0;
    nfilt = nfilt -1;
  else
    nfilt = nfilt + 1;
  end
end

%test = abs(basis(end,:));
%nfilt = max(find(test<0.01));


function alpha = ch_alpha(hlen,num_filt);

alpha = 0.5;
ntest = num_filters(hlen,alpha);
step = 0.25;
if ntest == num_filt
  searching = 0;
else
  searching = 1;
end

while searching
  if ntest < num_filt
    alpha = alpha - step;
  else
    alpha = alpha + step;
  end
  ntest = num_filters(hlen,alpha);
  if ntest == num_filt
    searching = 0;
  else
    step = step/2;
  end
end

  