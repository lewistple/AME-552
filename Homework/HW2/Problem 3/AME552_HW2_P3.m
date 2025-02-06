%% AME-552

% HW2 Problem 3

%% Clear

clear, clc, close all;

%% Program Execution

% Define the system
f = @(x1, x2) x2; 
g = @(x1, x2) arrayfun(@g_func, x1, x2);

% Define the grid
[x1, x2] = meshgrid(-5: 0.5: 5, -5: 0.5: 5);

% Calculate vector field
dx1 = f(x1, x2);
dx2 = g(x1, x2);

% Normalize the vector field for better visualization
magnitude = sqrt(dx1.^2 + dx2.^2);
dx1 = dx1 ./ magnitude;
dx2 = dx2 ./ magnitude;

% Plot region boundaries
figure; hold on;
yline(-1, 'k', LineWidth=2);
yline(1, 'b', LineWidth=2);
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
legend('x_2=-1', 'x_2=1', 'Vector Field', 'Exact Solution');
axis equal;
grid on;
hold off;

%% Functions

function g = g_func(x1, x2)

    if x2 < -1
    
        g = -x1 + 1;
    
    elseif x2 > 1
    
        g = -x1 - 1;
    
    else
    
        g = -x1 - x2;
    
    end

end