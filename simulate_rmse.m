function rmse = simulate_rmse(adder_func, M, L, num_trials, adder_args)
% adder_func: handle (@mux_adder, @cemux_adder, etc.)
% adder_args: optional, e.g. PSA group size
errors = zeros(1,num_trials);

for r = 1:num_trials
    % Common RNS for correlation if needed
    RNS = rand(1,L);

    % Generate random target values
    values = rand(1,M);

    % Generate bitstreams
    X = zeros(M,L);
    for i = 1:M
        X(i,:) = sng(values(i), L, RNS); % share same RNS
    end

    % Compute estimated sum
    if nargin > 4
        Z_hat = adder_func(X, adder_args);
    else
        Z_hat = adder_func(X);
    end

    Z_true = mean(values);
    errors(r) = (Z_hat - Z_true)^2;
end

rmse = sqrt(mean(errors));
end
