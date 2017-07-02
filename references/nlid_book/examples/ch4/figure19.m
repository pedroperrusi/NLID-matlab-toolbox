function figure19(figno)
%  Generating the first and second order Volterra kernels of the first 1, 2
%  and 3 paths in a parallel casacde representation of the 
%  Peripheral Auditory Processing model,  see figure 4-19 in:
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%
% Calling figure19, or figure19(1) uses the default NLID toolbox plot
% routines. figure18(2) uses MATLAB handle graphics to dress things up a
% bit.


if nargin == 0
  figno = 1;
end



figure(1);
clf;


fiber = PeripheralAuditoryModel(100);
hlen = 16;

% sampling frequency of 10,000 Hz gives a center frequency of about 1160 Hz.
fs = 10000; 
Ts = 1/fs;

tau = [0:hlen-1]'*Ts;


num_paths = 3;
pc_model = lnl2pc(fiber,hlen,num_paths,'kernel2');
pc_elements = get(pc_model,'elements');
pc_order = get(pc_model,'OrderMax');
pc_H = zeros(hlen,num_paths);
pc_M = zeros(pc_order+1,num_paths);

for i = 1:num_paths
  pc_H(:,i) = get(pc_elements{i,1},'Data');
  pc_M(:,i) = get(pc_elements{i,2},'Coef');
end


tau2 = tau(1:11);

% volterra series for first path alone

pc_trunc = pc_model;
pct_elements = {pc_elements{1,1} pc_elements{1,2}};
set(pc_trunc,'NPaths',1,'elements',pct_elements);
vs1 = vseries(pc_trunc,'ordermax',2,'nlags',16);
set(vs1,'comment','Kernels of First Wiener Path');

% volterra series for first two paths
pct_elements = {pc_elements{1,1} pc_elements{1,2};...
                pc_elements{2,1} pc_elements{2,2}};
set(pc_trunc,'NPaths',2,'elements',pct_elements)
vs2 = vseries(pc_trunc,'ordermax',2,'nlags',16);
set(vs2,'comment','Kernels of First Two Wiener Paths');


% volterra series for first three paths
pct_elements = {pc_elements{1,1} pc_elements{1,2};...
                pc_elements{2,1} pc_elements{2,2};...
		pc_elements{3,1} pc_elements{3,2}};
set(pc_trunc,'NPaths',3,'elements',pct_elements)
vs3 = vseries(pc_trunc,'ordermax',2,'nlags',16);
set(vs3,'comment','Kernels of First Two Wiener Paths');

% volterra series for LNL model
vs4 = vseries(fiber,'ordermax',2,'nlags',16);



switch figno
  case 1
    figure(1)
    plot(vs1)

    figure(2)
    plot(vs2)

    figure(3)
    plot(vs3)

    figure(4)
    plot(vs4)
  case 2
    close all
    figure(1)
    
    yticks1 = [0 1000];
    tauticks = [0:0.5:1.5]*1e-3;
    taulabels = [' 0 ';'   ';'   ';'1.5'];
    tau2ticks = [0:0.5:1]*1e-3;
    tau2labels = ['0';' ';'1'];
    zlimits = [-2 4]*1e6;

    
    
    kernels = get(vs1,'elements');
    vk1 = kernels{2};
    vk2 = kernel_truncate(kernels{3},11);
 

    
        
    subplot(321)
    vh1 = plot(vk1);
    
    set(vh1,'color','k');
    set(gca,'fontsize',12,'ylim',[-500 1000],'ytick',yticks1,...
	'xtick',tauticks,'xticklabel',taulabels);
    ylabel('Amplitude');
    xlabel(' ');
    title('First Path Alone');
    
    subplot(322)
    plot(vk2);
    set(gca,'fontsize',12,'xtick',tau2ticks,'xticklabel',tau2labels,...
	'ytick',tau2ticks,'yticklabel',tau2labels,'zlim',zlimits);
    xlabel(' '); ylabel(' ');zlabel(' ');
    
    
    colormap bone
    caxis([-12 8]*1e7);
    view([60 25]);
    shading faceted
    
    kernels = get(vs2,'elements');
    vk1 = kernels{2};
    vk2 = kernel_truncate(kernels{3},11);

    
        
    subplot(323)
    vh1 = plot(vk1);
    
    set(vh1,'color','k');
    set(gca,'fontsize',12,'ylim',[-500 1000],'ytick',yticks1,...
	'xtick',tauticks,'xticklabel',taulabels);
    ylabel('Amplitude');
    xlabel(' ');
    title('First Two Paths');
    
    subplot(324)
    plot(vk2);
    set(gca,'fontsize',12,'xtick',tau2ticks,'xticklabel',tau2labels,...
	'ytick',tau2ticks,'yticklabel',tau2labels,'zlim',zlimits);
    
    xlabel(' '); ylabel(' ');zlabel(' ');
    colormap bone
    caxis([-12 8]*1e7);
    view([60 25]);
    shading faceted

    
        
    kernels = get(vs3,'elements');
    vk1 = kernels{2};
    vk2 = kernel_truncate(kernels{3},11);

    
        
    subplot(325)
    vh1 = plot(vk1);
    
    set(vh1,'color','k');
    set(gca,'fontsize',12,'ylim',[-500 1000],'ytick',yticks1,...
	'xtick',tauticks,'xticklabel',taulabels);
    ylabel('Amplitude');
    xlabel('lag (ms)');
    title('First Three Paths');
    
    subplot(326)
    plot(vk2);
    set(gca,'fontsize',12,'xtick',tau2ticks,'xticklabel',tau2labels,...
	'ytick',tau2ticks,'yticklabel',tau2labels,'zlim',zlimits);
    
    xlabel('lag (ms)'); ylabel('lag (ms)');zlabel(' ');
    colormap bone
    caxis([-12 8]*1e7);
    view([60 25]);
    shading faceted

    
end

return


function k2 = kernel_truncate(k1,hlen);

k2 = k1;
kern = get(k2,'data');
kern = kern(1:hlen,1:hlen);
set(k2,'data',kern);



return













