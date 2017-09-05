%plotting it on the histogram
%NGC6611 data and size
Mass1 = load('MNGC6611.mat');
Mass1 = Mass1.highmass; 
Mass2 = load('lowmassNGC6611.mat');
Mass2 = Mass2.lowmass;
Mass = [Mass1 ;Mass2];
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
p1 = stairs(log10(x1), mly1,'k')
xlabel logm
ylabel logmf(m)
hold on 

%plotting MLP
a = 4.3833;
b = -0.9225;
c = 0.9958;
x0 = logspace(-2,1,100); % these are linear values but logarithmically distirbuted.
y0 = log10((a.*0.5).*exp((a.*b)+((a.*c).^2.*0.5)).*x0.^(-a).*erfc(((a.*c)-((log(x0)-b)./c))./sqrt(2)));
p2 = plot(log10(x0),y0,'g')

%------------plotting LOG M vs. LOG (MFM)chab for the paramters---------%
hold on 
%plotting lognormal
mu =  -1.0303
sigma = 0.8936
x = logspace(-2,0,100);
y = log10(normpdf(log(x),mu1,sigma1));
p3 = plot(log10(x),y,'r')
hold on 
%plotting pareto
alpha = -3.2667
x0 = logspace(0,1,100);
y0 = log10(0.021.*-(alpha + 1).*x0.^(alpha + 1));
plot(log10(x0),y0,'r')
hold on
%------------plotting LOG M vs. LOG (MFM) Kroupa for the paramters---------%
alpha1 = 0.8842
alpha2 = 0.3745
alpha3 = -2.52
xmax1 = 0.08 ;
xmax2 = 0.50 ;

power = @(x) (alpha1 + 1).*(xmax1.^(-alpha1-1)).*x.^(alpha1+1);
trunc = @(x) (alpha2 + 1).*((xmax2.^(alpha2+1)-xmax1.^(alpha2+1)).^(-1)).*x.^(alpha2+1); 
pareto1 = @(x) -(alpha3 + 1).*(xmax2.^(-alpha3-1)).*x.^(alpha3 + 1);


%plotting power
x = logspace(-2,-1.0969,100);
y = log10(0.058.*power(x));
p4 = plot(log10(x),y,'b')
hold on 
x = logspace(-1.0969,-0.3010,100);
y = log10(0.9.*trunc(x));
plot(log10(x),y,'b')
hold on 
x = logspace(-0.3010,1,100);
y = log10(0.9.*pareto1(x));
plot(log10(x),y,'b')

legend([p1,p2,p3,p4],'NGC6611','MLP','Chabrier','Kroupa')