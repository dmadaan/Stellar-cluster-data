%Random Numbers generation!
N=200

% get normal random variable
Nrand = normrnd(0,1,10000,1);
% get uniform random variable
%generating uniform random numbers in the interval (0, 0.8)
A = 0;
B = 1;
Urand = A + (B-A).*rand(10000,1);

% set parameters of MLP below as desired
% values below provide best fit to Chabrier (2005) IMF as explained in Basu, Gil, & Auddy (2015)

mu = -2.404
sigma = 1.044
alpha = 1.396
%plotting MLP
a = alpha;
b = mu;
c = sigma;
x0 = logspace(-2.5,2.5,100); % these are linear values but logarithmically distirbuted.
y0 = log10((a.*0.5).*exp((a.*b)+((a.*c).^2.*0.5)).*x0.^(-a).*erfc(((a.*c)-((log(x0)-b)./c))./sqrt(2)));
plot(log10(x0),y0,'g')

% draw random sample from MLP distribution
mass = exp(mu + sigma.*Nrand - log(Urand)./alpha);

% can generate a histogram of mass or alog10(mass) using these values

[n,m] = size(mass);% n is the number of data points 
nbins = 2*(n)^(2/5);
nbins = ceil(nbins);

hist(log(mass),nbins)%%%% this is plotting in logspace with fixed distances.
[counts,centers] = hist(log(mass),nbins);


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
[k,l] = size(x1)


%------------plotting LOG M vs. LOG (MFM) MLP for the paramters---------%
figure
plot(log10(x1), mly1,'^')
xlabel logm
ylabel logmf(m)
hold on 

%plotting MLP
a = alpha;
b = mu;
c = sigma;
x0 = logspace(-2.5,2.5,100); % these are linear values but logarithmically distirbuted.
y0 = log10((a.*0.5).*exp((a.*b)+((a.*c).^2.*0.5)).*x0.^(-a).*erfc(((a.*c)-((log(x0)-b)./c))./sqrt(2)));
plot(log10(x0),y0,'g')