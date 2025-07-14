function sn = sng(value, L, RNS)
% SNG: generate stochastic bitstream
% value: target probability [0,1]
% L: length of bitstream
% RNS (optional): pass a precomputed random sequence for correlation
if nargin < 3
    RNS = rand(1,L); % default: random sequence
end
sn = RNS < value;
end
