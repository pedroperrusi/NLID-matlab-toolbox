function figure4(dataset,snro);
% function to produce figure showing unrefined IRF estimates of the
% ankle model use as a running example throughout chapter 5 of
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%
% Note Figure 5-4 shows all of the IRF estimates together.  This
% m-file pesents them individually, using only the basic plot command
% for IRF objects, as provided by the NLID toolbox. 
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
  snro = nan;
  if nargin < 1
    dataset = 1;
  end
end

iodata = ExampleData(dataset,snro);

h = irf(iodata,'nlags',50);
plot(h);
