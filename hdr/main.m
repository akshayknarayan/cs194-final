% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

function main()
    [linear_result, global_result, durand_result] = create_hdr_image(50, 0.09, 'station', 'jpg');
    figure, imshow(linear_result);
    figure, imshow(global_result);
    figure, imshow(durand_result);
end