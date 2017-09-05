
%NGC1711 data and size

Mass1 = load('MNGC1711.mat');
Mass = Mass1.Mass2; 
Mass = sort(Mass);
[n,m] = size(Mass); 

%we will have to separate the data into above1solar and below1solar
j = 1;
k= 1;
for i = 1:n 
    if Mass(i)<= 1
        below1solar(j,1) = Mass(i);
        j = j+1;
    else
        above1solar(k,1) = Mass(i);
        k = k+1;
    end
end
x1 = min(below1solar)
x2 = max(below1solar)
x3 = max(above1solar)
%%%%%% NORMALIZATION CONSTANT for Chabrier!!
mu =  -0.0557
sigma = 0.0320
fun = @(x) lognpdf(x,mu,sigma)
a1 = integral(fun,x1,x2)

alpha = -2.9188
pareto = @(x) -(alpha + 1).* x.^(alpha);%note this is f(m)
a2 = integral(pareto,x2,x3)

a1 + a2

A = 1/(a1+a2)

fun1 = @(x) A.* fun(x)
a1 = integral(fun1,x1,x2)
pareto1 =  @(x) A.* pareto(x)
a2 = integral(pareto1,x2,x3)

a1 + a2 
%A we get is 0.3483
%%%%%% NORMALIZATION CONSTANT FOR KROUPA
% 3 segmented power law
%we will have to separate the data into domains

y3 = min(Mass);
y4 = max(Mass);

alpha3 = -1.9023;

xmax2 = 0.50 ;


pareto1 = @(x) -(alpha3 + 1).*(xmax2.^(-alpha3-1)).*x.^(alpha3);
b3 = integral(pareto1,y3,y4)
b3

A2 = 1/(b3)
%A2 we get is 0.4743


pareto1 =  @(x) A2.* pareto1(x)
b3 = integral(pareto1,y3,y4)

b3
