function y = cemux_adder_bitstream_bipolar(X, format)
% Helper for PSA: returns CeMux output bitstream
[M,L] = size(X);
y = zeros(1,L);

for t = 1:L
    idx = mod(t-1, M) + 1;
    y(t) = X(idx,t);
end
end
