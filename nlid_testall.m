function nlid_testall()
% nlid_testall - Run all nlmtst-files to verify code.

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU
% General Public License For details, see copying.txt and gpl.txt.
clc
clearvars

%% Cor
close all
disp('Correlation model')
nlmtst(cor)

%% Fresp
close all
disp('Frequency response model')
nlmtst(fresp)

%% Irf
close all
disp('Impulse response model')
nlmtst(irf)

%% Lnbl
close all
disp('Linear-nonlinear block model')
nlmtst(lnbl)

%% Lnlbl 
close all
disp('Linear-nonlinear-linear model')
nlmtst(lnlbl)

%% NARMAX
close all
disp('NARMAX model')
nlmtst(narmax)

%% Nlbl
close all
disp('Nonlinear block model')
nlmtst(nlbl)

%% P-Cascade (Parallel cascade model)
close all
disp('Parellel cascade model')
nlmtst(pcascade)

%% PDF
close all
disp('Probablity distribution model')
nlmtst(pdf)

%% Polynom
close all
disp('Polynomial model')
nlmtst(polynom)
nlmtst_2(polynom)

%% Spect
close all
disp('Power spectrum model')
nlmtst(spect)

%% Tvm
close all
disp('Time-varying model')
nlmtst(tvm)

%% Vkern
close all
disp('Volterra kernel model')
nlmtst(vkern)

%% Vseries
close all
disp('Volterra series model')
nlmtst(vseries)

%% Wbose
close all
disp('Wiener-Bose model')
nlmtst(wbose)

%% Wkern
close all
disp('Wiener kernel model')
nlmtst(wkern)

%% Wseries
close all
disp('Wiener series model')
nlmtst(wseries)

%% Finish
disp('Done')
