%% AME-552

% Class exercise: Lecture 2

% Draw a phase portrait of the following system:
% dx1 = x2
% dx2 = -sin(x1)

%% Clear

clear, clc, close all;

%% First Method

x1_space = linspace(-5, 5, 20);
x2_space = linspace(-5, 5, 20);

[Y, X] = meshgrid(x1_space, x2_space);
U = zeros(length(x1_space));
V = zeros(length(x1_space));

for i = 1: length(x1_space)

    for j = 1: length(x2_space)
    
        x1 = x1_space(i);
        x2 = x2_space(j);

        % Slope
        S = -sin(x1)/x2;

        U(i, j) = 1;
        V(i, j) = S;

    end

end

% Plot vector field
figure;
quiver(X, Y, U, V);
axis equal;
xlim([-5 5]);
ylim([-5 5]);
xlabel('x_1');
ylabel('x_2');
title('Phase Portrait (1st Method)');

%% Second Method

% Define the system
f = @(x1, x2) x2;                 
g = @(x1, x2) -sin(x1);

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
for x0 = -5:1:5                 % Initial conditions
    for y0 = -5:1:5
        [T, Y] = ode45(@(t, y) [f(y(1), y(2)); g(y(1), y(2))], [0, 1], [x0, y0]);
        plot(Y(:,1), Y(:,2), 'b'); % Trajectories
    end
end

% Label the axes
xlabel('x_1');
ylabel('x_2');
title('Phase Portrait (2nd Method)');
legend('Vector Field', 'Exact Solution');
axis equal;
grid on;
hold off;
