%plotting it on the histogram
%NGC6611 data and size
Mass1 = load('MNGC1711.mat');
Mass = Mass1.Mass2; 
Mass = sort(Mass);
[n,m] = size(Mass);
lm1 = log(Mass); 
%------------------mass spectrum------------------%
[n,m] = size(Mass);% n is the number of data points 
nbins = 2*(n)^(2/5);
nbins = ceil(nbins);

hist(log(Mass),nbins)%%%% this is plotting in logspace with fixed distances.
[counts,centers] = hist(log(Mass),nbins);


figure
plot(centers,counts,'^')


w = centers(1,2) - centers(1,1) 

fm = counts./(w.*n);%this is mf which is probability

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
[k,l] = size(x1)

%------------plotting LOG M vs. LOG (MFM) MLP for the paramters---------%
figure
stairs(log10(x1), mly1 ,'k')
xlabel logm
ylabel logmf(m)
hold on 

%plotting MLP
a = 1.486;
b = -0.1094;
c = 0;
x0 = logspace(-1.5,1,100); % these are linear values but logarithmically distirbuted.
y0 = log10((a.*0.5).*exp((a.*b)+((a.*c).^2.*0.5)).*x0.^(-a).*erfc(((a.*c)-((log(x0)-b)./c))./sqrt(2)));
plot(log10(x0),y0,'g')

%------------plotting LOG M vs. LOG (MFM)chab for the paramters---------%

hold on

%plotting pareto
alpha = -2.9062
x0 = logspace(-0.05,1.2,100);
y0 = log10(-(alpha + 1).*x0.^(alpha + 1));
plot(log10(x0),y0,'r')
hold on
%------------plotting LOG M vs. LOG (MFM) Kroupa for the paramters---------%

alpha3 = -2.9062
xmax1 = 0.08 ;
xmax2 = 0.50 ;
pareto1 = @(x) -(alpha3 + 1).*x.^(alpha3 + 1);
x = logspace(-0.05,1,100);
y = log10(pareto1(x));
plot(log10(x),y,'b')