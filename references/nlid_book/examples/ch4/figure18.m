function figure18(figno)
%  Generating the first 3 paths in a parallel casacde representation of the 
%  Peripheral Auditory Processing model,  see figure 4-18 in:
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%
% Calling figure18, or figure18(1) uses the default NLID toolbox plot
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
% front end for the transformation from lnl to pcascade has not yet
% implemented.  Call the operator directly. 
pc_model = lnl2pc(fiber,hlen,num_paths,'kernel2');


switch figno
  case 1
    plot(pc_model);
  case 2
    

    pc_elements = get(pc_model,'elements');
    pc_order = get(pc_model,'OrderMax');
    pc_H = zeros(hlen,num_paths);
    pc_M = zeros(pc_order+1,num_paths);

    for i = 1:num_paths
      pc_H(:,i) = get(pc_elements{i,1},'Data');
      pc_M(:,i) = get(pc_elements{i,2},'Coef');
    end

    tauticks = [0:5:15]*1e-4;
    taulabels = [' 0 ';'0.5';' 1 ';'1.5'];

    
    subplot(321)
    plot(tau,pc_H(:,1),'k');
    set(gca,'xlim',[tau(1) tau(hlen)],'xtick',tauticks,...
	'xticklabel',taulabels,'fontsize',12);
    title('Linear Filters');
    ax1ylab = ylabel('Amplitude');


    subplot(322)
    plot(pc_elements{1,2});
    kids = get(gca,'children');
    set(kids,'color','k');
    set(gca,'ylim',[-0.15 1.5],'fontsize',12);
    title('Nonlinearities');
    ax2ylab = ylabel('Output');

    
    subplot(323)
    plot(tau,pc_H(:,2),'k');
    set(gca,'xlim',[tau(1) tau(hlen)],'xtick',tauticks,...
	'xticklabel',taulabels,'fontsize',12);
    ax3ylab = ylabel('Amplitude');


    subplot(324)
    plot(pc_elements{2,2});
    kids = get(gca,'children');
    set(kids,'color','k');
    set(gca,'ylim',[-0.5 0.05],'fontsize',12);
    ax4ylab = ylabel('Output');




    
    
    subplot(325)
    plot(tau,pc_H(:,3),'k');
    set(gca,'xlim',[tau(1) tau(hlen)],'xtick',tauticks,...
	'xticklabel',taulabels,'fontsize',12);
    xlabel('Lag (ms)');
    ax5ylab = ylabel('Amplitude');
    pos = get(ax1ylab,'position');
    pos2 = get(ax5ylab,'position');
    pos2(1) = pos(1);
    set(ax5ylab,'position',pos2);


    subplot(326)
    plot(pc_elements{3,2});
    kids = get(gca,'children');
    set(kids,'color','k');
    set(gca,'ylim',[-0.22 0.02],'fontsize',12);
    xlabel('Input');
    ylabel('Output')

    pos = get(ax2ylab,'position');
    pos2 = get(ax4ylab,'position');
    pos(1) = pos2(1);
    set(ax2ylab,'position',pos);

end



%nlid_style;

