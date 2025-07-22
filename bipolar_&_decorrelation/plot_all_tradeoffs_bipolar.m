function plot_all_tradeoffs_bipolar(G_values, rmse_psa, M, rmse_mux, rmse_cemux, rmse_apc)
% Plots area vs accuracy trade-offs for bipolar adders

area_psa = M ./ G_values;
area_mux = 1;
area_cemux = 2;
area_apc = M;

figure;
hold on;

% Plot PSA curve
plot(area_psa, rmse_psa, '-o', 'LineWidth', 2, 'DisplayName', 'PSA');

% Plot single points
plot(area_mux, rmse_mux, 'rx', 'MarkerSize',10, 'LineWidth',2, 'DisplayName','Mux');
plot(area_cemux, rmse_cemux, 'gs', 'MarkerSize',10, 'LineWidth',2, 'DisplayName','CeMux');
plot(area_apc, rmse_apc, 'bd', 'MarkerSize',10, 'LineWidth',2, 'DisplayName','APC');

xlabel('Estimated area (normalized)');
ylabel('RMSE');
title('Bipolar Adder Area vs. Accuracy Trade-off');
legend('show','Location','northwest');
grid on;
hold off;
end
