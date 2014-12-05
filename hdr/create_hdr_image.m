% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

% create_hdr_image() is a helper function which creates the HDR image from
% the provided directory of images.
% @param lambda is the smoothing factor to use
% @param a is value which corresponds to the key of the image.  It controls 
% the brightness of the output image from tone mapping.  Lower values 
% generate darker pictures while higher values generate brighter ones.  Use 
% 0.18, 0.36, or 0.72 for bright pictures and 0.09, 0.045, etc for darker 
% pictures.
% @param saturation is a factor between 0.0 amd 1.0 used to determine the 
% threshold for color  saturation.  According to Fattal's 2002 SIGGRAPH 
% paper, values of 0.4 to 0.6 worked well.
% @param directory is the path relative to input/ which contains the
% images.  WARNING: Must not contain trailing slash!
% @param extension (optional) is the file extension of the images.  Default
% is 'jpg'
function result = create_hdr_image(lambda, a, saturation, directory, extension)
    % Read in images and exposure times from directory.  Take the log of exposure time.
    [images, exposure_times] = read_images(directory, extension);
    ln_dt = log(exposure_times);

    % Sample the images appropriately, per color channel.
    [z_red, z_green, z_blue] = sample_rgb_images(images);

    % Compute the weighting function needed.
    weights = compute_weights();

    % Solve for the camera response for each color channel.
    fprintf('== Computing camera response for each channel ==\n');
    [g_red, ~] = gsolve(z_red, ln_dt, lambda, weights);
    [g_green, ~] = gsolve(z_green, ln_dt, lambda, weights);
    [g_blue, ~] = gsolve(z_blue, ln_dt, lambda, weights);

    % Compute the HDR radiance map.
    hdr_map = compute_hdr_map(images, g_red, g_green, g_blue, weights, ln_dt);

    % Apply Reinhard's global tone mapping.
    result = apply_reinhard_global_tonemap(hdr_map, a, saturation);
end