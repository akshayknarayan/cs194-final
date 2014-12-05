% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

function result = create_hdr_image(directory, extension)
    % Read in images and exposure times from directory.  Take the log of exposure time.
    [images, exposure_times] = read_images(directory, extension);
    ln_dt = log(exposure_times);

    % Sample the images appropriately, per color channel.
    [z_red, z_green, z_blue] = sample_rgb_images(images);

    % Compute the weighting function needed.
    weights = compute_weights();


    % Solve for the camera response for each color channel.


    % Compute the HDR radiance map.



end