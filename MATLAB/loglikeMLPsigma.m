%------LnL i.e. log of the MLP likelihood ------%

function el = loglikeMLPsigma(c)
Mass1 = load('MONC.mat');
x =  Mass1.Mass;
s = 0.351;
p1 = (c(1)./2).*(exp(c(1).*c(2) + ((c(1).*s).^2)./2));
p2 = x.^(-c(1));
p3 = erfc((1/sqrt(2)).*((c(1).*s)-((log(x)-c(2))./s)));
p = p1.*p2.*p3;
el = sum(-log(p)); % this is lnL
end
