function kernels = lag_std (covar);
%  Estimates the  standard deviation of Laguerre expansion kernel
%  estimates.   


stuff = get(covar,'elements');
vs = stuff{1};
S = stuff{2};
NumPar = size(S,1);

nlags = get(vs,'nlags');
Qmax = get(vs,'ordermax');
NumFilt = get(vs,'NumFilt');
alpha = get(vs,'alpha');
delay = get(vs,'delay');
kernels = get(vs,'elements');
Ts = get(kernels{1},'domainincr');

vk = vkern;
set(vk,'nlags',nlags,'domainincr',Ts);



imp = [1;zeros(nlags-1,1)];
basis = laguerre_basis(imp,NumFilt,alpha,delay);



% zero-order kernel
vk0 = vk;
set(vk0,'order',0,'data',sqrt(S(1,1)));
kernels{1} = vk0;

% first order kernel
if Qmax > 0
  hvar = zeros(nlags,1);
  dhdc = zeros(NumPar,1);
  for tau = 1:nlags
    dhdc(2:NumFilt+1) = basis(tau,:)';
    hvar(tau) = dhdc'*S*dhdc;
  end
  vk1 = vk;
  set(vk1,'order',1,'data',sqrt(hvar)/Ts);
  kernels{2} = vk1;
end

% second order kernel 
if Qmax > 1
  h2var = zeros(nlags,nlags);
  dhdc = zeros(NumPar,1);
  for t1 = 1:nlags
    for t2 = t1:nlags
      offset = NumFilt+1;
      for i = 1:NumFilt
        offset = offset + 1;
        dhdc(offset) = basis(t1,i)*basis(t2,i);
        for j = i+1:NumFilt
	  offset = offset + 1;
	  dhdc(offset) = (basis(t1,i)*basis(t2,j) + basis(t1,j)*basis(t2,i))/2;
        end
      end
      h2var(t1,t2) = dhdc'*S*dhdc;
      h2var(t2,t1) = h2var(t1,t2);
    end
  end
  vk2 = vk;
  set(vk2,'order',2,'data',sqrt(h2var)/Ts^2);
  kernels{3} = vk2;
end

% third order kernel
if Qmax > 2
  h3var = zeros(nlags^3,1);
  dhdc = zeros(NumPar,1);
  for t1 = 1:nlags
    for t2 = t1:nlags
      for t3 = t2:nlags
	offset =  prod([NumFilt+1:NumFilt+2])/prod(1:2);
	for i = 1:NumFilt
	  for j = i:NumFilt
	    for k = j:NumFilt
	      offset = offset + 1;
	      dhdc(offset) = basis(t1,i)*basis(t2,j)*basis(t3,k) + ...
		basis(t1,i)*basis(t2,k)*basis(t3,j) + ...
		basis(t1,j)*basis(t2,i)*basis(t3,k) + ...
		basis(t1,j)*basis(t2,k)*basis(t3,i) + ...
		basis(t1,k)*basis(t2,i)*basis(t3,j) + ...
		basis(t1,k)*basis(t2,j)*basis(t3,i);
	    end
	  end
	end
	dhdc = dhdc/6;
	var3 = dhdc'*S*dhdc;
	h3var((t1-1)*nlags^2 + (t2-1)*nlags + t3) = var3;  
	h3var((t1-1)*nlags^2 + (t3-1)*nlags + t2) = var3;
	h3var((t2-1)*nlags^2 + (t1-1)*nlags + t3) = var3;
	h3var((t2-1)*nlags^2 + (t3-1)*nlags + t1) = var3;
	h3var((t3-1)*nlags^2 + (t2-1)*nlags + t1) = var3;
	h3var((t3-1)*nlags^2 + (t1-1)*nlags + t2) = var3;
      end
    end
  end
  h3std = reshape(sqrt(h3var),nlags,nlags,nlags);
  vk3 = vk;
  set(vk3,'order',3,'data',h3std/Ts^3);
  kernels{4} = vk3;
end
   
 
function basis = laguerre_basis(x,num_filt,alpha,delay)

data_len = length(x);
x = x(:);
x = [zeros(delay,1);x(1:data_len - delay)];
basis = zeros(data_len,num_filt);
alpha_srt = sqrt(alpha);
laga = [alpha_srt,-1];
lagb = [1, -alpha_srt];

basis(:,1) = filter(sqrt(1-alpha),[1, -alpha_srt],x);
for i = 2:num_filt
  basis(:,i) = filter(laga,lagb,basis(:,i-1));
end

