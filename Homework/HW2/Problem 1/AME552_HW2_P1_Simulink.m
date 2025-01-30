%% AME-552

% HW2 Problem 1

%% Clear

clear, clc, close all;

%% Setup

% Symbolic variables
A = 1;
D = 1;
tau = 1;
I = 1;

% Define error initial conditions
e0_space = -2: 0.5: 2;
de0_space = -2: 0.5: 2;

% Define Simulink model
mdl = 'AME552_HW2_P1_SimulinkModel';
open_system(mdl);
set_param(mdl, "StopTime", "1");

% Define figure
figure(1); hold on;

%% Plotting

% Iterate through IC's
for i = 1: length(e0_space)

    for j = 1: length(de0_space)

        % Adjust IC values
        e0 = e0_space(i);
        de0 = de0_space(j);

        % Run Simulink model
        out = sim(mdl);

        % Plot error phase portrait
        p = plot(out.x1.Data, out.x2.Data, '-r'); 
        row = dataTipTextRow('Time', out.x1.Time);
        p.DataTipTemplate.DataTipRows(end+1) = row;
        clear("out");
        
    end
    
end

% Plot region boundaries
fun1 = @(x) (1/tau) * (-D-x);
fun2 = @(x) (1/tau) * (D-x);
fplot(fun1, 'k', LineWidth=2);
fplot(fun2, 'b', LineWidth=2);

% Plot properties
grid on; axis equal;
xlabel('$x_1 (e)$', 'Interpreter', 'latex');
ylabel('$x_2 (\dot{e})$', 'Interpreter', 'latex');
title('Phase Portrait');
ylim([-5 5]);

% Close Simulink model
close_system(mdl, 0);