function [exp, theory] = exercise2(N,q,sigma_x);
% exercise2 chapter 2

if nargin < 3
  sigma_x = 0.5;
  if nargin < 2
    q = 4;
    if nargin < 1 
      N = 1000;
    end
  end  
end

if ((q/2)- fix(q/2)) > 0.1
  error('q must be even');
end


x= nldat(randv('sd',sigma_x,'domainincr',1,'domainmax',N-1));

exp = mean(double(x).^q)

gain = 1;
for i = 1:2:q-1
  gain = gain * i;
end

theory = gain*sigma_x^q


