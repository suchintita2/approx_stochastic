function Z_hat = apc_adder(X)
% X: M x L matrix
[M,L] = size(X);
counts = sum(X,1); % count '1's in each cycle
Z_hat = mean(counts) / M; % normalize
end
