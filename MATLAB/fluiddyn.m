% Finite Difference code
tic
N  = 1000;   % No. of grid points
L  = 2 ;     % grid length
l  = 1 ;     % Wavelength
cs = 1;      % sound speed
dx = L/N;    % space interval
nu = 0.1;    % Courant no.
dt = nu*dx;  % time interval
tmax = 1.0;  % maximum time
M = ceil(tmax/dt); % No. of time steps 
r1 = 0.3;    % density perturbation
r0 = 1 ;     % initial density
v1 = r1/r0;  % velocity perturbation
% making arrays for rho and v. First row represents the boundary values
% which is known at timestep 0 for both rho and v. 

rho = zeros(N,N);         
v = zeros(N,N);

%defining boundary conditions! note 1st row represent time and column
%space. i = time, j = space i.e. row corresponds to time and column to
%space

for j= 1:N
   rho(1,j) = r0 + r1*cos(2*pi*(j-1)*dx/l);
   v(1,j)   = v1*cos(2*pi*(j-1)*dx/l);
end
% the first column and last columns are dummy for periodicity. 
rho = [ rho(:,N) rho rho(:,1)];
v = [ v(:,N) v v(:,1)];
S = N+2;

%marching forward in time
%We first move different columns i.e. forward in space so keep time fixed and
%then move forward in time i.e. row.


for i = 1:M-1
    for j = 2:S-1
        rho(i+1,j) = (rho(i,j+1) + rho(i,j-1))/2 - (nu/2)*(rho(i,j+1)*v(i,j+1) - rho(i,j-1)*v(i,j-1));
        v(i+1,j) = (1/rho(i+1,j))*((rho(i,j+1)*v(i,j+1) + rho(i,j-1)*v(i,j-1))/2 - ...
            (nu/2)*(rho(i,j+1)*v(i,j+1)*v(i,j+1) - rho(i,j-1)*v(i,j-1)*v(i,j-1)) - (nu/2)*(rho(i,j+1)- rho(i,j-1)));

    end
    rho(i+1,1) = rho(i+1,S-1);
    rho(i+1,S) = rho(i+1,1);
    v(i+1,1) = v(i+1,S-1);
    v(i+1,S) = v(i+1,1);
  
end

rho = rho(:,2:S-1);
v = v(:,2:S-1);
   
rho = rho - r0;

%S here is the dummy variable for size! 
for i=1:N
    x(i)=(i-1)*dx;
end
toc

plot(x,v(1500,:),'b');
hold on
plot(x,v(2500,:),'g');
hold on 
plot(x,v(5000,:),'r');


figure 
plot(x,rho(1500,:),'b');
hold on
plot(x,rho(2500,:),'g');
hold on 
plot(x,rho(5000,:),'r');
toc

figure


plot(x,v(M,:),'b');
hold on 
plot(x,rho(M,:),'r');

toc