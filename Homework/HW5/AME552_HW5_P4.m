%% AME-552

% HW5 Problem 4

%% Clear

clear, clc, close all;

%% Part (a)

syms x1 x2 phi11 k real

f1 = -2*x1 - x1^3 + x2;
f2 = x1 - x2;

g1 = phi11*x1 + k*x2;
g2 = k*x1 + 2*x2;

f = [f1; f2];
g = [g1; g2];

dV = g'*f;

% F = expand(subs(dV, phi11, k*x1^2 + 3*k - 2));

A = [(3*k-2)/2 k/2; k/2 1];

Anum = double(subs(A, k, 1));