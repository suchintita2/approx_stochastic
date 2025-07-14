function Z_hat = mux_adder(X)
% X: M x L matrix of input bitstreams
[M,L] = size(X);
Z = zeros(1,L);

for t = 1:L
    idx = randi(M);  % pure random selection
    Z(t) = X(idx,t);
end

Z_hat = mean(Z); % estimated value
end
