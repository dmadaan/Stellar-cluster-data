%Truncated Pareto Estimator

%Estimates the exponent for truncated Pareto data when provided with the
%minimum attainable value of x (xmin), the maximum atttainable value of x
%(xmax), and a vector of observations (data). The function mle_pareto must
%also be accessible by Matlab (i.e., in the path or in the current
%directory) to allow for the calculation of a starting point for the
%numerical solution.

function [exponent] = mle_truncpareto(data,xmin,xmax)

%Determine a starting point for the numerical search by fitting the
%distribution using MLE for the simple Pareto
lambda0=mle_pareto(data,xmin);

%Find the exponent numerically by finding the value of the exponent that
%sets the relevent equation in Table 1 to be equal to 0. This equation is
%given by the nested function 'truncpareto_mle_equation'.
exponent = fzero(@(lambda) truncpareto_mle_equation(lambda,mean(log(data)),xmin,xmax),lambda0);
    
    %Nested function that provides the equation for the root finder to set
    %to zero
    function [y] = truncpareto_mle_equation(lambda,meanlogx,xmin,xmax)
    y=-meanlogx-1/(lambda+1)+(xmax^(lambda+1)*log(xmax)-xmin^(lambda+1)*log(xmin))/(xmax^(lambda+1)-xmin^(lambda+1));
    end

end