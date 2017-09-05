
%NGC2024 only has lognormal behavior
%------------------OPTIMIZING THE LOGLIKEMLP---------------%
%initial parameter values
x0 = [1 -2 1];
lb = [0;-4;0];
ub = [5;5;5];

%ONC data and size
Mass = load('MNGC2024.mat');
Mass = Mass.Mass;
Mass = sort(Mass); 
[n,m] = size(Mass); 


%parameters from optim using simulated annealing

[x,fval,exitflag,output] = simulannealbnd(@(c)loglikeMLP(Mass,c),x0,lb,ub)

%calculating the loglike value for the best fit paramters

par1 = [x(1) x(2) x(3)]
[e,f] = size(par1);

el_mlp = 2*loglikeMLP(Mass,par1)% -2lnL
par1 = [36.45 -2.28 0.988]
el_mlp1 = 2*loglikeMLP(Mass,par1)% -2lnL
%-2LogL = 

%Computing AIC & BIC

AIC_mlp = 2*3 + el_mlp

BIC_mlp = 3*log(n) + el_mlp

%AIC = 5396.3
%BIC =  2718.7


%---------------OPTIMIZING THE LOGLIKECHAB----------------%


%ONLY lognormal

[phat,pci] = mle(Mass,'distribution','logn') 
%correct value reconfirmed from simullognormal

%so the peak is at 0.2 solar masses which is fine!from graph on plotting as
%a histogram we get 0.15 which is very close.

%Computing AIC & BIC

l2 = loglikelognormal(Mass,phat)
el_chab = 2*( l2 );% this is -2lnL
%chab has 4 paramters + 1 for the normalization!
%4 but only 3 free parameters
AIC_chab = 2*3 + el_chab 

BIC_chab = 3*log(n) + el_chab

%---------------OPTIMIZING THE LOGLIKEKROUPA----------------%
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

%pareto
xmax1 = 0.08 ;
alpha1 = mle_pareto(M1,xmax1) %note this is alpha positive

%truncated
xmin2 = 0.08;
xmax2 = 0.50;
alpha2 = mle_truncpareto(M2,xmin2,xmax2)

%pareto

xmin3 = 0.50 ;
alpha3 = mle_pareto(M3,xmin3) 

%computing the loglikelihood
l1 = loglikepower(M1,alpha1,xmax1);
%l1 = 0;
l2 = logliketrunc(M2,alpha2,xmin2,xmax2);
l3 = loglikepareto(M3,alpha3,xmin3);
el_kroupa = 2*(l1 + l2 +l3 -n*log(0.4054));

%kroupa has 5 paramters but 2 fixed therefore only 3 free parameters
AIC_kroupa = 2*3 + el_kroupa

BIC_kroupa = 3*log(n) + el_kroupa

%-------------Akaike weights-----------%
AIC = [AIC_chab;AIC_kroupa;AIC_mlp];
AICmin = min(AIC)

dAIC = AIC - AICmin;
rellike = exp(-dAIC/2);
sumrel = sum(rellike);

w = rellike/sumrel;
