function [ YL ] = generate_received_signal( L_C, L_S, M, SNR, x, h )
% This function generates Y(L) in (10), (11)
% Input:
% L_C : channel length
% L_S : signal length
% M : number of channels (different paths in SIMO system)
% Output: YL as in paper Y(L) in (10), (11)
% dimensionality of Y(L) :  [ (N-2L+1)*M(M-1)/2 ] ¡Á (M*L_C)

% first, calculate all y_i(k) as equation (4)  (there're M of them)
% y_i : (L_C+L_S-1)¡Á1 column vector
% in paper, y_i has index of L, ..., N, so clearly N-L+1 = L_C+L_S-1, 
% N-L+1 = L+L_S, N = 2L+L_S-1 = 2L_C + L_S -3. 
L = L_C - 1;
N = 2*L + L_S - 1;

% Step 1: calculate all y_i as in (4)
all_y_i = zeros(L_C+L_S-1, M); % each column is a single y_i
for i = 1:1:M
    h_i = h( (i-1)*L_C+1 : i*L_C );
    all_y_i(:,i) = conv(x, h_i);
    %%%%% the SNR should affect here, but first we consider a noise-free case
end
%%%%% Tested: 2018-08-09 16:37:52 Correct


% Step 2: form Y_m(L) as in (6)
% write a function to generate Y_m(L) given m & L (the index is always L isn;t it??)
% this tep is done by function generate_Y_mL( all_y_i, m, L, N ), which
% will be called in Step 3 to form all the Y_m(L)

% Step 3: form Y^i(L) as (8) in paper 
% also realized bu function 

% Step 4: form X(L) as in (9)
YL = [];
for i = 1:1:M-1
    YL = [YL; generate_YiL( all_y_i, M, L, N, i )];
end


end

