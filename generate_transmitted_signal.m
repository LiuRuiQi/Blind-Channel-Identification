function [ x ] = generate_transmitted_signal( L_S, mode )
% Input:
% L_S : signal length (# of symbols)
% mode: 'QPSK', 'real' ...
%%%%% Tested: 2018-08-09 16:37:52 Correct

% refer to 'A fast blind SIMO channel identification algorithm for sparse
% sources' for the Bernoulli-Gaussian pdf to generate sparse spike trains
% if sparse signals are needed to be studied

% z = complex(a,b) creates a complex output, z, from two real inputs, such that z = a + bi.
if( strcmp(mode,'QPSK'))  % generate base band QPSK signals, as in paper
    real_part = rand(L_S, 1);
    real_part = (real_part > 0.5) * 2 - 1;
    imagery_part = rand(L_S, 1);
    imagery_part = (imagery_part > 0.5) * 2 - 1;
    x = complex(real_part, imagery_part);
else if ( strcmp(mode,'real'))  % generate real numbered signal sequences
    x = rand(L_S,1);
    % x = floor(10 * x) - 5;
    % range of elements in x : -5 to 4, all integers
    x = 10 * x - 5;
end

end

