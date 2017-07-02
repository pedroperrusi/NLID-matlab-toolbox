function term = parse_equation (eq)
% parse a narmax equation and return narmax structure
% Get elements must be separated by spaces


% Copyright 1998-2000, Robert E Kearney and Sunil L Kukreja
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 


term=[];
% make all lower case;
r=lower(eq);
% handle extra blanks;
r=strrep(r,' ','');
r=strrep(r,')+',') +');
r=strrep(r,')-',') -');
el={};
elcnt=0;
% Parse elements of equation
while length(r) > 0,
   [t,r]=strtok(r);
   elcnt=elcnt+1;
   el{elcnt}=t;
end
%
% Get componets of each element
%
for i=1:elcnt,
   r=el{i};
   cpcnt=0; c={};
   while length(r) > 0
      cpcnt=cpcnt+1;
      [t,r]=strtok(r,'*');
      c{cpcnt}=t;
   end
   cp{i}=c;
end
%
% Parse each component
%
n=0;
for e=1:elcnt,
   comp=cp{e};
   xcoef=1;
   for c=1:length(comp);
      % lag
      [s1,lag]=strtok(comp{c},'(');
      % Case for a constant
      if length(lag) ==0,
         coef=s1;
         xvar=0;
         xlag=0;
         xpower=0;
      else
         xlag=-eval(lag);
         % power
         [s2,power]=strtok(s1,'^');
         if (length(power) > 1),
            xpower=str2double(power(2:length(power)));
         else
            xpower=1;
         end
         % variable
         [coef,var]=strtok(s2,'uyze');
         if (length(var) == 0),
            var=s2;
         end
            xvar=findstr(var,'uyze');
       
         % coefficient
         if length(coef) > 0,
            if coef == '-',
               xcoef=xcoef*-1;
            elseif coef == '+',
               xcoef=xcoef;
            else
               xtemp=str2double(coef);
               if ~isnan(xtemp),
                  xcoef=xcoef*xtemp;
               else
                  error ('coefficient is not a number');
               end
            end
         end
      end
      term(e).Coef=xcoef;
      term(e).Terms(c,:)=[xvar xlag xpower];
 
   end
end

   
