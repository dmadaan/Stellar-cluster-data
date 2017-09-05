%Lognormal Maximum Likelihood Estimator
%Based on Equation in Table 1, modified from Johnson et al. 1994
% mean = sum/n;
function [mu, sigma] = mle_lognormal(data)

mu = mean(log10(data));

sigma = mean((log10(data) - mu).^2);%note this is sigma squared
