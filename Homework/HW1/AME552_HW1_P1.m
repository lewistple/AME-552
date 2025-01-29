%% AME-552

% HW1 Problem 1

% Draw a phase portrait of the following system:
% dx1 = 2*x1 - x1*x2
% dx2 = -2*x1^2 - x2

%% Clear

clear, clc, close all;

%% Program Execution

% Define the system
f = @(x1, x2) 2*x1 - x1.*x2;                 
g = @(x1, x2) 2*x1.^2 - x2;

% Define the grid
[x1, x2] = meshgrid(-5: 0.5: 5, -10: 1: 10);

% Calculate vector field
dx1 = f(x1, x2);
dx2 = g(x1, x2);

% Normalize the vector field for better visualization
magnitude = sqrt(dx1.^2 + dx2.^2);
dx1 = dx1 ./ magnitude;
dx2 = dx2 ./ magnitude;

% Plot the vector field
figure;
quiver(x1, x2, dx1, dx2, 'r');    % Quiver plot
hold on;

% Plot trajectories using ode45
for x0 = -5:2.5:5                 % Initial conditions
    for y0 = -5:2.5:5
        [T, Y] = ode45(@(t, y) [f(y(1), y(2)); g(y(1), y(2))], [0, 10], [x0, y0]);
        plot(Y(:,1), Y(:,2), 'b'); % Trajectories
    end
end

% Label the axes
xlabel('x_1');
ylabel('x_2');
title('Phase Portrait');
legend('Vector Field', 'Exact Solution');
axis equal;
grid on;
hold off;
