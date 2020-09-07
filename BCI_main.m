function [ h, h_bar ] = BCI_main( L, M, L_S, SNR )
% This script handles blind channel identification of SIMO systems, according to the method in paper 
% Ruiqi Liu, Wei Dai and Chao Zhang, "Multi-target Detection by Distributed Passive Radar Systems without Reference Signals," 
% The approach is rather easy to implement: form Y(L) as (9), then carry
% out least squares estimation of Y(L)h
%
% All parameters inherit their names from the paper
% Input: 
% L : channel order        L_C = L+1 is channel length
% M : number of channels (number of signal paths)
% L_S : signal length (# of symbols)
% in this script, signals and channel responses are all real-numbered,

L_C = L + 1;

% generate x(k)   L_S*1 column vector
mode = 'real';   % real numbers  [-5, 4], integers
x = generate_transmitted_signal(L_S, mode);

% generate h in equation (10)
pdf = 'manual';  % a channel spike train manually set
h = generate_channel_response(M, L_C, pdf);
% h : (M*L_C) ¡Á1 column vector

% generate Y(L) in equation (9), (10)
YL = generate_received_signal(L_C, L_S, M, SNR, x, h);

% tested 2018-08-10 17:24:20   YL is correct


Rank = rank(YL)

% h_bar is the estimate of h, also with dimensionality of (M*L_C) ¡Á1
cvx_begin
    variable h_bar_cvx(M*(L+1))
    minimize (  norm(YL*h_bar_cvx)  )
    subject to 
        h_bar_cvx <= 1
        h_bar_cvx >= 0
        % YL*h_bar_cvx == 0
cvx_end

h_bar_cvx = h_bar_cvx';  % covert to row vector


% and h_bar_cvx is not supposed to be h, the order is reversed
h_bar = zeros(1, M*(L+1)); % row vector
for j = 1:1:M
    h_bar((j-1)*L_C+1 : j*L_C) = fliplr( h_bar_cvx((j-1)*L_C+1 : j*L_C) );
end
h_bar = h_bar';  % convert to column vector

end

