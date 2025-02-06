%% AME-552

% HW2 Problem 2 (Simulink)

%% Clear

clear, clc, close all;

%% Setup

% Symbolic variables
alpha = 1;
beta = 1;
C = 0.9;
D = 1;
M = 1;

% Define error initial conditions
e0_space = -5: 1: 5;
de0_space = -5: 1: 5;

% Define Simulink model
mdl = 'AME552_HW2_P2_SimulinkModel';
load_system(mdl);
set_param(mdl, "StopTime", "5");

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
xline(-D, 'k', LineWidth=2);
xline(D, 'b', LineWidth=2);

% Plot properties
grid on; axis equal;
xlabel('$x_1 (e)$', 'Interpreter', 'latex');
ylabel('$x_2 (\dot{e})$', 'Interpreter', 'latex');
title('Phase Portrait');
ylim([-5 5]);