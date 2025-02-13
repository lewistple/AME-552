%% AME-552

% HW3 Problem 2

%% Clear

clear, clc, close all;

%% Characteristic Equation Approach

% Find relationship between k and A
k = @(A) (pi/10) * (1/(asin(1/A) + (1/A)*sqrt(1 - (1/A)^2)));

figure;
fplot(k, [1 100], LineWidth=2); grid on;
xlabel('A');
ylabel('k');
title('k vs. A');
xlim([0 100]);

%% Nyquist Approach

k = 1;

% Linear system
s = tf('s');
G = -5*s/(s^2 + s + 25);

% Line of 1/N(A, w)
Nline_Re = @(A) -1 / ((2*k/pi) * (asin(1/A) + (1/A)*sqrt(1-(1/A)^2)));
Nline_Im = @(A) 0;

nyquist(G); hold on;
fplot(Nline_Re, Nline_Im, 'r', [1 30]);
