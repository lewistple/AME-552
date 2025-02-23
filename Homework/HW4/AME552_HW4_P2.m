%% AME-552

% HW4 Problem 2

%% Clear

clear, clc, close all;

%% Part (a)

fun = @(t) 1 - t^2 * exp(-t);
tspan = [0 10];

figure;
fplot(fun, tspan, LineWidth=2);
ylim([0 1]);
