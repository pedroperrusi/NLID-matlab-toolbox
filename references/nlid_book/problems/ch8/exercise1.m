% sample solution for chapter 8, computer exercise 1


clear
close all
echo on


% construct identification and validation data sets.
uz_id = RunningEx;
uz_cv = RunningEx;

% set up a volterra series model, and identify it
vs = vseries;
set(vs,'NLags',32);
vs = nlident(vs,uz_id);

% test the identification accuracy
vs_id_vaf = double(vaf(vs,uz_id))

% test the validation accuracy
vs_cv_vaf = double(vaf(vs,uz_cv))

figure
plot(vs)


%% press any key to continue

pause

% set up a parallel cascade model
pc2 = pcascade;
set(pc2,'NLags',32,'OrderMax',2);
pc2 = nlident(pc2,uz_id);

% test the model on identification and validation data

pc2_id_vaf = double(vaf(pc2, uz_id))
pc2_cv_vaf = double(vaf(pc2, uz_cv))

figure
plot(pc2);


%% press any key to continue

pause

% try 4'th order polynomials

pc4 = pc2;
set(pc4,'OrderMax',4);

pc4 = nlident(pc4,uz_id);

% test the model on identification and validation data

pc4_id_vaf = double(vaf(pc4, uz_id))
pc4_cv_vaf = double(vaf(pc4, uz_cv))

figure
plot(pc4);

echo off


disp(['Identification and Cross Validation VAFs']);
disp(['                          Identification  Validation']);
fprintf('Volterra Series (FOA):  %12.2f %12.2f\n',...
    [vs_id_vaf vs_cv_vaf]);
fprintf('Parallel Cascade (2) :  %12.2f %12.2f\n',...
    [pc2_id_vaf pc2_cv_vaf]);
fprintf('Parallel Cascade (4) :  %12.2f %12.2f\n',...
    [pc4_id_vaf pc4_cv_vaf]);


