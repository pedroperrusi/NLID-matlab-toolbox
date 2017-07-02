function [Props,AsgnVals] = pnames(sys,flag)
%PNAMES  All public properties and their assignable values
%
%   [PROPS,ASGNVALS] = PNAMES(SYS,'true')  returns the list PROPS of
%   public properties of the object SYS (a cell vector), as well as 
%   the assignable values ASGNVALS for these properties (a cell vector
%   of strings).  PROPS contains the true case-sensitive property names.
%   These include the public properties of SYS's parent(s).
%
%   [PROPS,ASGNVALS] = PNAMES(SYS,'lower')  returns lowercase property
%   names.  This helps speed up name matching in GET and SET.
%
%   See also  GET, SET.

%       Author(s): P. Gahinet, 7-8-97
%       Copyright (c) 1986-98 by The MathWorks, Inc.
%       $Revision: 1.1.1.1 $  $Date: 2003/02/07 19:47:05 $


% NLM properties
Props = {'Coef' ; 'Terms'; 'Method' ...
 };
if ~strcmp(flag,'true'),
   Props = lower (Props);
end
% Get parent properties and values
   [NLTOPprops,NLTOPvals] = pnames(sys.nltop,flag);
   Props = [Props ; NLTOPprops];

% Also return values if needed
if nargout>1,
   AsgnVals = {'Coefficients' ; ...
         'Terms' ; ...
         'Method [ols/' ; ...
      };
   % Add parent properties and their admissible values
   AsgnVals = [AsgnVals ; NLTOPvals];
end

% end narmax/pnames.m
