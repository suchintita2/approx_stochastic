function rmse = simulate_rmse_bipolar(adder_func, M, L, num_trials, format, varargin)
% Enhanced RMSE simulation with bipolar support and decorrelation
% adder_func: function handle
% M: number of inputs
% L: bitstream length  
% num_trials: number of Monte Carlo trials
% format: 'unipolar' or 'bipolar'
% varargin: additional parameters (e.g., PSA group size)

if nargin < 5
    format = 'unipolar';
end

errors = zeros(1, num_trials);

% Generate decorrelated RNS system
[input_RNS, weight_RNS, input_inversions, weight_inversions] = ...
    generate_decorrelated_RNS(M, L, 'inversion');

for r = 1:num_trials
    % Generate random target values based on format
    switch lower(format)
        case 'unipolar'
            input_values = rand(1, M);
            weight_values = rand(1, M);
            Z_true = mean(input_values .* weight_values);
            
        case 'bipolar'
            input_values = 2 * rand(1, M) - 1;
            weight_values = 2 * rand(1, M) - 1;
            Z_true = mean(input_values .* weight_values);
    end
    
    % Generate bitstreams with decorrelation
    X = zeros(M, L);
    W = zeros(M, L);
    
    for i = 1:M
        X(i, :) = sng_bipolar(input_values(i), L, input_RNS, format, ...
                              input_inversions(i, :));
        W(i, :) = sng_bipolar(weight_values(i), L, weight_RNS, format, ...
                              weight_inversions(i, :));
    end
    
    % Compute estimated output
    if ~isempty(varargin)
        Z_hat = adder_func(X, W, varargin{1}, format);
    else
        Z_hat = adder_func(X, W, format);
    end
    
    errors(r) = (Z_hat - Z_true)^2;
end

rmse = sqrt(mean(errors));
end
