%------LnL i.e. log of the MLP likelihood ------%

function el = loglikeprav(c)
Mass1 = load('MONC.mat');
x =  Mass1.Mass;

%c = [1.35 0.51 0.35]
p1 = x.^(-c(1));
p2 = 1 - exp(-((x./c(3)).^(c(1)+c(2))));
p = p1.*p2;
el = sum(-log(p)); % this is lnL
end

