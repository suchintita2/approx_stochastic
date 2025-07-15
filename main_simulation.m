%% Stochastic Computing Adders: Mux vs CeMux vs APC vs PSA
% Compare accuracy (RMSE) of different stochastic computing adders:
% - Basic Mux adder
% - CeMux adder (correlation-enhanced)
% - APC (Accumulative Parallel Counter)
% - PSA (Parallel Sampling Adder) with different group sizes

%% Parameters
M = 16;            % Number of inputs
L = 1024;          % Bitstream length
num_trials = 500;  % Number of Monte Carlo trials

%% Simulate: Mux Adder
% Smallest area, lowest accuracy
rmse_mux = simulate_rmse(@mux_adder, M, L, num_trials);

%% Simulate: CeMux Adder
% Structured sampling, better accuracy
rmse_cemux = simulate_rmse(@cemux_adder, M, L, num_trials);

%% Simulate: APC Adder
% Counts '1's every cycle; usually best accuracy
rmse_apc = simulate_rmse(@apc_adder, M, L, num_trials);

%% Simulate: PSA Adders with different group sizes
% PSA combines CeMux and APC, tunable area-accuracy trade-off
G_values = [2,4,8];
rmse_psa = zeros(size(G_values));

for i = 1:length(G_values)
    G = G_values(i);
    rmse_psa(i) = simulate_rmse(@psa_adder, M, L, num_trials, G);
end

%% Plot: RMSE Comparison (Bar plot)
figure;
bar([rmse_mux, rmse_cemux, rmse_apc, rmse_psa]);
xticklabels({'Mux','CeMux','APC','PSA G=2','PSA G=4','PSA G=8'});
ylabel('RMSE');
title('Adder Accuracy Comparison');
grid on;

%% Plot: PSA Area vs. Accuracy Trade-off (with other adders)
plot_all_tradeoffs(G_values, rmse_psa, M, rmse_mux, rmse_cemux, rmse_apc);

%% End of script
disp('Simulation complete.');
