function Nout =  nlident(Nin, z,  varargin)
% Identify a narmax model 
%
% Setup default values

% Copyright 1999-2000, Robert E Kearney and Sunil L Kukreja
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

% Setup default values
%
if nargin < 1,
   disp('Must have at least two inputs for narmax objects: narma, Z' );
elseif nargin > 2,
   set(Nin,varargin)
end
%
% If input is a string create a equation from it
if isstr(z),
   Nout=narmax;
   term=parse_equation(z);
   [n,m]=size(term);
   for i=1:m,
      Nout.Coef(i) = term(i).Coef;
      Nout.Terms{i}= term(i).Terms;
   end
   N.Method='Equation';
   Nout=purge(Nout);
   Nout=purgeterms(Nout);
   return
   % If z is a data set then identify the model
elseif isa(z,'nldat'),
   if strcmp('ols',Nin.Method),
      [Nout,err]=ols_fixed(Nin, z);
      
   elseif strcmp('els',Nin.Method)
      [Nout,err]=els_fixed(Nin, z);
   else
      
      
      error ([ 'Method: ' Nin.Method ' not defined for narmax identificiation']);
   end
   
   end
% narmax/nlident
% 8 April 2000

