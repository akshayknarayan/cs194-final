% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

% apply_reinhard_global_tonemap() is a helper function which applies the global tonemap specified 
% in Reinhard's 2002 SIGGRAPH paper, Photographic Tone Reproduction for Digital Images.
% @param luminance_map is the luminance map that we will operate off of
% @param a is a value which corresponds to the key of the image.  It controls the brightness of the 
% output image from tone mapping.  Lower values generate darker pictures while higher values 
% generate brighter ones.  Use 0.18, 0.36, or 0.72 for bright pictures and 0.09, 0.045, etc for 
% darker pictures.
% @return result is the resulting displayable image once we have applied the tonemap
function result = apply_reinhard_global_tonemap(hdr_map, a)     % Consider adding white.
    fprintf('== Applying Reinhard Global Tonemap (a = %.3f) ==\n', a);
    % Constants.
    [height, width, num_channels] = size(hdr_map);
    num_pixels = height * width;
    delta = 0.0001;
    luminance_map = compute_luminance_map(hdr_map);

    % Compute the key of the image.
    %        1
    % key = --- exp{\sum_{x,y} (log(delta + L_{w}(x, y)))}
    %        N
    % (L_{w} represents the input world luminance from the luminance_map)
    key = exp((1 / num_pixels) * sum(sum(log(delta + luminance_map))));     % Seems to blow up if 1/N is outside exp.

    % Compute the scaled luminance of the image.
    %            a
    % L(x, y) = --- L_{w}(x, y)
    %           key
    scaled_luminance = (a / key) * luminance_map;

    % Compute the display luminance of the image.
    %                 L(x, y)
    % L_{d}(x, y) = -----------
    %               1 + L(x, y)
    display_luminance = scaled_luminance ./ (1 + scaled_luminance);

    % Get the final image.
    result = apply_tonemap(hdr_map, luminance_map, display_luminance);
end