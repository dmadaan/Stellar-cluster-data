%------------------OPTIMIZING THE LOGLIKEMLP---------------%
%initial parameter values
x0 = [1 -2 1];
lb = [0;-4;0];
ub = [5;5;5];

%ONC data and size
Mass1 = load('MNGC1711MESA.mat');
Mass = Mass1.Mass2; 
Mass = sort(Mass);
[n,m] = size(Mass); 


%parameters from optim using simulated annealing

[x,fval,exitflag,output] = simulannealbnd(@(c)loglikeMLP(Mass,c),x0,lb,ub)

%calculating the loglike value for the best fit paramters

par1 = [x(1) x(2) x(3)]
[e,f] = size(par1);

% writing the parameters
%par1 = [1.9004 -0.1094 0.00];
el_mlp = 2*loglikeMLP(Mass,par1)% -2lnL

%-2LogL =  3.8535e+03( depends on the number of iterations
%x = 1.9733 -0.1094 0

%Computing AIC & BIC

AIC_mlp = 2*3 + el_mlp

BIC_mlp = 3*log(n) + el_mlp




%---------------OPTIMIZING THE LOGLIKECHAB----------------%

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

%Now computing the parameters for lognormal and pareto using MLE
%Chabrier MLE
[mu,var] = mle_lognormal(below1solar)%this is variance = sigma^2 
% gives wierd result

%lognormal

[phat,pci] = mle(below1solar,'distribution','logn') 
%correct value reconfirmed from simullognormal

%so the peak is at 0.2 solar masses which is fine!from graph on plotting as
%a histogram we get 0.15 which is very close.

%pareto
xmin = 1 ;
alpha = mle_pareto(above1solar,xmin) %note this is alpha positive
%note that alpha+1 is in the likehood code for f(logm))
%Computing AIC & BIC

l1 = loglikepareto(above1solar,alpha,xmin)
l2 = loglikelognormal(below1solar,phat)
el_chab = 2*(l1 + l2 - n*log(0.5034));% this is -2lnL
%chab has 4 paramters + 1 for the normalization!%fixing the joining
%conditions therefore only 3 parameters

AIC_chab = 2*3 + el_chab 

BIC_chab = 3*log(n) + el_chab
%-----------------------Only pareto no break point-------------%
%so the peak is at 0.2 solar masses which is fine!from graph on plotting as
%a histogram we get 0.15 which is very close.

%pareto
xmin = min(Mass) ;
alphap = mle_pareto(Mass,xmin) %note this is alpha positive
%note that alpha+1 is in the likehood code for f(logm))
%Computing AIC & BIC

l1 = loglikepareto(Mass,alphap,xmin)
el_chab1 = 2*(l1);% this is -2lnL
%chab has 4 paramters + 1 for the normalization!

AIC_chab1 = 2*3 + el_chab1 %3 paramters because fixing the joining conditions.

BIC_chab1 = 3*log(n) + el_chab1 %3 because only 3 free while 1 is fixed


%---------------OPTIMIZING THE LOGLIKEKROUPA----------------%



%pareto

xmin3 = min(Mass) ;
alpha3 = mle_pareto(Mass,xmin3) 

%computing the loglikelihood
l3 = loglikepareto(Mass,alpha3,xmin3);
el_kroupa = 2*(l3);

%kroupa has 5 paramters but 2 are fixed therefore only 3 free parameters
AIC_kroupa = 2*2 + el_kroupa

BIC_kroupa = 2*log(n) + el_kroupa

%---------------OPTIMIZING THE LOGLIKEKROUPA with 0.50 as the breaking point----------------%



%pareto

xmin3 = min(Mass) ;
alpha3 = mle_pareto(Mass,0.50) 

%computing the loglikelihood
l4 = loglikepareto(Mass,alpha3,0.50);
el_kroupa1 = 2*(l4);

%kroupa has 5 paramters but 2 are fixed therefore only 3 free parameters
AIC_kroupa1 = 2*2 + el_kroupa1

BIC_kroupa1 = 2*log(n) + el_kroupa1

%-------------Akaike weights-----------%
AIC = [AIC_chab;AIC_chab1;AIC_kroupa;AIC_kroupa1;AIC_mlp];
AICmin = min(AIC)

dAIC = AIC - AICmin;
rellike = exp(-dAIC/2);
sumrel = sum(rellike);

w = rellike/sumrel;