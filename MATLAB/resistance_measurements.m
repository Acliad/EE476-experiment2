vi_vals = [
    .1 0 0; 
    .2 0 0; 
    1 0 0; 
    1.5 .1 .1; 
    2.0 .1 .1; 
    2.5 .2 .1; 
    3.0 .2 .1; 
    3.5 .2 .2; 
    4.0 .2 .2; 
    4.5 .3 .2;
    5.0 .3 .4; 
    5.5 .4 .3; 
    6.0 .4 .4; 
    6.5 .4 .5; 
    7.0 .5 .4; 
    7.5 .5 .6; 
    8.0 .5 .6; 
    8.5 .7 .5; 
    9.0 .7 .7; 
    9.5 .6 .7; 
    10  .8 .7; 
    10.5 .7 .8; 
    11 .9 .8; 
    11.5 0.9 0.8; 
    12.0 0.8 0.9];
resistance = array2table(...
    vi_vals, 'VariableNames', {'Voltage', 'Offset0', 'Offset2'});
resistance.average_current = (resistance.Offset0 + resistance.Offset2 ) / 2;

ft = fit(resistance.Voltage, resistance.average_current, 'poly1');
Rm_measured = 1/ft.p1;

resistance_fit = ft.p1*resistance.Voltage + ft.p2;
resistance_average = mean(resistance.Voltage(4:end)./ ...
                          resistance.average_current(4:end));

ls_err = abs(resistance.Voltage - resistance.average_current*Rm_measured);
avg_err = abs(resistance.Voltage - resistance.average_current*resistance_average);

ls_err = mean(ls_err);
avg_err = mean(avg_err);

% Plot measured data points
plot(resistance.Voltage, resistance.average_current, 'o', ...
     'linewidth', 2);        
 
hold on

% Plot best fit curve
plot(resistance.Voltage, resistance_fit, ...
     'linewidth', 2);        
 set(gca, 'fontsize', 20);
 
dim = [.2 .5 .3 .3];
str = 'Slope (R_m) = %.2f\nLeast Squares Error: %.3f\nAverage Error: %.3f';
str = sprintf(str, Rm_measured, ls_err, avg_err);

a = annotation('textbox', dim, 'String', str, 'FitBoxToText', 'on');
a.FontSize = 18;
% a.LineStyle = 'none';

legend('Raw data', 'Best fit curve', 'Interpreter', 'latex');
xlabel('Voltage [V]', 'Interpreter', 'latex', 'fontsize', 20);
ylabel('Current [A]', 'Interpreter', 'latex', 'fontsize', 20);
title('Plot of best fit line for measured voltage vs. current', ...
        'Interpreter', 'latex', 'fontsize', 20)