function display (P)
l=length(P);
pad=blanks(4);
disp([pad 'Param object']);
for i=1:l
    %   disp([pad pad P.Name{i} '=' num2str(value(P,i)) ' [' P.Help{i} ']' ])
    disp([pad P.Name{i} ' = ' num2str(getvalue(P,i))])
    disp([pad pad 'Description: ' P.Help{i}])
    
    
    limits = P.Limits{i};
    ltype = P.Type{i};
    switch lower(ltype)
        case 'number'
            llim = num2str(limits{1});
            ulim = num2str(limits{2});
            disp([pad pad 'Range: [ ' llim pad ulim ' ]']);
        case 'select'
            nopt = length(limits);
            lstr = ' ';
            for j = 1:nopt-1
                lstr = [lstr limits{j} ', '];
            end
            lstr = [lstr limits{nopt}];
            disp([pad pad 'Values: [ ' lstr ' ]']);
    end
    
    
end

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see ../copying.txt and ../gpl.txt
