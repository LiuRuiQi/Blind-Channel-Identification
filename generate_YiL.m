function [ YiL ] = generate_YiL( all_y_i, M, L, N, i )
% generate Y^i(L) in paper, according to (8)

YiL = [];
if (M-i)*(N-2*L+1)*(i-1)*(L+1) > 0
    Zero = zeros( (M-i)*(N-2*L+1), (i-1)*(L+1) );
    YiL = [YiL Zero];
end
Red_Block = [];
for t = i+1:1:M
    Red_Block = [Red_Block; generate_Y_mL(all_y_i, t, L, N) ];   
end
YiL = [YiL Red_Block];

I = eye(M-i);  % identity matrix
Green_Block = - kron(I, generate_Y_mL(all_y_i, i, L, N));  % Kronecker product to produce block diagonal matrix with identical diagonal blocks
YiL = [YiL Green_Block];

end