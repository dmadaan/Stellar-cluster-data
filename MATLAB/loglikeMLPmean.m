%------LnL i.e. log of the MLP likelihood ------%

function el = loglikeMLPmean(c)
Mass1 = load('MONC.mat');
x =  Mass1.Mass;
b = -2.071
p1 = (c(1)./2).*(exp(c(1).*b + ((c(1).*c(2)).^2)./2));
p2 = x.^(-c(1));
p3 = erfc((1/sqrt(2)).*((c(1).*c(2))-((log(x)-b)./c(2))));
p = p1.*p2.*p3;
el = sum(-log(p)); % this is lnL
end
