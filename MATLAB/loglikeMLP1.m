%------LnL i.e. log of the MLP likelihood ------%

%Note this is f(m)
function el = loglikeMLP(x,a,b,c)
Mass1 = load('MNGC1711MESA.mat');
Mass = Mass1.Mass2;
Mass = sort(Mass);
x = Mass;
p1 = (a./2).*(exp(a.*b + ((a.*c).^2)./2));
p2 = x.^-(a);%this is alpha0 + 1
p3 = erfc((1/sqrt(2)).*((a.*c)-((log(x)-b)./c)));
p = p1.*p2.*p3;
el = -sum(log(p)); % this is -lnL
end