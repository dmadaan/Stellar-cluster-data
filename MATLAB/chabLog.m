%------LnL i.e. log of the MLP likelihood ------%

function el = chabLog(c)
%c = [0.2 0.55]
Mass1 = load('MONC.mat');
x =  Mass1.Mass;
[n,m] = size(x);
j = 1;
for i = 1:n
    if x(i) <= 1
    x1(j,1) = x(i);
    j = j+1;
    end
end
p = 0.076*exp(-(log10(x1)-c(1))/(2*c(2)^2));
el = sum(-log(p)); % this is lnL
end

