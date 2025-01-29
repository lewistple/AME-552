%% AME-552

% HW1 Problem 2 Setup

% Draw a phase portrait of the following system:
% dx1 = x2
% dx2 = -c*x2 - k1*x1 - k2*x1^3

%% Clear

clear, clc, close all;

%% Program Execution

syms k1 k2 x1 x2 c;
dx1 = x2;
dx2 = -c*x2 - k1*x1 - k2*x1^3;

X = [x1; x2];
dX = [dx1 dx2];

A = jacobian(dX, X);
A1 = subs(A, [x1 x2], [0 0]);

% Eigenvalues and eigenvectors
[V1, D1] = eig(A1);
