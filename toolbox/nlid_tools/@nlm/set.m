function Out = set(sys,varargin)
%SET  Set properties of nlm model SYS.

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
%   See also  GET, SS, TF, ZPK.

%       Author(s): A. Potvin, 3-1-94
%       Revised: P. Gahinet, 4-1-96
%       Copyright (c) 1986-98 by The MathWorks, Inc.
%       $Revision: 1.2 $ $Date: 2003/06/13 16:13:01 $

% 2001 05 22 rek handle recurrsive calls
% handle case where nargin is compressed
[ni, varargin] = varg (nargin, varargin) ;



no = nargout;
if ~isa(sys,'nlm')
    % Call built-in SET. Handles calls like set(gcf,'user',ss)
    builtin('set',sys,varargin{:});
    return
elseif no && ni>2
    error('Output argument allowed only in SET(SYS) or SET(SYS,Property)');
end



% Get properties and their admissible values when needed
if ni>1,  flag = 'lower';  else flag = 'true';  end
AllProps = pnv(sys,'names',flag);
AsgnValues = pnv(sys,'avalues');


% Handle read-only cases
if ni==1
    % SET(SYS) or S = SET(SYS)
    if no
        Out = cell2struct(AsgnValues,AllProps,1);
    else
        pvdisp(AllProps,AsgnValues)
    end
    return
    
elseif ni==2
    % SET(SYS,'Property') or STR = SET(SYS,'Property')
    Property = varargin{1};
    if ~ischar(Property)
        error('Property names must be single-line strings,')
    end
    
    % Return admissible property value(s)
    [imatch,status] = pmatch(AllProps,Property);
    error(status)
    if no
        Out = AsgnValues{imatch};
    else
        disp(AsgnValues{imatch})
    end
    return
    
end


% Now left with SET(SYS,'Prop1',Value1, ...)
name = inputname(1);
if isempty(name)
    error('First argument to SET must be a named variable.')
elseif rem(ni-1,2)~=0
    error('Property/value pairs must come in even number.')
end

for i=1:2:ni-1
    % Set each PV pair in turn
    % See if it is a parameter value, if so set it
    P=sys.Parameters;
    j=pindex(P,varargin{i});
    if j>0
        P=setval(P,varargin{i},varargin{i+1});
        sys.Parameters=P;
        % If method changes then reset default parameters
        if strcmp('method',char(varargin(i)))
            sys=pdefault(sys);
        end
    else
        
        % not a parameter so set property
        
        [imatch,status] = pmatch(AllProps,varargin{i});
        error(status)
        Property = AllProps{imatch};
        Value = varargin{i+1};
        
        switch Property
            case 'domainincr'
                sys.DomainIncr = Value;
            case 'elements'
                sys.Elements = Value ;
            case 'inputname'
                sys.InputName = Value;
            case 'notes'
                sys.Notes = Value;
            case 'outputname'
                sys.OutputName = Value;
                
            case 'parameters'
                if isa (Value,'param')
                    % Value is param class so set
                    sys.Parameters = Value;
                elseif isa (Value,'cell')
                    % Vale is cell array so set values
                    sys.Parameters = setval(sys.Parameters,Value) ;
                else
                    error (' nlm: Parameter must be class param or cell');
                end
            otherwise
                N=sys.nltop;
                set_nl(N,Property,Value);
                sys.nltop=N;
                
                
        end % switch
        
    end
end % for


% Finally, assign sys in caller's workspace
assignin('caller',name,sys);
% end ../@nlm/set.m


