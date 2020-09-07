function [ Y_mL ] = generate_Y_mL( all_y_i, m, L, N )
% generate Y_m(L) in (6) given m & L
% all_y_i = zeros(L_C+L_S-1, M); % each column is a single y_i
% This function is tested  2018-08-10 17:16:57

Y_mL = zeros(N-2*L+1, L+1);
y_m = all_y_i(:,m);  % column vector

for r = 1:1:(N-2*L+1)  % row of Y_m(L)
    for c = 1:1:(L+1)   % column of Y_m(L)
        Y_mL(r,c) = y_m(r + c - 1);
    end
end

end

