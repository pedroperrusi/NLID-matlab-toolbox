function y=smo(x,numtimes)
% smooth with a 3-point moving average 
% THE SMOOTH FUNCTION SMOOTHS THE DATA WITH A 3-POINT
% MOVING AVERAGE, ZERO-PHASE-SHIFT AGORITHM:
%	y(i) = x(i-1)/4 + x(i) + x(i+1)/4
%
%	USAGE	: y = smo(x,numtimes)
%
%	x	: input vector
%	numtimes: number of times x should be smoothed
%
% IF X IS A MATRIX, SMO(X,NUMTIMES) WILL SMOOTH EACH
% COLUMN OF X NUMTIMES
%	
% EJP Jan 1991
%
fil = [0.25 0.5 0.25];
y=x;
[nr,nc]=size(x);
if min([nr nc]) > 1
  for j=1:nc
    for i=1:numtimes
      y(:,j)=filter_ts(fil,y(:,j),2);
    end
  end
else
  for i=1:numtimes
    y=filter_ts(fil,y,2);
  end
end
return
