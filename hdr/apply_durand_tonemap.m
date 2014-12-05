% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

% apply_durand_tonemap() is a helper function which follows a simplified version of the algorithm 
% proposed in Durand's SIGGRAPH 2002 paper, Fast Bilateral Filtering for HDR Display.
% @param hdr_map is the HDR radiance map for the image
% @param dR represents the stops of the dynamic range.  As covered in the spec, choose a value 
% between 2 and 8; typically values of 4 or 5 work well
% @param gamma is the value to use for gamma compression to ensure the result won't look too dark. 
% Typically a value of 0.5 is good.
% @return result is the result of applying the Durand tonemap to the HDR radiance map, which should 
% be displayable on a normal display
function result = apply_durand_tonemap(hdr_map, dR, gamma)
    % Compute the intensity by averaging the color channels.
    intensity = mean(hdr_map, 3);

    % Compute the chrominance channels.  (R/I, G/I, B/I)
    red_channel = hdr_map(:,:,1);
    green_channel = hdr_map(:,:,2);
    blue_channel = hdr_map(:,:,3);

    chrominance_red = red_channel ./ intensity;
    chrominance_green = green_channel ./ intensity;
    chrominance_blue = blue_channel ./ intensity;

    figure, imshow(chrominance_red);
    figure, imshow(chrominance_green);
    figure, imshow(chrominance_blue);

    % Compute the log intensity.  L = log_{2}(I)
    log_intensity = log2(intensity);    % TODO: Handle cases when intensity is zero!

    % Filter the log intensity with a bilateral filter.  B = bf(L)
    base = apply_bilateral_filter(log_intensity);

    % Compute the detail layer.  D = L - B
    detail_layer = log_intensity - base;

    % Apply an offset and a scale to the base.  B' = (B-o) * s
    % o = max(B) and s = dR / (max(B) - min(B)).  dR = [2, 8].
    offset = max(max(base));
    scale = dR / (max(max(base)) - min(min(base)));
    modified_base = (base - offset) * scale;

    % Reconstruct the log intensity.  O = 2^(B' + D)
    reconstructed_intensity = pow2(modified_base + detail_layer);

    % Put back the colors:  R', G', B' = O * (R/I, G/I, B/I)
    result(:,:,1) = reconstructed_intensity .* chrominance_red;
    result(:,:,2) = reconstructed_intensity .* chrominance_green;
    result(:,:,3) = reconstructed_intensity .* chrominance_blue;

    % Apply gamma compression.  Try result^0.5 (gamma = 0.5) or use simple global intensity scaling.
    result = result ^ gamma;
end