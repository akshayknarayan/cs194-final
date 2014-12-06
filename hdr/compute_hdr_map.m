% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

% compute_hdr_map() is a helper function which creates the HDR radiance map.
% @param images is a cell array of the input images
% @param g_red is the camera response for the red channel
% @param g_green is the camera response for the green channel
% @param g_blue is the camera response for the blue channel
% @param weights is the weight vector to use
% @param ln_dt is the log of the exposure times
% @return hdr_map is the HDR radiance map we are trying to compute
function hdr_map = compute_hdr_map(directory, images, g_red, g_green, g_blue, weights, ln_dt)
    fprintf('== Computing HDR map ==\n');
    num_exposures = numel(images);
    [height, width, num_channels] = size(images{1});  % Assume all images are the same size.
    numerator = zeros(height, width, num_channels);
    denominator = zeros(height, width, num_channels);
    curr_num = zeros(height, width, num_channels);

    for i = 1 : num_exposures
        % Grab the current image we are processing and split into channels.
        curr_image = double(images{i}+1);     % Grab the current image.  Add 1 to get rid of zeros.
        curr_red = curr_image(:,:,1);
        curr_green = curr_image(:,:,2);
        curr_blue = curr_image(:,:,3);

        % Compute the numerator and denominator for this exposure.  Add to cumulative total.
        %          sum_{j=1}^{P} (w(Z_ij)[g(Z_ij) - ln dt_j])
        % ln E_i = ------------------------------------------
        %                  sum_{j=1}^{P} (w(Z_ij))
        curr_weight = weights(curr_image);
        curr_num(:,:,1) = curr_weight(:,:,1) .* (g_red(curr_red) - ln_dt(i));
        curr_num(:,:,2) = curr_weight(:,:,2) .* (g_green(curr_green) - ln_dt(i));
        curr_num(:,:,3) = curr_weight(:,:,3) .* (g_blue(curr_blue) - ln_dt(i));
        
        % Sum into the numerator and denominator.
        numerator = numerator + curr_num;
        denominator = denominator + curr_weight;
    end

    ln_hdr_map = numerator ./ denominator;
    hdr_map = exp(ln_hdr_map);
    
    % Plot radiance map.
%     plot_radiance_map(directory, ln_hdr_map);
end

function plot_radiance_map(directory, map)
    map = map ./ max(max(max(map)));
    map(find(map < 0)) = 0;
    map(find(map > 1)) = 1;
    h = figure;
    imagesc(map);
    set(h,'PaperUnits','inches','PaperPosition',[0 0 5 3]);
    saveas(h, ['output/' directory '_radiance_map.jpg']);
end