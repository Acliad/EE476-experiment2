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
    -1.0 -.075 0;
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

omega_m = vi_vals(:, 3);
vi_vals(:, 2) = vi_vals(:, 2) - current_offset;
Vrm = vi_vals(:, 2) * Rm_measured;
Vemf = vi_vals(:, 1) - Vrm;

Vemf_fun = @(x, xdata) x(1)*xdata + x(2)*xdata.^2;
x0 = [.1, .1];

% Calculate the least square fit for km and tau_m
coeff = lsqcurvefit(Vemf_fun, x0, omega_m, Vemf);
km_ls = coeff(1);
tau_m = coeff(2)/coeff(1);

% Calcuate km assuming tau_m is 0 and average all tau
km_all = Vemf./omega_m;
km_all = km_all(isfinite(km_all));
km_avg = mean(km_all);


% Plot the measurements and estimations
clf
plot(omega_m, Vemf./omega_m, 'o', 'linewidth', 2);
hold on
plot(omega_m, coeff(1) + coeff(2)*omega_m, 'linewidth', 2);
plot(omega_m([1, end]), [km_avg, km_avg], '--', 'linewidth', 2);

set(gca, 'FontSize', 20)
ylim([0, 0.2]);
xlabel('$\omega_m$', 'fontsize', 20, 'Interpreter', 'latex');
ylabel('$v_{emf} / \omega_m$', 'fontsize', 20, ...
       'Interpreter', 'latex');
title('$\omega_m vs. \frac{v_{emf}}{\omega_m}$', 'fontsize', 20, ...
      'Interpreter', 'latex');
legend('Measured points', 'Least square fit', 'Average fit');
grid on;