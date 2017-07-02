function plot(covar)
% overloaded plot method for objects in class nlmcov

stuff = get(covar,'elements');
model = stuff{1};

if isa(model,'vseries')
  bounds = get(cbounds(covar),'elements');
  kernels = get(model,'elements');
  order = length(kernels)-1;
  switch order
    case 0
      nv = 1; nh = 1;
    case 1
      nv = 2; nh = 1;
    otherwise
      nv = order; nh = 2;
  end
  % zero order kernel and bounds
  subplot(nv,nh,1)
  val = double(kernels{1});
  sdev = double(bounds{1});
  upper = val + 3*sdev;
  lower = val - 3*sdev;
  stem(val,'filled');
  set(gca,'xlim',[0 2]);
  hold on
  plot([0.9 1.1],lower*[1 1],'b-');
  plot([0.9 1.1],upper*[1 1],'b-');
  if val > 0
    plot([1 1],[val upper],'b:');
  else
    plot([1 1],[val lower],'b:');
  end  
  hold off
  legend('k^{(0)}','3\sigma bnd');
  ylabel('zero-order kernel');
  title('kernel and bounds')
  
  if order > 0
    subplot(nv,nh,2);
    k1 = kernels{2};
    val = double(k1);
    sdev = double(bounds{2});
    upper = val + 3*sdev;
    lower = val - 3*sdev;
    
    nlags = get(k1,'nlags');
    Ts = get(k1,'domainincr');
    tau = [0:nlags-1]'*Ts;
    
    handles = plot(tau,[val upper lower]);
    set(handles(1),'color','b','linestyle','-');
    set(handles(2),'color','b','linestyle',':');
    set(handles(3),'color','b','linestyle',':');    
    legend('k^{(1)}','3\sigma bound');
    ylabel('first-order kernel');
    xlabel('lag (sec)');
    title('kernel and bounds')
  end
  
  if order> 1
    subplot(nv,2,3);
    plot(kernels{3});
    title('kernel estimate');
    subplot(nv,2,4)
    plot(bounds{3});
    title('standard deviation');
  end
  
  if order >2
    subplot(nv,2,5);
    plot(kernels{4});
    title('kernel estimate');
    subplot(nv,2,6)
    plot(bounds{4});
    title('standard deviation');
  end
  
  
  
  
elseif isa(model,'polynom')
  nin=get(model,'NInputs');
  range=get(model,'Range');
  if isnan(range);
    umean = get(model,'mean');
    ustd = get(model,'std');
    if isnan(umean+ustd)
      range=[-1 1];
    else
      range=[umean-3*ustd umean+3*ustd];
    end  
  end

  if nin==1,
    x=linspace(range(1),range(2))';
    y=double(nlsim(covar,x));
    ym = y(:,1);
    ystd = y(:,2);
    lower = ym - 3*ystd;
    upper = ym + 3*ystd;
    handles = plot (x,[ym lower upper]);
    set(handles(2),'linestyle','--','color','b');
    set(handles(3),'linestyle','--','color','b');   
    title('  ');
    xlabel('input');
    ylabel('output');
  elseif nin==2,
    x=linspace(range(1,1), range(2,1))';
    y=linspace(range(1,2), range(2,2))';
    [X,Y]=meshgrid(x,y);
    Z=cat(2,X(:),Y(:));
    zp=nlsim(covar,Z);
    z=double(zp);
    zm=reshape (z(:,1),length(x),length(y));
    zstd = reshape (z(:,2),length(x),length(y));
    subplot(121)
    mesh (x,y,zm);
    title('polynomial estimate');
    subplot(122)
    mesh(x,y,zstd);
    title('standard deviation');
  else
    error('plotting not available for polynominal with > 2 inputs');
  end

elseif isa(model,'irf')  
  bounds = get(cbounds(covar),'data');
  val = double(model);
  sdev = double(bounds);
  upper = val + 3*sdev;
  lower = val - 3*sdev;
    
  nlags = get(model,'nlags');
  Ts = get(model,'domainincr');
  tau = [0:nlags-1]'*Ts;
    
  handles = plot(tau,[val upper lower]);
  set(handles(1),'color','b','linestyle','-');
  set(handles(2),'color','b','linestyle',':');
  set(handles(3),'color','b','linestyle',':');    
  legend('h(\tau)','3\sigma bound');
  ylabel('impulse response');
  xlabel('lag (sec)');
  title('impulse response and bounds')

  
  
end
