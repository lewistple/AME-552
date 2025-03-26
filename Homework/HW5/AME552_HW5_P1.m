%% AME-552

% HW5 Problem 1

%% Clear

clear, clc, close all;

%% Part (a)

syms t x1(t) x2(t) V(x1, x2)

V = (-x1-x2)^2 + (2*x1-x2^3)^2;
dV = diff(V, t);

dx1 = -x1-x2;
dx2 = 2*x1-x2^3;
dV_new = simplify(subs(dV, [diff(x1(t), t) diff(x2(t), t)], [dx1 dx2]));

dV2 = -((x1+x2) + (2*x1-x2^3))^2 - (x1+x2)^2 - (6*x2^2-1)*(2*x1-x2^3)^2;

simplify(dV_new - dV2);

%% Part (c)

% Define the system
f = @(x1, x2) -x1 + x2.^6;                 
g = @(x1, x2) x1.^6 + x2.^3;

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
for x0 = -2:0.5:2                % Initial conditions
    for y0 = -2:0.5:2
        [T, Y] = ode45(@(t, y) [f(y(1), y(2)); g(y(1), y(2))], [0, 1], [x0, y0]);
        plot(Y(:,1), Y(:,2), 'b'); % Trajectories
    end
end

% Label the axes
xlabel('x_1');
ylabel('x_2');
xlim([-8 8]);
ylim([-8 8]);
title('Phase Portrait');
legend('Vector Field', 'Exact Solution');
axis equal;
grid on;
hold off;

%%
% syms p11 p12 p22

P = [p11 p12; p12 p22];
P2 = [p12 (p11+p22-p12)/2; (p11+p22-p12)/2 p12-p22];

D1 = eig(P);
D2 = eig(P2);

ieq1 = D1(1) > 0;
ieq2 = D1(2) > 0;
ieq3 = D2(1) < 0;
ieq4 = D2(2) < 0;

S = solve([ieq1 ieq2 ieq3 ieq4], [p11 p12 p22], 'ReturnConditions',true);

Pnew = double(subs(P, [p11 p12 p22], [2.8 -4.51 7.32]));
P2new = double(subs(P2, [p11 p12 p22], [2.8 -4.51 7.32]));