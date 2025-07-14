function Z_hat = cemux_adder(X)
% X: M x L matrix of input bitstreams
[M,L] = size(X);
Z = zeros(1,L);

% CeMux: use structured selection — round-robin
for t = 1:L
    idx = mod(t-1, M) + 1;
    Z(t) = X(idx,t);
end

Z_hat = mean(Z); % estimated value
end
