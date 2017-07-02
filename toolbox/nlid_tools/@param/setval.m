function Pout = setval (Pin, varargin );
% set the value for a parameter set
% Pin - input paramter array
% varagin - name/value pairs to set

% Copyright 1999-2003, Robert E Kearney
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

Pout=Pin;
% Take care of nested calls with variable number of parameters
% where args appear as one element of a cell array

while length(varargin)==1 & iscell (varargin{1}),
  varargin=varargin{1};
end

for i=1:2:length(varargin),
  name = varargin{i};
  value = varargin{i+1};
  j=pindex(Pin,name);
  if j ==0,
    error (['Parameter:' name 'not found']);  
  end
  if strcmp(Pin.Type(j),'select'),
    if ~any(strcmp(value,Pin.Limits{j})),
      error (['The value: ''' value ''' is not in the limits list for select parameter: ' Pin.Name{j} ]);
    end
  end
  
  
  Pout.Value{j}=varargin{i+1};
end



