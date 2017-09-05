%------LnL i.e. log of the pareto likelihood ------%

%Note this is f(log m)
function el = loglikepareto(x,alpha,xmin)
p = -(alpha + 1).*(xmin.^(-alpha-1)).*x.^(alpha + 1); % instead of -(c+1).*x.^c.
%p = 0.041.*x.^(alpha+1);
el = sum(-log(p)); % this is lnL
end
