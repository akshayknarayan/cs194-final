% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

% apply_tonemap() is a function which takes a luminance map, the computed display luminance, and the 
% original HDR radiance map image and generates the tonemapped result.  This effectively applies the 
% colors to the final resulting image.
% @param hdr_img is the HDR radiance map
% @param luminance_map is the luminance map computed from the HDR radiance map.  This is denoted as 
% L_{w} in Reinhard's paper.
% @param display_luminance is the luminance map that has been moved into the appropriate range for 
% display purposes
% @return result is the result of applying the tone mapping to the HDR image
function result = apply_tonemap(hdr_img, luminance_map, display_luminance)
    [height, width, num_channels] = size(hdr_img);
    result = zeros(height, width, num_channels);
    for ch = 1 : num_channels
        result(:,:,ch) = ((hdr_img(:,:,ch) ./ luminance_map)) .* display_luminance;
    end
end