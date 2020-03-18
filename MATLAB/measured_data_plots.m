% Script for loading and plotting measured vs. predicted data
% clearvars

run('resistance_measurements.m');
run('zero_load_current_measurements.m');
run('vemf_measurements.m');
close all
load('lumped tf parameters1.mat');
t = step_data_Time(:, 1);
step_measured = step_data_Value(:, 1);
step_predicted = step_data_Value(:, 2);

% *****************************************
% * Experiment with automatically finding tau
% *****************************************
% i = 1:length(step_measured)-1;
% % Find the 4*tau time
% t_start = (find(abs(step_measured(i) - step_measured(i+1)) > 2));
% t_start = t(t_start(1));
% t_end = find(step_measured >= max(step_measured)*0.98);
% tau = (t_end(1) - t_start(1)) / 4

% *****************************************
% * Define modeled transfer function using measured values from plot
% *****************************************
% * Experimently obtained tau, k: 90ms, 14.7
tau = 90e-3;
model = tf(14.7, [tau 1]);
[y, t_model] = step(8*model, 10);
y = y - 60;
plot(t - t(1), step_predicted, 'linewidth', 2);
hold on
plot(t - t(1), step_measured, 'linewidth', 2);
plot(t_model + .16, y, 'linewidth', 2);
xlabel('Time [s]', 'fontsize', 16);
ylabel('Speed [rad/s]', 'fontsize', 16);
legend('Predicted with k, \tau = 0', 'Measured', 'Step() simulation');
grid on