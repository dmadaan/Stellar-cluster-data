%NGC1711 data and size
Mass1 = load('MNGC1711MESA.mat');
Mass = Mass1.Mass2; 
Mass = sort(Mass);
[n,m] = size(Mass); 


%MLE

custnlf = @(x,c)loglikeMLP(x,a,b,c)
start = [1, -2, 1];
[phat,pci] = mle(Mass,'nloglf',@loglikeMLP,'start',start,'lower',[0,-4,0],'upper',[5,5,5],'optimfun','fminsearch')