%------LnL i.e. log of the MLP likelihood ------%

function el = loglikeMLPnew(c)
Mass1 = load('MONC.mat');
x =  Mass1.Mass;
a = 1.42;
p1 = (a./2).*(exp(a.*c(1) + ((a.*c(2)).^2)./2));
p2 = x.^(-a);
p3 = erfc((1/sqrt(2)).*((a.*c(2))-((log(x)-c(1))./c(2))));
p = p1.*p2.*p3;
el = sum(-log(p)); % this is lnL
end
