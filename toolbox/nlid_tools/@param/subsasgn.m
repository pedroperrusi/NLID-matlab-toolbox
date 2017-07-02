function Aout=subsasgn(A,S,B)
% subsasgn for param objects
% B must be a param object 

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

if strcmp (S.type, '()')
  namein=S.subs{1};
  if isa(namein,'double')
    j=namein;
  else
    j=0;
    for i=1:length(A),
      if strcmp(A.Name{i},namein),
	j=i;
      end
    end
    if j==0,
      error (['parameter: ' S.subs{1} ' not found' ]);
    end
  end 
  Aout=A;
  nval=length(j);
  for k=1:nval
    Aout.Default{j(k)}=B.Default{k};
    Aout.Help{j(k)}=B.Help{k};
    Aout.Limits{j(k)}=B.Limits{k};
    Aout.Name{j(k)}=B.Name{k};
    Aout.Type{j(k)}=B.Type{k};
    Aout.Value{j(k)}=B.Value{k};
  end
end

% @nlm/subsasgn
