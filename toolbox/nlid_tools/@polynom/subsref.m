function datout = subsref (datin,S);
% V01-01 REK 21 Dec Created

% Copyright 2001-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

while length(S) >1,
    datin=subsref(datin,S(1));
    Snew=S(2:length(S));
    S=Snew;
end
datout=datin;
if strcmp (S.type, '()'),
    if  isa(datin,'double'),
        datout=datin(S.subs{1});
    else
    error ('polynom subsref - does not support () indexing yet');
end

elseif strcmp(S.type,'.')
    switch lower(S.subs)
    case 'coef'
        datout = datin.Coef;
    case 'mean'
        datout = datin.Mean;
    case 'inputs'
        datout=datin.NInputsr;
    case 'paramters'
        datout=datin.Paramters;
    case 'range'
        datout=datin.Range;
    case 'std'
        datout=datin.Std;
    case 'vaf'
        datout=datin.VAF;
    otherwise
        error(['polynom susref error. Field not defined' S.type])
    end
    
    
else
    datout=NaN;
    error ('polynom subsref function not yet implemented');
end
return
