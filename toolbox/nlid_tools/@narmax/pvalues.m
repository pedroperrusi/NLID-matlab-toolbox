function Values = pvalues(sys)
%PVALUES  Values of all public properties of an object
%
%   VALUES = PVALUES(SYS)  returns the list of values of all
%   public properties of the object SYS.  VALUES is a cell vector.
%
%   See also  GET.

%       Author(s): P. Gahinet, 7-8-97
%       Copyright (c) 1986-98 by The MathWorks, Inc.
%       $Revision: 1.1.1.1 $  $Date: 2003/02/07 19:47:09 $

Npublic = 3;  % Number of SNL-specific public properties

% Values of public LTI properties
Values = struct2cell(sys);
Values = Values(1:Npublic);
% Add parent properties
Values = [Values; pvalues(sys.nltop) ];



% end snl/pvalues.m
