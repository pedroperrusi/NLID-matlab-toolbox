function Out = set(sys,varargin)
%SET  Set properties of nlm model fresp
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
%   See also  GET% handle case where nargin is compressed
ni = nargin;
% Handle recurrsive varags
[ni, varargin] = varg (nargin, varargin) ;
no = nargout;
if ~isa(sys,'fresp'),
    % Call built-in SET. Handles calls like set(gcf,'user',ss)
    builtin('set',sys,varargin{:});
    return
elseif no & ni>2,
    error('Output argument allowed only in SET(SYS) or SET(SYS,Property)');
end

% Get properties and their admissible values when needed
if ni>1,  flag = 'lower';  else flag = 'true';  end

    AllProps= pnv(sys,'names', flag);
AsgnValues= pnv(sys,'avalues', flag);

% Handle read-only cases
if ni==1,
    % SET(SYS) or S = SET(SYS)
    if no,
        Out = cell2struct(AsgnValues,AllProps,1);
    else
        nlpvdisp(AllProps,AsgnValues)
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
        disp(AsgnValues{imatch})
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
    % check to see if it is a parameter value
    P=sys.Parameters;
    j=pindex(P,varargin{i});
    if j>0,
        P=setval(P,varargin{i},varargin{i+1});
        sys.Parameters=P;
    else
        % Set each PV pair in turn
        [imatch,status] = pmatch(AllProps,varargin{i});
        error(status)
        Property = AllProps{imatch};
        Value = varargin{i+1};
        
        switch Property
            
        case 'parameters'
            sys.Parameters=Value;
          
        otherwise
            N=sys.nldat;
            set(N,Property,Value);
            sys.nldat=N;
        end % switch
        
    end % if
    end % for
    
    
    % Finally, assign sys in caller's workspace
    assignin('caller',name,sys)
    
    
    % end ../@fresp/set.m
    
    
    
