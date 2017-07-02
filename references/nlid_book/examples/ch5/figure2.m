function figure2(dataset,snro);
% function to produce figure showing time domain records of the 3 datasets 
% used to identify ankle model use as a running example throughout chapter 5
% of
%
%  Westwick and Kearney, Identification of Nonlinear Physiological Systems,
%  IEEE Press/John Wiley & Sons, 2003  
%
% Note Figure 5-2 shows all of the noise-free datasets together.  This
% m-file pesents them individually, using only the basic plot command
% for NLDAT objects, as provided by the NLID toolbox. 
% 
% syntax:  figure2(datatset,snro);
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

figure(1)
clf
plot(iodata);
