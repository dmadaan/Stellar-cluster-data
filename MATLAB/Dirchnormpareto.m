%%%% normalizing

fun = @(x) (0.093./x).*exp(-((log10(x)-log10(0.2)).^2)/(2*(0.55)^2));

a = integral(fun,0.06,1)

power = @(x) ((0.041./0.9288)).*(0.9288.*x.^(-2.711));% this seems to be normalized for the data when we can power law exponent as 2.877

b = integral(power,1,10)

A = 1/(a+b)

%%%%checking normalization
fun = @(x) (A.*0.093./x).*exp(-((log10(x)-log10(0.2)).^2)/(2*(0.55)^2));
a1 = integral(fun,0.06,0.9660);
power = @(x) (A.*(0.041./0.9288)).*(0.9288.*x.^(-2.711));
b1 = integral(power,1,10);
a1+b1
N = A.*(0.041./0.9288);

x0 = logspace(0,1,58);
y0 = power(x0);
x2 = logspace(-1.2218,0,58);%generating same number of points as for the MLP 
y2 = fun(x2);% this is just fm
my2 = x2.*y2;%this is mfm
mly2 = log10(my2);
figure
plot(x0,y0,x2,y2)
figure
plot(log10(x0),log10(x0.*y0),log10(x2),log10(x2.*y2))
title 'log'

% Some normalization issue with the data! 


%-----------------Now the data for combining--------------------%
%----------60 million MLR --------%


Mass1 = load('DirMass1.mat');
Mass1 = Mass1.Mass1;
lm1 = log(Mass1); % this is natural log but chabrier takes log10
%------------------mass spectrum------------------%
[n,m] = size(Mass1);% n is the number of data points 
nbins = 2*(n)^(2/5);
nbins = ceil(nbins);

figure
hist(log(Mass1),nbins)%%%% this is plotting in logspace with fixed distances.
[counts,centers] = hist(log(Mass1),nbins);


figure
plot(centers,counts,'^')


w = centers(1,2) - centers(1,1) 

mfm = counts./(w.*n);%this is mfm
figure
plot (centers,log10(mfm),'^')

lx1 = centers;%note this is ln and not log10
x1 = exp(lx1);
y1 = N.*mfm;%this is mfm with normalization
mly1 = log10(N.*mfm);

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

%deleting first data point to reach some convergence for MLP fit
[k,l]=size(x1)
x1 = x1(4:l)
mly1 = mly1(4:l)
y1 = y1(4:l)

xdata = x2;
mlydata = mly2;

for i=1:58
    xdata(58+i) = x1(i);
    mlydata(58+i) = mly1(i);
end

xdata = xdata';
mlydata = mlydata';

T = table(xdata,mlydata);


filename = 'deepu.csv';
writetable(T,filename)

figure
plot(xdata,mlydata,'^')

figure 
plot(x1, y1,'^')
xlabel m
ylabel mfm
hold on 
plot(x2, my2,'^')


figure
plot(log10(x1), mly1,'^')
xlabel m
ylabel logmfm
hold on 
plot(log10(x2), log10(my2),'^')




%%%%plotting best fit MLP obtained from Mathematica

hold on
a =  2.509;
b = -1.88369;
c = 1.017;
x = xdata;
MLP = log10((a.*0.5).*exp((a.*b)+(((a.*c).^2).*0.5)).*x.^(-a).*erfc(((a.*c)-((log(x)-b)./c))./sqrt(2)));
plot(log10(x),MLP,'m','linewidth',1)

hold on
a = 1.878;
b = 0.06497;
c = 0.00202;
x0 = logspace(0.03,1,100); % these are linear values but logarithmically distirbuted.
y0 = log10(N.*(a.*0.5).*exp((a.*b)+((a.*c).^2.*0.5)).*x0.^(-a).*erfc(((a.*c)-((log(x0)-b)./c))./sqrt(2)));
plot(log10(x0),y0,'g','linewidth',1)



