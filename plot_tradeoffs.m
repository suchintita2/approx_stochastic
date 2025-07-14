function plot_tradeoffs(G_values, rmse_values, M)
% Estimate area ~ M / G (rough proxy)
area = M ./ G_values;

figure;
plot(area, rmse_values, '-o','LineWidth',2);
xlabel('Estimated area (normalized)');
ylabel('RMSE');
title('PSA area vs. accuracy trade-off');
grid on;
end
