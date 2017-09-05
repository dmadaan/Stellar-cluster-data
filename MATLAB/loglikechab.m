%------LnL i.e. log of the MLP likelihood ------%
%c(1) = alpha , c(2) = mu , c(3) = sigma

function el = loglikechab(c)
%c = [1.35 0.2 0.55]


p = ones(n,1);

for i = 1:n 
    if x(i) <= 1
    p(i) = 0.076*exp(-(log10(x(i))-c(2))/(2*(c(3))^2));
    else 
    p(i) = 0.041*(x(i)^(-c(1)-1));
    end
end
el = sum(-log(p(:,1))); % this is lnL
end
