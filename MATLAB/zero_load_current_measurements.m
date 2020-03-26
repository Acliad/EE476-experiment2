vi_vals = [
%     1 .007 0;
    5.0 .024 76;
    4.5 .022 69;
    4.0 .022 59;
    3.5 .022 50;
    3.0 .022 39;
    2.5 .022 29;
    2.0 .022 19;
    1.5 .02 9;
%     -1.0 -.075 0;
    -1.5 -.075 -12;
    -2.0 -.074 -22;
    -2.5 -.074 -32;
    -3.0 -.074 -41;
    -3.5 -.077 -49;
    -4.0 -.076 -59;
    -4.5 -.076 -69;
    -5.0 -.077 -78;
    ];
current_offset = -0.027;

vi_vals(:, 2) = vi_vals(:, 2) - current_offset;

friction_current_all = @(x, xdata) x(1)*sign(xdata) + x(2)*xdata + x(3)*xdata.^2;
friction_current_1 = @(x, xdata) x*xdata;
friction_current_0 = @(x, xdata) x*sign(xdata);
x_all = [1, .01, .01];
x1 = 0.01;
x0 = 0.01;
I_all = lsqcurvefit(friction_current_all, x_all,vi_vals(:, 3), vi_vals(:, 2));
I_1 = lsqcurvefit(friction_current_1, x1,vi_vals(:, 3), vi_vals(:, 2));
I_0 = lsqcurvefit(friction_current_0, x0,vi_vals(:, 3), vi_vals(:, 2));

plot(vi_vals(:, 3), vi_vals(:, 2), 'o', 'linewidth', 2)
hold on
plot(vi_vals(:, 3), friction_current_all(I_all, vi_vals(:, 3)), ...
    'linewidth', 2)
plot(vi_vals(:, 3), friction_current_1(I_1, vi_vals(:, 3)), ...
    'linewidth', 2)
plot(vi_vals(:, 3), friction_current_0(I_0, vi_vals(:, 3)), '--', ...
    'linewidth', 2)
set(gca, 'FontSize', 20);
legend('Captured Data', ...
       'I_f = I_0sgn(\omega_m) + I_1\omega_m + I_2\omega_m^2', ...
       'I_f = I_1\omega_m', ...
       'I_f = I_0sgn(\omega_m)');
title('Plot of I_f for different approximations')
xlabel('\omega_m [rad/s]')
ylabel('I_f [A]')
grid on
