%loglike Kroupa
%now there are five paramters.

function el = loglikekroupa(c)
Mass1 = load('MONC.mat');
x =  Mass1.Mass;
%dlmwrite('my_data.out',x, ';')

p1 = c(4).*((x./c(4)).^(-c(1))) ;
p2 = c(4).*((x./c(4)).^(-c(2)));
p3 = erfc((1/sqrt(2)).*((c(1).*c(3))-((log(x)-c(2))./c(3))));
p = p1.*p2.*p3;
el = sum(-log(p)); % this is lnL
end

