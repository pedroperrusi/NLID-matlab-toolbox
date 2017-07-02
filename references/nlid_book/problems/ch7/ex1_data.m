function uz = ex1_data(N,cutoff,dB);

if nargin == 0
  N = 10000;
end

if nargin < 2
  cutoff = 1;
end

if nargin < 3
  noisefree = 1;
else
  noisefree = 0;
end

load ear_model;
stuff = get(ear_model,'elements');
Ts = get(stuff{1},'domainincr');

u = randn(N,1);
if cutoff < 1
  [b,a] = butter(2,cutoff);
  u = filter(b,a,u);
end
u = nldat(u,'domainincr',Ts);

y = nlsim(ear_model,u);

if noisefree
  z = y;
else
  n = randn(N,1);
  n = n * double(std(y))/(std(n)*10^(dB/20));
  n = nldat(n,'domainincr',Ts);
  z = y + n;
end


uz = cat(2,u,z);
