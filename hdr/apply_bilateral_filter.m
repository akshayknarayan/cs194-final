% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

% apply_bilateral_filter() is a helper function which applies a bilateral filter to the input image.
% See Bilateral Filtering for Gray and Color Images (Tomasi 1998) for details.
% @param img is the image to apply the filter on
% @param window is an integer specifying the window to use when applying the Gaussians
% @param sigma_d is the standard deviation to use for the spatial domain Gaussian
% @param sigma_r is the standard deviation to use for the intensity domain Gaussian
% @return result is the filtered result
function result = apply_bilateral_filter(img, window, sigma_d, sigma_r)
    fprintf('== Computing bilateral filter (window = %d, sigma_d = %.3f, sigma_r = %.3f) ==\n', window, sigma_d, sigma_r);
    [img_height, img_width] = size(img);

    % Pre-compute Gaussian values to use for the spatial domain.
    [X, Y] = meshgrid(-window:window, -window:window);  % This is the box we are using.
    G = exp(-(X.^2 + Y.^2) / (2 * sigma_d^2));

    result = zeros(img_height, img_width);
    for i = 1:img_height
        if (mod(i, 100) == 1)
            fprintf('Computing filter response for rows %d to %d (out of %d)\n', i, max(i+99, img_height), img_height);
        end
        for j = 1:img_width
            % Current window to work with.  Added bounds check to make sure the window works at edge.
            i_min = max(1, i - window);
            i_max = min(img_height, i + window);
            j_min = max(1, j - window);
            j_max = min(img_width, j + window);
            curr_window = img(i_min:i_max, j_min:j_max, :);

            % Compute the Gaussian values for the intensity domain.
            % Start by computing: ||f(\xi) - f(x)||^2.  (f is the image, \xi is the window, x is current position)
            s = exp(-(curr_window - img(i, j) .^ 2) / (2 * sigma_r^2));

            % Compute the Gaussian values for the spatial domain.
            c = G((i_min:i_max)-i+window+1, (j_min:j_max)-j+window+1);

            % Calculate the response for the filter.
            % J(x) = 1/k(x) * sum_{\xi}(c(\xi - x) * s(I(\xi) - I(x)) * I(\xi)))
            normalization = sum(sum(c .* s));   % k(x) above.
            raw_response = sum(sum(c .* s .* curr_window));
            result(i, j) = raw_response / normalization;
        end
    end
end