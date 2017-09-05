%computing paramters for lognormal
%for lognormal break the distribution into less than 1 and more than 1 and
%then find paramters for lognormal and pareto

x1 = load('below1ONC.mat');
x1 = x1.x1;

[mu, sigma] = mle_lognormal(x1)
%mu and sigma values are -1.5446 and 0.2973

L1 = 0.076.*exp(-(log10(x1)-mu))./(2.*(sigma)^2);
el1 = sum(-log(L1(:,1)))

%get an el1 = 4027.8


%now computing for pareto 


x2 = load('above1ONC.mat');
x2 = x2.x2;
xmin = 1;
exponent = mle_pareto(x2,xmin)

%this gives me a negative exponent:Check for sign exponen = -2.4828

L2 = 0.041.*(x2).^(exponent-1);
el2 = sum(-log(L2(:,1)))

%Error check sign!
%get an el2 1125.2 for removing the minus sign

el = el1 + el2

%computing AIC 

AIC = 2*4 + 2*el

%AIC we get 10314 which is much bigger than AIC(MLP) = 5396.3

