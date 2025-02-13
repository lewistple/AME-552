%% AME-552

% HW3 Problem 1

%% Clear

clear, clc, close all;

%% Characteristic Equation Approach

% Symbolic expressions
syms A w real

% Describing function of nonlinear system
N = 4/(pi*A);

% Linear system
s = 1i * w;
G = (s + 6)/(s*(s+2)*(s+3));

% Characteristic equation
delta_eqn = 1 + G*N == 0;

% Solve
S = solve(delta_eqn, [A, w]);
disp(S.A);
disp(S.w);

%% Nyquist Approach

% Linear system
s = tf('s');
G = (s+6) / (s*(s+2)*(s+3));

% Line of 1/N(A, w)
Nline_Re = @(A) -1 / (4/(pi*A));
Nline_Im = @(A) 0;

nyquist(G); hold on;
fplot(Nline_Re, Nline_Im, 'r');

