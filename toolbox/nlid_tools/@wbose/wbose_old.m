function wb = wbose (z, varargin)
% CONSTRUCT an Wiener-Bose  object
%
% Setup default values

% Copyright 1999-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

disp('wbose - V01.01')
%
% Structure of wbose
%
wb.Hd = nlhd;
wb.Basis = irf;
wb.Coef = [];
wb.Order = NaN;
if nargin== 0,
   wb=class(wb,'wbose');;
   return
end
options= arg_options('wbose');
%
if isstr(z),
  arg_help('wbose',options);
  return
elseif isa (z,'wbose');
   wb=z;
else
   % Parse options
   arg_parse( options, varargin );
if isnan(alpha),
   alpha = ch_alpha(maxorder,numlags);
end
zd=double(z);
u=zd(:,1);
y=zd(:,2);
%
% Estimate model
%
impulse = [1;zeros(numlags-1,1)];
basis = laguerre(impulse,numfilt,alpha,1);
u_basis = laguerre(u,numfilt,alpha,1);
X = multi_herm(u_basis,maxorder);
coeff = X\y;
ib=wb.Basis;
set(ib,'Filter',basis);
set(ib,'NSides',1);
set(ib,'Ts',get(z,'DomainIncr'));
for i=1:numfilt+1,
   cn{i} = [ 'Lagurree Basis function # ' int2str(i)];
end
wb.Basis=ib;
wb.Order=maxorder;
wb.Coef=coeff;
wb=class(wb,'wbose');
wb=set(wb,'Nlhd',get(z,'Nlhd'));
wb=set(wb,'Comment','Weiner-Bose model');
end
