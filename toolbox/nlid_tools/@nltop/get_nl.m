function Value = get_nl(sys,Property)
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
narginchk(1,2);


% Get all public properties and their values
if ni>1, flag = 'lower'; else flag = 'true'; end
AllProps = pnv(sys,'names',flag);
AllValues = pnv(sys,'values');

% Handle various cases
if ni==2
   if ischar(Property)
      % Query of type GET(SYS,'Property')
      [imatch,status] = pmatch(AllProps,Property);
      if status
         % See if property is a parameter value
         P_sys=get_nl(sys,'Parameters');
         j=pindex(P_sys,Property);
         if (j>0)
             Value = getvalue(P_sys,j);
         else
             error(status)
         end
      else
          Value = AllValues{imatch};
      end
      
   else
      % Query of type GET(SYS,{'Prop1','Prop2',...})
      np = numel(Property);
      Value = cell(1,np);
      for i=1:np
         [imatch,status] = pmatch(AllProps,Property{i});
         error(status)
         Value{i} = AllValues{imatch};
      end
   end

elseif nargout
   % Query of type STRUCT = GET(SYS)
   Value = cell2struct(AllValues,AllProps,1);
   
else
   % Query of type GET(SYS)
   pvdisp(AllProps,AllValues);
   
end