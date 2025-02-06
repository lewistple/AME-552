%% AME-552

% HW2 Problem 2

%% Clear

clear, clc, close all;

%% Program Execution

% Symbolic variables
alpha = 1;
beta = 1;
C = 0.9;
D = 1;
M = 1;

% Define the system
f = @(x1, x2) x2; 
g = @(x1, x2) arrayfun(@g_func, x1, x2, alpha*ones(size(x1)), beta*ones(size(x1)), C*ones(size(x1)), D*ones(size(x1)), M*ones(size(x1)));

% Define the grid
[x1, x2] = meshgrid(-5: 0.5: 5, -5: 0.5: 5);

% Calculate vector field
dx1 = f(x1, x2);
dx2 = g(x1, x2);

% Normalize the vector field for better visualization
magnitude = sqrt(dx1.^2 + dx2.^2);
dx1 = dx1 ./ magnitude;
dx2 = dx2 ./ magnitude;

% Plot boundaries
figure; hold on;
xline(-D, 'k', LineWidth=2);
xline(D, 'b', LineWidth=2);
quiver(x1, x2, dx1, dx2, 'r');    % Quiver plot

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
legend('x_1=-D', 'x_1=D', 'Vector Field', 'Exact Solution');
axis equal;
grid on;
hold off;

%% Functions

function g = g_func(x1, x2, alpha, beta, C, D, M)

    if x1 < -D
    
        g = -alpha*x2 - beta*x1 + beta*C + M;
    
    elseif x1 > D
    
        g = -alpha*x2 - beta*x1 + beta*C - M;
    
    else
    
        g = -alpha*x2 - beta*x1 + beta*C;
    
    end

end