
%NGC2024 data and size
Mass = load('MNGC2024.mat');
Mass = Mass.Mass;
Mass = sort(Mass); 
[n,m] = size(Mass); 



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
alpha1 = 0.3164
alpha2 = -1.2195
alpha3 = -5.0259
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
