%% AME-552

% HW3 Problem 3

%% Clear

clear, clc, close all;

%% Part (b)

% Symbolic expressions
syms A real positive

a = 4/(3*pi);
w = sqrt(2);

% Describing function of nonlinear system
N = (4/(pi*A)) * sqrt(1 - (a/A)^2);

% Linear system
s = 1i * w;
G = 4/(s*(s+1)*(s+2));

% Characteristic equation
delta_eqn1 = real(1 + N*G) == 0;
delta_eqn2 = abs(imag(1 + N*G)) <= 1e-10;

% Solve
S = solve([delta_eqn1 delta_eqn2], A);
% disp(S.A);
% disp(S.w);
disp(S);

%% Part (b) 2nd Method

% Find relationship between a and A
a = @(A) sqrt((64*A^2 - 9*pi^2*A^4)/64);

figure; 
fplot(a, [0 1], LineWidth=2); grid on
xlabel('A');
ylabel('a');
title('a vs. A');

%% Part (c)

% TF Variable
s = tf('s');

% Plant
G = 4/(s*(s+1)*(s+2));

a_cr = 4/(3*pi);
k = 0.5;
a = k*a_cr;


Nline_Re = @(A) -1 / ((4/(pi*A)) * sqrt(1 - (a/A)^2));  
Nline_Im = @(A) 0; 

figure; 
nyquist(G); hold on;
fplot(Nline_Re, Nline_Im, [0 0.3], 'r');
xlim([-3 1]);
ylim([-2 2]);

%% Part (d)

% Symbolic variables
a_cr = 4/(3*pi);
k = 0.5;
a = k*a_cr;

% Limit cycle amplitude and frequency
A1 = (8/(3*pi)) * sqrt((1-sqrt(1-k^2))/2);
A2 = (8/(3*pi)) * sqrt((1+sqrt(1-k^2))/2);
w = sqrt(2);

% Define the system
f = @(x1, x2, x3) x2;
g = @(x1, x2, x3) x3;
h = @(x1, x2, x3) arrayfun(@h_func, x1, x2, x3, a*ones(size(x1)));

% Define the grid
[x1, x2, x3] = meshgrid(-5: 0.5: 5, -1: 0.1: 1, -5: 0.5: 5);

% Calculate vector field
dx1 = f(x1, x2, x3);
dx2 = g(x1, x2, x3);
dx3 = h(x1, x2, x3);

% Normalize the vector field for better visualization
magnitude = sqrt(dx1.^2 + dx2.^2 + dx3.^2);
dx1 = dx1 ./ magnitude;
dx2 = dx2 ./ magnitude;
dx3 = dx2 ./ magnitude;

% Initial conditions
x0 = [0   0.2 1 2];
y0 = [0.1 0.2 0 3];
z0 = [0.2 0.2 0 3];
for i = 1: length(x0)                

    % Plot limit cycles
    figure(i); hold on;
    plotLimitCycle(A1, w, '-r');
    plotLimitCycle(A2, w, '-k');
    view(3);

    % Plot trajectories using ode45
    [T, Y] = ode45(@(t, y) [f(y(1), y(2), y(3)); g(y(1), y(2), y(3)); h(y(1), y(2), y(3))], [0 10], [x0(i) y0(i) z0(i)]);
    plot3(Y(:,1), Y(:,2), Y(:,3), 'b'); % Trajectories

    % Plot vector field
    step = 40;
    dY1 = f(Y(:, 1), Y(:, 2), Y(:, 3));
    dY2 = g(Y(:, 1), Y(:, 2), Y(:, 3));
    dY3 = h(Y(:, 1), Y(:, 2), Y(:, 3));
    magnitude = sqrt(dY1.^2 + dY2.^2 + dY3.^2);
    dY1 = dY1 ./ magnitude;
    dY2 = dY2 ./ magnitude;
    dY3 = dY3 ./ magnitude;
    quiver3(Y(1:step:end,1), Y(1:step:end,2), Y(1:step:end,3), ...
        dY1(1:step:end), dY2(1:step:end), dY3(1:step:end), ...
        0.5, 'LineWidth', 1);

    % Label the axes
    xlabel('$y$', 'Interpreter', 'latex');
    ylabel('$\dot{y}$', 'Interpreter', 'latex');
    zlabel('$\ddot{y}$', 'Interpreter', 'latex');
    title(sprintf('Phase Portrait\n Initial Condition: [%.1f %.1f %.1f]', x0(i), y0(i), z0(i)));
    legend('Limit Cycle (Unstable)', 'Limit Cycle (Stable)', 'Exact Solution', 'Vector Field');
    axis equal;
    grid on;
    hold off;

end

%% Functions

% Piecewise function h
function h = h_func(x1, x2, x3, a)

    if x1 < -a
    
        N = -1;
    
    elseif x1 > a
    
        N = 1;
    
    else

        N = 0;

    end

    h = -4*N - 2*x2 - 3*x3;

end

% Plot limit cycle
function plotLimitCycle(A, w, style)

    y = @(t) A * sin(w*t);
    dy = @(t) A*w * cos(w*t);
    ddy = @(t) -A*w^2 * sin(w*t);

    hold on;
    fplot3(y, dy, ddy, style, LineWidth=2);

end