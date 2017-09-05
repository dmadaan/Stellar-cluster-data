%----------Sayantan --------%


Mass1 = load('Mass1dirsch.mat');
Mass1 = Mass1.Mass1;
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