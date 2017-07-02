% sample solution for chapter 7 computer exercise 1b

clear 
close all
echo on

% set up the simulation parameters
NumTrials = 3;    % Number of Monte Carlo trials
dB = 10;          % signal to noise ratio (in dB).
N = 10000;        % length of data records

hlen = 64;        % memory length of the system.
alpha = 0.25;     % Laguerre decay parameter
M = 18;           % Number of Laguerre Filters.
slice = 7;

% Allocate storage for the sum of the estimated quantities, and 
% for the sum of the squared estimates -- used to compute the enesemble mean
% and variance.

foa_k1_sum = zeros(hlen,1);
foa_k1_sumsq = foa_k1_sum;

foa_k2_sum = zeros(hlen,hlen);
foa_k2_sumsq = foa_k2_sum;

let_k1_sum = zeros(hlen,1);
let_k1_sumsq = let_k1_sum;

let_k2_sum = zeros(hlen,hlen);
let_k2_sumsq = let_k2_sum;

lnl_g_sum = zeros(hlen,1);
lnl_g_sumsq = lnl_g_sum;

lnl_h_sum = zeros(hlen,1);
lnl_h_sumsq = lnl_h_sum;

for i = 1:NumTrials
  uz = ex1_data(N,1,dB);
  [sys1,sys2,sys3] = ex1_models(uz,hlen,alpha,M,slice);
  
  kernels = get(sys1,'elements');
  k1 = double(kernels{2});
  foa_k1_sum = foa_k1_sum + k1;
  foa_k1_sumsq = foa_k1_sumsq + k1.^2;
  k2 = double(kernels{3});
  foa_k2_sum = foa_k2_sum + k2;
  foa_k2_sumsq = foa_k2_sumsq + k2.^2;
  
  kernels = get(sys2,'elements');
  k1 = double(kernels{2});
  let_k1_sum = let_k1_sum + k1;
  let_k1_sumsq = let_k1_sumsq + k1.^2;
  k2 = double(kernels{3});
  let_k2_sum = let_k2_sum + k2;
  let_k2_sumsq = let_k2_sumsq + k2.^2;

  stuff = get(sys3,'elements');
  g = double(stuff{1});
  lnl_g_sum = lnl_g_sum + g;
  lnl_g_sumsq = lnl_g_sumsq + g.^2;
  h = double(stuff{3});
  lnl_h_sum = lnl_h_sum + h;
  lnl_h_sumsq = lnl_h_sumsq + h.^2;
end

foa_k1_mean = foa_k1_sum/NumTrials;
foa_k1_var = foa_k1_sumsq/NumTrials - foa_k1_mean.^2;

foa_k2_mean = foa_k2_sum/NumTrials;
foa_k2_var = foa_k2_sumsq/NumTrials - foa_k2_mean.^2;

let_k1_mean = let_k1_sum/NumTrials;
let_k1_var = let_k1_sumsq/NumTrials - let_k1_mean.^2;

let_k2_mean = let_k2_sum/NumTrials;
let_k2_var = let_k2_sumsq/NumTrials - let_k2_mean.^2;

lnl_g_mean = lnl_g_sum/NumTrials;
lnl_g_var = lnl_g_sumsq/NumTrials - lnl_g_mean.^2;

lnl_h_mean = lnl_h_sum/NumTrials;
lnl_h_var = lnl_h_sumsq/NumTrials - lnl_h_mean.^2;

echo off