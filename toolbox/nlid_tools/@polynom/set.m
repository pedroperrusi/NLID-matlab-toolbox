function Out = set(sys,varargin)
%SET  Set properties of polynominal class oobjects
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
%   See also  GET,
% 2001 05 22 Fix problem with recurssive calls
% handle case where nargin is compressed

% Copyright 2001-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

[ni, varargin] = varg (nargin, varargin) ;

no = nargout;
if ~isa(sys,'polynom'),
    % Call built-in SET. Handles calls like set(gcf,'user',ss)
    builtin('set',sys,varargin{:});
    return
elseif no & ni>2,
    
    error('Output argument allowed only in SET(SYS) or SET(SYS,Property)');
end

% Get properties and their admissible values when needed
if ni>1,  flag = 'lower';  else flag = 'true';  end
AllProps = pnv(sys,'names',flag);
AsgnValues = pnv(sys,'avalues');


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
    % First check to see if it is a paramter value
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
        case 'coef'
            if isempty(Value),  Value = -1;  end
            if ndims(Value)>2 | ~isreal(Value) | ~isfinite(Value) ,
                error('Coefficients must be a real numbers.')
            end
            sys.Coef = Value;
	    if sys.NInputs == 1
              sys.Order = length(Value)-1;
	    else
              order = 0;
	      Ncoeff = 1;
	      while order <= 20
		order = order + 1;
		Ncoeff = Ncoeff*(sys.NInputs+order)/order;
		if length(Value)==Ncoeff
		  sys.Order = order;
		  break;
		end
	      end
	      if order == 21
		error('coefficient vector length is incorrect');
	      end
	    end
	    
            
            
        case 'mean'
            sys.Mean= Value;
        case 'parameters'
            if isa (Value,'param')
                % Value is param class so set 
                sys.Parameters = Value;
            elseif isa (Value,'cell')
                % Value is cell array so set values
                sys.Parameters = setval(sys.Parameters,Value) ;
            else
                error (' polynom: Parameter must be class param or cell');
            end
            
            
        case 'ninputs'
            sys.NInputs = Value;
        case 'order'
            if ndims(Value)>2 | ~isreal(Value) | ~isfinite(Value),
                error('Order must be real numbers.')
            elseif Value < 0 | Value > 20,
                error('Order muse be 0 < order < 20.')
            end
            sys.Order = Value;
            
        case 'range'
            sys.Range = Value;
        case 'std' 
            sys.Std = Value;
        case 'type'
            if ~any(strcmp(lower(Value),{ 'hermite' 'power' 'tcheb'})),
                error (['Bad value for type:' Value]);
	    end
            sys.Type = Value;	      
%            if isnan(sys.Coef),
%                %  No coefficients so just set type
%                sys.Type = Value;
%            elseif strcmp(sys.Type,Value)
%                % Type is already set so do nothing
%                break
%            elseif sys.NInputs > 1,
%                error ('Conversion not yet implemented for multiple inputs')
%            else
%                Pstats= [sys.Range(2) sys.Range(1) sys.Mean sys.Std];
%                cold=(sys.Coef);
%                cnew = poly_convert(cold, Pstats,sys.Type,Value);
%                sys.Coef=cnew;
%                sys.Type=Value;
%                % Convert type of polynomial
%            end
        case 'vaf'
            sys.Mode = Value;
        otherwise
            NLT=sys.nltop;
            set (NLT,Property,Value)
            sys.nltop=NLT;
        end % switch
    end % for
end



% Finally, assign sys in caller's workspace
assignin('caller',name,sys)


% end ..@polynom/set.m


