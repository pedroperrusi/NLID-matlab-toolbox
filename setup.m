%% Setup MATLAB path to include the toolbox
disp('Updating the MATLAB path to include the toolbox...')

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

% Supress deprecated functions warnings (temporary measure)
supress_warnings

disp('Set up done')

clear