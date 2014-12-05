% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

% sample_rgb_images() is a helper function which samples images to construct the Z matrix needed in 
% gsolve.  Z is an NxP matrix, where N is the number of sampled pixels and P is the number of input 
% images (exposures).  This is the RGB version, and returns one Z matrix per channel.
% @param images is a cell array of images to use, where each item in the array is one exposure.
% @return z_red is the Z matrix for the red channel
% @return z_green is the Z matrix for the green channel
% @return z_blue is the Z matrix for the blue channel
function [z_red, z_green, z_blue] = sample_rgb_images(images)
    num_exposures = numel(images);      % Value of P.

    % Number of samples should satisfy:     N(P-1) > Z_max - Z_min
    % This means that we should have:       N > (Z_max - Z_min) / (P-1).
    % We will use:                          N = 255 / (P-1) * 2, which satisfies the equation.
    num_samples = round(255 / (num_exposures - 1) * 2); % Value of N.

    % Calculate the indices we are going to sample from.  Assumes that all images are same size.
    img_pixels = size(images{1}, 1) * size(images{1}, 2);
    step = img_pixels / num_samples;
    sample_indices = round(1:step:img_pixels);

    % Preallocate space for results.
    z_red = zeros(num_samples, num_exposures);
    z_green = zeros(num_samples, num_exposures);
    z_blue = zeros(num_samples, num_exposures);

    % Sample the images.
    for i = 1 : num_exposures
        [sampled_red, sampled_green, sampled_blue] = sample_exposure(images{i}, sample_indices);
        z_red(:, i) = sampled_red;
        z_green(:, i) = sampled_green;
        z_blue(:, i) = sampled_blue;
    end
end

% sample_exposure() is a helper function which samples the given image at the specified indices.
% @param image is a single RGB image to be sampled from
% @param sample_indices is a 1 x N matrix with the indices to sample at.  N is the number of pixels
% @return sampled_red is an Nx1 column vector with the sample from the red channel
% @return sampled_green is an Nx1 column vector with the sample from the green channel
% @return sampled_blue is an Nx1 column vector with the sample from the blue channel
function [sampled_red, sampled_green, sampled_blue] = sample_exposure(image, sample_indices)
    assert(size(sample_indices, 1) == 1, 'Dimension of sample_indices is incorrect.');
    sample_indices = sample_indices'    % Use a column of indices so that we get back a column.
    
    % Get the constituent channels.
    red_img = image(:,:,1);
    green_img = image(:,:,2);
    blue_img = image(:,:,3);

    % Construct the samples.
    sampled_red = red_img(sample_indices);
    sampled_green = green_img(sample_indices);
    sampled_blue = blue_img(sample_indices);
end