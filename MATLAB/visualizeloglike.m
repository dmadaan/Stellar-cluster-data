%3D visualization of the loglikelihood function with contours 
%keeping alpha 'a' constant.

%Let X = mean 'b' and Y = sigma 'c'

% Generate the grid
[X,Y] = meshgrid(-4:0.035:4,-4:0.035:4);
% Compute the intensity over the grid
Z = arrayfun(@(x,y) loglikeMLPsigma([x y]),X,Y); 
%we get Z complex for sigma and mu constant! 

% Plot the surface 
figure
surf(X,Y,Z,'EdgeColor','none')
xlabel('x')
ylabel('y')
zlabel('intensity')

