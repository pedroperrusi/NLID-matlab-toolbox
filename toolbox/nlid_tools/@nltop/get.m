function Value = get(sys,Property)
%GET  Access/query SNL property values.
%
%   VALUE = GET(SYS,'Property')  returns the value of the specified
%   property of the LTI model SYS.
%   
%   STRUCT = GET(SYS)  converts the NLM object SYS into 
%   a structure STRUCT with the property names as field names and
%   the property values as field values.
%
%   Without left-hand argument,  GET(SYS)  displays all properties 
%   of SYS and their values.
%
%   See also  SET,
%       Author(s): A. Potvin, 3-1-94
%       Revised: P. Gahinet, 7-11-97
%       Copyright (c) 1986-98 by The MathWorks, Inc.
%       $Revision: 1.2 $  $Date: 2003/06/13 16:13:01 $

% Generic GET method for all NLM children
% Uses the object-specific methods PNAMES and PVALUES
% to get the list of all public properties and their
% values (PNAMES and PVALUES must be defined for each 
% particular child object)

ni = nargin;
error(nargchk(1,2,ni));


% Get all public properties and their values
if ni>1, flag = 'lower'; else flag = 'true'; end
AllProps = pnv(sys,'names',flag);
AllValues = pnv(sys,'values');

% Handle various cases
if ni==2,
   if isstr(Property)
      % GET(SYS,'Property')
      [imatch,status] = pmatch(AllProps,Property);
      if status,
         % See if property is a parameter value
         P=get(sys,'Parameters');
         j=pindex(P,Property);
         if (j>0),
            Value=value(P(Property));
         else
            error(status)
         end
      else
       
         Value = AllValues{imatch};
      end
      
   else
      % GET(SYS,{'Prop1','Prop2',...})
      np = prod(size(Property));
      Value = cell(1,np);
      for i=1:np,
         [imatch,status] = pmatch(AllProps,Property{i});
         error(status)
         Value{i} = AllValues{imatch};
      end
   end

elseif nargout,
   % STRUCT = GET(SYS)
   Value = cell2struct(AllValues,AllProps,1);
   
else
   % GET(SYS)
   pvdisp(AllProps,AllValues);

end


% end nltop/get.m
