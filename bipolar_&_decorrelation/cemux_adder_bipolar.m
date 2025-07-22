function Z_hat = cemux_adder_bipolar(X, W, format)
% Enhanced CeMux adder with bipolar support and structured sampling
[M,L] = size(X);
if nargin < 3
    format = 'unipolar';
end

Z = zeros(1,L);

for t = 1:L
    idx = mod(t-1, M) + 1;
    
    switch lower(format)
        case 'unipolar'
            if nargin >= 2 && ~isempty(W)
                Z(t) = X(idx,t) & W(idx,t);
            else
                Z(t) = X(idx,t);
            end
            
        case 'bipolar'
            if nargin >= 2 && ~isempty(W)
                Z(t) = ~xor(X(idx,t), W(idx,t));
            else
                Z(t) = X(idx,t);
            end
    end
end

Z_hat = mean(Z);

if strcmpi(format, 'bipolar')
    Z_hat = 2 * Z_hat - 1;
end
end
