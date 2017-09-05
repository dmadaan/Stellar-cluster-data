function [x,fval,exitflag,output] = optimMLPmatlabcode(x0)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimset;
%% Modify options setting
options = optimset(options,'Display', 'off');
options = optimset(options,'PlotFcns', {  @optimplotx @optimplotfunccount @optimplotfval });
[x,fval,exitflag,output] = ...
fminsearch(@loglikeMLP,x0,options);

