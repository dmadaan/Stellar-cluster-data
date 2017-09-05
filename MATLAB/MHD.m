%MHD
c = 1;
G = 1;
s = 1;
Q = 1/4;
o = (Q*pi*G*s)/c;
k = linspace(0,10,100);
w = c^2.*k.^2 - 2*(pi*G*s).*k + 4*o^2;
plot(k,w,'g')
hold on 
Q = 0.5;
o = (Q*pi*G*s)/c;
w = c^2.*k.^2 - 2*(pi*G*s).*k + 4*o^2;
plot(k,w,'r')
hold on 
Q = 1;
o = (Q*pi*G*s)/c;
w = c^2.*k.^2 - 2*(pi*G*s).*k + 4*o^2;
plot(k,w,'b')
legend('Q=1/4','Q=1/2','Q=1')
ax = gca;
ax.XAxisLocation = 'origin';