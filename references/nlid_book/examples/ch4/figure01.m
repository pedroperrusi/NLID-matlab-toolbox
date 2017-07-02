function figure01(figno)
% function to draw LNL cascade model of the 
% auditory processing example system.
%
% Note:  version in text used xfig to draw block diagram.


figure(1);
clf;


fiber = PeripheralAuditoryModel(100);

elements = get(fiber,'Elements');
h = elements{1};
g = elements{3};
mt = elements{2};

tauticks = ['  0';'0.5';'1.0';'1.5'];



subplot(231)
plot(h);
set(gca,'fontsize',12,'xlim',[0 0.0015],'xtick',[0:0.0005:0.0015],...
    'xticklabel',tauticks,'ytick',[0:200:400]);
hold on
plot([0 0.0015],[0 0],'k:');
hold off
title('1^{st} Linear IRF');
xlabel('Lag (ms)');
ylabel('Amplitude');
pos = get(gca,'position');
pos(1) = pos(1) - 0.03;
set(gca,'position',pos);


subplot(232)
plot(mt)
set(gca,'fontsize',12,'xlim',[-0.25 0.25],'ytick',[0:20:40]);
hold on
plot([-0.25 0.25],[0 0],'k:');
plot([0 0],[-10 40],'k:');
hold off
title('Static Nonlinearity');
xlabel('Input');
ylabel('Output');


subplot(233)
plot(g);
set(gca,'fontsize',12,'xlim',[0 0.0015],'xtick',[0:0.0005:0.0015],...
    'xticklabel',tauticks,'ytick',[0:200:400]);
hold on
plot([0 0.0015],[0 0],'k:');
hold off
title('2^{nd} Linear IRF');
xlabel('Lag (ms)');
ylabel('Amplitude');
pos = get(gca,'position');
pos(1) = pos(1) + 0.03;
set(gca,'position',pos);







