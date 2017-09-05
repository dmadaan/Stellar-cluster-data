%------LnL i.e. log of the MLP likelihood ------%


%Note this is f(m)
function el = loglikeMLP(x,c)
p1 = (c(1)./2).*(exp(c(1).*c(2) + ((c(1).*c(3)).^2)./2));
p2 = x.^-(c(1));%this is alpha0 + 1 
p3 = erfc((1/sqrt(2)).*((c(1).*c(3))-((log(x)-c(2))./c(3))));
p = p1.*p2.*p3;
el = -sum(log(p)); % this is -lnL
end

