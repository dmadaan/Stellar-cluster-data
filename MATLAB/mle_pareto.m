%Pareto Maximum Likelihood Estimator
%Based on Equation in Table 1, modified from Johnson et al. 1994

function alpha = mle_pareto(data,xmin)

alpha = -1-(mean(log(data./xmin)))^-1;
%gamma = -alpha - 1; %alpha is positive