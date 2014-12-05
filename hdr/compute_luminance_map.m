% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

% compute_luminance_map() is a helper function which computes the luminance based on the radiance 
% values in the map.
% @param hdr_map is the HDR radiance map for the image
% @return luminance_map is the resulting Luminance map for the image
function luminance_map = compute_luminance_map(hdr_map)
    % Create luminance map from linear combination of the channels.
    % Source: http://stackoverflow.com/questions/596216/formula-to-determine-brightness-of-rgb-color
    red_channel = hdr_map(:,:,1);
    green_channel = hdr_map(:,:,2);
    blue_channel = hdr_map(:,:,3);
    luminance_map = 0.2126 * red_channel + 0.7152 * green_channel + 0.0722 * blue_channel;
end