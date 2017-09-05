%------LnL i.e. log of the power likelihood ------%
%Note this is f(log m)
function el = loglikepareto(x,alpha,xmax)
p = (alpha + 1).*(xmax.^(-alpha-1)).*x.^(alpha+1); % instead of -(c+1).*x.^c.
el = sum(-log(p)); % this is -lnL
end
