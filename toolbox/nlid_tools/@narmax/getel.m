function E = getel (N,nel);
% @narmax/getel

S.type='()';
S.subs{1}=nel;
E=subsref(N,S);

% Copyright 2000, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

