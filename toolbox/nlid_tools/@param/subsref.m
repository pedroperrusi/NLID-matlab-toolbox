function Pout = subsref (P, S);
% subscript reference for objects of type param

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

Pout=param;
namein=S.subs{1};
if isa(namein,'double')
   j=namein;
else
   j=pindex(P,namein);
   if j==0,
      error (['parameter: ' S.subs{1} ' not found' ]);
   end
end
nval=length(j);
for k=1:nval
   Pout.Default{k}=P.Default{j(k)} ;
   Pout.Help{k}=P.Help{j(k)};
   Pout.Limits{k}=P.Limits{j(k)};
   Pout.Name{k}=P.Name{j(k)};
   Pout.Type{k}=P.Type{j(k)};
   Pout.Value{k}=P.Value{j(k)};
end

% param/subsref
% 13 Dec 2000 Fixed problemwith Type


   
   
   
   
   
