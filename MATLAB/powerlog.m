
%function el = powerlog(c)
c = [1.35]
Mass1 = load('MONC.mat');
x =  Mass1.Mass;
A = sort(x);
x1 = A(1:2345,1);
x2 = A(2346:2548,1);
p = 0.041*x1.^(-c(1));
el = sum(-log(p)); % this is lnL
%end

