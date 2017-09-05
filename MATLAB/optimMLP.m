%particle swarm optimization! Restricting the domain for the paramter
%values!
% See how the algorithm works! 

% can also use simulated annealing with the same upper and lower bounds! 
% It is a Monte Carlo stochastic optimization routine. 

fun = @loglikechab;
nvars = 3;
rng default
lb = [0;-4;0];
ub = [5;5;5];
[x,fval,exitflag] = particleswarm(fun,nvars,lb,ub)




