function [ h ] = generate_channel_response( M, L_C, pdf )
% Input:
% L_C : channel length
% M : number of channels (number of signal paths)
% Output:
% The h in equation (9), as marked by yellow marker inline
% h : (M*L_C) ¡Á1 column vector
%%%%% Tested: 2018-08-09 16:37:52 Correct

% channel response should not be greater than 1 (the amplitude)

h = zeros(L_C*M, 1);

if (strcmp(pdf, 'manual'))
    % fixed length channel response
    for m = 1:1:M
        channel_response = rand(L_C, 1);
        % channel_response = (channel_response < 0.4) .* channel_response;  % no other taps can exceed the amplitude of 0.4
        % channel_response(1) = 0.6 + rand/5;  % the first tap: [0.6, 0.8]
        channel_response = sort(channel_response);
        % generate channel response for every path independently
        h( (m-1)*L_C+1 : m*L_C ) = channel_response;
    end
end

end

