function plot_all_tradeoffs(G_values, rmse_psa, M, rmse_mux, rmse_cemux, rmse_apc)
% Plots: Mux, CeMux, APC as single points + PSA as trade-off curve

% Estimate area: very simple heuristic
% For PSA: area ≈ M / G (smaller G → larger APC → more area)
area_psa = M ./ G_values;

% For fixed adders, choose fixed area estimates (just rough examples)
% E.g., APC area = M; CeMux area = 2; Mux area = 1
area_mux   = 1;
area_cemux = 2;
area_apc   = M;

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
title('Adder Area vs. Accuracy Trade-off');
legend('show','Location','northwest');
grid on;
hold off;
end
