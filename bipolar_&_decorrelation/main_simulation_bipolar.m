%% Stochastic Computing Adders with Bipolar Support & Decorrelation
clear; clc;

%% Parameters
M = 32;
L = 256;
num_trials = 1000;
format = 'bipolar';

fprintf('=== SC Adders Comparison ===\n');
fprintf('Format: %s, Inputs: %d, Length: %d, Trials: %d\n\n', ...
        format, M, L, num_trials);

%% Test All Adder Types
fprintf('Testing adders...\n');

% Mux Adder
rmse_mux = simulate_rmse_bipolar(@mux_adder_bipolar, M, L, num_trials, format);
fprintf('Mux Adder RMSE: %.6f\n', rmse_mux);

% CeMux Adder  
rmse_cemux = simulate_rmse_bipolar(@cemux_adder_bipolar, M, L, num_trials, format);
fprintf('CeMux Adder RMSE: %.6f\n', rmse_cemux);

% APC Adder
rmse_apc = simulate_rmse_bipolar(@apc_adder_bipolar, M, L, num_trials, format);
fprintf('APC Adder RMSE: %.6f\n', rmse_apc);

% PSA Adders
G_values = [2, 4, 8];
rmse_psa = zeros(size(G_values));
for i = 1:length(G_values)
    G = G_values(i);
    rmse_psa(i) = simulate_rmse_bipolar(@psa_adder_bipolar, M, L, num_trials, format, G);
    fprintf('PSA (G=%d) RMSE: %.6f\n', G, rmse_psa(i));
end

%% Display Results
fprintf('\n=== Results Summary ===\n');
adder_names = {'Mux', 'CeMux', 'APC', 'PSA G=2', 'PSA G=4', 'PSA G=8'};
rmse_values = [rmse_mux, rmse_cemux, rmse_apc, rmse_psa];

for i = 1:length(adder_names)
    fprintf('%-10s: RMSE = %.6f\n', adder_names{i}, rmse_values(i));
end

%% Visualization
figure;
bar(rmse_values);
set(gca, 'XTickLabel', adder_names);
ylabel('RMSE');
title(sprintf('SC Adders Accuracy Comparison (%s Format)', format));
grid on;
xtickangle(45);

%% Area vs Accuracy Trade-off
plot_all_tradeoffs_bipolar(G_values, rmse_psa, M, rmse_mux, rmse_cemux, rmse_apc);

fprintf('\nSimulation complete.\n');
