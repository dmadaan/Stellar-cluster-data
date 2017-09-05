
function el = logliketry(c)
Mass1 = load('above1ONC.mat');
x =  Mass1.x2;

p = x.^(-c(1));
el = sum(-log(p)); % this is lnL
end


