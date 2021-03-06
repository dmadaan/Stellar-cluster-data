
%NGC6611 data and size
Mass1 = load('MNGC6611.mat');
Mass1 = Mass1.highmass; 
Mass2 = load('lowmassNGC6611.mat');
Mass2 = Mass2.lowmass;
Mass = [Mass1 ;Mass2];
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
mu =  -1.3872
sigma = 0.5597
fun = @(x) lognpdf(x,mu,sigma)
a1 = integral(fun,x1,x2)

alpha = -2.2959
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
j = 1;
k = 1;
l = 1;
for i = 1:n 
    if Mass(i)< 0.08
        M1(j,1) = Mass(i);
        j = j+1;
    else if Mass(i)< 0.50
            M2(k,1) = Mass(i);
            k = k+1;
        else
            M3(l,1) = Mass(i);
            l = l+1; 
        end
    end
end

y1 = min(M1);
y2 = min(M2);
y3 = min(M3);
y4 = max(M3);
alpha1 = 2.0996
alpha2 = -0.8080
alpha3 = -1.9826
xmax1 = 0.08 ;
xmax2 = 0.50 ;

power = @(x) (alpha1 + 1).*(xmax1.^(-alpha1-1)).*x.^(alpha1);
b1 = integral(power,y1,y2)

trunc = @(x) (alpha2 + 1).*((xmax2.^(alpha2+1)-xmax1.^(alpha2+1)).^(-1)).*x.^(alpha2); 
b2 = integral(trunc,y2,y3)

pareto1 = @(x) -(alpha3 + 1).*(xmax2.^(-alpha3-1)).*x.^(alpha3);
b3 = integral(pareto1,y3,y4)
b1 + b2 +b3

A2 = 1/(b1+b2+b3)
%A2 we get is 0.4743

power = @(x) A2.* power(x)
b1 = integral(power,y1,y2)
trunc = @(x) A2.* trunc(x)
b2 = integral(trunc,y2,y3)
pareto1 =  @(x) A2.* pareto1(x)
b3 = integral(pareto1,y3,y4)

b1 + b2 +b3
