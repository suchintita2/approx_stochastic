function Z_hat = apc_adder_bipolar(X, W, format)
% Enhanced APC adder with bipolar support
[M,L] = size(X);
if nargin < 3
    format = 'unipolar';
end

switch lower(format)
    case 'unipolar'
        if nargin >= 2 && ~isempty(W)
            products = X & W;
        else
            products = X;
        end
        counts = sum(products, 1);
        Z_hat = mean(counts) / M;
        
    case 'bipolar'
        if nargin >= 2 && ~isempty(W)
            products = ~xor(X, W);
        else
            products = X;
        end
        counts = sum(products, 1);
        Z_hat = mean(counts) / M;
        Z_hat = 2 * Z_hat - 1;
end
end
