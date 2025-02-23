%% AME-552

% HW4 Problem 1

%% Clear

clear, clc, close all;

%% Part (a)

Aa = [1 2 0; 2 1 0.5; 0 0.5 3];
[Va, Da] = eig(Aa);

%% Part (b)

% Define Variables
x = -5*pi: pi/5: 5*pi;
y = -5*pi: pi/5: 5*pi;
[x1, x2] = meshgrid(x, y);

% Define V(X)
Vb = abs(x1).*cos(x2) + x2.^2;

% Plot
figure;
surf(x1, x2, Vb);
title('Part (b)');
xlabel('x_1');
ylabel('x_2');
zlabel('V(X)');
zlim([0 inf]);

%% Part (c)

% Define Variables
x = -10: 1: 10;
y = -10: 1: 10;
[x1, x2] = meshgrid(x, y);

% Define V(X)
Vc = 5*x1.^4 - 4*x1.^2*x2 + x2.^2;

% Plot
figure;
surf(x1, x2, Vc);
title('Part (c)');
xlabel('x_1');
ylabel('x_2');
zlabel('V(X)');
zlim([0 inf]);

%% Part (d)

% Define variables
x = -pi: pi/10: pi;
y = -pi: pi/10: pi;
[x1, x2] = meshgrid(x, y);

% Define V(X)
Vd =2 - (cos(x1)).^2 - (cos(x2)).^2;

% Plot
figure;
surf(x1, x2, Vd);
title('Part (d)');
xlabel('x_1');
ylabel('x_2');
zlabel('V(X)');
zlim([0 inf]);

%% Part (e)

Ae = [1 0.5; 0.5 0];
[Ve, De] = eig(Ae);

%% Part (f)

Af = [1 0.5; 0.5 1];
[Vf, Df] = eig(Af);