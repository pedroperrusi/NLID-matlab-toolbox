function bounds = cbounds(covar)
% produces standard deviation for the model stored in covar

stuff = get(covar,'elements');

model = stuff{1};
covmat = stuff{2};
bounds = model;


if isa(model,'polynom')
  set(bounds,'coef',sqrt(diag(covmat)),'comment',...
      'standard deviation of polynomial coefficients');
elseif isa(model,'irf')
  Ts = get(model,'domainincr');
  set(bounds,'data',sqrt(diag(covmat))/Ts,'comment',...
      'standard deviation of filter weights');
elseif isa(model,'vseries')
  method = get(model,'method');
  kernels = get(bounds,'elements');
  vk = kernels{1};
  Ts = get(vk,'domainincr');

  order = get(bounds,'OrderMax');
  nlags = get(bounds,'nlags');
  switch lower(method)
    case 'foa'
      Astd = sqrt(diag(covmat));
      set(vk,'data',Astd(1));
      kernels{1} = vk;
      if order > 0
	vk = kernels{2};
	set(vk,'data',Astd(2:nlags+1)/Ts);
	kernels{2} = vk;
	if order > 1
	  kern2 = zeros(nlags,nlags);
	  offset = nlags+1;
	  for i = 1:nlags
	    for j = i:nlags
	      offset = offset + 1;
	      kern2(i,j) = Astd(offset)/2;
	    end
	  end
	  kern2 = kern2 + kern2';
	  vk = kernels{3};
	  set(vk,'data',kern2/Ts^2);
	  kernels{3} = vk;
	end
      end
      
      
    case 'laguerre'
      kernels = lag_std(covar);
  end
  set(bounds,'elements',kernels,'comment','standard deviation estimate');
end
