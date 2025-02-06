%% AME-552

% HW2 Problem 4

%% Clear

clear, clc, close all;

%% Program Execution

% Symbolic variables
kp = 1;
ki = 2;
kb = 1;
A = 1;
B = 1;
J = 1;
wc = 0.5;
% k = A/B;
% ans = (kp*k + kb)/(2*sqrt(k*ki));

% Define the system
f = @(x1, x2) x2; 
g = @(x1, x2) arrayfun(@g_func, x1, x2, kp*ones(size(x1)), ki*ones(size(x1)), kb*ones(size(x1)), A*ones(size(x1)), B*ones(size(x1)), J*ones(size(x1)), wc*ones(size(x1)));

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
fun1 = @(x) (-B - ki*x)/kp;
fun2 = @(x) (B - ki*x)/kp;
fplot(fun1, 'k', LineWidth=2);
fplot(fun2, 'b', LineWidth=2);
quiver(x1, x2, dx1, dx2, 'r');    % Quiver plot

% Plot trajectories using ode45
for x0 = -5:1:5                 % Initial conditions
    for y0 = -5:1:5
        [T, Y] = ode45(@(t, y) [f(y(1), y(2)); g(y(1), y(2))], [0, 3], [x0, y0]);
        plot(Y(:,1), Y(:,2), 'b'); % Trajectories
    end
end

% Label the axes
xlabel('x_1');
ylabel('x_2');
title('Phase Portrait');
legend('k_px_2+k_Ix_1=-B', 'k_px_2+k_Ix_1=B', 'Vector Field', 'Exact Solution');
axis equal;
grid on;
ylim([-5 5]);
hold off;

%% Functions

function g = g_func(x1, x2, kp, ki, kb, A, B, J, wc)

    if kp*x2 + ki*x1 < -B

        g = -(kb*(wc + x2) - A)/J;

    elseif kp*x2 + ki*x1 > B

        g = -(kb*(wc + x2) + A)/J;

    else

        g = -(kb*(wc + x2) + (A/B)*(kp*x2 + ki*x1))/J;

    end

end