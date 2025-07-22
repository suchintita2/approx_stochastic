function sn = sng_bipolar(value, L, RNS, format, inversion_pattern)
% Enhanced SNG with bipolar support and decorrelation
% value: target value ([-1,1] for bipolar, [0,1] for unipolar)
% L: bitstream length
% RNS: shared random number sequence
% format: 'unipolar' or 'bipolar'
% inversion_pattern: logical array for decorrelation (optional)

if nargin < 3
    RNS = rand(1,L);
end
if nargin < 4
    format = 'unipolar';
end
if nargin < 5
    inversion_pattern = false(1,L);
end

% Apply decorrelation inversions to shared RNS
decorrelated_RNS = RNS;
decorrelated_RNS(inversion_pattern) = 1 - decorrelated_RNS(inversion_pattern);

% Generate stochastic bitstream based on format
switch lower(format)
    case 'unipolar'
        if value < 0 || value > 1
            warning('Unipolar value should be in [0,1], clipping...');
            value = max(0, min(1, value));
        end
        sn = decorrelated_RNS < value;
        
    case 'bipolar'
        if value < -1 || value > 1
            warning('Bipolar value should be in [-1,1], clipping...');
            value = max(-1, min(1, value));
        end
        probability = (value + 1) / 2;
        sn = decorrelated_RNS < probability;
        
    otherwise
        error('Format must be "unipolar" or "bipolar"');
end
end
