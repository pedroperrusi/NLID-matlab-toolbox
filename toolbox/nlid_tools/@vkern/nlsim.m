function y = nlsim ( vk, u )
% Simulate response of one Volterra kernel to an input signal
% input options not fill defined as yet

% Copyright 1999-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt

order =get_nl(vk,'order');
k=get_nl(vk,'data');
Ts=get_nl(vk,'domainincr');
ud=double(u);
y=nldat(u);
yd = vkfilt(k,ud,order)*Ts^order;
set(y,'Data',yd);
return


% ... vkern/nlsim
