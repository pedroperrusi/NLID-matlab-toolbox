function sys = nlm (sys, varargin)
% NonLinear Model NLM object
%Parent: nltop

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see copying.txt and gpl.txt 

% Setup default values
if nargin== 0,
    sys.Elements = { };
    sys.InputName = { 'Input' };
    sys.OutputName = { 'Output' };
    sys.Parameters=param('Name','Method');
    sys.Notes = 'Notes';
    nlt=nltop;
    sys=class(sys,'nlm',nlt);
    return
elseif isa (sys,'nlm');
    s=sys;
else
    error(['nlm does not support inputs of class ' class(s)])
end
return
%
% @nlm/nlm
