%------LnL i.e. log of the lognormal likelihood ------%
%
%note this is f(log m) which is the normal distribution for log m i.e. sub
%logm for x in the pdf of the normal distribution
%sigma is actually sigma squared calculated by the estimator
function el = loglikelognormal(x,c)
%p = (1./(sqrt(2*pi)*sigma)).* exp(-((log(x)- mu).^2)./(2*(sigma^2)));
p = normpdf(log(x),c(1),c(2)); %same thing as above!
el = sum(-log(p)); % this is -lnL
end
