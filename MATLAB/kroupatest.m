%----------60 million MLR --------%


Mass1 = load('y2.mat');
Mass1 = Mass1.y2;
lm1 = log(Mass1); 
%------------------mass spectrum------------------%
[n,m] = size(Mass1);% n is the number of data points 
nbins = 2*(n)^(2/5);
nbins = ceil(nbins);

hist(log(Mass1),nbins)%%%% this is plotting in logspace with fixed distances.
[counts,centers] = hist(log(Mass1),nbins);


figure
plot(centers,counts,'^')


w = centers(1,2) - centers(1,1) 

fm = counts./(w.*n);%this is mfm
figure
plot (centers,log10(fm),'^')

lx1 = centers;%note this is ln and not log10
x1 = exp(lx1);
y1 = fm;%this is mfm
mly1 = log10(fm);

[m1,n1] = size(centers)
for i = 1:n1
    if mly1(1,i) == -Inf
        mly1(1,i) = NaN;
        y1(1,i) = NaN;
        x1(1,i) = NaN;
        lx1(1,i) = NaN;
    end
end
mly1(isnan(mly1)) = [];
x1(isnan(x1)) = [];
lx1(isnan(lx1)) = [];
y1(isnan(y1)) = [];
logx1 = log10(x1); 


figure 
plot(x1, y1,'^')
xlabel m
ylabel mfm

figure
plot(x1, mly1,'^')
xlabel m
ylabel logmfm
hold on 



%------------plotting LOG M vs. LOG (MFM) MLP for the paramters---------%
figure
plot(log10(x1), mly1,'^')
xlabel logm
ylabel logmf(m)
hold on 

x0 = logspace(-1.5,1,100); % these are linear values but logarithmically distirbuted.


%----------------plotting the pareto fit----------%
%we will have to do non-linear levenberg for this one too. 
a = 2.0946;
b = 0.08;
yp = (a.*b.^a)./(x0.^(a+1));
lyp = log10(x0.*yp);
plot(log10(x0),lyp,'b')
xlabel 'log(m)'
ylabel 'log(mf(m))'
