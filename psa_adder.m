function Z_hat = psa_adder(X, G)
% PSA: groups of size G -> CeMux -> APC
% X: M x L
% G: group size (power of 2)
[M,L] = size(X);
num_groups = ceil(M / G);
Y = zeros(num_groups,L);

for g = 1:num_groups
    idx1 = (g-1)*G + 1;
    idx2 = min(g*G, M);
    group_X = X(idx1:idx2,:);
    Y(g,:) = cemux_adder_bitstream(group_X);
end

% Final stage: small APC
counts = sum(Y,1);
Z_hat = mean(counts) / num_groups; % normalize
end

function y = cemux_adder_bitstream(X)
% helper for PSA: returns mux output bitstream, not mean
[M,L] = size(X);
y = zeros(1,L);
for t = 1:L
    idx = mod(t-1, M) + 1;
    y(t) = X(idx,t);
end
end
