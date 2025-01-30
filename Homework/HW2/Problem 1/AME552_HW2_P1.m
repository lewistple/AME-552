%% AME-552

% HW2 Problem 1

%% Clear

clear, clc, close all;

%% Program Execution

% Symbolic variables
A = 1;
D = 1;
tau = 1;
I = 1;

% Define the system
f = @(x1, x2) x2;                 
g1 = @(x1, x2) -A / I;
g2 = @(x1, x2) A / I;

% Define the grid
[x1, x2] = meshgrid(-5: 0.5: 5, -5: 0.5: 5);

% Calculate vector field
dx1 = f(x1, x2);

for i = 1: size(x1, 1)

    for j = 1: size(x1, 2)

        x1_o = x1(i, j);
        x2_o = x2(i, j);

        if tau*x2_o + x1_o >= D

            dx2(i, j) = g1(x1_o, x2_o);

        elseif tau*x2_o + x1_o <= -D

            dx2(i, j) = g2(x1_o, x2_o);

        else

            dx2(i, j) = nan;

        end

    end

end

% Normalize the vector field for better visualization
magnitude = sqrt(dx1.^2 + dx2.^2);
dx1 = dx1 ./ magnitude;
dx2 = dx2 ./ magnitude;

% Plot boundaries
figure; hold on;
fun1 = @(x) (1/tau) * (-D-x);
fun2 = @(x) (1/tau) * (D-x);
fplot(fun1, 'k', LineWidth=2);
fplot(fun2, 'b', LineWidth=2);
quiver(x1, x2, dx1, dx2, 'r');    % Quiver plot

% % Plot trajectories using ode45
% for x0 = -5:2.5:5                 % Initial conditions
%     for y0 = -5:2.5:5
%         [T, Y] = ode45(@(t, y) [f(y(1), y(2)); g1(y(1), y(2))], [0, 1], [x0, y0]);
%         plot(Y(:,1), Y(:,2), 'b'); % Trajectories
%     end
% end

% Label the axes
xlabel('x_1');
ylabel('x_2');
title('Phase Portrait');
legend('\taux_2+x_1=-D', '\taux_2+x_1=D', 'Vector Field');
axis equal;
grid on;
hold off;
