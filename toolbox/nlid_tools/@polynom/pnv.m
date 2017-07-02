function [Rval] = pnv(sys,mode, case_flag)
% pnv - returns public properties or vlaues of object sys. 
% sys - object
% mode - mode to return [names/values]
% case - 'lower' returns values as lower case 

% Copyright 2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

if nargin < 3,
    case_flag='lower';
end

parent=sys.nltop; % Parent object
Npublic = 9;    % Number of MS specific public properties
AsgnVals = {'Vector of length order+1';
               'Mean of input' ; ...
               'Number of inputs' ; ...
               'scalar'; ...
                 'scalar'; ...
               'std of input'; ...
               'set by tcheb'; ...
               'type of polynominal [ ''tcheb'' | ''hermite'' | ''power'']'; ...
               'set by polynom'; ...
               'arbitrary'};
Rval=pnvmain ( sys,mode, case_flag, parent, Npublic, AsgnVals);


