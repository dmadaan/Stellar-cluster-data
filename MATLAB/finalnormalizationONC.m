
 %ONC data and size
Mass1 = load('MONC.mat');
Mass1 = Mass1.Mass;
Mass1 = sort(Mass1); [n,m] = size(Mass1); 

totmass = sum(Mass1);
%we will have to separate the data into above1solar and below1solar
j = 1;
k= 1;
for i = 1:n 
    if Mass1(i)<= 1
        below1solar(j,1) = Mass1(i);
        j = j+1;
    else
        above1solar(k,1) = Mass1(i);
        k = k+1;
    end
end
x1 = min(below1solar) % this is m and not ln m
x2 = max(below1solar)
x3 = max(above1solar)


%%%%%% NORMALIZATION CONSTANT for Chabrier!! We normalize for dN/dm
mu =  -1.5426
sigma = 0.5476
fun = @(x) normpdf(log(x),mu,sigma) %
a1 = integral(fun,x1,x2)

alpha = -2.4609
pareto = @(x) -(alpha + 1).* x.^(alpha + 1);%note this is f(ln m)
a2 = integral(pareto,x2,x3)

A = (totmass/n)*(1/(a1 + a2))


%this would be ntotal/(a+b) because f(m) is not probablity but number alone.

fun1 = @(x) A.* fun(x)
a1 = integral(fun1,x1,x2)
pareto1 =  @(x) A.* pareto(x)
a2 = integral(pareto1,x2,x3)

a1 + a2

%%%%%% NORMALIZATION CONSTANT for Chabrier!! We normalize for dN/dm
mu =  -1.5426
sigma = 0.5476
fun2 = @(x) A.*normpdf(log(x),mu,sigma)
b1 = integral(fun2,x1,x2)

alpha = -2.4609
pareto2 = @(x) A.*-(alpha + 1).* x.^(alpha+1);%note this is f(ln m)
b2 = integral(pareto2,x2,x3)

B = 1/(b1+b2)

%this would be ntotal/(a+b) because f(m) is not probablity but number alone.

fun2 = @(x) B.* fun2(x)
b1 = integral(fun2,x1,x2)
pareto2 =  @(x) B.* pareto2(x)
b2 = integral(pareto2,x2,x3)

b1 + b2
