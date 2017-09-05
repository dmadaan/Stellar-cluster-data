%Evaluating Chabrier paramters!

%Evaluating the parameters of lognormal distribution using MLE

Mass1 = load('below1ONC.mat');
x =  Mass1.x1;

[mu sigma] = mle_lognormal(x)


%Pareto distribution 
Mass2 = load('above1ONC.mat');
x0 =  Mass2.x2;

alpha = mle_pareto(x0,1) %can use mle_power or mle_pareto(same thing)


%Evaluating Kroupa paramters!
%dividing into different domains!

Mass = load('MONC.mat')
y = Mass.Mass;

y = sort(y);

[n,m] = size(y)
j = 1;
k = 1;
l= 1;
m = 1;
for i= 1:n
    if y(i) <= 0.08
        y1(j,1)= y(i);
        j=j+1;
 
    elseif (y(i) > 0.08) && (y(i) <= 0.5)
        y2(k,1)= y(i);
        k=k+1;
        
    elseif (y(i) >= 0.5) %&& (y(i) <= 1)
        y3(l,1) = y(i);
        l = l+1;
    %elseif y(i)>= 1
        %y4(m,1) = y(i);
         %m = m+1;
    end
    
end

alpha1 = mle_pareto(y1,0.08)
alpha2 = mle_pareto(y2,0.08)
alpha3 = mle_pareto(y3,0.5)
%alpha4 = mle_pareto(y4,1)




