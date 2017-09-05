%Power Function Distribution Maximum Likelihood Estimator
%Based on equation in Table 1, modified from Evans et al. 2000 with
%correction.

function alpha = mle_power(data,xmax)
alpha = -1-(mean(log(data./xmax)))^-1;
%alpha=(log(xmax)-mean(log(data)))^-1-1;