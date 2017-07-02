function figure4

%  function to generate figure showing a transfer function (Bode diagram)
%  representation of the ankle compliance model used  as the running example
%  in chapter 3. 
%
%  This shows how figure 3-4 in 
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003
%
%  can be generated using the operators in the control systems toolbox. 
%

figure(1)
clf;

Hs = ExampleSystem;

[Mag,Phase,Omega] = bode(Hs);
Mag = 20*log10(squeeze(Mag));
Phase = squeeze(Phase);
f = Omega / (2*pi);

subplot(211)
semilogx(f,Mag);
set(gca,'ylim',[-80 -40],'ytick',[-80 -60 -40]);
title('Transfer Function Magnitude |H(j\omega)|');
ylabel('Gain (dB)');

subplot(212)
semilogx(f,Phase);
set(gca,'ylim',[0 180],'ytick',[0 90 180]);
title('Transfer Function Phase \phi(H(j\omega))');
ylabel('Phase (degrees)');
xlabel('Frequency (Hz)');



