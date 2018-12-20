clc
%% Setup MATLAB path to include the toolbox
disp('Updating the MATLAB path to include the toolbox.')

% Get global paths for nlid_tools and utility tools
cd 'toolbox/nlid_tools/'
nlid_path = pwd;
cd '../utility_tools/'
utility_path = pwd;
% Return to main directory
cd ../../
% Add the toolboxes to MATLAB path
addpath(nlid_path);
addpath(utility_path);

if input_l('Recompile MEX files?')
disp('Compiling and installing MEX files.')
install_nlid_mexfiles;
end

disp('Setup complete.')

clear