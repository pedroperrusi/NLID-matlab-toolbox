%% Script which will supress warnings related to deprecated MATLAB functions
% Although this is not be reccomended by mathworks, is a temporary measure
% to prevent these warnings to show up.

% Supress "NARGCHK will be removed in a future release. Use NARGINCHK or NARGOUTCHK instead."
warning('off', 'MATLAB:nargchk:deprecated');