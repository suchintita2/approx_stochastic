function [input_RNS, weight_RNS, input_inversions, weight_inversions] = generate_decorrelated_RNS(M, L, correlation_scheme)
% Generate RNS with decorrelation patterns
% M: number of inputs
% L: bitstream length
% correlation_scheme: 'none', 'inversion', 'permutation'

if nargin < 3
    correlation_scheme = 'inversion';
end

% Generate base RNS sequences
input_RNS = sobol_sequence(L, 1);
weight_RNS = sobol_sequence(L, 2);

input_inversions = false(M, L);
weight_inversions = false(M, L);

switch lower(correlation_scheme)
    case 'none'
        % Direct sharing - no decorrelation
        
    case 'inversion'
        % Random inversion patterns for decorrelation
        for i = 1:M
            inversion_prob = 0.5;
            input_inversions(i, :) = rand(1, L) < inversion_prob;
            weight_inversions(i, :) = rand(1, L) < inversion_prob;
        end
        
    case 'permutation'
        warning('Permutation decorrelation less effective than inversion');
        
    otherwise
        error('Unknown correlation scheme: %s', correlation_scheme);
end
end
