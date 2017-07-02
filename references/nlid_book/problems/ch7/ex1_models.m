function [sys1,sys2,sys3] = ex1_models(uz,hlen,alpha,M,slice)
%  
%  [sys1,sys2] = ex1_models(uz,hlen,alpha,M)


sys1 = vseries;
set(sys1,'method','foa','NLags',hlen,'OrderMax',2);
sys1 = nlident(sys1,uz);

sys2 = sys1;
set(sys2,'method','laguerre','alpha',alpha,'NumFilt',M);
sys2 = nlident(sys2,uz);

% construct a LNL model that approximates the 0-2 order kernels
sys3 = ex1_lnl(sys2,slice);
