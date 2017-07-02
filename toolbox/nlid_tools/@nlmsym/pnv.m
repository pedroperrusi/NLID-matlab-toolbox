function [Rval] = pnv(sys,mode, case_flag)
% pnv - returns public properties or vlaues of object sys. 
% sys - object
% mode - mode to return [names/values]
% case - 'lower' returns values as lower case 

if nargin < 3,
    case_flag='lower';
end
parent=sys.nltop; % Parent object
Npublic = 1;    % Number of MS specific public properties
AsgnVals = { 'symbolic elements'...
    };
Rval=pnvmain ( sys,mode, case_flag, parent, Npublic, AsgnVals);


