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

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

% NLM properties
Props = {'Name' };
if ~strcmp(flag,'true'),
   Props = lower (Props);
end
% Get parent properties and values
   [NLTOPprops,NLTOPvals] = pnames(sys.kern,flag);
   Props = [Props ; NLTOPprops];

% Also return values if needed
if nargout>1,
   AsgnVals = {'Name of op'       };
   % Add parent properties and their admissible values
   AsgnVals = [AsgnVals ; NLTOPvals];
end

% end cor/pnames.m
