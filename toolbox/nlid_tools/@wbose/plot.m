function plot ( wb )
% plot function for wbose objects

% Copyright 1999-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

clf;

stuff = get(wb,'elements');
bank = stuff{1};
mpol = stuff{2};
NF = get(mpol,'NInputs');

for i = 1:NF
  subplot(NF,2,2*i-1);
  plot(bank{i});
end

if NF < 3
  subplot(1,2,2);
  plot(mpol);
else
  warning ('nonolinearity has too many inputs to plot');
end

   
return


