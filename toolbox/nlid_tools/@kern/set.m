function Out = set(sys,varargin)
%SET  Set properties of nlm model irf.
%
%   SET(SYS,'Property',VALUE)  sets the property of SYS specified
%   by the string 'Property' to the value VALUE.
%
%   SET(SYS,'Property1',Value1,'Property2',Value2,...)  sets multiple 
%   LTI property values with a single statement.
%
%   SET(SYS,'Property')  displays possible values for the specified
%   property of SYS.
%
%   SET(SYS)  displays all properties of SYS and their admissible 
%   values.
%
%
%   See also 

% V01-02 Modify to use nlpvdisp.
% 2001 05 22 REK fix problem with parsing of compressed input args

% handle case where nargin is compressed
[ni, varargin] = varg (nargin, varargin) ;


no = nargout;
if ~isa(sys,'kern'),
   % Call built-in SET. Handles calls like set(gcf,'user',ss)
   builtin('set',sys,varargin{:});
   return
elseif no & ni>2,
   error('Output argument allowed only in SET(SYS) or SET(SYS,Property)');
end

% Get properties and their admissible values when needed
if ni>1,  flag = 'lower';  else flag = 'true';  end
   AllProps= pnv(sys,'names',flag);
   AsgnValues=pnv(sys,'avalues');


% Handle read-only cases
if ni==1,
   % SET(SYS) or S = SET(SYS)
   if no,
      Out = cell2struct(AsgnValues,AllProps,1);
   else
      pvdisp(AllProps,AsgnValues)
   end
   return
   
elseif ni==2,
   % SET(SYS,'Property') or STR = SET(SYS,'Property')
   Property = varargin{1};
   if ~isstr(Property),
      error('Property names must be single-line strings,')
   end
   
   % Return admissible property value(s)
   [imatch,status] = pmatch(AllProps,Property);
   error(status)
   if no,
      Out = AsgnValues{imatch};
   else
      disp([Property ':' AsgnValues{imatch}])
   end
   return
   
end


% Now left with SET(SYS,'Prop1',Value1, ...)
name = inputname(1);
if isempty(name),
   error('First argument to SET must be a named variable.')
elseif rem(ni-1,2)~=0,
   error('Property/value pairs must come in even number.')
end

for i=1:2:ni-1,
   % Set each PV pair in turn
   % check to see if it is a paramter value
   P=sys.Parameters;
   j=pindex(P,varargin{i});
   if j>0,
      P=setval(P,varargin{i},varargin{i+1});
      sys.Parameters=P;
   else
   % Not a parameter so see if it is a property. 
   [imatch,status] = pmatch(AllProps,varargin{i});
   error(status)
   Property = AllProps{imatch};
   Value = varargin{i+1};
   
   switch Property
case 'parameters'
      if isa (Value,'param')
         % Value is param class so set 
         sys.Parameters = Value;
      elseif isa (Value,'cell')
         % Value is cell array so set values
         sys.Parameters = setval(sys.Parameters,Value) ;
      else
         error (' irf: Parameter must be class param or cell');
      end

 case 'data'
       N=sys.nldat;
      set(N,Property,Value);
      sys.nldat=N;
      P=sys.Parameters;
      P=setval(P,'nlags', length(N));
      sys.Parameters=P; 
  case 'model_type'
      
   otherwise
      N=sys.nldat;
      set(N,Property,Value);
      sys.nldat=N;
   end % switch
end
end % for


% Finally, assign sys in caller's workspace
assignin('caller',name,sys)


% end ../@kern/set.m


