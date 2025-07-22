function Z_hat = psa_adder_bipolar(X, W, G, format)
% Enhanced PSA adder with bipolar support
[M,L] = size(X);
if nargin < 4
    format = 'unipolar';
end

% First stage: multiply inputs with weights
switch lower(format)
    case 'unipolar'
        if nargin >= 2 && ~isempty(W)
            products = X & W;
        else
            products = X;
        end
    case 'bipolar'
        if nargin >= 2 && ~isempty(W)
            products = ~xor(X, W);
        else
            products = X;
        end
end

% Group processing with hierarchical structure
current_G = G;
Y_groups = {};
group_idx = 1;
remaining_inputs = products;

while size(remaining_inputs, 1) > 0
    if size(remaining_inputs, 1) >= current_G
        group_data = remaining_inputs(1:current_G, :);
        Y_groups{group_idx} = cemux_adder_bitstream_bipolar(group_data, format);
        remaining_inputs = remaining_inputs(current_G+1:end, :);
    else
        current_G = max(1, current_G / 2);
        if current_G < 1
            current_G = 1;
        end
        
        if size(remaining_inputs, 1) >= current_G
            group_data = remaining_inputs(1:current_G, :);
            Y_groups{group_idx} = cemux_adder_bitstream_bipolar(group_data, format);
            remaining_inputs = remaining_inputs(current_G+1:end, :);
        else
            Y_groups{group_idx} = remaining_inputs(1, :);
            remaining_inputs = remaining_inputs(2:end, :);
        end
    end
    group_idx = group_idx + 1;
end

% Final APC stage
if ~isempty(Y_groups)
    Y_matrix = vertcat(Y_groups{:});
    Z_hat = apc_adder_bipolar(Y_matrix, [], format);
else
    Z_hat = 0;
end
end
