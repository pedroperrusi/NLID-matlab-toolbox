function figure5(figno)

% file to generate figures showing the relationship between the 0 through
% 6'th order terms in  a power series, a Hermite polynomial and a Tchebyshev
% polynomial 
%
%  This shows how figure 2-5 in 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003
%
%  can be generated using the operators in the NLID toolbox.  In this
%  example, the fiddly formatting has been included in the body of the
%  function. 


figure(1);
clf;


mpwr = polynom;
set(mpwr,'type','power','order',5','coef',[1 0 0 0 0 0]',...
    'range',[-10; 10]);

mherm = polynom;
set(mherm,'type','hermite','order',5','coef',[1 0 0 0 0 0]',...
    'mean',0,'std',1,'range',[-3; 3]);
mtcheb = polynom;
set(mtcheb,'type','tcheb','order',5','coef',[1 0 0 0 0 0]',...
    'range',[-1; 1]);

powerticks = {['0';'1';'2'],['-10';'  0';' 10'],['  0';' 50';'100'],...
              ['-1K';'  0';' 1K'],['  0';' 5K';'10K'],...
	      ['-100K';'    0';' 100K']};
	      




for i = 1:6
  coeff = zeros(6,1);
  coeff(i) = 1;
  set(mpwr,'coef',coeff);
  set(mherm,'coef',coeff);
  set(mtcheb,'coef',coeff);
  
  offset = 3*(i-1);
  
  
  subplot(6,3,offset+1)
  plot(mpwr)
  set(gca,'fontsize',12,'xlim',[-10 10],'xtick',[-10:10:10]);
  if i < 6
    set(gca,'xticklabel',[]);
    if i == 1
      title('Power');
    end    
  end
  set(gca,'yticklabel',powerticks{i});

  subplot(6,3,offset+2)
  plot(mherm)
  set(gca,'fontsize',12,'xlim',[-3 3],'xtick',[-3:3:3]);
  if i < 6
    set(gca,'xticklabel',[]);
    if i == 1
      title('Hermite');
    end    
  end

  
  
  subplot(6,3,offset+3)
  plot(mtcheb)
  set(gca,'fontsize',12,'xlim',[-1 1],'xtick',[-1:1:1],...
      'ylim',[-1.1 1.1],'ytick',[-1:1:1]);
    if i < 6
    set(gca,'xticklabel',[]);
    if i == 1
      title('Tchebyshev');
    end    
  end

  
  
  str = ['Order ' num2str(i-1)];
  text(1.25,0,str,'rotation',-90,'horizontalalignment','center',...
	'fontsize',12);
  
end




