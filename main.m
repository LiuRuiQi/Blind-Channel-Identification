close all; clc;
% All parameters inherit their names from the paper
% Input: 
% L : channel order        (L+1) is channel length
% M : number of channels (number of signal paths)
% L_S : signal length (# of symbols)

L = 4;
M = 2;
L_S = 12;
SNR = 999;  % not used for now

[h, h_bar] = BCI_main(L, M, L_S, SNR);

R = M*(L+1)-1
N = 2*L + L_S - 1;
(N-2*L+1)*(M-1) >= 2*(L+1)  % condition of a full-ranked X(L), see paper P2985 (red star)

% Notice that h_bar is identical to h up to a constant scalar (noiseless case)

if range( h./ h_bar ) <= 1e-4 % range: difference between the maximum and minimum values
    fprintf('Correct estimation of h under noiseless case.');
else  
    fprintf('Incorrect estimation of h under noiseless case, or noise is considered.');
end

