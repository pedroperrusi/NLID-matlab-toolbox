function WB = wbose (z, varargin)
% Wiener Bose Model
%  Parent: nlm


% Copyright 1999-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

WB=mkwb;


if nargin==0;
    return
elseif nargin==1,
    WB=nlmkobj(WB,z);
else
    args=varargin;
    WB=nlmkobj(WB,z,args);
end


function wb =mkwb;
% Structure of WeinerBose modelseries
N=nlm;
wb.ObjType='wbose';
bank = cell(1,1);
filt = irf;
bank{1} = filt;
mpol = polynom;
elements = {bank mpol};
set(N,'elements',elements);
wb=class(wb,'wbose',N);
set(wb,'Method','laguerre');
wb=pdefault(wb);


return




% .../@wbose/wbose


