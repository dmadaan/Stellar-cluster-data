%initial parameter values
x0 = [-2 1];
lb = [-4;0];
ub = [5;5];

%ONC data and size
Mass1 = load('below1ONC.mat');
Mass1 = Mass1.x1;
[n,m] = size(Mass1); 

%parameters from optim using simulated annealing

[x,fval,exitflag,output] = simulannealbnd(@(c)loglikelognormal(Mass1,c),x0,lb,ub)

loglikelognormal(below1solar,x)

x = [-1.5446 0.83]
loglikelognormal(below1solar,x)