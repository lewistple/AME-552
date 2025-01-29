%% AME-552

% HW1 Problem 2 Part (a)

% Draw a phase portrait of the following system:
% dx1 = x2
% dx2 = -c*x2 - k1*x1 - k2*x1^3
% c > 0, k1 > 0, k2 > 0

%% Clear

clear, clc, close all;

%% Program Execution

% Constants
c = 1; k1 = 1; k2 = 1;

% Define the system
f = @(x1, x2) x2;               
g = @(x1, x2) -c*x2 - k1*x1 - k2*x1.^3;

% Define the grid
[x1, x2] = meshgrid(-5: 0.5: 5, -5: 0.5: 5);

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
title('Phase Portrait (c = k_1 = k_2 = 1)');
legend('Vector Field', 'Exact Solution');
axis equal;
ylim([-5 5]);
grid on;
hold off;
