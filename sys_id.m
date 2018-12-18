% Description
%{
Script to run the system identification toolbox developed by Westwick and
Kearney as described in "Identification of Nonlinear Physiological
Systems". Procedures are based on Perreault (Multiple-input,
multiple-output system identification for characterization of limb
stiffness dynamics 1999)
%}

% Known issues
%{

%}

% Improvements
%{

%}

% Set working directory to script location
cd(fileparts(which(mfilename)));
% Add working directory and all subfolders to path
addpath(genpath(fileparts(which(mfilename))));

clc, clearvars, close all

%%
% Useful help commands
% D:\Github\NLID-matlab-toolbox\references\nlid_docs\NLID_Tools.pdf
%{
help nlid_tools 
methods(nldat)
get(emg)
%}