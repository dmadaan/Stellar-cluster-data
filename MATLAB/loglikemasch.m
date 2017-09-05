%------LnL i.e. log of the maschberger likelihood ------%
% alpha = c(1); beta = c(2);mu = c(3)

%this is not working. Gives me infinity!

function el = loglikemasch(c)
Mass1 = load('MONC.mat');
x =  Mass1.Mass;

p1 = (x./c(3)).^(-c(1));
p2 = (1+(x./c(3)).^(1-c(1))).^c(2);
p = p1.*p2;
el = sum(-log(p)); % this is lnL
end

