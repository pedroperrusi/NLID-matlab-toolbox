function figure6(dataset,snro);
% function to produce figure showing pseudo-inverse based IRF estimates 
% of the ankle model use as a running example throughout chapter 5 of
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
% 
% syntax:  figure4(datatset,snro);
%
% dataset  = [1], white noise
%             2, anti-alias filtering
%             3, low-pass filtered input, and anti-alias filtering.
% 
% snro     [nan], no output noise
%            dB, snr in dB (examples in text used 10 dB).



if nargin < 2
  snro = 10;
  if nargin < 1
    dataset = 3;
  end
end


idealdata = ExampleData(1,nan);
hideal = irf(idealdata,'nlags',50);
hihandle = plot(hideal);
hold on



iodata = ExampleData(dataset,snro);

h = irf(iodata,'nlags',50,'mode','auto');
hhandle = plot(h);
hold off

kids = get(gca,'children');
set(hhandle,'color','m','linewidth',2);
set(hihandle,'color','b','linewidth',2);
set(gca,'fontsize',12);
legend('Estimate','Model',4);