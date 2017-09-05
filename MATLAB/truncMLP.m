%plotting truncated MLP
a = 1.421;
b = -2.071;
c = 0.351;

%T = 2 is the ideal number when d = 1! i.e. \gamma
d = 1;
T = 2;
x0 = logspace(-1.5,3,100); % these are linear values but logarithmically distirbuted.
y0 = log10((a.*0.5).*exp((a.*b)+((a.*c).^2.*0.5)).*x0.^(-a).*(erf(((a.*c)-((log(x0)-b-d*T)./c))./sqrt(2))-erf(((a.*c)-((log(x0)-b)./c))./sqrt(2))));
plot(log10(x0),y0,'^')

hold on 
%MLP
y1 = log10((a.*0.5).*exp((a.*b)+((a.*c).^2.*0.5)).*x0.^(-a).*erfc(((a.*c)-((log(x0)-b)./c))./sqrt(2)));
plot(log10(x0),y1,'b')
