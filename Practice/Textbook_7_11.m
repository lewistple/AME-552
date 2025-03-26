%% Textbook 7.11

%% Clear

clear, clc, close all;

%% Part (3)

syms A w real

G = 1/(w*1i + 1)^6;
N = 4/(pi*A);

char_eqn = expand(1 + G*N);

eqn1 = real(char_eqn) == 0;
eqn2 = imag(char_eqn) == 0;

S = solve([eqn1 eqn2], [A w], 'ReturnConditions', true);

w_sol = double(S.w);
A_sol = double(S.A);