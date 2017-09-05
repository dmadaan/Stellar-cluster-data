%plotting it on the histogram

Mass1 = load('MNGC2024.mat');
Mass1 = Mass1.Mass;
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

fm = counts./(w.*n);%this is mfm which is probability and not number

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
[k,l] = size(x1)



%------------plotting LOG M vs. LOG (MFM) MLP for the paramters---------%
figure
p1 = stairs(log10(x1), mly1,'k')
xlabel logm
ylabel logmf(m)
hold on 
%plotting MLP
a = 4.49;
b = -2.28;
c = 0.98;
x0 = logspace(-1.7,-0.15,100); % these are linear values but logarithmically distirbuted.
y0 = log10((a.*0.5).*exp((a.*b)+((a.*c).^2.*0.5)).*x0.^(-a).*erfc(((a.*c)-((log(x0)-b)./c))./sqrt(2)));
p2 = plot(log10(x0),y0,'g')
hold on
%------------plotting LOG M vs. LOG (MFM) chabrier for the paramters---------%

%plotting lognormal
mu1 = -2.0688
sigma1 = 1.0064
x = logspace(-1.7,0,100);
y = log10(normpdf(log(x),mu1,sigma1));
p3 = plot(log10(x),y,'r')
hold on 


%------------plotting LOG M vs. LOG (MFM) Kroupa for the paramters---------%
alpha1 = 0.3164
alpha2 = -1.2195
alpha3 = -5.0259
xmax1 = 0.08 ;
xmax2 = 0.50 ;

power = @(x) (alpha1 + 1).*(xmax1.^(-alpha1-1)).*x.^(alpha1+1);
trunc = @(x) (alpha2 + 1).*((xmax2.^(alpha2+1)-xmax1.^(alpha2+1)).^(-1)).*x.^(alpha2+1); 
pareto1 = @(x) -(alpha3 + 1).*(xmax2.^(-alpha3-1)).*x.^(alpha3 + 1);


%plotting power
x = logspace(-1.7,-1.0969,100);
y = log10(0.33.*power(x));
p4 = plot(log10(x),y,'b')
hold on 
x = logspace(-1.0969,-0.3010,100);
y = log10(0.65.*trunc(x));
plot(log10(x),y,'b')
hold on 
x = logspace(-0.3010,-0.15,100);
y = log10(0.0712.*pareto1(x));
plot(log10(x),y,'b')

legend([p1,p2,p3,p4],'NGC2024','MLP','Chabrier','Kroupa')