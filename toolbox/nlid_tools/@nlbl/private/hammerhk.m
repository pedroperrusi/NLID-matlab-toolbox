function nlout = hammerhk ( z, nl, p );
% Identification of Hammerstein cascade using the Hunter-Korenberg
% iterative cross-correlation method.
%
% See: I.W. Hunter and M.J. Korenberg, The identification of nonlinear 
%      biological systems: Wiener and Hammerstein cascade models.
%      Biological Cybernetics, 55:135-144, 1986.

% Copyright 1991-2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../../copying.txt and ../../gpl.txt 

%
% 23 May 2002 - Normalization needs work and will probably not work 
% for HiPass systems

assign(p);

u=z(:,1);
y=z(:,2);
u0=u-mean(u);
y0=y-mean(y);
vfold = -1000;
vfnew = -900;
yp=y;
invi=irf;
%OrderMax=5;
OrderMax = get(nl,'ordermax');
set(invi,'NSides',2,'NLags',get(nl,'NLags'),'mode','auto');
i=irf;
set(i,'NSides',1,'NLags',get(nl,'NLags'),'mode','auto');
flag=1;
while flag,
   vfold=vfnew;
   z1 = cat (2,yp,u0);
   z1 = z1 - mean (z1);
   inv_h = nlident(invi, z1);
   halflen = floor(length(inv_h)/2);
   x_est = nlsim (inv_h, y0);
   z2=extract(cat(2,u0,x_est),halflen);
   t=polynom;
   m_est = polynom(t,z2, 'Type','Tcheb','OrderMax',OrderMax );
   x_est = nlsim (m_est, u0 );
   z3= cat (2, x_est,y0);
   h_est = nlident(i, z3);
   yp = nlsim (h_est, x_est);
   vfnewN = vaf (y0, yp);
   vfnew=vfnewN.Data;
   if (DisplayFlag)
      fprintf ('%6.4f \n',vfnew);
   end
   if (vfnew-vfold)> Tolerance
      h_final=h_est;
      m_final=m_est;
   else
      break
   end
   end
   %
   % Adjustment for DC offset
   %
   h_est=h_final;
   set(h_est,'comment','Linear Element');
   m_est=m_final;
   set(m_est,'Comment','Static Nonlinearity');
   %
   % Determine DC gain - will not work for high pass systems
   testin=y; set(testin,'Data',ones(size(y)));
   testv = double(nlsim (h_est, testin));
   yd=double(y);
   dc_gain = testv (ceil(length (yd)/2));
   %
   %
   mean_x = mean (yd) / dc_gain;
   x = nlsim (m_est,u0);
   x = x - mean(x) + mean_x;
   z4=cat (2,u,x);
   m_est= polynom(m_est,z4);
   elements = { m_est h_est };
   Ts=get(z,'Domainincr');
   set (nl,'Elements',elements)
   nlout=nl;
   
