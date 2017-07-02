function phi=phixxy(x,y,hlen)
%  the second-order cross correlation between  x and y
%
%  syntax: phi = phixxy (x,y,hlen)
%

%  the second-order cross correlation between  x and y
%  output y, out to hlen lags.  
%  the means of both x and y are subtracted prior to estimation
%  a biased estimate of the cross-correlation is returned
%  
%  DTW June 1991.
%  REK June 1994 Changed comments
%  DTW June 1994 Removed pointer to standalone c-function (obsolete)
%                added warning message about installation of MEX files
disp('This function is implemented as a MEX file.');
disp('If MATLAB is giving you this message, the nlid toolbox MEX files');
disp('have not been installed for your machine architecture');

